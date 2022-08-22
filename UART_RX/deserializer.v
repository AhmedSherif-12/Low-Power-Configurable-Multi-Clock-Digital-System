module deserializer (

    input wire clk,

    input wire rst,

    input wire En,

    input wire sampled_bit,

    input wire [4:0] edge_cnt,

    input wire [4:0] presample,

    output reg [7:0] P_data



);

//reg [7:0] comp_out;





always @(posedge clk or negedge rst)

    begin



        if (!rst) 

            begin

               P_data<=0;

              // comp_out<=0; 

            end

        else

		begin

		    if (En && (edge_cnt==((presample>>1)+2))) 

		        P_data<={sampled_bit,P_data[7:1]};  

		    else    

		        P_data<=P_data; 
		end     

    end





/*always @(*) 

    begin

        

        if (edge_cnt==((presample>>1)+2)) 

        begin

            comp_out={sampled_bit,comp_out[7:1]}; 

        end
	else
	//comp_out=comp_out;

  */      

    //end





endmodule