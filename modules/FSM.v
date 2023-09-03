module FSM(
    input   wire            mem_read,mem_write,ready,clk,reset,
    input   wire    [4:0]   index,
    input   wire    [3:0]   tag,    // tag[3] --> valid bit , tag[2:0] --> block number
    output  reg             stall,main_read,main_write,refill,update
);

    /////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////// State Encoding ////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
localparam  [2:0]   idle            = 3'b000 ,
                    reading         = 3'b001 ,
                    main_mem_read   = 3'b010 ,
                    writing         = 3'b011 ,
                    write_through   = 3'b100 ,
                    write_around    = 3'b101 ;

reg         [2:0]   current_state , next_state ;

    ////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////// internals ////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////
reg         [3:0]   tag_array   [0:32] ;    // tag[3] --> valid bit , tag[2:0] --> block number

////////////////////////////////////////////////////////////////////////////////////////////////
always @(posedge clk or negedge reset)         
    begin
            if(!reset)  
                current_state <= idle;
            else
                current_state <= next_state;
    end
    /////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////// States transition /////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
always @(*)
    begin
        case(current_state)
            idle            :   begin
                                    if(mem_read && !mem_write)
                                    next_state = reading ;
                                    else if (!mem_read && mem_write)
                                    next_state = writing ;
                                    else
                                    next_state = idle ;
                                end
    ///////////////////////////////////////////////////////
    ////////////////////// Reading ////////////////////////
    //////////////////////////////////////////////////////           
            reading         :   begin

                                end
///////////////////////////////////////////////////////////////////////
            main_mem_read   :   begin

                                end
    ///////////////////////////////////////////////////////
    ////////////////////// Writing ////////////////////////
    //////////////////////////////////////////////////////           
            writing         :   begin

                                end
///////////////////////////////////////////////////////////////////////
            write_through   :   begin

                                end
///////////////////////////////////////////////////////////////////////
            write_around   :   begin

                                end
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

                                end
    ///////////////////////////////////////////////////////
    ////////////////////// Reading ////////////////////////
    //////////////////////////////////////////////////////           
            reading         :   begin

                                end
///////////////////////////////////////////////////////////////////////
            main_mem_read   :   begin

                                end
    ///////////////////////////////////////////////////////
    ////////////////////// Writing ////////////////////////
    //////////////////////////////////////////////////////           
            writing         :   begin

                                end
///////////////////////////////////////////////////////////////////////
            write_through   :   begin

                                end
///////////////////////////////////////////////////////////////////////
            write_around   :   begin

                                end
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


//////////////////////////////////////// MUX 32x1 ////////////////////////////////

endmodule