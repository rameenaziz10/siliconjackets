// Code your design here
/*
 Module Name : gcd
 Description :
	 Greatest Common Divisor
	 ! gcd( 6, 2) = 2
	 ! gcd( 9,12) = 3
	 ! gcd(18,12) = 6
*/

typedef enum logic[1:0] {
    idle,
	comp,
	out
} states_t;

states_t state, next_state;


module gcd
    #(parameter WIDTH = 8)
    (
	    input  logic            clk_i, reset_i,   // global
	    input  logic            valid_i,        // valid in
	    input  logic [WIDTH-1:0]a_i, b_i,       // operands
	    output logic [WIDTH-1:0]gcd_o,          // gcd output
	    output logic            valid_o         // valid out

    );
	
  logic [WIDTH-1:0] ain, bin, a_next, b_next, c;

  always_ff @(posedge clk_i, negedge reset_i) 
    if (reset_i==1) begin
			ain <= 0;
			bin <= 0;

			gcd_o <= 0;
			valid_o <= 0;
			state <= idle;
    end
		
		else begin
			
		
		case (state)
			idle: begin
        if (valid_i == 1) begin
					ain <= a_i;
          bin <= b_i;
					state <= comp;
              end
            end
			comp: begin
        ain <= a_next;
        bin <= b_next;
        if(a_next == b_next) begin
          state <= out;
          gcd_o <= a_next;
        end
			end
			out: begin
              valid_o <= 1;
            end
        endcase
        end
  
always_comb begin
      a_next = 0;
      b_next = 0;
    case(state)
      idle: begin
      end
      comp: begin
        if (ain > bin) begin
                c = (ain - bin);
                if(c > bin) begin
                  b_next = ain;
                  a_next = c;
                end
                else begin
                  a_next = bin;
                  b_next = c;
                end	
              end
              else if (bin > ain) begin
                c = bin-ain;
                if (c > ain) begin
                  a_next = bin;
                  b_next = c;
                end
                else begin
                  b_next = ain;
                  a_next = c;
                end
              end
			
              
            end	
      out: begin
      end 
    endcase
  end
          
endmodule
