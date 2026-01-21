set env ABC_AREA 1
set env ABC_DRIVER_CELL BUFx2_ASAP7_75t_R
set env ABC_LOAD_IN_FF 3.898
set env ADDER_MAP_FILE ./platforms/asap7/yoSys/cells_adders_R.v
set env ADDITIONAL_GDSOAS 
set env ADDITIONAL_LEFS 
set env ASAP7_USE_VT RVT
set env BALANCE_ROWS 0
set env BC_CCS_DFF_LIB_FILE ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_RVT_FF_ccs_220123.lib
set env BC_CCS_DFF_LIB_FILE_T ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_PLACEHOLDERVT_FF_ccs_220123.lib
set env BC_CCS_LIB_FILES ./platforms/asap7/lib/NLDM/asap7sc7p5t_AO_RVT_FF_ccs_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_INVBUF_RVT_FF_ccs_220122.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_OA_RVT_FF_ccs_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_SIMPLE_RVT_FF_ccs_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_RVT_FF_ccs_220123.lib
set env BC_CCS_LIB_FILES_T ./platforms/asap7/lib/NLDM/asap7sc7p5t_AO_PLACEHOLDERVT_FF_ccs_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_INVBUF_PLACEHOLDERVT_FF_ccs_220122.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_OA_PLACEHOLDERVT_FF_ccs_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_SIMPLE_PLACEHOLDERVT_FF_ccs_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_PLACEHOLDERVT_FF_ccs_220123.lib
set env BC_NLDM_DFF_LIB_FILE ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_RVT_FF_nldm_220123.lib
set env BC_NLDM_DFF_LIB_FILE_T ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_PLACEHOLDERVT_FF_nldm_220123.lib
set env BC_NLDM_LIB_FILES ./platforms/asap7/lib/NLDM/asap7sc7p5t_AO_RVT_FF_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_INVBUF_RVT_FF_nldm_220122.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_OA_RVT_FF_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_SIMPLE_RVT_FF_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_RVT_FF_nldm_220123.lib
set env BC_NLDM_LIB_FILES_T ./platforms/asap7/lib/NLDM/asap7sc7p5t_AO_PLACEHOLDERVT_FF_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_INVBUF_PLACEHOLDERVT_FF_nldm_220122.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_OA_PLACEHOLDERVT_FF_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_SIMPLE_PLACEHOLDERVT_FF_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_PLACEHOLDERVT_FF_nldm_220123.lib
set env BC_TEMPERATURE 25C
set env BC_VOLTAGE 0.77
set env CELL_PAD_IN_SITES_DETAIL_PLACEMENT 0
set env CELL_PAD_IN_SITES_GLOBAL_PLACEMENT 0
set env CLKGATE_MAP_FILE ./platforms/asap7/yoSys/cells_clkgate_R.v
set env CLUSTER_FLOPS 0
set env CORE_ASPECT_RATIO 1
set env CORE_MARGIN 2
set env CORE_UTILIZATION 40
set env CORNER BC
set env CTS_SNAPSHOTS 0
set env DB_FILES 
set env DESIGN_DIR designs/asap7/aes/
set env DESIGN_HOME getenv("FLOW_HOME")/designs
set env DESIGN_NAME aes_cipher_top
set env DESIGN_NICKNAME aes
set env DETAILED_METRICS 0
set env DETAILED_ROUTE_END_ITERATION 64
set env DONT_BUFFER_PORTS 0
set env DONT_USE_CELLS *x1p*_ASAP7* *xp*_ASAP7* SDF* ICG*
set env DPO_MAX_DISPLACEMENT 5 1
set env ENABLE_DPO 1
set env EQUIVALENCE_CHECK 0
set env FASTROUTE_TCL ./platforms/asap7/fastroute.tcl
set env FILL_CELLS FILLERxp5_ASAP7_75t_R FILLER_ASAP7_75t_R DECAPx1_ASAP7_75t_R DECAPx2_ASAP7_75t_R DECAPx4_ASAP7_75t_R DECAPx6_ASAP7_75t_R DECAPx10_ASAP7_75t_R
set env FILL_CELLS_T FILLERxp5_ASAP7_75t_ FILLER_ASAP7_75t_ DECAPx1_ASAP7_75t_ DECAPx2_ASAP7_75t_ DECAPx4_ASAP7_75t_ DECAPx6_ASAP7_75t_ DECAPx10_ASAP7_75t_
set env FLOW_VARIANT base
set env GDSOAS_FILES ./platforms/asap7/gds/asap7sc7p5t_28_R_220121a.gds
set env GDS_ALLOW_EMPTY fakeram.*
set env GDS_FILES ./platforms/asap7/gds/asap7sc7p5t_28_R_220121a.gds
set env GDS_FINAL_FILE ./results/asap7/aes/base/6_final.gds
set env GDS_MERGED_FILE ./results/asap7/aes/base/6_1_merged.gds
set env GENERATE_ARTIFACTS_ON_FAILURE 0
set env GLOBAL_ROUTE_ARGS -congestion_iterations 30 -congestion_report_iter_step 5 -verbose
set env GND_NETS_VOLTAGES VSS 0.0
set env GPL_ROUTABILITY_DRIVEN 1
set env GPL_TIMING_DRIVEN 1
set env GUI_TIMING 1
set env HOLD_BUF_CELL BUFx2_ASAP7_75t_R
set env HOLD_SLACK_MARGIN 0
set env IO_PLACER_H M4
set env IO_PLACER_V M5
set env IR_DROP_LAYER M1
set env KEEP_VARS 0
set env LATCH_MAP_FILE ./platforms/asap7/yoSys/cells_latch_R.v
set env LEC_CHECK 1
set env LIB_DIR ./platforms/asap7/lib/NLDM
set env LIB_FILES ./platforms/asap7/lib/NLDM/asap7sc7p5t_AO_RVT_FF_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_INVBUF_RVT_FF_nldm_220122.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_OA_RVT_FF_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_SIMPLE_RVT_FF_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_RVT_FF_nldm_220123.lib
set env LIB_MODEL NLDM
set env LOG_DIR ./logs/asap7/aes/base
set env MACRO_PLACE_HALO 10 10
set env MACRO_ROWS_HALO_X 2
set env MACRO_ROWS_HALO_Y 2
set env MAKE_TRACKS ./platforms/asap7/openRoad/make_tracks.tcl
set env MATCH_CELL_FOOTPRINT 0
set env MAX_PLACE_STEP_COEF 1.05
set env MAX_REPAIR_ANTENNAS_ITER_DRT 5
set env MAX_REPAIR_ANTENNAS_ITER_GRT 5
set env MAX_ROUTING_LAYER M7
set env MIN_BUF_CELL_AND_PORTS BUFx2_ASAP7_75t_R A Y
set env MIN_CLK_ROUTING_LAYER M4
set env MIN_PLACE_STEP_COEF 0.95
set env MIN_ROUTING_LAYER M2
set env OBJECTS_DIR ./objects/asap7/aes/base
set env OPENROAD_ARGS -no_init -threads 64
set env OPENROAD_HIERARCHICAL 0
set env OPENROAD_IS_VALID true
set env OTHER_VT 
set env PDN_TCL ./platforms/asap7/openRoad/pdn/grid_strategy-M1-M2-M5-M6.tcl
set env PLACE_DENSITY 0.65
set env PLACE_SITE asap7sc7p5t
set env PLATFORM asap7
set env PLATFORM_DIR ./platforms/asap7
set env PLATFORM_TCL ./platforms/asap7/liberty_suppressions.tcl
set env PRIMARY_VT RVT
set env PRIMARY_VT_TAG R
set env PROCESS 7
set env PWR_NETS_VOLTAGES VDD 0.77
set env RCX_RULES ./platforms/asap7/rcx_patterns.rules
set env RECOVER_POWER 0
set env REMOVE_ABC_BUFFERS 0
set env REMOVE_CELLS_FOR_EQY TAPCELL*
set env REPORTS_DIR ./reports/asap7/aes/base
set env REPORT_CLOCK_SKEW 1
set env RESULTS_DEF 
set env RESULTS_DIR ./results/asap7/aes/base
set env RESULTS_GDS 
set env RESULTS_OAS 
set env ROUTING_LAYER_ADJUSTMENT 0.5
set env RTLMP_AREA_WT 0.1
set env RTLMP_BOUNDARY_WT 50.0
set env RTLMP_DATA_FLOW_DRIVEN 1
set env RTLMP_FENCE_LX 0.0
set env RTLMP_FENCE_LY 0.0
set env RTLMP_FENCE_UX 0.0
set env RTLMP_FENCE_UY 0.0
set env RTLMP_MAX_LEVEL 2
set env RTLMP_MIN_AR 0.33
set env RTLMP_NOTCH_WT 10.0
set env RTLMP_OUTLINE_WT 100.0
set env RTLMP_WIRELENGTH_WT 100.0
set env RUN_LOG_NAME_STEM run
set env SCRIPTS_DIR ./scripts
set env SC_LEF ./platforms/asap7/lef/asap7sc7p5t_28_R_1x_220121a.lef
set env SDC_FILE getenv("FLOW_HOME")/designs/asap7/aes/constraint.sdc
set env SDC_FILE_CLOCK_PERIOD ./results/asap7/aes/base/clock_period.txt
set env SEAL_GDSOAS 
set env SETUP_SLACK_MARGIN 0
set env SET_RC_TCL ./platforms/asap7/setRC.tcl
set env SKIP_ANTENNA_REPAIR 0
set env SKIP_ANTENNA_REPAIR_POST_DRT 0
set env SKIP_ANTENNA_REPAIR_PRE_GRT 0
set env SKIP_CTS_REPAIR_TIMING 0
set env SKIP_DETAILED_ROUTE 0
set env SKIP_INCREMENTAL_REPAIR 0
set env SKIP_REPAIR_TIE_FANOUT 0
set env SKIP_REPORT_METRICS 0
set env STREAM_SYSTEM GDS
set env STREAM_SYSTEM_EXT gds
set env SYNTH_GUT 0
set env SYNTH_HIERARCHICAL 0
set env SYNTH_HIER_SEPARATOR .
set env SYNTH_KEEP_MOCKED_MEMORIES 1
set env SYNTH_MEMORY_MAX_BITS 4096
set env SYNTH_MINIMUM_KEEP_SIZE 1000
set env SYNTH_MOCK_LARGE_MEMORIES 0
set env SYNTH_REPEATABLE_BUILD 0
set env SYNTH_SCRIPT getenv("FLOW_HOME")/scripts/synth.tcl
set env SYNTH_SLANG_ARGS 
set env TAPCELL_TCL ./platforms/asap7/openRoad/tapcell.tcl
set env TAP_CELL_NAME TAPCELL_ASAP7_75t_R
set env TC_NLDM_DFF_LIB_FILE ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_RVT_TT_nldm_220123.lib
set env TC_NLDM_DFF_LIB_FILE_T ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_PLACEHOLDERVT_TT_nldm_220123.lib
set env TC_NLDM_LIB_FILES ./platforms/asap7/lib/NLDM/asap7sc7p5t_AO_RVT_TT_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_INVBUF_RVT_TT_nldm_220122.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_OA_RVT_TT_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_RVT_TT_nldm_220123.lib ./platforms/asap7/lib/NLDM/asap7sc7p5t_SIMPLE_RVT_TT_nldm_211120.lib.gz
set env TC_NLDM_LIB_FILES_T ./platforms/asap7/lib/NLDM/asap7sc7p5t_AO_PLACEHOLDERVT_TT_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_INVBUF_PLACEHOLDERVT_TT_nldm_220122.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_OA_PLACEHOLDERVT_TT_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_PLACEHOLDERVT_TT_nldm_220123.lib ./platforms/asap7/lib/NLDM/asap7sc7p5t_SIMPLE_PLACEHOLDERVT_TT_nldm_211120.lib.gz
set env TC_TEMPERATURE 0C
set env TC_VOLTAGE 0.70
set env TECH_LEF ./platforms/asap7/lef/asap7_tech_1x_201209.lef
set env TEMPERATURE 25C
set env TEST_DIR getenv("FLOW_HOME")/test
set env TIEHI_CELL_AND_PORT TIEHIx1_ASAP7_75t_R H
set env TIELO_CELL_AND_PORT TIELOx1_ASAP7_75t_R L
set env TIE_SEPARATION 0
set env TIME_BIN env time
set env TIME_TEST foo
set env TNS_END_PERCENT 100
set env USE_FILL 0
set env UTILS_DIR getenv("FLOW_HOME")/util
set env VERILOG_FILES getenv("FLOW_HOME")/designs/src/aes/aes_cipher_top.v getenv("FLOW_HOME")/designs/src/aes/aes_inv_cipher_top.v getenv("FLOW_HOME")/designs/src/aes/aes_inv_sbox.v getenv("FLOW_HOME")/designs/src/aes/aes_key_expand_128.v getenv("FLOW_HOME")/designs/src/aes/aes_rcon.v getenv("FLOW_HOME")/designs/src/aes/aes_sbox.v getenv("FLOW_HOME")/designs/src/aes/timescale.v
set env VOLTAGE 0.77
set env VT_LIST  RVT
set env WC_NLDM_DFF_LIB_FILE ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_RVT_SS_nldm_220123.lib
set env WC_NLDM_DFF_LIB_FILE_T ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_PLACEHOLDERVT_SS_nldm_220123.lib
set env WC_NLDM_LIB_FILES ./platforms/asap7/lib/NLDM/asap7sc7p5t_AO_RVT_SS_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_INVBUF_RVT_SS_nldm_220122.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_OA_RVT_SS_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_RVT_SS_nldm_220123.lib ./platforms/asap7/lib/NLDM/asap7sc7p5t_SIMPLE_RVT_SS_nldm_211120.lib.gz
set env WC_NLDM_LIB_FILES_T ./platforms/asap7/lib/NLDM/asap7sc7p5t_AO_PLACEHOLDERVT_SS_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_INVBUF_PLACEHOLDERVT_SS_nldm_220122.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_OA_PLACEHOLDERVT_SS_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_PLACEHOLDERVT_SS_nldm_220123.lib ./platforms/asap7/lib/NLDM/asap7sc7p5t_SIMPLE_PLACEHOLDERVT_SS_nldm_211120.lib.gz
set env WC_TEMPERATURE 100C
set env WC_VOLTAGE 0.63
set env WORK_HOME .
set env WRAPPED_GDSOAS 
set env WRAPPED_LEFS 
set env WRAPPED_LIBS 
set env WRAP_CFG ./platforms/asap7/wrapper.cfg
set env WRITE_ODB_AND_SDC_EACH_STAGE 1
set env YOSYS_DEPENDENCIES ./platforms/asap7/lib/NLDM/asap7sc7p5t_AO_RVT_FF_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_INVBUF_RVT_FF_nldm_220122.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_OA_RVT_FF_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_SIMPLE_RVT_FF_nldm_211120.lib.gz ./platforms/asap7/lib/NLDM/asap7sc7p5t_SEQ_RVT_FF_nldm_220123.lib      getenv("FLOW_HOME")/designs/src/aes/aes_cipher_top.v getenv("FLOW_HOME")/designs/src/aes/aes_inv_cipher_top.v getenv("FLOW_HOME")/designs/src/aes/aes_inv_sbox.v getenv("FLOW_HOME")/designs/src/aes/aes_key_expand_128.v getenv("FLOW_HOME")/designs/src/aes/aes_rcon.v getenv("FLOW_HOME")/designs/src/aes/aes_sbox.v getenv("FLOW_HOME")/designs/src/aes/timescale.v  ./platforms/asap7/yoSys/cells_latch_R.v ./platforms/asap7/yoSys/cells_adders_R.v ./results/asap7/aes/base/clock_period.txt
set env YOSYS_FLAGS -v 3
set env YOSYS_IS_VALID true
