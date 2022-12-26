class scoreboard;
    transaction_port #(input_transaction) scoreboard_tp_in;
    transaction_port #(output_transaction) scoreboard_tp_out;

    logic [WIDTH - 1:0] vrf [4:0];
    logic [WIDTH - 1:0] vpc = 32'b0;
    
    logic [WIDTH - 1:0] imm, instruction, target;
    logic [4:0] rs, rt, rd;

    typedef struct {
        logic [WIDTH - 2:0] address;
        logic [WIDTH - 1:0] data;
    } vdmem;

    typedef struct {
        logic [WIDTH - 2:0] address;
        logic [WIDTH - 1:0] instruction;
    } vimem;

    vdmem dmem_array [];
    vimem imem_array [];

    opcode_t opcode;
    funct_t funct;

    event input_read;
    event output_read;

    function new();
        dmem_array =  new[1];
        imem_array =  new[1];
    endfunction : new

    function void execute();
        vrf [5'b0] = 32'b0;

        //instruction = vimem[vpc[31:2]];

        foreach(imem_array[i])
        begin
            if(imem_array[i].address == vpc[31:2])
            begin
                instruction = imem_array[i].instruction;
                break;
            end
        end

        //$cast(opcode, instruction[31:26]);
        //$cast(funct, instruction[5:0]);
        opcode = opcode_t'(instruction[31:26]);
        funct  = funct_t'(instruction[5:0]);

        rs = instruction[25:21]; 
        rt = instruction[20:16];
        rd = instruction[15:11];

        imm = {{16{instruction[15]}}, instruction[15:0]};

        case(opcode)
            _r_type:
            begin
                case(funct)
                _add:
                begin
                    if(rd != 5'd0)
                        vrf[rd] = vrf[rs] + vrf[rt];
                end

                _sub:
                begin
                    if(rd != 5'd0)
                        vrf[rd] = vrf[rs] - vrf[rt];
                end
                
                _AND:
                begin
                    if(rd != 5'd0)
                        vrf[rd] = vrf[rs] & vrf[rt];
                end
                
                _OR:
                begin
                    if(rd != 5'd0)
                        vrf[rd] = vrf[rs] | vrf[rt];
                end
                
                _slt:
                begin
                    if(rd != 5'd0)
                        vrf[rd] = (vrf[rs] < vrf[rt]) ? {{(WIDTH-1){1'b0}}, 1'b1} : {WIDTH{1'b0}};
                end
                
                default:
                begin
                end
                endcase
            end

            _j:
            begin
                target = {vpc[31:28], instruction[25:0], 2'b00};
            end

            _beq:
            begin
                target = ((vrf[rs] - vrf[rt]) == 32'b0) ? vpc + 32'd4 + imm : vpc + 32'd4;
            end

            _addiu:
            begin
                if(rt != 5'd0)
                    vrf[rt] = vrf[rs] + {{14{imm[15]}}, imm};
            end
            
            _lw:
            begin
                if(rt != 5'd0)
                begin
                    foreach(dmem_array[j])
                    begin
                        if(dmem_array[j].address == (vrf[rs] + {{14{imm[15]}}, imm}))
                        begin
                            vrf[rt] = dmem_array[j].data;
                            break;
                        end
                    end
                end
            end
            
            _sw:
            begin
                bit exists = 1'b0;
                foreach(dmem_array[j])
                begin
                    if(dmem_array[j].address == (vrf[rs] + {{14{imm[15]}}, imm}))
                    begin
                        dmem_array[j].data = vrf[rt];
                        exists = 1'b1;
                        break;
                    end
                end
                
                if(!exists)
                begin
                    dmem_array[dmem_array.size()-1] = '{(vrf[rs] + {{14{imm[15]}}, imm}), vrf[rt]};
                    dmem_array = new[dmem_array.size()+1](dmem_array);
                end
            end

            default:
            begin
                
            end
        endcase

        vpc = (opcode == _j || opcode == _beq) ? target : vpc + 32'd4;

        
    endfunction : execute

    task run();
        input_transaction  t_in;
        output_transaction t_out, predicted;

        forever 
        begin
            predicted = new();

            @(input_read);
            scoreboard_tp_in.read(t_in);

            if(t_in == null)
                $display("%0t [SCOREBOARD]: No input transaction. Null pointer.", $time);
            else
            begin
                if(t_in.instrWrite_in)
                begin
                    imem_array[imem_array.size()-1] = '{t_in.instr_address_in[31:2], t_in.instr_in};
                    imem_array = new[imem_array.size()+1](imem_array); 
                    
                    $display("%0t [SCOREBOARD]: Input:: ", $time, t_in.convert2string());
                end
            end

            if(!t_in.instrWrite_in)
            begin
                @(output_read);
                scoreboard_tp_out.read(t_out);

                if(t_out == null)
                    $display("%0t [SCOREBOARD]: No output transaction. Null pointer.", $time);
                else
                begin
                    if(!t_in.instrWrite_in)
                    begin
                        execute();

                        predicted.copy(t_out);

                        foreach(dmem_array[k])
                        begin
                            if(dmem_array[k].address == t_in.read_data_address_in[31:2])
                            begin
                                predicted.read_data_out = dmem_array[k].data;
                                break;
                            end
                        end

                        if(t_in.instr_in[31:26] == 6'b111111)
                        begin
                            $display("%0t [SCOREBOARD]: Input:: ", $time, t_in.convert2string());

                            if(predicted.compare(t_out))
                            begin
                                //$write("%c[2;34m",27);//blue
                                $display("%c[2;34m", 27, "%0t", $time, {" [SCOREBOARD]: PASS:: ", t_out.convert2string(), " || Predicted => ", predicted.convert2string()});
                                $write("%c[2;0m",27);//standard color
                            end
                            else
                            begin
                                //$display("%c[2;31m",27);//red
                                $display("%c[2;31m", 27, "%0t", $time, {" [SCOREBOARD]: FAIL:: ", t_out.convert2string(), " || Predicted => ", predicted.convert2string()});
                                $write("%c[2;0m",27);//standard color
                            end
                        end
                    end
                end
            end
        end
    endtask : run
endclass : scoreboard