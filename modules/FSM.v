module FSM(
    input   wire            mem_read,mem_write,ready,clk,reset,hit,
//    input   wire    [4:0]   index_addr,
//    input   wire    [2:0]   tag_addr,    // tag[2:0] --> block number
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
//reg         [2:0]   tag_cache   [0:31] ;    // tag[2:0] --> block number
//reg                 valid_cache [0:31] ;    // valid array
////////////////////////////////////////////////////////////////////////////////////////////////

always @(posedge clk or negedge reset)         
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
                                    if(hit == 1'b1)
                                    next_state = idle ;
                                    else 
                                    next_state = main_mem_read ;
                                end
///////////////////////////////////////////////////////////////////////
            main_mem_read   :   begin
                                    if (ready == 1'b1)
                                    next_state = reading ;
                                    else 
                                    next_state = main_mem_read ;
                                end
    ///////////////////////////////////////////////////////
    ////////////////////// Writing ////////////////////////
    //////////////////////////////////////////////////////           
            writing         :   begin
                                    if (hit == 1'b1)
                                    next_state = write_through;
                                    else 
                                    next_state = write_around;
                                end
///////////////////////////////////////////////////////////////////////
            write_through   :   begin
                                    if (ready == 1'b1)
                                    next_state = idle ;
                                    else 
                                    next_state = write_through ;
                                end
///////////////////////////////////////////////////////////////////////
            write_around   :   begin
                                    if (ready == 1'b1)
                                    next_state = idle ;
                                    else 
                                    next_state = write_around ;
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
                                    stall       = 1'b0 ;
                                    main_read   = 1'b0 ;
                                    main_write  = 1'b0 ;
                                    refill      = 1'b0 ;
                                    update      = 1'b0 ;
                                end
    ///////////////////////////////////////////////////////
    ////////////////////// Reading ////////////////////////
    //////////////////////////////////////////////////////           
            reading         :   begin
                                    if (hit == 1'b1) begin
                                        stall       = 1'b0 ;
                                        main_read   = 1'b0 ;
                                        main_write  = 1'b0 ;
                                        refill      = 1'b1 ;
                                        update      = 1'b1 ;    //  refill & update  = reading operation (11)
                                    end else 
                                    begin
                                        stall       = 1'b1 ;
                                        main_read   = 1'b0 ;
                                        main_write  = 1'b0 ;
                                        refill      = 1'b0 ;
                                        update      = 1'b0 ;
                                    end
                                 
                                end
///////////////////////////////////////////////////////////////////////
            main_mem_read   :   begin
                                    if (ready == 1'b1) begin
                                    stall       = 1'b0 ;
                                    main_read   = 1'b0 ;
                                    main_write  = 1'b0 ;
                                    refill      = 1'b0 ;
                                    update      = 1'b0 ;
                                end else 
                                begin
                                    stall       = 1'b1 ;
                                    main_read   = 1'b0 ;
                                    main_write  = 1'b0 ;
                                    refill      = 1'b0 ;
                                    update      = 1'b1 ;
                                end
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