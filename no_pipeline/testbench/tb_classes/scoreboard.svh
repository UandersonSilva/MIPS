class scoreboard;
    transaction_port #(input_transaction) scoreboard_tp_in;
    transaction_port #(output_transaction) scoreboard_tp_out;

    logic [WIDTH - 1:0] vrf [4:0];
    logic [WIDTH - 1:0] vdmem [2**(WIDTH - 2) - 1:0];
    logic [WIDTH - 1:0] vimem [2**(WIDTH - 2) - 1:0];
    logic [WIDTH - 1:0] vpc = 32'b0;
    
    logic [WIDTH - 1:0] imm, instruction, target;
    logic [4:0] rs, rt, rd;

    opcode_t opcode;
    funct_t funct;

    event input_read;
    event output_read;

    function void execute();
        vrf [5'b0] = 32'b0;

        instruction = vimem[vpc[31:2]];

        opcode = instruction[31:26];
        funct  = instruction[5:0];

        rs = instruction[25:21]; 
        rt = instruction[20:16];
        rd = instruction[15:11];

        imm = [15:0];

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
                    vrf[rt] = vdmem[vrf[rs] + {{14{imm[15]}}, imm}];
            end
            
            _sw:
            begin
                vdmem[vrf[rs] + {{14{imm[15]}}, imm}] = vrf[rt];
            end

            default:
            begin
                
            end
        endcase

        vpc = (opcode == _j || opcode == _beq) ? target : vpc + 32'b4;

        
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
                    imem[t_in.instr_address_in[31:2]] = t_in.instr;
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

                        t_predicted.read_data_out = vdmem[t_in.read_data_address_in[31:2]];

                        if(t_in.instr_in[31:26] == _check)
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