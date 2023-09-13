module FSM(
    input   wire            mem_read,mem_write,ready,clk,reset,hit,
    output  reg             stall,main_read,main_write,refill,update
);

    /////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////// State Encoding ////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
localparam  [1:0]   idle            = 3'b00 ,
                    reading         = 3'b01 ,
                    writing         = 3'b11 ;

reg         [1:0]   current_state , next_state ;
wire        [3:0]   sel_NS;

assign sel_NS ={mem_read, mem_write, hit, ready};

always @(negedge clk or negedge reset)         
    begin
            if(!reset) begin
                current_state <= idle;
            end  
            else begin
                current_state <= next_state;
            end
    end
    /////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////// States transition /////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
always @(*)
    begin
        case(current_state)
            idle            :   begin
                                    casez (sel_NS)
                                        4'b100?:  next_state = reading ;
                                        4'b01?0:  next_state = writing ;
                                        default:  next_state = idle ;
                                    endcase
                                end
    ///////////////////////////////////////////////////////
    ////////////////////// Reading ////////////////////////
    //////////////////////////////////////////////////////           
            reading         :   begin
                                    casez (sel_NS)
                                        4'b101?:  next_state =  idle;
                                        4'b1000:  next_state =  reading;
                                        4'b1001:  next_state =  reading;
                                        4'b01??:  next_state =  writing;
                                        default:  next_state = idle ;
                                    endcase
                                end
    ///////////////////////////////////////////////////////
    ////////////////////// Writing ////////////////////////
    //////////////////////////////////////////////////////           
            writing         :   begin
                                    casez (sel_NS)
                                        4'b01?0:  next_state =  writing;
                                        4'b01?1:  next_state =  idle;
                                        4'b101?:  next_state =  idle;
                                        4'b100?:  next_state =  reading;
                                        default:  next_state = idle ;
                                    endcase
                                end
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
            default         :   begin
                                    next_state = idle;
                                end            
        endcase
    end
    /////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////// output logic //////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
always@(*)
begin
    ///////////////////////////////////////////////////////
    /////////////////// initial values ////////////////////
    //////////////////////////////////////////////////////  
                                    stall       = 1'b0 ;
                                    main_read   = 1'b0 ;
                                    main_write  = 1'b0 ;
                                    refill      = 1'b0 ;
                                    update      = 1'b0 ;
                                    
///////////////////////////////////////////////////////////////////////
    case(current_state)
            idle            :   begin
                                    stall       = 1'b0 ;
                                    main_read   = 1'b0 ;
                                    main_write  = 1'b0 ;
                                    if (mem_read && !mem_write && hit ) begin
                                        refill      = 1'b1 ;
                                        update      = 1'b1 ;    //  refill & update  = reading operation (11)
                                    end else 
                                    begin
                                        refill      = 1'b0 ;
                                        update      = 1'b0 ;
                                    end
                                end
    ///////////////////////////////////////////////////////
    ////////////////////// Reading ////////////////////////
    //////////////////////////////////////////////////////           
            reading         :   begin
                                    stall       = 1'b1 ;
                                    main_write  = 1'b0 ;
                                    update      = 1'b0 ;
                                    if (ready == 1'b1)
                                    begin
                                        main_read   = 1'b0 ;
                                        refill      = 1'b1 ;
                                    end else if (ready == 1'b0 && hit == 1'b0) 
                                    begin 
                                        main_read   = 1'b1 ;
                                        refill      = 1'b0 ;
                                    end else if ((ready == 1'b0 && hit == 1'b1))
                                    begin
                                        main_read   = 1'b0 ;
                                        refill      = 1'b0 ;
                                    end 
                                end
///////////////////////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////
    ////////////////////// Writing ////////////////////////
    //////////////////////////////////////////////////////           
            writing         :   begin
                                    main_read   = 1'b0 ;
                                    refill      = 1'b0 ;
                                    stall       = 1'b1 ;

                                    if (hit == 1'b1 && !ready == 1'b1) begin
                                    update      = 1'b1 ;
                                    end else 
                                    begin
                                    update      = 1'b0 ;
                                    end

                                    if (ready == 1'b1) begin
                                    main_write  = 1'b0 ;
                                    end else 
                                    begin
                                    main_write  = 1'b1 ;
                                    end
                                end
///////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////
            default         :   begin
                                    stall       = 1'b0 ;
                                    main_read   = 1'b0 ;
                                    main_write  = 1'b0 ;
                                    refill      = 1'b0 ;
                                    update      = 1'b0 ;
                                end
///////////////////////////////////////////////////////////////////////
        endcase
end
//assign stall= ~hit;

endmodule