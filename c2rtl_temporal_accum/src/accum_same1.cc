#include "/xls_builtin.h"

#pragma hls_design top
void temporal_accum(__xls_channel<int, __xls_channel_dir_In>& in,
                    __xls_channel<int, __xls_channel_dir_Out>& out) {
  static int acc = 0;
  int x = in.read();
  acc = acc + x;
  out.write(acc);
}
