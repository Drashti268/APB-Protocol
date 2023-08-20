`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:43:51 06/06/2023
// Design Name:   apb
// Module Name:   /home/ise/Desktop/Verilog/APB/apb/apb_tb.v
// Project Name:  apb
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: apb
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module apb_tb;

	// Inputs
	reg psel;
	reg penable;
	reg clk;
	reg rst;
	reg pwrite;
	reg [7:0] paddr;
	reg [7:0] pwdata;

	// Outputs
	wire [7:0] prdata;

	// Instantiate the Unit Under Test (UUT)
	apb uut (
		.psel(psel), 
		.penable(penable), 
		.clk(clk), 
		.rst(rst), 
		.pwrite(pwrite), 
		.paddr(paddr), 
		.pwdata(pwdata), 
		.prdata(prdata)
	);
	
	initial begin
	clk=0;
	forever #5 clk=~clk;
	end
	initial begin
		psel = 0;
		penable = 0;
		rst = 0;
		pwrite = 0;
		paddr = 0;
		pwdata = 0;
		#10;
		
		psel=1;
		penable=0;
		rst=1;
		pwdata=8'b00001111;
		paddr=8'b000000011;
		#10;
		
		penable=1;
		pwrite=1;
		#10;
		
		pwrite=0;
		paddr=8'b00000011;
	   #10;
		
	   $monitor ($time, " clk=%b,psel=%b,penable=%b,pwrite=%b,paddr=%b,pwdata=%b,prdata=%b", clk,psel,penable,pwrite,paddr,pwdata,prdata);
		
		#100 $finish;
		
	end
      
endmodule

