class scoreboard;
    transaction_port #(input_transaction) scoreboard_tp_in;
    transaction_port #(output_transaction) scoreboard_tp_out;

    integer stage_count;

    logic [WIDTH - 1:0] vpc = 32'd0;
    
    logic [WIDTH - 1:0] imm, instruction, target;
    logic [4:0] rs, rt, rd;

    typedef struct {
        logic [WIDTH - 1:0] value;
    } vrf;

    typedef struct {
        logic [WIDTH - 2:0] address;
        logic [WIDTH - 1:0] data;
    } vdmem;

    typedef struct {
        logic [WIDTH - 2:0] address;
        logic [WIDTH - 1:0] instruction;
    } vimem;

    vrf vrf_array [];
    vdmem dmem_array [];
    vimem imem_array [];

    opcode_t opcode;
    funct_t funct;

    event input_read;
    event output_read;

    function new();
        dmem_array =  new[1];
        imem_array =  new[1];
        vrf_array = new[32];
        vrf_array[0].value = 32'd0;
    endfunction : new

    function void execute();
        foreach(imem_array[i])
        begin
            if(imem_array[i].address == vpc[31:2])
            begin
                instruction = imem_array[i].instruction;
                break;
            end
        end

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
                        vrf_array[rd].value = vrf_array[rs].value + vrf_array[rt].value;
                end

                _sub:
                begin
                    if(rd != 5'd0)
                        vrf_array[rd].value = vrf_array[rs].value - vrf_array[rt].value;
                end
                
                _AND:
                begin
                    if(rd != 5'd0)
                        vrf_array[rd].value = vrf_array[rs].value & vrf_array[rt].value;
                end
                
                _OR:
                begin
                    if(rd != 5'd0)
                        vrf_array[rd].value = vrf_array[rs].value | vrf_array[rt].value;
                end
                
                _slt:
                begin
                    if(rd != 5'd0)
                        vrf_array[rd].value = (vrf_array[rs].value < vrf_array[rt].value) ? {{(WIDTH-1){1'b0}}, 1'b1} : {WIDTH{1'b0}};
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
                target = ((vrf_array[rs].value - vrf_array[rt].value) == 32'b0) ? vpc + 32'd4 + {imm[29:0], 2'b00} : vpc + 32'd4;
            end

            _addiu:
            begin
                if(rt != 5'd0)
                    vrf_array[rt].value = vrf_array[rs].value + imm;
            end
            
            _lw:
            begin
                if(rt != 5'd0)
                begin
                    foreach(dmem_array[j])
                    begin
                        if(dmem_array[j].address == (vrf_array[rs].value[31:2] + imm[31:2]))
                        begin
                            vrf_array[rt].value = dmem_array[j].data;
                            break;
                        end
                    end
                end
            end
            
            _sw:
            begin
                bit exists = 1'b0;
                foreach(dmem_array[k])
                begin
                    if(dmem_array[k].address == (vrf_array[rs].value[31:2] + imm[31:2]))
                    begin
                        dmem_array[k].data = vrf_array[rt].value;
                        exists = 1'b1;
                        break;
                    end
                end
                
                if(!exists)
                begin
                    dmem_array[dmem_array.size()-1] = '{(vrf_array[rs].value[31:2] + imm[31:2]), vrf_array[rt].value};
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
                if(t_in.reset_in)
                begin
                    vpc = 32'd0;
                    stage_count = 0;
                end

                if(t_in.instrWrite_in)
                begin
                    bit exists = 1'b0;

                    foreach(imem_array[l])
                    begin
                        if(imem_array[l].address == t_in.instr_address_in[31:2])
                        begin
                            imem_array[l].instruction = t_in.instr_in;
                            exists = 1'b1;
                            break;
                        end
                    end

                    if(!exists)
                    begin
                        imem_array[imem_array.size()-1] = '{t_in.instr_address_in[31:2], t_in.instr_in};
                        imem_array = new[imem_array.size()+1](imem_array); 
                    end

                    $display("%0t [SCOREBOARD]: Input:: ", $time, t_in.convert2string());
                end
            end

            if(!t_in.instrWrite_in)
            begin
                @(output_read);
                scoreboard_tp_out.read(t_out);

                if(stage_count < 4)
                    stage_count++;

                if(t_out == null)
                    $display("%0t [SCOREBOARD]: No output transaction. Null pointer.", $time);
                else
                begin
                    if(!t_in.instrWrite_in && (stage_count >= 4))
                    begin
                        execute();

                        foreach(imem_array[m])
                        begin
                            if(imem_array[m].address == t_in.instr_address_in[31:2])
                            begin
                                predicted.read_instr_out = imem_array[m].instruction;
                                break;
                            end
                        end

                        foreach(dmem_array[n])
                        begin
                            if(dmem_array[n].address == t_in.read_data_address_in[31:2])
                            begin
                                predicted.read_data_out = dmem_array[n].data;
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