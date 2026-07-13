module temporal_accum(
  input wire clk,
  input wire rst,
  input wire [31:0] in,
  input wire in_vld,
  input wire out_rdy,
  output wire in_rdy,
  output wire [31:0] out,
  output wire out_vld
);
  wire continuation_0_literal__1 = 1'h1;
  reg [31:0] ___ZZ14temporal_accumR13__xls_channelIiL17__xls_channel_dir2EERS_IiLS0_1EEE3acc;
  reg [31:0] __in_reg;
  reg __in_valid_reg;
  reg [31:0] __out_reg;
  reg __out_valid_reg;
  wire in_recv_pred;
  wire out_valid_inv;
  wire out_op0_1;
  wire __out_vld_buf;
  wire out_valid_load_en;
  wire out_load_en;
  wire p0_stage_done;
  wire in_valid_inv;
  wire [31:0] in_select;
  wire in_valid_load_en;
  wire [31:0] out_op0_0__1;
  wire in_load_en;
  wire [31:0] _ZZ14temporal_accumR13__xls_channelIiL17__xls_channel_dir2EERS_IiLS0_1EEE3acc_next_state_value;
  assign in_recv_pred = continuation_0_literal__1;
  assign out_valid_inv = ~__out_valid_reg;
  assign out_op0_1 = 1'h1;
  assign __out_vld_buf = ~in_recv_pred | __in_valid_reg;
  assign out_valid_load_en = out_rdy | out_valid_inv;
  assign out_load_en = __out_vld_buf & out_valid_load_en;
  assign p0_stage_done = __out_vld_buf & (~out_op0_1 | out_load_en);
  assign in_valid_inv = ~__in_valid_reg;
  assign in_select = in_recv_pred ? __in_reg : 32'h0000_0000;
  assign in_valid_load_en = p0_stage_done & in_recv_pred | in_valid_inv;
  assign out_op0_0__1 = ___ZZ14temporal_accumR13__xls_channelIiL17__xls_channel_dir2EERS_IiLS0_1EEE3acc + in_select;
  assign in_load_en = in_vld & in_valid_load_en;
  assign _ZZ14temporal_accumR13__xls_channelIiL17__xls_channel_dir2EERS_IiLS0_1EEE3acc_next_state_value = out_op0_1 ? out_op0_0__1 : ___ZZ14temporal_accumR13__xls_channelIiL17__xls_channel_dir2EERS_IiLS0_1EEE3acc;
  always @ (posedge clk) begin
    if (rst) begin
      ___ZZ14temporal_accumR13__xls_channelIiL17__xls_channel_dir2EERS_IiLS0_1EEE3acc <= 32'h0000_0000;
      __in_reg <= 32'h0000_0000;
      __in_valid_reg <= 1'h0;
      __out_reg <= 32'h0000_0000;
      __out_valid_reg <= 1'h0;
    end else begin
      ___ZZ14temporal_accumR13__xls_channelIiL17__xls_channel_dir2EERS_IiLS0_1EEE3acc <= p0_stage_done ? _ZZ14temporal_accumR13__xls_channelIiL17__xls_channel_dir2EERS_IiLS0_1EEE3acc_next_state_value : ___ZZ14temporal_accumR13__xls_channelIiL17__xls_channel_dir2EERS_IiLS0_1EEE3acc;
      __in_reg <= in_load_en ? in : __in_reg;
      __in_valid_reg <= in_valid_load_en ? in_vld : __in_valid_reg;
      __out_reg <= out_load_en ? out_op0_0__1 : __out_reg;
      __out_valid_reg <= out_valid_load_en ? __out_vld_buf : __out_valid_reg;
    end
  end
  assign in_rdy = in_load_en;
  assign out = __out_reg;
  assign out_vld = __out_valid_reg;
endmodule
