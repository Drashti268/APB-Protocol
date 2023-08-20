
module apb(psel,penable,clk,rst,pwrite,paddr,pwdata,prdata);
input psel;
input penable;
input clk;
input rst;
input pwrite;
input [7:0]paddr;
input [7:0]pwdata;
output reg [7:0]prdata;

reg IDLE=2'b00,SETUP=2'b01,ACCESS=2'b10;
reg [1:0]state;
reg [7:0] mem [0:255]; 
reg [7:0]prdata1; 


always @ (posedge clk  )
begin
    if (!rst)
             state = IDLE;
    else 
    begin
         case(state)
	           IDLE:begin
	                     if ((penable==0) && ( psel == 0 ))
	                     begin
                            state=IDLE;
	                         prdata1=8'b0;
                        end
	    
                        else if (( psel==1 ) && ( penable==0 ))
                        begin
                        state = SETUP;
	                     end 
		             end 
      

              SETUP:begin
	                     if(( psel==1) && (penable==1))
                        begin
                            state = ACCESS;
                        end
                   end 
						 
						 
		       ACCESS:begin
	                      if ((psel==1) && (penable==0))
                           state  = SETUP;
	                      if (( psel == 0 ) && ( penable == 0 ))  
                           state = IDLE;
	                 end 
      
             default : state = IDLE;
    endcase
end
end 
  
always @ (posedge clk)
begin
     if ((state==ACCESS) && (pwrite==1))
     begin
        mem [paddr] = pwdata; 
     end 
	  if ((state==ACCESS)&&(pwrite==0))
	  begin
	     prdata1=mem[paddr];
		  prdata=prdata1;
	  end
end
  
endmodule
  