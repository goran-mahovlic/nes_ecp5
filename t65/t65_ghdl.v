// GENERIRANO: t65/gen_verilog.sh (GHDL 7.0.0-dev (6.0.0.r541.ge76fc566c.dirty) [Dunoon edition)
// izvor: t65/T65_Pack.vhd t65/T65_MCode.vhd t65/T65_ALU.vhd t65/T65.vhd ; NE UREDJIVATI RUCNO
module t65_alu_Brtl
  (input  [1:0] mode,
   input  bcd_en,
   input  [4:0] op,
   input  [7:0] busa,
   input  [7:0] busb,
   input  [7:0] p_in,
   output [7:0] p_out,
   output [7:0] q);
  wire adc_z;
  wire adc_c;
  wire adc_v;
  wire adc_n;
  wire [7:0] adc_q;
  wire sbc_z;
  wire sbc_c;
  wire sbc_v;
  wire sbc_n;
  wire [7:0] sbc_q;
  wire [7:0] sbx_q;
  wire [3:0] n3021;
  wire n3022;
  wire [4:0] n3023;
  wire [6:0] n3024;
  wire [3:0] n3025;
  wire [4:0] n3027;
  wire [6:0] n3028;
  wire [6:0] n3029;
  wire [3:0] n3030;
  wire n3031;
  wire [4:0] n3032;
  wire [6:0] n3033;
  wire [3:0] n3034;
  wire [4:0] n3036;
  wire [6:0] n3037;
  wire [6:0] n3038;
  wire [3:0] n3039;
  wire [30:0] n3040;
  wire n3042;
  wire [3:0] n3043;
  wire [30:0] n3044;
  wire n3046;
  wire n3047;
  wire n3050;
  wire [4:0] n3051;
  wire [30:0] n3052;
  wire n3054;
  wire n3055;
  wire n3056;
  wire n3057;
  wire [5:0] n3058;
  wire [5:0] n3060;
  wire [5:0] n3061;
  wire [5:0] n3062;
  wire n3063;
  wire [6:0] n3064;
  wire n3065;
  wire [6:0] n3066;
  wire n3067;
  wire n3068;
  wire [3:0] n3069;
  wire [4:0] n3070;
  wire [6:0] n3071;
  wire [3:0] n3072;
  wire [4:0] n3074;
  wire [6:0] n3075;
  wire [6:0] n3076;
  wire n3077;
  wire n3078;
  wire n3079;
  wire n3080;
  wire n3081;
  wire n3082;
  wire n3083;
  wire n3084;
  wire n3085;
  wire [4:0] n3086;
  wire [30:0] n3087;
  wire n3089;
  wire n3090;
  wire n3091;
  wire n3092;
  wire [5:0] n3093;
  wire [5:0] n3095;
  wire [5:0] n3096;
  wire [5:0] n3097;
  wire n3098;
  wire [6:0] n3099;
  wire n3100;
  wire [6:0] n3101;
  wire n3102;
  wire n3103;
  wire [6:0] n3104;
  wire [3:0] n3105;
  wire [6:0] n3106;
  wire [3:0] n3107;
  wire [7:0] n3108;
  wire n3119;
  wire n3121;
  wire n3122;
  wire n3124;
  wire n3125;
  wire n3127;
  wire n3128;
  wire n3130;
  wire n3131;
  wire n3133;
  wire n3134;
  wire n3136;
  wire n3137;
  wire n3140;
  wire n3142;
  wire n3143;
  wire n3144;
  wire [3:0] n3145;
  wire [4:0] n3146;
  wire [6:0] n3147;
  wire [3:0] n3148;
  wire [4:0] n3150;
  wire [5:0] n3151;
  wire [6:0] n3152;
  wire [6:0] n3153;
  wire [3:0] n3154;
  wire [4:0] n3156;
  wire [5:0] n3157;
  wire [3:0] n3158;
  wire n3159;
  wire [4:0] n3160;
  wire [5:0] n3161;
  wire [5:0] n3162;
  wire [3:0] n3163;
  wire [30:0] n3164;
  wire n3166;
  wire [3:0] n3167;
  wire [30:0] n3168;
  wire n3170;
  wire n3171;
  wire n3174;
  wire n3175;
  wire n3176;
  wire n3177;
  wire n3178;
  wire n3179;
  wire n3180;
  wire n3181;
  wire n3182;
  wire n3183;
  wire n3184;
  wire [3:0] n3185;
  wire [3:0] n3186;
  wire [7:0] n3187;
  wire n3188;
  wire n3189;
  wire n3190;
  wire [4:0] n3191;
  wire [4:0] n3193;
  wire [4:0] n3194;
  wire [4:0] n3195;
  wire [3:0] n3196;
  wire [4:0] n3198;
  wire [5:0] n3199;
  wire [3:0] n3200;
  wire n3201;
  wire n3202;
  wire [6:0] n3203;
  wire n3204;
  wire [4:0] n3205;
  wire [5:0] n3206;
  wire [5:0] n3207;
  wire n3208;
  wire [4:0] n3209;
  wire [4:0] n3211;
  wire [4:0] n3212;
  wire [4:0] n3213;
  wire n3214;
  wire [4:0] n3215;
  wire [4:0] n3216;
  wire n3217;
  wire n3218;
  wire [5:0] n3219;
  wire [5:0] n3220;
  wire [3:0] n3221;
  wire [6:0] n3222;
  wire [3:0] n3223;
  wire [7:0] n3224;
  wire [7:0] n3231;
  wire n3233;
  wire [7:0] n3234;
  wire n3236;
  wire [7:0] n3237;
  wire n3239;
  wire n3241;
  wire n3243;
  wire n3245;
  wire n3247;
  wire [6:0] n3248;
  wire [7:0] n3250;
  wire n3251;
  wire n3253;
  wire [6:0] n3254;
  wire n3255;
  wire [7:0] n3256;
  wire n3257;
  wire n3259;
  wire [6:0] n3260;
  wire [7:0] n3262;
  wire n3263;
  wire n3265;
  wire n3266;
  wire [6:0] n3267;
  wire [7:0] n3268;
  wire n3269;
  wire n3271;
  wire n3272;
  wire [6:0] n3273;
  wire [6:0] n3274;
  wire [6:0] n3275;
  wire [7:0] n3276;
  wire n3277;
  wire n3278;
  wire n3279;
  wire n3280;
  wire n3281;
  wire [3:0] n3282;
  wire [3:0] n3283;
  wire [3:0] n3284;
  wire n3286;
  wire [3:0] n3287;
  wire [3:0] n3289;
  wire [3:0] n3290;
  wire [3:0] n3291;
  wire [3:0] n3292;
  wire [3:0] n3293;
  wire [3:0] n3294;
  wire n3296;
  wire [3:0] n3297;
  wire [3:0] n3299;
  wire n3302;
  wire [3:0] n3303;
  wire [3:0] n3304;
  wire n3305;
  wire n3306;
  wire [7:0] n3307;
  wire [7:0] n3308;
  wire n3310;
  wire n3311;
  wire n3313;
  wire [7:0] n3315;
  wire n3317;
  wire [7:0] n3319;
  wire n3321;
  wire [14:0] n3322;
  wire n3323;
  reg n3324;
  wire n3325;
  reg n3326;
  wire n3328;
  reg [7:0] n3330;
  reg [7:0] n3331;
  wire n3333;
  wire n3335;
  wire n3337;
  wire n3338;
  wire n3340;
  wire n3341;
  wire n3343;
  wire n3344;
  wire [7:0] n3345;
  wire n3347;
  wire n3350;
  wire n3352;
  wire n3353;
  wire n3354;
  wire n3356;
  wire n3359;
  wire n3361;
  wire n3362;
  wire n3364;
  wire n3367;
  wire [4:0] n3368;
  reg n3369;
  wire n3370;
  reg n3371;
  reg n3372;
  wire [3:0] n3373;
  wire n3375;
  wire [7:0] n3376;
  wire [7:0] n3378;
  assign p_out = n3378; //(module output)
  assign q = n3376; //(module output)
  /*# t65/T65_ALU.vhd:73:15 */
  assign adc_z = n3050; // (signal)
  /*# t65/T65_ALU.vhd:74:15 */
  assign adc_c = n3103; // (signal)
  /*# t65/T65_ALU.vhd:75:15 */
  assign adc_v = n3085; // (signal)
  /*# t65/T65_ALU.vhd:76:15 */
  assign adc_n = n3077; // (signal)
  /*# t65/T65_ALU.vhd:77:15 */
  assign adc_q = n3108; // (signal)
  /*# t65/T65_ALU.vhd:78:15 */
  assign sbc_z = n3174; // (signal)
  /*# t65/T65_ALU.vhd:79:15 */
  assign sbc_c = n3176; // (signal)
  /*# t65/T65_ALU.vhd:80:15 */
  assign sbc_v = n3183; // (signal)
  /*# t65/T65_ALU.vhd:81:15 */
  assign sbc_n = n3184; // (signal)
  /*# t65/T65_ALU.vhd:82:15 */
  assign sbc_q = n3224; // (signal)
  /*# t65/T65_ALU.vhd:83:15 */
  assign sbx_q = n3187; // (signal)
  /*# t65/T65_ALU.vhd:92:31 */
  assign n3021 = busa[3:0]; // extract
  /*# t65/T65_ALU.vhd:92:50 */
  assign n3022 = p_in[0]; // extract
  /*# t65/T65_ALU.vhd:92:44 */
  assign n3023 = {n3021, n3022};
  /*# t65/T65_ALU.vhd:92:11 */
  assign n3024 = {2'b0, n3023};  // uext
  /*# t65/T65_ALU.vhd:92:86 */
  assign n3025 = busb[3:0]; // extract
  /*# t65/T65_ALU.vhd:92:99 */
  assign n3027 = {n3025, 1'b1};
  /*# t65/T65_ALU.vhd:92:66 */
  assign n3028 = {2'b0, n3027};  // uext
  /*# t65/T65_ALU.vhd:92:64 */
  assign n3029 = n3024 + n3028;
  /*# t65/T65_ALU.vhd:93:31 */
  assign n3030 = busa[7:4]; // extract
  /*# t65/T65_ALU.vhd:93:48 */
  assign n3031 = n3029[5]; // extract
  /*# t65/T65_ALU.vhd:93:44 */
  assign n3032 = {n3030, n3031};
  /*# t65/T65_ALU.vhd:93:11 */
  assign n3033 = {2'b0, n3032};  // uext
  /*# t65/T65_ALU.vhd:93:79 */
  assign n3034 = busb[7:4]; // extract
  /*# t65/T65_ALU.vhd:93:92 */
  assign n3036 = {n3034, 1'b1};
  /*# t65/T65_ALU.vhd:93:59 */
  assign n3037 = {2'b0, n3036};  // uext
  /*# t65/T65_ALU.vhd:93:57 */
  assign n3038 = n3033 + n3037;
  /*# t65/T65_ALU.vhd:100:10 */
  assign n3039 = n3029[4:1]; // extract
  /*# t65/T65_ALU.vhd:100:23 */
  assign n3040 = {27'b0, n3039};  // uext
  /*# t65/T65_ALU.vhd:100:23 */
  assign n3042 = n3040 == 31'b0000000000000000000000000000000;
  /*# t65/T65_ALU.vhd:100:33 */
  assign n3043 = n3038[4:1]; // extract
  /*# t65/T65_ALU.vhd:100:46 */
  assign n3044 = {27'b0, n3043};  // uext
  /*# t65/T65_ALU.vhd:100:46 */
  assign n3046 = n3044 == 31'b0000000000000000000000000000000;
  /*# t65/T65_ALU.vhd:100:27 */
  assign n3047 = n3046 & n3042;
  /*# t65/T65_ALU.vhd:100:5 */
  assign n3050 = n3047 ? 1'b1 : 1'b0;
  /*# t65/T65_ALU.vhd:106:10 */
  assign n3051 = n3029[5:1]; // extract
  /*# t65/T65_ALU.vhd:106:23 */
  assign n3052 = {26'b0, n3051};  // uext
  /*# t65/T65_ALU.vhd:106:23 */
  assign n3054 = $unsigned(n3052) > $unsigned(31'b0000000000000000000000000001001);
  /*# t65/T65_ALU.vhd:106:35 */
  assign n3055 = p_in[3]; // extract
  /*# t65/T65_ALU.vhd:106:27 */
  assign n3056 = n3055 & n3054;
  /*# t65/T65_ALU.vhd:106:50 */
  assign n3057 = bcd_en & n3056;
  /*# t65/T65_ALU.vhd:107:27 */
  assign n3058 = n3029[6:1]; // extract
  /*# t65/T65_ALU.vhd:107:40 */
  assign n3060 = n3058 + 6'b000110;
  /*# t65/T65_ALU.vhd:88:14 */
  assign n3061 = n3029[6:1]; // extract
  /*# t65/T65_ALU.vhd:106:5 */
  assign n3062 = n3057 ? n3060 : n3061;
  /*# t65/T65_ALU.vhd:88:14 */
  assign n3063 = n3029[0]; // extract
  /*# t65/T65_ALU.vhd:88:14 */
  assign n3064 = {n3062, n3063};
  /*# t65/T65_ALU.vhd:110:12 */
  assign n3065 = n3064[6]; // extract
  /*# t65/T65_ALU.vhd:88:14 */
  assign n3066 = {n3062, n3063};
  /*# t65/T65_ALU.vhd:110:21 */
  assign n3067 = n3066[5]; // extract
  /*# t65/T65_ALU.vhd:110:16 */
  assign n3068 = n3065 | n3067;
  /*# t65/T65_ALU.vhd:111:31 */
  assign n3069 = busa[7:4]; // extract
  /*# t65/T65_ALU.vhd:111:44 */
  assign n3070 = {n3069, n3068};
  /*# t65/T65_ALU.vhd:111:11 */
  assign n3071 = {2'b0, n3070};  // uext
  /*# t65/T65_ALU.vhd:111:75 */
  assign n3072 = busb[7:4]; // extract
  /*# t65/T65_ALU.vhd:111:88 */
  assign n3074 = {n3072, 1'b1};
  /*# t65/T65_ALU.vhd:111:55 */
  assign n3075 = {2'b0, n3074};  // uext
  /*# t65/T65_ALU.vhd:111:53 */
  assign n3076 = n3071 + n3075;
  /*# t65/T65_ALU.vhd:113:16 */
  assign n3077 = n3076[4]; // extract
  /*# t65/T65_ALU.vhd:114:17 */
  assign n3078 = n3076[4]; // extract
  /*# t65/T65_ALU.vhd:114:29 */
  assign n3079 = busa[7]; // extract
  /*# t65/T65_ALU.vhd:114:21 */
  assign n3080 = n3078 ^ n3079;
  /*# t65/T65_ALU.vhd:114:47 */
  assign n3081 = busa[7]; // extract
  /*# t65/T65_ALU.vhd:114:59 */
  assign n3082 = busb[7]; // extract
  /*# t65/T65_ALU.vhd:114:51 */
  assign n3083 = n3081 ^ n3082;
  /*# t65/T65_ALU.vhd:114:38 */
  assign n3084 = ~n3083;
  /*# t65/T65_ALU.vhd:114:34 */
  assign n3085 = n3080 & n3084;
  /*# t65/T65_ALU.vhd:120:10 */
  assign n3086 = n3076[5:1]; // extract
  /*# t65/T65_ALU.vhd:120:23 */
  assign n3087 = {26'b0, n3086};  // uext
  /*# t65/T65_ALU.vhd:120:23 */
  assign n3089 = $unsigned(n3087) > $unsigned(31'b0000000000000000000000000001001);
  /*# t65/T65_ALU.vhd:120:35 */
  assign n3090 = p_in[3]; // extract
  /*# t65/T65_ALU.vhd:120:27 */
  assign n3091 = n3090 & n3089;
  /*# t65/T65_ALU.vhd:120:50 */
  assign n3092 = bcd_en & n3091;
  /*# t65/T65_ALU.vhd:121:27 */
  assign n3093 = n3076[6:1]; // extract
  /*# t65/T65_ALU.vhd:121:40 */
  assign n3095 = n3093 + 6'b000110;
  /*# t65/T65_ALU.vhd:89:14 */
  assign n3096 = n3076[6:1]; // extract
  /*# t65/T65_ALU.vhd:120:5 */
  assign n3097 = n3092 ? n3095 : n3096;
  /*# t65/T65_ALU.vhd:89:14 */
  assign n3098 = n3076[0]; // extract
  /*# t65/T65_ALU.vhd:89:14 */
  assign n3099 = {n3097, n3098};
  /*# t65/T65_ALU.vhd:124:16 */
  assign n3100 = n3099[6]; // extract
  /*# t65/T65_ALU.vhd:89:14 */
  assign n3101 = {n3097, n3098};
  /*# t65/T65_ALU.vhd:124:25 */
  assign n3102 = n3101[5]; // extract
  /*# t65/T65_ALU.vhd:124:20 */
  assign n3103 = n3100 | n3102;
  /*# t65/T65_ALU.vhd:89:14 */
  assign n3104 = {n3097, n3098};
  /*# t65/T65_ALU.vhd:126:33 */
  assign n3105 = n3104[4:1]; // extract
  /*# t65/T65_ALU.vhd:88:14 */
  assign n3106 = {n3062, n3063};
  /*# t65/T65_ALU.vhd:126:50 */
  assign n3107 = n3106[4:1]; // extract
  /*# t65/T65_ALU.vhd:126:46 */
  assign n3108 = {n3105, n3107};
  /*# t65/T65_ALU.vhd:136:12 */
  assign n3119 = op == 5'b00001;
  /*# t65/T65_ALU.vhd:137:12 */
  assign n3121 = op == 5'b00011;
  /*# t65/T65_ALU.vhd:136:24 */
  assign n3122 = n3119 | n3121;
  /*# t65/T65_ALU.vhd:138:12 */
  assign n3124 = op == 5'b00101;
  /*# t65/T65_ALU.vhd:137:24 */
  assign n3125 = n3122 | n3124;
  /*# t65/T65_ALU.vhd:139:12 */
  assign n3127 = op == 5'b00111;
  /*# t65/T65_ALU.vhd:138:24 */
  assign n3128 = n3125 | n3127;
  /*# t65/T65_ALU.vhd:140:12 */
  assign n3130 = op == 5'b01001;
  /*# t65/T65_ALU.vhd:139:24 */
  assign n3131 = n3128 | n3130;
  /*# t65/T65_ALU.vhd:141:12 */
  assign n3133 = op == 5'b01011;
  /*# t65/T65_ALU.vhd:140:24 */
  assign n3134 = n3131 | n3133;
  /*# t65/T65_ALU.vhd:143:12 */
  assign n3136 = op == 5'b01110;
  /*# t65/T65_ALU.vhd:141:24 */
  assign n3137 = n3134 | n3136;
  /*# t65/T65_ALU.vhd:136:5 */
  assign n3140 = n3137 ? 1'b1 : 1'b0;
  /*# t65/T65_ALU.vhd:148:14 */
  assign n3142 = p_in[0]; // extract
  /*# t65/T65_ALU.vhd:148:26 */
  assign n3143 = ~n3140;
  /*# t65/T65_ALU.vhd:148:23 */
  assign n3144 = n3142 | n3143;
  /*# t65/T65_ALU.vhd:149:31 */
  assign n3145 = busa[3:0]; // extract
  /*# t65/T65_ALU.vhd:149:44 */
  assign n3146 = {n3145, n3144};
  /*# t65/T65_ALU.vhd:149:11 */
  assign n3147 = {2'b0, n3146};  // uext
  /*# t65/T65_ALU.vhd:149:75 */
  assign n3148 = busb[3:0]; // extract
  /*# t65/T65_ALU.vhd:149:88 */
  assign n3150 = {n3148, 1'b1};
  /*# t65/T65_ALU.vhd:149:55 */
  assign n3151 = {1'b0, n3150};  // uext
  /*# t65/T65_ALU.vhd:149:53 */
  assign n3152 = {1'b0, n3151};  // uext
  /*# t65/T65_ALU.vhd:149:53 */
  assign n3153 = n3147 - n3152;
  /*# t65/T65_ALU.vhd:150:31 */
  assign n3154 = busa[7:4]; // extract
  /*# t65/T65_ALU.vhd:150:44 */
  assign n3156 = {n3154, 1'b0};
  /*# t65/T65_ALU.vhd:150:11 */
  assign n3157 = {1'b0, n3156};  // uext
  /*# t65/T65_ALU.vhd:150:77 */
  assign n3158 = busb[7:4]; // extract
  /*# t65/T65_ALU.vhd:150:94 */
  assign n3159 = n3153[5]; // extract
  /*# t65/T65_ALU.vhd:150:90 */
  assign n3160 = {n3158, n3159};
  /*# t65/T65_ALU.vhd:150:57 */
  assign n3161 = {1'b0, n3160};  // uext
  /*# t65/T65_ALU.vhd:150:55 */
  assign n3162 = n3157 - n3161;
  /*# t65/T65_ALU.vhd:157:10 */
  assign n3163 = n3153[4:1]; // extract
  /*# t65/T65_ALU.vhd:157:23 */
  assign n3164 = {27'b0, n3163};  // uext
  /*# t65/T65_ALU.vhd:157:23 */
  assign n3166 = n3164 == 31'b0000000000000000000000000000000;
  /*# t65/T65_ALU.vhd:157:33 */
  assign n3167 = n3162[4:1]; // extract
  /*# t65/T65_ALU.vhd:157:46 */
  assign n3168 = {27'b0, n3167};  // uext
  /*# t65/T65_ALU.vhd:157:46 */
  assign n3170 = n3168 == 31'b0000000000000000000000000000000;
  /*# t65/T65_ALU.vhd:157:27 */
  assign n3171 = n3170 & n3166;
  /*# t65/T65_ALU.vhd:157:5 */
  assign n3174 = n3171 ? 1'b1 : 1'b0;
  /*# t65/T65_ALU.vhd:163:20 */
  assign n3175 = n3162[5]; // extract
  /*# t65/T65_ALU.vhd:163:14 */
  assign n3176 = ~n3175;
  /*# t65/T65_ALU.vhd:164:17 */
  assign n3177 = n3162[4]; // extract
  /*# t65/T65_ALU.vhd:164:29 */
  assign n3178 = busa[7]; // extract
  /*# t65/T65_ALU.vhd:164:21 */
  assign n3179 = n3177 ^ n3178;
  /*# t65/T65_ALU.vhd:164:43 */
  assign n3180 = busa[7]; // extract
  /*# t65/T65_ALU.vhd:164:55 */
  assign n3181 = busb[7]; // extract
  /*# t65/T65_ALU.vhd:164:47 */
  assign n3182 = n3180 ^ n3181;
  /*# t65/T65_ALU.vhd:164:34 */
  assign n3183 = n3179 & n3182;
  /*# t65/T65_ALU.vhd:165:16 */
  assign n3184 = n3162[4]; // extract
  /*# t65/T65_ALU.vhd:167:33 */
  assign n3185 = n3162[4:1]; // extract
  /*# t65/T65_ALU.vhd:167:50 */
  assign n3186 = n3153[4:1]; // extract
  /*# t65/T65_ALU.vhd:167:46 */
  assign n3187 = {n3185, n3186};
  /*# t65/T65_ALU.vhd:169:12 */
  assign n3188 = p_in[3]; // extract
  /*# t65/T65_ALU.vhd:169:27 */
  assign n3189 = bcd_en & n3188;
  /*# t65/T65_ALU.vhd:170:12 */
  assign n3190 = n3153[5]; // extract
  /*# t65/T65_ALU.vhd:171:29 */
  assign n3191 = n3153[5:1]; // extract
  /*# t65/T65_ALU.vhd:171:42 */
  assign n3193 = n3191 - 5'b00110;
  /*# t65/T65_ALU.vhd:130:14 */
  assign n3194 = n3153[5:1]; // extract
  /*# t65/T65_ALU.vhd:170:7 */
  assign n3195 = n3190 ? n3193 : n3194;
  /*# t65/T65_ALU.vhd:173:33 */
  assign n3196 = busa[7:4]; // extract
  /*# t65/T65_ALU.vhd:173:46 */
  assign n3198 = {n3196, 1'b0};
  /*# t65/T65_ALU.vhd:173:13 */
  assign n3199 = {1'b0, n3198};  // uext
  /*# t65/T65_ALU.vhd:173:79 */
  assign n3200 = busb[7:4]; // extract
  /*# t65/T65_ALU.vhd:130:14 */
  assign n3201 = n3153[0]; // extract
  /*# t65/T65_ALU.vhd:130:14 */
  assign n3202 = n3153[6]; // extract
  /*# t65/T65_ALU.vhd:130:14 */
  assign n3203 = {n3202, n3195, n3201};
  /*# t65/T65_ALU.vhd:173:96 */
  assign n3204 = n3203[6]; // extract
  /*# t65/T65_ALU.vhd:173:92 */
  assign n3205 = {n3200, n3204};
  /*# t65/T65_ALU.vhd:173:59 */
  assign n3206 = {1'b0, n3205};  // uext
  /*# t65/T65_ALU.vhd:173:57 */
  assign n3207 = n3199 - n3206;
  /*# t65/T65_ALU.vhd:174:12 */
  assign n3208 = n3207[5]; // extract
  /*# t65/T65_ALU.vhd:175:29 */
  assign n3209 = n3207[5:1]; // extract
  /*# t65/T65_ALU.vhd:175:42 */
  assign n3211 = n3209 - 5'b00110;
  /*# t65/T65_ALU.vhd:131:14 */
  assign n3212 = n3207[5:1]; // extract
  /*# t65/T65_ALU.vhd:174:7 */
  assign n3213 = n3208 ? n3211 : n3212;
  /*# t65/T65_ALU.vhd:131:14 */
  assign n3214 = n3207[0]; // extract
  /*# t65/T65_ALU.vhd:130:14 */
  assign n3215 = n3153[5:1]; // extract
  /*# t65/T65_ALU.vhd:169:5 */
  assign n3216 = n3189 ? n3195 : n3215;
  /*# t65/T65_ALU.vhd:130:14 */
  assign n3217 = n3153[6]; // extract
  /*# t65/T65_ALU.vhd:130:14 */
  assign n3218 = n3153[0]; // extract
  /*# t65/T65_ALU.vhd:169:5 */
  assign n3219 = {n3213, n3214};
  /*# t65/T65_ALU.vhd:169:5 */
  assign n3220 = n3189 ? n3219 : n3162;
  /*# t65/T65_ALU.vhd:179:33 */
  assign n3221 = n3220[4:1]; // extract
  /*# t65/T65_ALU.vhd:130:14 */
  assign n3222 = {n3217, n3216, n3218};
  /*# t65/T65_ALU.vhd:179:50 */
  assign n3223 = n3222[4:1]; // extract
  /*# t65/T65_ALU.vhd:179:46 */
  assign n3224 = {n3221, n3223};
  /*# t65/T65_ALU.vhd:196:21 */
  assign n3231 = busa | busb;
  /*# t65/T65_ALU.vhd:195:7 */
  assign n3233 = op == 5'b00000;
  /*# t65/T65_ALU.vhd:198:21 */
  assign n3234 = busa & busb;
  /*# t65/T65_ALU.vhd:197:7 */
  assign n3236 = op == 5'b00001;
  /*# t65/T65_ALU.vhd:200:21 */
  assign n3237 = busa ^ busb;
  /*# t65/T65_ALU.vhd:199:7 */
  assign n3239 = op == 5'b00010;
  /*# t65/T65_ALU.vhd:201:7 */
  assign n3241 = op == 5'b00011;
  /*# t65/T65_ALU.vhd:205:7 */
  assign n3243 = op == 5'b00110;
  /*# t65/T65_ALU.vhd:207:7 */
  assign n3245 = op == 5'b10001;
  /*# t65/T65_ALU.vhd:210:7 */
  assign n3247 = op == 5'b00111;
  /*# t65/T65_ALU.vhd:215:20 */
  assign n3248 = busa[6:0]; // extract
  /*# t65/T65_ALU.vhd:215:33 */
  assign n3250 = {n3248, 1'b0};
  /*# t65/T65_ALU.vhd:216:30 */
  assign n3251 = busa[7]; // extract
  /*# t65/T65_ALU.vhd:214:7 */
  assign n3253 = op == 5'b01000;
  /*# t65/T65_ALU.vhd:218:20 */
  assign n3254 = busa[6:0]; // extract
  /*# t65/T65_ALU.vhd:218:39 */
  assign n3255 = p_in[0]; // extract
  /*# t65/T65_ALU.vhd:218:33 */
  assign n3256 = {n3254, n3255};
  /*# t65/T65_ALU.vhd:219:30 */
  assign n3257 = busa[7]; // extract
  /*# t65/T65_ALU.vhd:217:7 */
  assign n3259 = op == 5'b01001;
  /*# t65/T65_ALU.vhd:221:26 */
  assign n3260 = busa[7:1]; // extract
  /*# t65/T65_ALU.vhd:221:20 */
  assign n3262 = {1'b0, n3260};
  /*# t65/T65_ALU.vhd:222:30 */
  assign n3263 = busa[0]; // extract
  /*# t65/T65_ALU.vhd:220:7 */
  assign n3265 = op == 5'b01010;
  /*# t65/T65_ALU.vhd:224:20 */
  assign n3266 = p_in[0]; // extract
  /*# t65/T65_ALU.vhd:224:35 */
  assign n3267 = busa[7:1]; // extract
  /*# t65/T65_ALU.vhd:224:29 */
  assign n3268 = {n3266, n3267};
  /*# t65/T65_ALU.vhd:225:30 */
  assign n3269 = busa[0]; // extract
  /*# t65/T65_ALU.vhd:223:7 */
  assign n3271 = op == 5'b01011;
  /*# t65/T65_ALU.vhd:227:20 */
  assign n3272 = p_in[0]; // extract
  /*# t65/T65_ALU.vhd:227:36 */
  assign n3273 = busa[7:1]; // extract
  /*# t65/T65_ALU.vhd:227:57 */
  assign n3274 = busb[7:1]; // extract
  /*# t65/T65_ALU.vhd:227:49 */
  assign n3275 = n3273 & n3274;
  /*# t65/T65_ALU.vhd:227:29 */
  assign n3276 = {n3272, n3275};
  /*# t65/T65_ALU.vhd:228:29 */
  assign n3277 = n3276[5]; // extract
  /*# t65/T65_ALU.vhd:228:40 */
  assign n3278 = n3276[6]; // extract
  /*# t65/T65_ALU.vhd:228:33 */
  assign n3279 = n3277 ^ n3278;
  /*# t65/T65_ALU.vhd:230:16 */
  assign n3280 = p_in[3]; // extract
  /*# t65/T65_ALU.vhd:230:29 */
  assign n3281 = bcd_en & n3280;
  /*# t65/T65_ALU.vhd:231:19 */
  assign n3282 = busa[3:0]; // extract
  /*# t65/T65_ALU.vhd:231:40 */
  assign n3283 = busb[3:0]; // extract
  /*# t65/T65_ALU.vhd:231:32 */
  assign n3284 = n3282 & n3283;
  /*# t65/T65_ALU.vhd:231:54 */
  assign n3286 = $unsigned(n3284) > $unsigned(4'b0100);
  /*# t65/T65_ALU.vhd:232:62 */
  assign n3287 = n3276[3:0]; // extract
  /*# t65/T65_ALU.vhd:232:76 */
  assign n3289 = n3287 + 4'b0110;
  /*# t65/T65_ALU.vhd:187:14 */
  assign n3290 = n3276[3:0]; // extract
  /*# t65/T65_ALU.vhd:231:11 */
  assign n3291 = n3286 ? n3289 : n3290;
  /*# t65/T65_ALU.vhd:234:19 */
  assign n3292 = busa[7:4]; // extract
  /*# t65/T65_ALU.vhd:234:40 */
  assign n3293 = busb[7:4]; // extract
  /*# t65/T65_ALU.vhd:234:32 */
  assign n3294 = n3292 & n3293;
  /*# t65/T65_ALU.vhd:234:54 */
  assign n3296 = $unsigned(n3294) > $unsigned(4'b0100);
  /*# t65/T65_ALU.vhd:235:62 */
  assign n3297 = n3276[7:4]; // extract
  /*# t65/T65_ALU.vhd:235:76 */
  assign n3299 = n3297 + 4'b0110;
  /*# t65/T65_ALU.vhd:234:11 */
  assign n3302 = n3296 ? 1'b1 : 1'b0;
  /*# t65/T65_ALU.vhd:187:14 */
  assign n3303 = n3276[7:4]; // extract
  /*# t65/T65_ALU.vhd:234:11 */
  assign n3304 = n3296 ? n3299 : n3303;
  /*# t65/T65_ALU.vhd:241:31 */
  assign n3305 = n3276[6]; // extract
  /*# t65/T65_ALU.vhd:230:9 */
  assign n3306 = n3281 ? n3302 : n3305;
  /*# t65/T65_ALU.vhd:230:9 */
  assign n3307 = {n3304, n3291};
  /*# t65/T65_ALU.vhd:230:9 */
  assign n3308 = n3281 ? n3307 : n3276;
  /*# t65/T65_ALU.vhd:226:7 */
  assign n3310 = op == 5'b01111;
  /*# t65/T65_ALU.vhd:244:30 */
  assign n3311 = busb[6]; // extract
  /*# t65/T65_ALU.vhd:243:7 */
  assign n3313 = op == 5'b01100;
  /*# t65/T65_ALU.vhd:246:48 */
  assign n3315 = busa - 8'b00000001;
  /*# t65/T65_ALU.vhd:245:7 */
  assign n3317 = op == 5'b01101;
  /*# t65/T65_ALU.vhd:248:48 */
  assign n3319 = busa + 8'b00000001;
  /*# t65/T65_ALU.vhd:247:7 */
  assign n3321 = op == 5'b01110;
  /*# t65/T65_ALU.vhd:194:5 */
  assign n3322 = {n3321, n3317, n3313, n3310, n3271, n3265, n3259, n3253, n3247, n3245, n3243, n3241, n3239, n3236, n3233};
  /*# t65/T65_ALU.vhd:65:5 */
  assign n3323 = p_in[0]; // extract
  /*# t65/T65_ALU.vhd:194:5 */
  always @*
    case (n3322)
      15'b100000000000000: n3324 = n3323;
      15'b010000000000000: n3324 = n3323;
      15'b001000000000000: n3324 = n3323;
      15'b000100000000000: n3324 = n3306;
      15'b000010000000000: n3324 = n3269;
      15'b000001000000000: n3324 = n3263;
      15'b000000100000000: n3324 = n3257;
      15'b000000010000000: n3324 = n3251;
      15'b000000001000000: n3324 = sbc_c;
      15'b000000000100000: n3324 = sbc_c;
      15'b000000000010000: n3324 = sbc_c;
      15'b000000000001000: n3324 = adc_c;
      15'b000000000000100: n3324 = n3323;
      15'b000000000000010: n3324 = n3323;
      15'b000000000000001: n3324 = n3323;
      default: n3324 = n3323;
    endcase
  /*# t65/T65_ALU.vhd:65:5 */
  assign n3325 = p_in[6]; // extract
  /*# t65/T65_ALU.vhd:194:5 */
  always @*
    case (n3322)
      15'b100000000000000: n3326 = n3325;
      15'b010000000000000: n3326 = n3325;
      15'b001000000000000: n3326 = n3311;
      15'b000100000000000: n3326 = n3279;
      15'b000010000000000: n3326 = n3325;
      15'b000001000000000: n3326 = n3325;
      15'b000000100000000: n3326 = n3325;
      15'b000000010000000: n3326 = n3325;
      15'b000000001000000: n3326 = sbc_v;
      15'b000000000100000: n3326 = n3325;
      15'b000000000010000: n3326 = n3325;
      15'b000000000001000: n3326 = adc_v;
      15'b000000000000100: n3326 = n3325;
      15'b000000000000010: n3326 = n3325;
      15'b000000000000001: n3326 = n3325;
      default: n3326 = n3325;
    endcase
  /*# t65/T65_ALU.vhd:65:5 */
  assign n3328 = p_in[7]; // extract
  /*# t65/T65_ALU.vhd:194:5 */
  always @*
    case (n3322)
      15'b100000000000000: n3330 = n3319;
      15'b010000000000000: n3330 = n3315;
      15'b001000000000000: n3330 = busa;
      15'b000100000000000: n3330 = n3276;
      15'b000010000000000: n3330 = n3268;
      15'b000001000000000: n3330 = n3262;
      15'b000000100000000: n3330 = n3256;
      15'b000000010000000: n3330 = n3250;
      15'b000000001000000: n3330 = sbc_q;
      15'b000000000100000: n3330 = sbx_q;
      15'b000000000010000: n3330 = busa;
      15'b000000000001000: n3330 = adc_q;
      15'b000000000000100: n3330 = n3237;
      15'b000000000000010: n3330 = n3234;
      15'b000000000000001: n3330 = n3231;
      default: n3330 = busa;
    endcase
  /*# t65/T65_ALU.vhd:194:5 */
  always @*
    case (n3322)
      15'b100000000000000: n3331 = busa;
      15'b010000000000000: n3331 = busa;
      15'b001000000000000: n3331 = busa;
      15'b000100000000000: n3331 = n3308;
      15'b000010000000000: n3331 = busa;
      15'b000001000000000: n3331 = busa;
      15'b000000100000000: n3331 = busa;
      15'b000000010000000: n3331 = busa;
      15'b000000001000000: n3331 = busa;
      15'b000000000100000: n3331 = busa;
      15'b000000000010000: n3331 = busa;
      15'b000000000001000: n3331 = busa;
      15'b000000000000100: n3331 = busa;
      15'b000000000000010: n3331 = busa;
      15'b000000000000001: n3331 = busa;
      default: n3331 = busa;
    endcase
  /*# t65/T65_ALU.vhd:255:7 */
  assign n3333 = op == 5'b00011;
  /*# t65/T65_ALU.vhd:258:7 */
  assign n3335 = op == 5'b00110;
  /*# t65/T65_ALU.vhd:258:22 */
  assign n3337 = op == 5'b00111;
  /*# t65/T65_ALU.vhd:258:22 */
  assign n3338 = n3335 | n3337;
  /*# t65/T65_ALU.vhd:258:33 */
  assign n3340 = op == 5'b10001;
  /*# t65/T65_ALU.vhd:258:33 */
  assign n3341 = n3338 | n3340;
  /*# t65/T65_ALU.vhd:261:7 */
  assign n3343 = op == 5'b00100;
  /*# t65/T65_ALU.vhd:263:30 */
  assign n3344 = busb[7]; // extract
  /*# t65/T65_ALU.vhd:264:18 */
  assign n3345 = busa & busb;
  /*# t65/T65_ALU.vhd:264:28 */
  assign n3347 = n3345 == 8'b00000000;
  /*# t65/T65_ALU.vhd:264:9 */
  assign n3350 = n3347 ? 1'b1 : 1'b0;
  /*# t65/T65_ALU.vhd:262:7 */
  assign n3352 = op == 5'b01100;
  /*# t65/T65_ALU.vhd:270:29 */
  assign n3353 = n3330[7]; // extract
  /*# t65/T65_ALU.vhd:271:29 */
  assign n3354 = n3330[7]; // extract
  /*# t65/T65_ALU.vhd:272:16 */
  assign n3356 = n3330 == 8'b00000000;
  /*# t65/T65_ALU.vhd:272:9 */
  assign n3359 = n3356 ? 1'b1 : 1'b0;
  /*# t65/T65_ALU.vhd:269:7 */
  assign n3361 = op == 5'b10000;
  /*# t65/T65_ALU.vhd:278:29 */
  assign n3362 = n3330[7]; // extract
  /*# t65/T65_ALU.vhd:279:16 */
  assign n3364 = n3330 == 8'b00000000;
  /*# t65/T65_ALU.vhd:279:9 */
  assign n3367 = n3364 ? 1'b1 : 1'b0;
  /*# t65/T65_ALU.vhd:254:5 */
  assign n3368 = {n3361, n3352, n3343, n3341, n3333};
  /*# t65/T65_ALU.vhd:254:5 */
  always @*
    case (n3368)
      5'b10000: n3369 = n3354;
      5'b01000: n3369 = n3324;
      5'b00100: n3369 = n3324;
      5'b00010: n3369 = n3324;
      5'b00001: n3369 = n3324;
      default: n3369 = n3324;
    endcase
  /*# t65/T65_ALU.vhd:65:5 */
  assign n3370 = p_in[1]; // extract
  /*# t65/T65_ALU.vhd:254:5 */
  always @*
    case (n3368)
      5'b10000: n3371 = n3359;
      5'b01000: n3371 = n3350;
      5'b00100: n3371 = n3370;
      5'b00010: n3371 = sbc_z;
      5'b00001: n3371 = adc_z;
      default: n3371 = n3367;
    endcase
  /*# t65/T65_ALU.vhd:254:5 */
  always @*
    case (n3368)
      5'b10000: n3372 = n3353;
      5'b01000: n3372 = n3344;
      5'b00100: n3372 = n3328;
      5'b00010: n3372 = sbc_n;
      5'b00001: n3372 = adc_n;
      default: n3372 = n3362;
    endcase
  /*# t65/T65_ALU.vhd:65:5 */
  assign n3373 = p_in[5:2]; // extract
  /*# t65/T65_ALU.vhd:286:10 */
  assign n3375 = op == 5'b01111;
  /*# t65/T65_ALU.vhd:286:5 */
  assign n3376 = n3375 ? n3331 : n3330;
  /*# t65/T65_ALU.vhd:65:5 */
  assign n3378 = {n3372, n3326, n3373, n3371, n3369};
endmodule

module t65_mcode_Brtl
  (input  [1:0] mode,
   input  [7:0] ir,
   input  [2:0] mcycle,
   input  [7:0] p,
   output [2:0] lcycle,
   output [4:0] alu_op,
   output [3:0] set_busa_to,
   output [1:0] set_addr_to,
   output [3:0] write_data,
   output [1:0] jump,
   output [1:0] baadd,
   output breakatna,
   output adadd,
   output addy,
   output pcadd,
   output inc_s,
   output dec_s,
   output lda,
   output ldp,
   output ldx,
   output ldy,
   output lds,
   output lddi,
   output ldalu,
   output ldad,
   output ldbal,
   output ldbah,
   output savep,
   output write);
  wire branch;
  wire alumore;
  wire [2:0] n874;
  wire n875;
  wire n876;
  wire n878;
  wire n879;
  wire n881;
  wire n882;
  wire n883;
  wire n885;
  wire n886;
  wire n888;
  wire n889;
  wire n890;
  wire n892;
  wire n893;
  wire n895;
  wire n896;
  wire n897;
  wire n899;
  wire n900;
  wire [6:0] n901;
  reg n902;
  wire [2:0] n905;
  wire [1:0] n906;
  wire [2:0] n907;
  wire n909;
  wire [3:0] n912;
  wire n914;
  wire [2:0] n915;
  wire n917;
  wire [3:0] n920;
  wire n922;
  wire [2:0] n923;
  wire n925;
  wire [3:0] n928;
  wire n931;
  wire [2:0] n932;
  wire n934;
  wire [2:0] n935;
  wire n937;
  wire n938;
  wire [2:0] n939;
  wire n941;
  wire n942;
  wire [3:0] n945;
  wire n947;
  wire [2:0] n948;
  reg [3:0] n952;
  reg [3:0] n954;
  reg n956;
  wire n958;
  wire [1:0] n959;
  wire n960;
  wire n962;
  wire n963;
  wire n965;
  wire n966;
  wire n969;
  wire n971;
  wire n973;
  wire n975;
  wire [2:0] n976;
  wire n978;
  wire [3:0] n981;
  wire n984;
  wire [2:0] n985;
  reg [3:0] n987;
  reg n992;
  reg n996;
  reg n998;
  reg n1000;
  wire n1002;
  wire [1:0] n1003;
  wire n1004;
  wire n1005;
  wire n1008;
  wire n1010;
  reg [3:0] n1013;
  reg n1015;
  wire n1017;
  wire [1:0] n1018;
  wire n1019;
  wire n1020;
  wire n1023;
  wire n1025;
  reg [3:0] n1028;
  reg n1030;
  wire n1032;
  wire [3:0] n1033;
  reg [3:0] n1035;
  reg [3:0] n1038;
  reg n1041;
  reg n1044;
  reg n1047;
  reg n1050;
  wire [1:0] n1052;
  wire n1054;
  wire n1055;
  wire n1056;
  wire n1058;
  wire n1059;
  wire n1060;
  wire n1061;
  wire n1062;
  wire n1064;
  wire [3:0] n1067;
  wire [3:0] n1068;
  wire [4:0] n1069;
  wire n1071;
  wire n1073;
  wire n1075;
  wire n1077;
  wire n1079;
  wire n1081;
  wire [5:0] n1082;
  reg [1:0] n1089;
  reg [3:0] n1093;
  reg [1:0] n1096;
  reg n1101;
  reg n1104;
  reg n1109;
  wire n1111;
  wire n1113;
  wire n1115;
  wire n1117;
  wire n1119;
  wire n1121;
  wire [4:0] n1122;
  reg [1:0] n1127;
  reg [3:0] n1130;
  reg [1:0] n1134;
  reg n1138;
  reg n1141;
  reg n1145;
  wire n1147;
  wire n1149;
  wire n1151;
  wire n1153;
  wire n1155;
  wire n1157;
  wire [4:0] n1158;
  reg [3:0] n1160;
  reg [1:0] n1166;
  reg [1:0] n1169;
  reg n1174;
  reg n1177;
  reg n1180;
  wire n1182;
  wire n1184;
  wire n1186;
  wire n1188;
  wire n1190;
  wire n1192;
  wire [4:0] n1193;
  reg [1:0] n1198;
  reg [1:0] n1202;
  reg n1206;
  reg n1209;
  wire n1211;
  wire n1213;
  wire n1214;
  wire n1215;
  wire [2:0] n1218;
  wire n1221;
  wire n1222;
  wire n1223;
  wire n1224;
  wire [3:0] n1225;
  wire n1227;
  wire n1229;
  wire n1231;
  wire [3:0] n1233;
  wire n1236;
  wire n1238;
  wire n1240;
  wire [3:0] n1242;
  wire n1245;
  wire n1247;
  wire [3:0] n1248;
  reg [3:0] n1251;
  reg n1253;
  wire [1:0] n1257;
  wire [3:0] n1258;
  wire n1260;
  wire n1262;
  wire n1264;
  wire [1:0] n1265;
  reg [1:0] n1267;
  reg [3:0] n1268;
  reg n1271;
  reg n1273;
  wire n1275;
  wire n1277;
  wire n1278;
  wire n1280;
  wire n1281;
  wire n1283;
  wire n1284;
  wire n1286;
  wire n1287;
  wire n1288;
  wire [2:0] n1291;
  wire [3:0] n1293;
  wire n1295;
  wire n1297;
  wire n1299;
  wire n1301;
  wire n1303;
  wire n1305;
  wire n1307;
  wire n1309;
  wire [3:0] n1310;
  reg n1312;
  reg n1315;
  reg n1316;
  reg n1317;
  wire n1319;
  wire n1320;
  wire n1321;
  wire n1322;
  wire n1325;
  wire n1327;
  wire n1329;
  wire n1330;
  wire n1331;
  wire n1332;
  wire [1:0] n1335;
  wire n1337;
  wire n1339;
  wire n1341;
  wire n1343;
  wire [3:0] n1344;
  reg [3:0] n1346;
  reg [1:0] n1349;
  reg n1352;
  reg n1354;
  reg n1356;
  wire n1358;
  wire n1360;
  wire n1361;
  wire n1363;
  wire n1364;
  wire n1366;
  wire n1367;
  wire n1369;
  wire n1371;
  wire [1:0] n1372;
  reg [1:0] n1375;
  wire n1377;
  wire n1379;
  wire n1380;
  wire n1382;
  wire n1383;
  wire n1385;
  wire n1387;
  wire [1:0] n1388;
  reg [3:0] n1390;
  wire n1392;
  wire n1394;
  wire n1396;
  wire [1:0] n1397;
  reg [3:0] n1399;
  wire n1401;
  wire n1403;
  wire n1405;
  wire n1407;
  wire n1409;
  wire [1:0] n1410;
  reg [3:0] n1412;
  wire n1414;
  wire n1416;
  wire n1417;
  wire n1424;
  wire n1426;
  wire n1427;
  wire n1429;
  wire n1430;
  wire n1432;
  wire n1433;
  wire n1440;
  wire n1442;
  wire n1443;
  wire n1445;
  wire n1447;
  wire [1:0] n1448;
  reg [3:0] n1450;
  wire n1452;
  wire n1454;
  wire n1455;
  wire n1457;
  wire n1459;
  wire n1461;
  wire [1:0] n1462;
  reg [3:0] n1464;
  wire n1466;
  wire n1468;
  wire n1470;
  wire [1:0] n1471;
  reg [1:0] n1474;
  wire n1476;
  wire [15:0] n1479;
  reg [2:0] n1485;
  reg [3:0] n1487;
  reg [1:0] n1489;
  reg [3:0] n1490;
  reg [1:0] n1492;
  reg n1494;
  reg n1496;
  reg n1499;
  reg n1501;
  reg n1504;
  reg n1506;
  reg n1508;
  reg n1510;
  reg n1512;
  reg n1514;
  wire n1516;
  wire n1518;
  wire n1519;
  wire n1521;
  wire n1522;
  wire n1524;
  wire n1525;
  wire n1527;
  wire n1528;
  wire [1:0] n1529;
  wire n1531;
  wire n1533;
  wire n1534;
  wire n1535;
  wire [2:0] n1538;
  wire [2:0] n1540;
  wire n1543;
  wire n1545;
  wire n1547;
  wire n1549;
  wire [2:0] n1550;
  wire n1552;
  wire n1555;
  wire n1557;
  wire n1559;
  wire n1560;
  wire n1561;
  wire [1:0] n1562;
  wire n1564;
  wire n1565;
  wire [1:0] n1568;
  wire n1571;
  wire n1574;
  wire n1576;
  wire n1578;
  wire n1580;
  wire [6:0] n1581;
  reg [3:0] n1583;
  reg [1:0] n1590;
  reg [1:0] n1593;
  reg [1:0] n1596;
  reg n1599;
  reg n1601;
  reg n1604;
  reg n1607;
  reg n1610;
  reg n1613;
  reg n1616;
  reg n1619;
  reg n1622;
  wire n1624;
  wire n1626;
  wire n1627;
  wire [2:0] n1628;
  wire n1630;
  wire n1632;
  wire n1634;
  reg [1:0] n1637;
  wire n1639;
  wire n1641;
  wire [2:0] n1642;
  wire n1644;
  wire n1646;
  wire n1647;
  wire n1649;
  wire n1650;
  wire n1652;
  wire n1653;
  wire n1655;
  wire n1657;
  wire n1659;
  wire [3:0] n1660;
  reg [3:0] n1665;
  reg n1670;
  reg n1672;
  wire n1674;
  reg [1:0] n1677;
  wire [3:0] n1678;
  wire [1:0] n1680;
  wire n1681;
  wire n1682;
  wire n1684;
  wire n1686;
  wire n1688;
  wire [3:0] n1689;
  wire n1691;
  wire [3:0] n1692;
  wire n1694;
  wire n1695;
  wire [3:0] n1696;
  wire n1698;
  wire n1699;
  wire [1:0] n1702;
  wire [1:0] n1704;
  wire n1706;
  wire n1708;
  wire [1:0] n1709;
  reg [1:0] n1711;
  reg n1712;
  wire n1714;
  wire n1716;
  wire n1717;
  wire [2:0] n1718;
  wire n1720;
  wire n1723;
  wire n1725;
  wire [2:0] n1726;
  wire n1728;
  wire n1731;
  wire n1733;
  wire n1735;
  wire [2:0] n1736;
  reg [1:0] n1739;
  reg [1:0] n1742;
  reg n1745;
  reg n1747;
  reg n1749;
  wire n1751;
  wire [1:0] n1752;
  wire n1754;
  wire n1755;
  wire n1756;
  wire n1758;
  wire n1759;
  wire n1760;
  wire n1761;
  wire n1762;
  wire n1764;
  wire n1765;
  wire n1766;
  wire n1768;
  wire n1770;
  wire n1772;
  wire n1775;
  wire n1777;
  wire n1779;
  wire n1781;
  wire n1782;
  wire n1783;
  wire [3:0] n1785;
  wire n1788;
  wire n1791;
  wire n1793;
  wire [3:0] n1794;
  reg [3:0] n1795;
  reg [1:0] n1800;
  reg [1:0] n1803;
  reg n1806;
  reg n1809;
  reg n1812;
  reg n1815;
  reg n1818;
  reg n1820;
  wire [1:0] n1821;
  wire n1823;
  wire n1825;
  wire n1827;
  wire [2:0] n1828;
  wire n1830;
  wire n1833;
  wire n1835;
  wire n1837;
  wire [2:0] n1838;
  reg [1:0] n1841;
  reg [1:0] n1844;
  reg n1847;
  reg n1849;
  wire [2:0] n1852;
  wire [3:0] n1853;
  wire [1:0] n1854;
  wire [1:0] n1855;
  wire n1856;
  wire n1858;
  wire n1860;
  wire n1861;
  wire n1863;
  wire n1864;
  wire n1866;
  wire n1868;
  wire n1870;
  wire n1871;
  wire n1873;
  wire n1874;
  wire [1:0] n1875;
  wire n1877;
  wire [4:0] n1878;
  wire n1880;
  wire n1881;
  wire n1882;
  wire n1883;
  wire n1885;
  wire n1887;
  wire [1:0] n1888;
  reg [1:0] n1892;
  reg n1895;
  wire n1897;
  wire n1899;
  wire [1:0] n1902;
  wire n1904;
  wire [1:0] n1907;
  wire n1909;
  wire n1911;
  wire [1:0] n1914;
  wire [1:0] n1917;
  wire [1:0] n1920;
  wire n1922;
  wire n1924;
  wire [3:0] n1925;
  reg [1:0] n1927;
  reg [1:0] n1931;
  reg [1:0] n1933;
  reg n1937;
  reg n1940;
  reg n1943;
  wire [2:0] n1946;
  wire [1:0] n1948;
  wire [1:0] n1949;
  wire [1:0] n1951;
  wire n1952;
  wire n1954;
  wire n1956;
  wire [2:0] n1957;
  wire n1959;
  wire n1962;
  wire n1964;
  wire n1966;
  wire [2:0] n1967;
  wire n1969;
  wire n1972;
  wire n1974;
  wire n1976;
  wire [3:0] n1977;
  reg [1:0] n1980;
  reg [1:0] n1984;
  reg n1987;
  reg n1990;
  reg n1992;
  reg n1994;
  wire [2:0] n1996;
  wire [1:0] n1997;
  wire [1:0] n1998;
  wire [1:0] n2000;
  wire n2002;
  wire n2003;
  wire n2004;
  wire n2006;
  wire n2008;
  wire n2010;
  wire [1:0] n2011;
  wire n2013;
  wire n2014;
  wire n2015;
  wire n2017;
  wire n2018;
  wire n2019;
  wire n2020;
  wire n2021;
  wire n2023;
  wire n2024;
  wire n2025;
  wire n2027;
  wire n2029;
  wire n2031;
  wire n2033;
  wire n2036;
  wire n2038;
  wire n2040;
  wire n2042;
  wire n2043;
  wire n2044;
  wire [3:0] n2046;
  wire n2049;
  wire n2051;
  wire [4:0] n2052;
  reg [3:0] n2053;
  reg [1:0] n2058;
  reg [1:0] n2062;
  reg n2065;
  reg n2068;
  reg n2071;
  reg n2074;
  reg n2077;
  reg n2080;
  reg n2082;
  wire [1:0] n2083;
  wire n2085;
  wire n2087;
  wire n2089;
  wire n2091;
  wire [2:0] n2092;
  wire n2094;
  wire n2097;
  wire n2099;
  wire n2101;
  wire [3:0] n2102;
  reg [1:0] n2105;
  reg [1:0] n2109;
  reg n2112;
  reg n2115;
  reg n2117;
  wire [2:0] n2120;
  wire [3:0] n2121;
  wire [1:0] n2122;
  wire [1:0] n2123;
  wire n2124;
  wire n2126;
  wire n2128;
  wire n2129;
  wire n2130;
  wire n2132;
  wire n2133;
  wire n2135;
  wire n2137;
  wire n2139;
  wire n2140;
  wire n2142;
  wire n2143;
  wire [2:0] n2146;
  wire n2148;
  wire n2150;
  wire n2152;
  wire [2:0] n2153;
  reg [1:0] n2157;
  reg n2160;
  reg n2163;
  wire n2165;
  wire [1:0] n2166;
  wire n2168;
  wire n2170;
  wire n2171;
  wire n2172;
  wire [2:0] n2175;
  wire [2:0] n2177;
  wire n2180;
  wire n2182;
  wire n2184;
  wire n2186;
  wire [2:0] n2187;
  wire n2189;
  wire n2190;
  wire n2191;
  wire n2193;
  wire n2194;
  wire n2197;
  wire n2199;
  wire n2202;
  wire n2204;
  wire n2206;
  wire n2207;
  wire n2208;
  wire [1:0] n2209;
  wire n2211;
  wire n2212;
  wire [1:0] n2215;
  wire n2218;
  wire n2221;
  wire n2223;
  wire n2225;
  wire n2227;
  wire [6:0] n2228;
  reg [3:0] n2231;
  reg [1:0] n2238;
  reg [1:0] n2241;
  reg [1:0] n2246;
  reg n2248;
  reg n2250;
  reg n2253;
  reg n2256;
  reg n2259;
  reg n2262;
  reg n2265;
  reg n2268;
  reg n2271;
  wire n2273;
  wire n2275;
  wire n2276;
  wire [1:0] n2277;
  wire n2279;
  wire n2280;
  wire n2281;
  wire n2283;
  wire n2284;
  wire n2285;
  wire n2286;
  wire n2287;
  wire n2289;
  wire n2290;
  wire n2291;
  wire n2293;
  wire n2295;
  wire n2297;
  wire n2299;
  wire n2302;
  wire n2304;
  wire n2306;
  wire n2307;
  wire n2308;
  wire n2311;
  wire n2313;
  wire n2315;
  wire n2316;
  wire n2317;
  wire [3:0] n2319;
  wire n2322;
  wire n2324;
  wire [4:0] n2325;
  reg [3:0] n2326;
  reg [1:0] n2332;
  reg [1:0] n2335;
  reg n2338;
  reg n2341;
  reg n2344;
  reg n2347;
  reg n2350;
  reg n2353;
  reg n2355;
  wire [1:0] n2356;
  wire n2358;
  wire n2359;
  wire n2360;
  wire n2362;
  wire n2364;
  wire n2366;
  wire [2:0] n2367;
  wire n2369;
  wire n2372;
  wire [2:0] n2373;
  wire n2375;
  wire n2378;
  wire n2380;
  wire n2382;
  wire [3:0] n2383;
  reg [1:0] n2387;
  reg [1:0] n2390;
  reg n2393;
  reg n2395;
  reg n2398;
  reg n2400;
  wire [2:0] n2403;
  wire [3:0] n2404;
  wire [1:0] n2405;
  wire [1:0] n2406;
  wire n2407;
  wire n2409;
  wire n2410;
  wire n2412;
  wire n2414;
  wire n2415;
  wire n2417;
  wire n2418;
  wire n2420;
  wire n2422;
  wire n2424;
  wire n2425;
  wire n2427;
  wire n2428;
  wire n2430;
  wire n2431;
  wire [1:0] n2432;
  wire n2434;
  wire n2436;
  wire n2437;
  wire n2438;
  wire [2:0] n2441;
  wire [2:0] n2443;
  wire n2446;
  wire n2448;
  wire n2450;
  wire [2:0] n2451;
  wire n2453;
  wire n2454;
  wire n2455;
  wire n2457;
  wire n2458;
  wire n2461;
  wire n2463;
  wire n2466;
  wire n2468;
  wire n2470;
  wire n2471;
  wire n2472;
  wire [1:0] n2473;
  wire n2475;
  wire n2476;
  wire [1:0] n2479;
  wire n2482;
  wire n2485;
  wire n2487;
  wire n2489;
  wire n2491;
  wire [5:0] n2492;
  reg [3:0] n2495;
  reg [1:0] n2500;
  reg [1:0] n2504;
  reg [1:0] n2508;
  reg n2510;
  reg n2512;
  reg n2515;
  reg n2518;
  reg n2521;
  reg n2524;
  reg n2527;
  reg n2530;
  wire n2532;
  wire n2534;
  wire n2535;
  wire [1:0] n2536;
  wire n2538;
  wire n2539;
  wire n2540;
  wire n2542;
  wire n2543;
  wire n2544;
  wire n2545;
  wire n2546;
  wire n2548;
  wire n2549;
  wire n2550;
  wire n2552;
  wire n2554;
  wire n2556;
  wire n2558;
  wire n2560;
  wire n2563;
  wire n2565;
  wire n2567;
  wire n2569;
  wire n2570;
  wire n2571;
  wire [3:0] n2573;
  wire n2576;
  wire n2578;
  wire [5:0] n2579;
  reg [3:0] n2581;
  reg [1:0] n2587;
  reg [1:0] n2591;
  reg [1:0] n2595;
  reg n2598;
  reg n2601;
  reg n2604;
  reg n2607;
  reg n2610;
  reg n2613;
  reg n2615;
  wire [1:0] n2616;
  wire n2618;
  wire n2620;
  wire n2621;
  wire n2622;
  wire n2623;
  wire [1:0] n2624;
  wire n2626;
  wire n2627;
  wire n2629;
  wire n2630;
  wire n2632;
  wire n2634;
  wire [1:0] n2635;
  wire n2637;
  wire [3:0] n2638;
  wire n2640;
  wire n2641;
  wire [3:0] n2644;
  wire n2646;
  wire [2:0] n2647;
  wire n2649;
  wire n2652;
  wire n2655;
  wire n2657;
  wire n2659;
  wire [4:0] n2660;
  reg [3:0] n2661;
  reg [1:0] n2665;
  reg [1:0] n2669;
  reg [1:0] n2673;
  reg n2675;
  reg n2678;
  reg n2681;
  reg n2683;
  wire [2:0] n2686;
  wire [3:0] n2687;
  wire [1:0] n2688;
  wire [1:0] n2689;
  wire [1:0] n2690;
  wire n2692;
  wire n2693;
  wire n2695;
  wire n2697;
  wire n2698;
  wire n2699;
  wire n2701;
  wire n2702;
  wire n2704;
  wire n2706;
  wire n2708;
  wire n2709;
  wire n2711;
  wire n2712;
  wire n2714;
  wire n2715;
  wire [13:0] n2716;
  reg [2:0] n2719;
  reg [3:0] n2721;
  reg [1:0] n2723;
  reg [3:0] n2725;
  reg [1:0] n2727;
  reg [1:0] n2730;
  reg n2733;
  reg n2736;
  reg n2739;
  reg n2742;
  reg n2745;
  reg n2748;
  reg n2750;
  reg n2752;
  reg n2754;
  reg n2755;
  reg n2756;
  reg n2758;
  reg n2761;
  reg n2764;
  reg n2767;
  reg n2770;
  reg n2773;
  reg n2776;
  reg n2779;
  wire [1:0] n2784;
  wire [2:0] n2785;
  wire [2:0] n2786;
  wire n2788;
  wire n2790;
  wire n2791;
  wire n2793;
  wire n2795;
  wire [2:0] n2796;
  reg [4:0] n2801;
  wire n2803;
  wire n2805;
  wire n2806;
  wire n2808;
  wire n2809;
  wire [2:0] n2810;
  wire n2812;
  wire n2814;
  wire n2815;
  wire n2817;
  wire [1:0] n2818;
  reg [4:0] n2822;
  wire n2824;
  wire [2:0] n2825;
  wire n2827;
  reg [4:0] n2830;
  wire n2832;
  wire [2:0] n2833;
  wire n2835;
  reg [4:0] n2838;
  wire [2:0] n2839;
  reg [4:0] n2840;
  wire n2842;
  wire [2:0] n2843;
  wire [30:0] n2844;
  wire n2846;
  wire n2848;
  wire n2850;
  wire n2852;
  wire n2854;
  wire n2856;
  wire n2858;
  wire [6:0] n2859;
  reg [4:0] n2868;
  wire n2870;
  wire [2:0] n2871;
  wire [30:0] n2872;
  wire [2:0] n2873;
  wire n2875;
  wire n2877;
  wire n2878;
  wire [4:0] n2881;
  wire n2884;
  wire [2:0] n2885;
  wire n2887;
  wire n2889;
  wire n2890;
  wire [4:0] n2893;
  wire n2896;
  wire n2898;
  wire n2900;
  wire [2:0] n2901;
  wire n2903;
  wire [4:0] n2906;
  wire n2909;
  wire n2911;
  wire n2913;
  wire [6:0] n2914;
  reg [4:0] n2920;
  wire n2922;
  wire [2:0] n2923;
  wire [30:0] n2924;
  wire n2926;
  wire [4:0] n2929;
  wire n2931;
  wire n2933;
  wire n2935;
  wire n2937;
  wire n2939;
  wire n2940;
  wire n2942;
  wire [2:0] n2943;
  wire [30:0] n2944;
  wire n2946;
  wire n2948;
  wire n2950;
  wire n2952;
  wire n2954;
  wire n2956;
  wire n2958;
  wire [6:0] n2959;
  reg [4:0] n2968;
  wire [2:0] n2969;
  wire [30:0] n2970;
  wire n2972;
  wire n2974;
  wire n2976;
  wire n2978;
  wire n2980;
  wire n2982;
  wire [2:0] n2983;
  wire n2985;
  wire [4:0] n2988;
  wire n2991;
  wire [6:0] n2992;
  reg [4:0] n3000;
  wire [4:0] n3001;
  wire [4:0] n3003;
  wire [4:0] n3005;
  wire [4:0] n3007;
  wire [4:0] n3009;
  reg [4:0] n3010;
  wire [2:0] n3011;
  reg [4:0] n3012;
  assign lcycle = n2719; //(module output)
  assign alu_op = n3012; //(module output)
  assign set_busa_to = n2721; //(module output)
  assign set_addr_to = n2723; //(module output)
  assign write_data = n2725; //(module output)
  assign jump = n2727; //(module output)
  assign baadd = n2730; //(module output)
  assign breakatna = n2733; //(module output)
  assign adadd = n2736; //(module output)
  assign addy = n2739; //(module output)
  assign pcadd = n2742; //(module output)
  assign inc_s = n2745; //(module output)
  assign dec_s = n2748; //(module output)
  assign lda = n2750; //(module output)
  assign ldp = n2752; //(module output)
  assign ldx = n2754; //(module output)
  assign ldy = n2755; //(module output)
  assign lds = n2756; //(module output)
  assign lddi = n2758; //(module output)
  assign ldalu = n2761; //(module output)
  assign ldad = n2764; //(module output)
  assign ldbal = n2767; //(module output)
  assign ldbah = n2770; //(module output)
  assign savep = n2773; //(module output)
  assign write = n2776; //(module output)
  /*# t65/T65_MCode.vhd:94:10 */
  assign branch = n902; // (signal)
  /*# t65/T65_MCode.vhd:95:10 */
  assign alumore = n2779; // (signal)
  /*# t65/T65_MCode.vhd:99:10 */
  assign n874 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:100:20 */
  assign n875 = p[7]; // extract
  /*# t65/T65_MCode.vhd:100:15 */
  assign n876 = ~n875;
  /*# t65/T65_MCode.vhd:100:29 */
  assign n878 = n874 == 3'b000;
  /*# t65/T65_MCode.vhd:101:20 */
  assign n879 = p[7]; // extract
  /*# t65/T65_MCode.vhd:101:29 */
  assign n881 = n874 == 3'b001;
  /*# t65/T65_MCode.vhd:102:20 */
  assign n882 = p[6]; // extract
  /*# t65/T65_MCode.vhd:102:15 */
  assign n883 = ~n882;
  /*# t65/T65_MCode.vhd:102:29 */
  assign n885 = n874 == 3'b010;
  /*# t65/T65_MCode.vhd:103:20 */
  assign n886 = p[6]; // extract
  /*# t65/T65_MCode.vhd:103:29 */
  assign n888 = n874 == 3'b011;
  /*# t65/T65_MCode.vhd:104:20 */
  assign n889 = p[0]; // extract
  /*# t65/T65_MCode.vhd:104:15 */
  assign n890 = ~n889;
  /*# t65/T65_MCode.vhd:104:29 */
  assign n892 = n874 == 3'b100;
  /*# t65/T65_MCode.vhd:105:20 */
  assign n893 = p[0]; // extract
  /*# t65/T65_MCode.vhd:105:29 */
  assign n895 = n874 == 3'b101;
  /*# t65/T65_MCode.vhd:106:20 */
  assign n896 = p[1]; // extract
  /*# t65/T65_MCode.vhd:106:15 */
  assign n897 = ~n896;
  /*# t65/T65_MCode.vhd:106:29 */
  assign n899 = n874 == 3'b110;
  /*# t65/T65_MCode.vhd:107:20 */
  assign n900 = p[1]; // extract
  /*# t65/T65_MCode.vhd:99:3 */
  assign n901 = {n899, n895, n892, n888, n885, n881, n878};
  /*# t65/T65_MCode.vhd:99:3 */
  always @*
    case (n901)
      7'b1000000: n902 = n897;
      7'b0100000: n902 = n893;
      7'b0010000: n902 = n890;
      7'b0001000: n902 = n886;
      7'b0000100: n902 = n883;
      7'b0000010: n902 = n879;
      7'b0000001: n902 = n876;
      default: n902 = n900;
    endcase
  /*# t65/T65_MCode.vhd:137:12 */
  assign n905 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:139:16 */
  assign n906 = ir[1:0]; // extract
  /*# t65/T65_MCode.vhd:142:18 */
  assign n907 = ir[4:2]; // extract
  /*# t65/T65_MCode.vhd:142:30 */
  assign n909 = n907 == 3'b111;
  /*# t65/T65_MCode.vhd:142:13 */
  assign n912 = n909 ? 4'b1011 : 4'b0011;
  /*# t65/T65_MCode.vhd:140:11 */
  assign n914 = n906 == 2'b00;
  /*# t65/T65_MCode.vhd:149:18 */
  assign n915 = ir[4:2]; // extract
  /*# t65/T65_MCode.vhd:149:30 */
  assign n917 = n915 == 3'b111;
  /*# t65/T65_MCode.vhd:149:13 */
  assign n920 = n917 ? 4'b1010 : 4'b0010;
  /*# t65/T65_MCode.vhd:147:11 */
  assign n922 = n906 == 2'b10;
  /*# t65/T65_MCode.vhd:155:18 */
  assign n923 = ir[4:2]; // extract
  /*# t65/T65_MCode.vhd:155:30 */
  assign n925 = n923 == 3'b110;
  /*# t65/T65_MCode.vhd:155:13 */
  assign n928 = n925 ? 4'b1001 : 4'b0001;
  /*# t65/T65_MCode.vhd:155:13 */
  assign n931 = n925 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:161:18 */
  assign n932 = ir[4:2]; // extract
  /*# t65/T65_MCode.vhd:161:30 */
  assign n934 = n932 == 3'b111;
  /*# t65/T65_MCode.vhd:161:42 */
  assign n935 = ir[4:2]; // extract
  /*# t65/T65_MCode.vhd:161:54 */
  assign n937 = n935 == 3'b110;
  /*# t65/T65_MCode.vhd:161:37 */
  assign n938 = n934 | n937;
  /*# t65/T65_MCode.vhd:161:66 */
  assign n939 = ir[4:2]; // extract
  /*# t65/T65_MCode.vhd:161:78 */
  assign n941 = n939 == 3'b100;
  /*# t65/T65_MCode.vhd:161:61 */
  assign n942 = n938 | n941;
  /*# t65/T65_MCode.vhd:161:13 */
  assign n945 = n942 ? 4'b1001 : 4'b1000;
  /*# t65/T65_MCode.vhd:154:11 */
  assign n947 = n906 == 2'b11;
  /*# t65/T65_MCode.vhd:139:9 */
  assign n948 = {n947, n922, n914};
  /*# t65/T65_MCode.vhd:139:9 */
  always @*
    case (n948)
      3'b100: n952 = n928;
      3'b010: n952 = 4'b0010;
      3'b001: n952 = 4'b0011;
      default: n952 = 4'b0001;
    endcase
  /*# t65/T65_MCode.vhd:139:9 */
  always @*
    case (n948)
      3'b100: n954 = n945;
      3'b010: n954 = n920;
      3'b001: n954 = n912;
      default: n954 = 4'b0001;
    endcase
  /*# t65/T65_MCode.vhd:139:9 */
  always @*
    case (n948)
      3'b100: n956 = n931;
      3'b010: n956 = 1'b0;
      3'b001: n956 = 1'b0;
      default: n956 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:138:7 */
  assign n958 = n905 == 3'b100;
  /*# t65/T65_MCode.vhd:171:16 */
  assign n959 = ir[1:0]; // extract
  /*# t65/T65_MCode.vhd:173:18 */
  assign n960 = ir[4]; // extract
  /*# t65/T65_MCode.vhd:173:22 */
  assign n962 = n960 != 1'b1;
  /*# t65/T65_MCode.vhd:173:34 */
  assign n963 = ir[2]; // extract
  /*# t65/T65_MCode.vhd:173:38 */
  assign n965 = n963 != 1'b0;
  /*# t65/T65_MCode.vhd:173:29 */
  assign n966 = n962 | n965;
  /*# t65/T65_MCode.vhd:173:13 */
  assign n969 = n966 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:172:11 */
  assign n971 = n959 == 2'b00;
  /*# t65/T65_MCode.vhd:176:11 */
  assign n973 = n959 == 2'b01;
  /*# t65/T65_MCode.vhd:178:11 */
  assign n975 = n959 == 2'b10;
  /*# t65/T65_MCode.vhd:183:18 */
  assign n976 = ir[4:2]; // extract
  /*# t65/T65_MCode.vhd:183:30 */
  assign n978 = n976 == 3'b110;
  /*# t65/T65_MCode.vhd:183:13 */
  assign n981 = n978 ? 4'b0100 : 4'b0000;
  /*# t65/T65_MCode.vhd:183:13 */
  assign n984 = n978 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:171:9 */
  assign n985 = {n975, n973, n971};
  /*# t65/T65_MCode.vhd:171:9 */
  always @*
    case (n985)
      3'b100: n987 = 4'b0000;
      3'b010: n987 = 4'b0000;
      3'b001: n987 = 4'b0000;
      default: n987 = n981;
    endcase
  /*# t65/T65_MCode.vhd:171:9 */
  always @*
    case (n985)
      3'b100: n992 = 1'b0;
      3'b010: n992 = 1'b1;
      3'b001: n992 = 1'b0;
      default: n992 = 1'b1;
    endcase
  /*# t65/T65_MCode.vhd:171:9 */
  always @*
    case (n985)
      3'b100: n996 = 1'b1;
      3'b010: n996 = 1'b0;
      3'b001: n996 = 1'b0;
      default: n996 = 1'b1;
    endcase
  /*# t65/T65_MCode.vhd:171:9 */
  always @*
    case (n985)
      3'b100: n998 = 1'b0;
      3'b010: n998 = 1'b0;
      3'b001: n998 = n969;
      default: n998 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:171:9 */
  always @*
    case (n985)
      3'b100: n1000 = 1'b0;
      3'b010: n1000 = 1'b0;
      3'b001: n1000 = 1'b0;
      default: n1000 = n984;
    endcase
  /*# t65/T65_MCode.vhd:169:7 */
  assign n1002 = n905 == 3'b101;
  /*# t65/T65_MCode.vhd:189:16 */
  assign n1003 = ir[1:0]; // extract
  /*# t65/T65_MCode.vhd:191:18 */
  assign n1004 = ir[4]; // extract
  /*# t65/T65_MCode.vhd:191:22 */
  assign n1005 = ~n1004;
  /*# t65/T65_MCode.vhd:191:13 */
  assign n1008 = n1005 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:190:11 */
  assign n1010 = n1003 == 2'b00;
  /*# t65/T65_MCode.vhd:189:9 */
  always @*
    case (n1010)
      1'b1: n1013 = 4'b0011;
      default: n1013 = 4'b0001;
    endcase
  /*# t65/T65_MCode.vhd:189:9 */
  always @*
    case (n1010)
      1'b1: n1015 = n1008;
      default: n1015 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:188:7 */
  assign n1017 = n905 == 3'b110;
  /*# t65/T65_MCode.vhd:199:16 */
  assign n1018 = ir[1:0]; // extract
  /*# t65/T65_MCode.vhd:201:16 */
  assign n1019 = ir[4]; // extract
  /*# t65/T65_MCode.vhd:201:20 */
  assign n1020 = ~n1019;
  /*# t65/T65_MCode.vhd:201:11 */
  assign n1023 = n1020 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:200:9 */
  assign n1025 = n1018 == 2'b00;
  /*# t65/T65_MCode.vhd:199:9 */
  always @*
    case (n1025)
      1'b1: n1028 = 4'b0010;
      default: n1028 = 4'b0001;
    endcase
  /*# t65/T65_MCode.vhd:199:9 */
  always @*
    case (n1025)
      1'b1: n1030 = n1023;
      default: n1030 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:198:7 */
  assign n1032 = n905 == 3'b111;
  /*# t65/T65_MCode.vhd:137:5 */
  assign n1033 = {n1032, n1017, n1002, n958};
  /*# t65/T65_MCode.vhd:137:5 */
  always @*
    case (n1033)
      4'b1000: n1035 = n1028;
      4'b0100: n1035 = n1013;
      4'b0010: n1035 = n987;
      4'b0001: n1035 = n952;
      default: n1035 = 4'b0001;
    endcase
  /*# t65/T65_MCode.vhd:137:5 */
  always @*
    case (n1033)
      4'b1000: n1038 = 4'b0000;
      4'b0100: n1038 = 4'b0000;
      4'b0010: n1038 = 4'b0000;
      4'b0001: n1038 = n954;
      default: n1038 = 4'b0000;
    endcase
  /*# t65/T65_MCode.vhd:137:5 */
  always @*
    case (n1033)
      4'b1000: n1041 = 1'b0;
      4'b0100: n1041 = 1'b0;
      4'b0010: n1041 = n992;
      4'b0001: n1041 = 1'b0;
      default: n1041 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:137:5 */
  always @*
    case (n1033)
      4'b1000: n1044 = n1030;
      4'b0100: n1044 = 1'b0;
      4'b0010: n1044 = n996;
      4'b0001: n1044 = 1'b0;
      default: n1044 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:137:5 */
  always @*
    case (n1033)
      4'b1000: n1047 = 1'b0;
      4'b0100: n1047 = n1015;
      4'b0010: n1047 = n998;
      4'b0001: n1047 = 1'b0;
      default: n1047 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:137:5 */
  always @*
    case (n1033)
      4'b1000: n1050 = 1'b0;
      4'b0100: n1050 = 1'b0;
      4'b0010: n1050 = n1000;
      4'b0001: n1050 = n956;
      default: n1050 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:211:10 */
  assign n1052 = ir[7:6]; // extract
  /*# t65/T65_MCode.vhd:211:23 */
  assign n1054 = n1052 != 2'b10;
  /*# t65/T65_MCode.vhd:211:37 */
  assign n1055 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:211:31 */
  assign n1056 = n1055 & n1054;
  /*# t65/T65_MCode.vhd:211:56 */
  assign n1058 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:211:67 */
  assign n1059 = ir[0]; // extract
  /*# t65/T65_MCode.vhd:211:70 */
  assign n1060 = ~n1059;
  /*# t65/T65_MCode.vhd:211:62 */
  assign n1061 = n1058 | n1060;
  /*# t65/T65_MCode.vhd:211:47 */
  assign n1062 = n1061 & n1056;
  /*# t65/T65_MCode.vhd:212:12 */
  assign n1064 = ir == 8'b11101011;
  /*# t65/T65_MCode.vhd:212:7 */
  assign n1067 = n1064 ? 4'b0001 : 4'b0000;
  /*# t65/T65_MCode.vhd:211:5 */
  assign n1068 = n1062 ? n1067 : n1035;
  /*# t65/T65_MCode.vhd:219:12 */
  assign n1069 = ir[4:0]; // extract
  /*# t65/T65_MCode.vhd:232:15 */
  assign n1071 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:236:15 */
  assign n1073 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:241:15 */
  assign n1075 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:246:15 */
  assign n1077 = mcycle == 3'b100;
  /*# t65/T65_MCode.vhd:249:15 */
  assign n1079 = mcycle == 3'b101;
  /*# t65/T65_MCode.vhd:252:15 */
  assign n1081 = mcycle == 3'b110;
  /*# t65/T65_MCode.vhd:231:13 */
  assign n1082 = {n1081, n1079, n1077, n1075, n1073, n1071};
  /*# t65/T65_MCode.vhd:231:13 */
  always @*
    case (n1082)
      6'b100000: n1089 = 2'b10;
      6'b010000: n1089 = 2'b11;
      6'b001000: n1089 = 2'b11;
      6'b000100: n1089 = 2'b00;
      6'b000010: n1089 = 2'b00;
      6'b000001: n1089 = 2'b00;
      default: n1089 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:231:13 */
  always @*
    case (n1082)
      6'b100000: n1093 = n1038;
      6'b010000: n1093 = n1038;
      6'b001000: n1093 = n1038;
      6'b000100: n1093 = 4'b0101;
      6'b000010: n1093 = 4'b0110;
      6'b000001: n1093 = 4'b0111;
      default: n1093 = n1038;
    endcase
  /*# t65/T65_MCode.vhd:231:13 */
  always @*
    case (n1082)
      6'b100000: n1096 = 2'b10;
      6'b010000: n1096 = 2'b00;
      6'b001000: n1096 = 2'b00;
      6'b000100: n1096 = 2'b00;
      6'b000010: n1096 = 2'b00;
      6'b000001: n1096 = 2'b00;
      default: n1096 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:231:13 */
  always @*
    case (n1082)
      6'b100000: n1101 = 1'b0;
      6'b010000: n1101 = 1'b0;
      6'b001000: n1101 = 1'b1;
      6'b000100: n1101 = 1'b1;
      6'b000010: n1101 = 1'b1;
      6'b000001: n1101 = 1'b0;
      default: n1101 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:231:13 */
  always @*
    case (n1082)
      6'b100000: n1104 = 1'b0;
      6'b010000: n1104 = 1'b1;
      6'b001000: n1104 = 1'b0;
      6'b000100: n1104 = 1'b0;
      6'b000010: n1104 = 1'b0;
      6'b000001: n1104 = 1'b0;
      default: n1104 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:231:13 */
  always @*
    case (n1082)
      6'b100000: n1109 = 1'b0;
      6'b010000: n1109 = 1'b0;
      6'b001000: n1109 = 1'b0;
      6'b000100: n1109 = 1'b1;
      6'b000010: n1109 = 1'b1;
      6'b000001: n1109 = 1'b1;
      default: n1109 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:228:11 */
  assign n1111 = ir == 8'b00000000;
  /*# t65/T65_MCode.vhd:259:15 */
  assign n1113 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:263:15 */
  assign n1115 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:267:15 */
  assign n1117 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:272:15 */
  assign n1119 = mcycle == 3'b100;
  /*# t65/T65_MCode.vhd:274:15 */
  assign n1121 = mcycle == 3'b101;
  /*# t65/T65_MCode.vhd:258:13 */
  assign n1122 = {n1121, n1119, n1117, n1115, n1113};
  /*# t65/T65_MCode.vhd:258:13 */
  always @*
    case (n1122)
      5'b10000: n1127 = 2'b10;
      5'b01000: n1127 = 2'b10;
      5'b00100: n1127 = 2'b00;
      5'b00010: n1127 = 2'b00;
      5'b00001: n1127 = 2'b00;
      default: n1127 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:258:13 */
  always @*
    case (n1122)
      5'b10000: n1130 = n1038;
      5'b01000: n1130 = n1038;
      5'b00100: n1130 = 4'b0110;
      5'b00010: n1130 = 4'b0111;
      5'b00001: n1130 = n1038;
      default: n1130 = n1038;
    endcase
  /*# t65/T65_MCode.vhd:258:13 */
  always @*
    case (n1122)
      5'b10000: n1134 = 2'b10;
      5'b01000: n1134 = 2'b00;
      5'b00100: n1134 = 2'b00;
      5'b00010: n1134 = 2'b00;
      5'b00001: n1134 = 2'b01;
      default: n1134 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:258:13 */
  always @*
    case (n1122)
      5'b10000: n1138 = 1'b0;
      5'b01000: n1138 = 1'b1;
      5'b00100: n1138 = 1'b1;
      5'b00010: n1138 = 1'b0;
      5'b00001: n1138 = 1'b0;
      default: n1138 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:258:13 */
  always @*
    case (n1122)
      5'b10000: n1141 = 1'b0;
      5'b01000: n1141 = 1'b0;
      5'b00100: n1141 = 1'b0;
      5'b00010: n1141 = 1'b0;
      5'b00001: n1141 = 1'b1;
      default: n1141 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:258:13 */
  always @*
    case (n1122)
      5'b10000: n1145 = 1'b0;
      5'b01000: n1145 = 1'b0;
      5'b00100: n1145 = 1'b1;
      5'b00010: n1145 = 1'b1;
      5'b00001: n1145 = 1'b0;
      default: n1145 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:256:11 */
  assign n1147 = ir == 8'b00100000;
  /*# t65/T65_MCode.vhd:281:15 */
  assign n1149 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:283:15 */
  assign n1151 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:286:15 */
  assign n1153 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:290:15 */
  assign n1155 = mcycle == 3'b100;
  /*# t65/T65_MCode.vhd:295:15 */
  assign n1157 = mcycle == 3'b101;
  /*# t65/T65_MCode.vhd:280:15 */
  assign n1158 = {n1157, n1155, n1153, n1151, n1149};
  /*# t65/T65_MCode.vhd:280:15 */
  always @*
    case (n1158)
      5'b10000: n1160 = n1068;
      5'b01000: n1160 = n1068;
      5'b00100: n1160 = 4'b0000;
      5'b00010: n1160 = n1068;
      5'b00001: n1160 = n1068;
      default: n1160 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:280:15 */
  always @*
    case (n1158)
      5'b10000: n1166 = 2'b10;
      5'b01000: n1166 = 2'b00;
      5'b00100: n1166 = 2'b00;
      5'b00010: n1166 = 2'b00;
      5'b00001: n1166 = 2'b00;
      default: n1166 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:280:15 */
  always @*
    case (n1158)
      5'b10000: n1169 = 2'b10;
      5'b01000: n1169 = 2'b00;
      5'b00100: n1169 = 2'b00;
      5'b00010: n1169 = 2'b00;
      5'b00001: n1169 = 2'b00;
      default: n1169 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:280:15 */
  always @*
    case (n1158)
      5'b10000: n1174 = 1'b0;
      5'b01000: n1174 = 1'b1;
      5'b00100: n1174 = 1'b1;
      5'b00010: n1174 = 1'b1;
      5'b00001: n1174 = 1'b0;
      default: n1174 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:280:15 */
  always @*
    case (n1158)
      5'b10000: n1177 = 1'b0;
      5'b01000: n1177 = 1'b1;
      5'b00100: n1177 = 1'b0;
      5'b00010: n1177 = 1'b0;
      5'b00001: n1177 = 1'b0;
      default: n1177 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:280:15 */
  always @*
    case (n1158)
      5'b10000: n1180 = 1'b0;
      5'b01000: n1180 = 1'b1;
      5'b00100: n1180 = 1'b0;
      5'b00010: n1180 = 1'b0;
      5'b00001: n1180 = 1'b0;
      default: n1180 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:278:13 */
  assign n1182 = ir == 8'b01000000;
  /*# t65/T65_MCode.vhd:302:15 */
  assign n1184 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:304:15 */
  assign n1186 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:307:15 */
  assign n1188 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:311:15 */
  assign n1190 = mcycle == 3'b100;
  /*# t65/T65_MCode.vhd:313:15 */
  assign n1192 = mcycle == 3'b101;
  /*# t65/T65_MCode.vhd:301:13 */
  assign n1193 = {n1192, n1190, n1188, n1186, n1184};
  /*# t65/T65_MCode.vhd:301:13 */
  always @*
    case (n1193)
      5'b10000: n1198 = 2'b10;
      5'b01000: n1198 = 2'b10;
      5'b00100: n1198 = 2'b00;
      5'b00010: n1198 = 2'b00;
      5'b00001: n1198 = 2'b00;
      default: n1198 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:301:13 */
  always @*
    case (n1193)
      5'b10000: n1202 = 2'b01;
      5'b01000: n1202 = 2'b10;
      5'b00100: n1202 = 2'b00;
      5'b00010: n1202 = 2'b00;
      5'b00001: n1202 = 2'b00;
      default: n1202 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:301:13 */
  always @*
    case (n1193)
      5'b10000: n1206 = 1'b0;
      5'b01000: n1206 = 1'b0;
      5'b00100: n1206 = 1'b1;
      5'b00010: n1206 = 1'b1;
      5'b00001: n1206 = 1'b0;
      default: n1206 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:301:13 */
  always @*
    case (n1193)
      5'b10000: n1209 = 1'b0;
      5'b01000: n1209 = 1'b0;
      5'b00100: n1209 = 1'b1;
      5'b00010: n1209 = 1'b0;
      5'b00001: n1209 = 1'b0;
      default: n1209 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:299:11 */
  assign n1211 = ir == 8'b01100000;
  /*# t65/T65_MCode.vhd:319:23 */
  assign n1213 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:319:36 */
  assign n1214 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:319:30 */
  assign n1215 = n1214 & n1213;
  /*# t65/T65_MCode.vhd:319:15 */
  assign n1218 = n1215 ? 3'b001 : 3'b010;
  /*# t65/T65_MCode.vhd:324:24 */
  assign n1221 = mode != 2'b00;
  /*# t65/T65_MCode.vhd:324:36 */
  assign n1222 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:324:39 */
  assign n1223 = ~n1222;
  /*# t65/T65_MCode.vhd:324:31 */
  assign n1224 = n1221 | n1223;
  /*# t65/T65_MCode.vhd:326:26 */
  assign n1225 = ir[7:4]; // extract
  /*# t65/T65_MCode.vhd:327:19 */
  assign n1227 = n1225 == 4'b0000;
  /*# t65/T65_MCode.vhd:329:19 */
  assign n1229 = n1225 == 4'b0100;
  /*# t65/T65_MCode.vhd:332:29 */
  assign n1231 = mode != 2'b00;
  /*# t65/T65_MCode.vhd:332:21 */
  assign n1233 = n1231 ? 4'b0011 : n1038;
  /*# t65/T65_MCode.vhd:332:21 */
  assign n1236 = n1231 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:331:19 */
  assign n1238 = n1225 == 4'b0101;
  /*# t65/T65_MCode.vhd:338:29 */
  assign n1240 = mode != 2'b00;
  /*# t65/T65_MCode.vhd:338:21 */
  assign n1242 = n1240 ? 4'b0010 : n1038;
  /*# t65/T65_MCode.vhd:338:21 */
  assign n1245 = n1240 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:337:19 */
  assign n1247 = n1225 == 4'b1101;
  /*# t65/T65_MCode.vhd:326:19 */
  assign n1248 = {n1247, n1238, n1229, n1227};
  /*# t65/T65_MCode.vhd:326:19 */
  always @*
    case (n1248)
      4'b1000: n1251 = n1242;
      4'b0100: n1251 = n1233;
      4'b0010: n1251 = 4'b0001;
      4'b0001: n1251 = 4'b0101;
      default: n1251 = n1038;
    endcase
  /*# t65/T65_MCode.vhd:326:19 */
  always @*
    case (n1248)
      4'b1000: n1253 = n1245;
      4'b0100: n1253 = n1236;
      4'b0010: n1253 = 1'b1;
      4'b0001: n1253 = 1'b1;
      default: n1253 = 1'b1;
    endcase
  /*# t65/T65_MCode.vhd:324:17 */
  assign n1257 = n1224 ? 2'b00 : 2'b10;
  /*# t65/T65_MCode.vhd:324:17 */
  assign n1258 = n1224 ? n1251 : n1038;
  /*# t65/T65_MCode.vhd:324:17 */
  assign n1260 = n1224 ? n1253 : 1'b0;
  /*# t65/T65_MCode.vhd:323:15 */
  assign n1262 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:347:15 */
  assign n1264 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:322:15 */
  assign n1265 = {n1264, n1262};
  /*# t65/T65_MCode.vhd:322:15 */
  always @*
    case (n1265)
      2'b10: n1267 = 2'b10;
      2'b01: n1267 = n1257;
      default: n1267 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:322:15 */
  always @*
    case (n1265)
      2'b10: n1268 = n1038;
      2'b01: n1268 = n1258;
      default: n1268 = n1038;
    endcase
  /*# t65/T65_MCode.vhd:322:15 */
  always @*
    case (n1265)
      2'b10: n1271 = 1'b1;
      2'b01: n1271 = 1'b0;
      default: n1271 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:322:15 */
  always @*
    case (n1265)
      2'b10: n1273 = 1'b0;
      2'b01: n1273 = n1260;
      default: n1273 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:317:13 */
  assign n1275 = ir == 8'b00001000;
  /*# t65/T65_MCode.vhd:317:24 */
  assign n1277 = ir == 8'b01001000;
  /*# t65/T65_MCode.vhd:317:24 */
  assign n1278 = n1275 | n1277;
  /*# t65/T65_MCode.vhd:317:32 */
  assign n1280 = ir == 8'b01011010;
  /*# t65/T65_MCode.vhd:317:32 */
  assign n1281 = n1278 | n1280;
  /*# t65/T65_MCode.vhd:317:40 */
  assign n1283 = ir == 8'b11011010;
  /*# t65/T65_MCode.vhd:317:40 */
  assign n1284 = n1281 | n1283;
  /*# t65/T65_MCode.vhd:353:21 */
  assign n1286 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:353:34 */
  assign n1287 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:353:28 */
  assign n1288 = n1287 & n1286;
  /*# t65/T65_MCode.vhd:353:13 */
  assign n1291 = n1288 ? 3'b001 : 3'b011;
  /*# t65/T65_MCode.vhd:356:20 */
  assign n1293 = ir[7:4]; // extract
  /*# t65/T65_MCode.vhd:357:15 */
  assign n1295 = n1293 == 4'b0010;
  /*# t65/T65_MCode.vhd:359:15 */
  assign n1297 = n1293 == 4'b0110;
  /*# t65/T65_MCode.vhd:362:25 */
  assign n1299 = mode != 2'b00;
  /*# t65/T65_MCode.vhd:362:17 */
  assign n1301 = n1299 ? 1'b1 : n1047;
  /*# t65/T65_MCode.vhd:361:15 */
  assign n1303 = n1293 == 4'b0111;
  /*# t65/T65_MCode.vhd:366:25 */
  assign n1305 = mode != 2'b00;
  /*# t65/T65_MCode.vhd:366:17 */
  assign n1307 = n1305 ? 1'b1 : n1044;
  /*# t65/T65_MCode.vhd:365:15 */
  assign n1309 = n1293 == 4'b1111;
  /*# t65/T65_MCode.vhd:356:13 */
  assign n1310 = {n1309, n1303, n1297, n1295};
  /*# t65/T65_MCode.vhd:356:13 */
  always @*
    case (n1310)
      4'b1000: n1312 = n1041;
      4'b0100: n1312 = n1041;
      4'b0010: n1312 = 1'b1;
      4'b0001: n1312 = n1041;
      default: n1312 = n1041;
    endcase
  /*# t65/T65_MCode.vhd:356:13 */
  always @*
    case (n1310)
      4'b1000: n1315 = 1'b0;
      4'b0100: n1315 = 1'b0;
      4'b0010: n1315 = 1'b0;
      4'b0001: n1315 = 1'b1;
      default: n1315 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:356:13 */
  always @*
    case (n1310)
      4'b1000: n1316 = n1307;
      4'b0100: n1316 = n1044;
      4'b0010: n1316 = n1044;
      4'b0001: n1316 = n1044;
      default: n1316 = n1044;
    endcase
  /*# t65/T65_MCode.vhd:356:13 */
  always @*
    case (n1310)
      4'b1000: n1317 = n1047;
      4'b0100: n1317 = n1301;
      4'b0010: n1317 = n1047;
      4'b0001: n1317 = n1047;
      default: n1317 = n1047;
    endcase
  /*# t65/T65_MCode.vhd:373:25 */
  assign n1319 = mode != 2'b00;
  /*# t65/T65_MCode.vhd:373:38 */
  assign n1320 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:373:42 */
  assign n1321 = ~n1320;
  /*# t65/T65_MCode.vhd:373:33 */
  assign n1322 = n1319 | n1321;
  /*# t65/T65_MCode.vhd:373:17 */
  assign n1325 = n1322 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:372:15 */
  assign n1327 = mcycle == 3'b000;
  /*# t65/T65_MCode.vhd:377:25 */
  assign n1329 = mode != 2'b00;
  /*# t65/T65_MCode.vhd:377:38 */
  assign n1330 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:377:42 */
  assign n1331 = ~n1330;
  /*# t65/T65_MCode.vhd:377:33 */
  assign n1332 = n1329 | n1331;
  /*# t65/T65_MCode.vhd:377:17 */
  assign n1335 = n1332 ? 2'b00 : 2'b10;
  /*# t65/T65_MCode.vhd:377:17 */
  assign n1337 = n1332 ? 1'b0 : n1315;
  /*# t65/T65_MCode.vhd:376:15 */
  assign n1339 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:381:15 */
  assign n1341 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:385:15 */
  assign n1343 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:371:13 */
  assign n1344 = {n1343, n1341, n1339, n1327};
  /*# t65/T65_MCode.vhd:371:13 */
  always @*
    case (n1344)
      4'b1000: n1346 = 4'b0000;
      4'b0100: n1346 = n1068;
      4'b0010: n1346 = n1068;
      4'b0001: n1346 = n1068;
      default: n1346 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:371:13 */
  always @*
    case (n1344)
      4'b1000: n1349 = 2'b10;
      4'b0100: n1349 = 2'b00;
      4'b0010: n1349 = n1335;
      4'b0001: n1349 = 2'b10;
      default: n1349 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:371:13 */
  always @*
    case (n1344)
      4'b1000: n1352 = 1'b0;
      4'b0100: n1352 = 1'b1;
      4'b0010: n1352 = 1'b0;
      4'b0001: n1352 = 1'b0;
      default: n1352 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:371:13 */
  always @*
    case (n1344)
      4'b1000: n1354 = n1315;
      4'b0100: n1354 = 1'b0;
      4'b0010: n1354 = n1337;
      4'b0001: n1354 = n1315;
      default: n1354 = n1315;
    endcase
  /*# t65/T65_MCode.vhd:371:13 */
  always @*
    case (n1344)
      4'b1000: n1356 = 1'b0;
      4'b0100: n1356 = 1'b0;
      4'b0010: n1356 = 1'b0;
      4'b0001: n1356 = n1325;
      default: n1356 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:351:11 */
  assign n1358 = ir == 8'b00101000;
  /*# t65/T65_MCode.vhd:351:23 */
  assign n1360 = ir == 8'b01101000;
  /*# t65/T65_MCode.vhd:351:23 */
  assign n1361 = n1358 | n1360;
  /*# t65/T65_MCode.vhd:351:31 */
  assign n1363 = ir == 8'b01111010;
  /*# t65/T65_MCode.vhd:351:31 */
  assign n1364 = n1361 | n1363;
  /*# t65/T65_MCode.vhd:351:39 */
  assign n1366 = ir == 8'b11111010;
  /*# t65/T65_MCode.vhd:351:39 */
  assign n1367 = n1364 | n1366;
  /*# t65/T65_MCode.vhd:392:15 */
  assign n1369 = mcycle == 3'b000;
  /*# t65/T65_MCode.vhd:393:15 */
  assign n1371 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:391:13 */
  assign n1372 = {n1371, n1369};
  /*# t65/T65_MCode.vhd:391:13 */
  always @*
    case (n1372)
      2'b10: n1375 = 2'b01;
      2'b01: n1375 = 2'b00;
      default: n1375 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:389:11 */
  assign n1377 = ir == 8'b10100000;
  /*# t65/T65_MCode.vhd:389:22 */
  assign n1379 = ir == 8'b11000000;
  /*# t65/T65_MCode.vhd:389:22 */
  assign n1380 = n1377 | n1379;
  /*# t65/T65_MCode.vhd:389:30 */
  assign n1382 = ir == 8'b11100000;
  /*# t65/T65_MCode.vhd:389:30 */
  assign n1383 = n1380 | n1382;
  /*# t65/T65_MCode.vhd:400:15 */
  assign n1385 = mcycle == 3'b000;
  /*# t65/T65_MCode.vhd:401:15 */
  assign n1387 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:399:13 */
  assign n1388 = {n1387, n1385};
  /*# t65/T65_MCode.vhd:399:13 */
  always @*
    case (n1388)
      2'b10: n1390 = 4'b0011;
      2'b01: n1390 = n1068;
      default: n1390 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:397:11 */
  assign n1392 = ir == 8'b10001000;
  /*# t65/T65_MCode.vhd:408:15 */
  assign n1394 = mcycle == 3'b000;
  /*# t65/T65_MCode.vhd:409:15 */
  assign n1396 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:407:13 */
  assign n1397 = {n1396, n1394};
  /*# t65/T65_MCode.vhd:407:13 */
  always @*
    case (n1397)
      2'b10: n1399 = 4'b0010;
      2'b01: n1399 = n1068;
      default: n1399 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:405:11 */
  assign n1401 = ir == 8'b11001010;
  /*# t65/T65_MCode.vhd:414:21 */
  assign n1403 = mode != 2'b00;
  /*# t65/T65_MCode.vhd:414:13 */
  assign n1405 = n1403 ? 1'b1 : n1041;
  /*# t65/T65_MCode.vhd:420:15 */
  assign n1407 = mcycle == 3'b000;
  /*# t65/T65_MCode.vhd:421:15 */
  assign n1409 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:419:13 */
  assign n1410 = {n1409, n1407};
  /*# t65/T65_MCode.vhd:419:13 */
  always @*
    case (n1410)
      2'b10: n1412 = 4'b0100;
      2'b01: n1412 = n1068;
      default: n1412 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:413:11 */
  assign n1414 = ir == 8'b00011010;
  /*# t65/T65_MCode.vhd:413:22 */
  assign n1416 = ir == 8'b00111010;
  /*# t65/T65_MCode.vhd:413:22 */
  assign n1417 = n1414 | n1416;
  /*# t65/T65_MCode.vhd:425:11 */
  assign n1424 = ir == 8'b00001010;
  /*# t65/T65_MCode.vhd:425:22 */
  assign n1426 = ir == 8'b00101010;
  /*# t65/T65_MCode.vhd:425:22 */
  assign n1427 = n1424 | n1426;
  /*# t65/T65_MCode.vhd:425:30 */
  assign n1429 = ir == 8'b01001010;
  /*# t65/T65_MCode.vhd:425:30 */
  assign n1430 = n1427 | n1429;
  /*# t65/T65_MCode.vhd:425:38 */
  assign n1432 = ir == 8'b01101010;
  /*# t65/T65_MCode.vhd:425:38 */
  assign n1433 = n1430 | n1432;
  /*# t65/T65_MCode.vhd:433:11 */
  assign n1440 = ir == 8'b10001010;
  /*# t65/T65_MCode.vhd:433:22 */
  assign n1442 = ir == 8'b10011000;
  /*# t65/T65_MCode.vhd:433:22 */
  assign n1443 = n1440 | n1442;
  /*# t65/T65_MCode.vhd:442:15 */
  assign n1445 = mcycle == 3'b000;
  /*# t65/T65_MCode.vhd:443:15 */
  assign n1447 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:441:13 */
  assign n1448 = {n1447, n1445};
  /*# t65/T65_MCode.vhd:441:13 */
  always @*
    case (n1448)
      2'b10: n1450 = 4'b0001;
      2'b01: n1450 = n1068;
      default: n1450 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:440:11 */
  assign n1452 = ir == 8'b10101010;
  /*# t65/T65_MCode.vhd:440:22 */
  assign n1454 = ir == 8'b10101000;
  /*# t65/T65_MCode.vhd:440:22 */
  assign n1455 = n1452 | n1454;
  /*# t65/T65_MCode.vhd:447:11 */
  assign n1457 = ir == 8'b10011010;
  /*# t65/T65_MCode.vhd:452:15 */
  assign n1459 = mcycle == 3'b000;
  /*# t65/T65_MCode.vhd:453:15 */
  assign n1461 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:451:13 */
  assign n1462 = {n1461, n1459};
  /*# t65/T65_MCode.vhd:451:13 */
  always @*
    case (n1462)
      2'b10: n1464 = 4'b0100;
      2'b01: n1464 = n1068;
      default: n1464 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:449:11 */
  assign n1466 = ir == 8'b10111010;
  /*# t65/T65_MCode.vhd:459:15 */
  assign n1468 = mcycle == 3'b000;
  /*# t65/T65_MCode.vhd:460:15 */
  assign n1470 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:458:13 */
  assign n1471 = {n1470, n1468};
  /*# t65/T65_MCode.vhd:458:13 */
  always @*
    case (n1471)
      2'b10: n1474 = 2'b01;
      2'b01: n1474 = 2'b00;
      default: n1474 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:457:11 */
  assign n1476 = ir == 8'b10000000;
  /*# t65/T65_MCode.vhd:227:9 */
  assign n1479 = {n1476, n1466, n1457, n1455, n1443, n1433, n1417, n1401, n1392, n1383, n1367, n1284, n1211, n1182, n1147, n1111};
  /*# t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1479)
      16'b1000000000000000: n1485 = 3'b001;
      16'b0100000000000000: n1485 = 3'b001;
      16'b0010000000000000: n1485 = 3'b001;
      16'b0001000000000000: n1485 = 3'b001;
      16'b0000100000000000: n1485 = 3'b001;
      16'b0000010000000000: n1485 = 3'b001;
      16'b0000001000000000: n1485 = 3'b001;
      16'b0000000100000000: n1485 = 3'b001;
      16'b0000000010000000: n1485 = 3'b001;
      16'b0000000001000000: n1485 = 3'b001;
      16'b0000000000100000: n1485 = n1291;
      16'b0000000000010000: n1485 = n1218;
      16'b0000000000001000: n1485 = 3'b101;
      16'b0000000000000100: n1485 = 3'b101;
      16'b0000000000000010: n1485 = 3'b101;
      16'b0000000000000001: n1485 = 3'b110;
      default: n1485 = 3'b001;
    endcase
  /*# t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1479)
      16'b1000000000000000: n1487 = n1068;
      16'b0100000000000000: n1487 = n1464;
      16'b0010000000000000: n1487 = n1068;
      16'b0001000000000000: n1487 = n1450;
      16'b0000100000000000: n1487 = n1068;
      16'b0000010000000000: n1487 = 4'b0001;
      16'b0000001000000000: n1487 = n1412;
      16'b0000000100000000: n1487 = n1399;
      16'b0000000010000000: n1487 = n1390;
      16'b0000000001000000: n1487 = n1068;
      16'b0000000000100000: n1487 = n1346;
      16'b0000000000010000: n1487 = n1068;
      16'b0000000000001000: n1487 = n1068;
      16'b0000000000000100: n1487 = n1160;
      16'b0000000000000010: n1487 = n1068;
      16'b0000000000000001: n1487 = n1068;
      default: n1487 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1479)
      16'b1000000000000000: n1489 = 2'b10;
      16'b0100000000000000: n1489 = 2'b10;
      16'b0010000000000000: n1489 = 2'b10;
      16'b0001000000000000: n1489 = 2'b10;
      16'b0000100000000000: n1489 = 2'b10;
      16'b0000010000000000: n1489 = 2'b10;
      16'b0000001000000000: n1489 = 2'b10;
      16'b0000000100000000: n1489 = 2'b10;
      16'b0000000010000000: n1489 = 2'b10;
      16'b0000000001000000: n1489 = 2'b10;
      16'b0000000000100000: n1489 = n1349;
      16'b0000000000010000: n1489 = n1267;
      16'b0000000000001000: n1489 = n1198;
      16'b0000000000000100: n1489 = n1166;
      16'b0000000000000010: n1489 = n1127;
      16'b0000000000000001: n1489 = n1089;
      default: n1489 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1479)
      16'b1000000000000000: n1490 = n1038;
      16'b0100000000000000: n1490 = n1038;
      16'b0010000000000000: n1490 = n1038;
      16'b0001000000000000: n1490 = n1038;
      16'b0000100000000000: n1490 = n1038;
      16'b0000010000000000: n1490 = n1038;
      16'b0000001000000000: n1490 = n1038;
      16'b0000000100000000: n1490 = n1038;
      16'b0000000010000000: n1490 = n1038;
      16'b0000000001000000: n1490 = n1038;
      16'b0000000000100000: n1490 = n1038;
      16'b0000000000010000: n1490 = n1268;
      16'b0000000000001000: n1490 = n1038;
      16'b0000000000000100: n1490 = n1038;
      16'b0000000000000010: n1490 = n1130;
      16'b0000000000000001: n1490 = n1093;
      default: n1490 = n1038;
    endcase
  /*# t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1479)
      16'b1000000000000000: n1492 = n1474;
      16'b0100000000000000: n1492 = 2'b00;
      16'b0010000000000000: n1492 = 2'b00;
      16'b0001000000000000: n1492 = 2'b00;
      16'b0000100000000000: n1492 = 2'b00;
      16'b0000010000000000: n1492 = 2'b00;
      16'b0000001000000000: n1492 = 2'b00;
      16'b0000000100000000: n1492 = 2'b00;
      16'b0000000010000000: n1492 = 2'b00;
      16'b0000000001000000: n1492 = n1375;
      16'b0000000000100000: n1492 = 2'b00;
      16'b0000000000010000: n1492 = 2'b00;
      16'b0000000000001000: n1492 = n1202;
      16'b0000000000000100: n1492 = n1169;
      16'b0000000000000010: n1492 = n1134;
      16'b0000000000000001: n1492 = n1096;
      default: n1492 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1479)
      16'b1000000000000000: n1494 = 1'b0;
      16'b0100000000000000: n1494 = 1'b0;
      16'b0010000000000000: n1494 = 1'b0;
      16'b0001000000000000: n1494 = 1'b0;
      16'b0000100000000000: n1494 = 1'b0;
      16'b0000010000000000: n1494 = 1'b0;
      16'b0000001000000000: n1494 = 1'b0;
      16'b0000000100000000: n1494 = 1'b0;
      16'b0000000010000000: n1494 = 1'b0;
      16'b0000000001000000: n1494 = 1'b0;
      16'b0000000000100000: n1494 = n1352;
      16'b0000000000010000: n1494 = 1'b0;
      16'b0000000000001000: n1494 = n1206;
      16'b0000000000000100: n1494 = n1174;
      16'b0000000000000010: n1494 = 1'b0;
      16'b0000000000000001: n1494 = 1'b0;
      default: n1494 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1479)
      16'b1000000000000000: n1496 = 1'b0;
      16'b0100000000000000: n1496 = 1'b0;
      16'b0010000000000000: n1496 = 1'b0;
      16'b0001000000000000: n1496 = 1'b0;
      16'b0000100000000000: n1496 = 1'b0;
      16'b0000010000000000: n1496 = 1'b0;
      16'b0000001000000000: n1496 = 1'b0;
      16'b0000000100000000: n1496 = 1'b0;
      16'b0000000010000000: n1496 = 1'b0;
      16'b0000000001000000: n1496 = 1'b0;
      16'b0000000000100000: n1496 = 1'b0;
      16'b0000000000010000: n1496 = n1271;
      16'b0000000000001000: n1496 = 1'b0;
      16'b0000000000000100: n1496 = 1'b0;
      16'b0000000000000010: n1496 = n1138;
      16'b0000000000000001: n1496 = n1101;
      default: n1496 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1479)
      16'b1000000000000000: n1499 = n1041;
      16'b0100000000000000: n1499 = n1041;
      16'b0010000000000000: n1499 = n1041;
      16'b0001000000000000: n1499 = n1041;
      16'b0000100000000000: n1499 = 1'b1;
      16'b0000010000000000: n1499 = 1'b1;
      16'b0000001000000000: n1499 = n1405;
      16'b0000000100000000: n1499 = n1041;
      16'b0000000010000000: n1499 = n1041;
      16'b0000000001000000: n1499 = n1041;
      16'b0000000000100000: n1499 = n1312;
      16'b0000000000010000: n1499 = n1041;
      16'b0000000000001000: n1499 = n1041;
      16'b0000000000000100: n1499 = n1041;
      16'b0000000000000010: n1499 = n1041;
      16'b0000000000000001: n1499 = n1041;
      default: n1499 = n1041;
    endcase
  /*# t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1479)
      16'b1000000000000000: n1501 = 1'b0;
      16'b0100000000000000: n1501 = 1'b0;
      16'b0010000000000000: n1501 = 1'b0;
      16'b0001000000000000: n1501 = 1'b0;
      16'b0000100000000000: n1501 = 1'b0;
      16'b0000010000000000: n1501 = 1'b0;
      16'b0000001000000000: n1501 = 1'b0;
      16'b0000000100000000: n1501 = 1'b0;
      16'b0000000010000000: n1501 = 1'b0;
      16'b0000000001000000: n1501 = 1'b0;
      16'b0000000000100000: n1501 = n1354;
      16'b0000000000010000: n1501 = 1'b0;
      16'b0000000000001000: n1501 = 1'b0;
      16'b0000000000000100: n1501 = n1177;
      16'b0000000000000010: n1501 = 1'b0;
      16'b0000000000000001: n1501 = 1'b0;
      default: n1501 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1479)
      16'b1000000000000000: n1504 = n1044;
      16'b0100000000000000: n1504 = 1'b1;
      16'b0010000000000000: n1504 = n1044;
      16'b0001000000000000: n1504 = n1044;
      16'b0000100000000000: n1504 = n1044;
      16'b0000010000000000: n1504 = n1044;
      16'b0000001000000000: n1504 = n1044;
      16'b0000000100000000: n1504 = 1'b1;
      16'b0000000010000000: n1504 = n1044;
      16'b0000000001000000: n1504 = n1044;
      16'b0000000000100000: n1504 = n1316;
      16'b0000000000010000: n1504 = n1044;
      16'b0000000000001000: n1504 = n1044;
      16'b0000000000000100: n1504 = n1044;
      16'b0000000000000010: n1504 = n1044;
      16'b0000000000000001: n1504 = n1044;
      default: n1504 = n1044;
    endcase
  /*# t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1479)
      16'b1000000000000000: n1506 = n1047;
      16'b0100000000000000: n1506 = n1047;
      16'b0010000000000000: n1506 = n1047;
      16'b0001000000000000: n1506 = n1047;
      16'b0000100000000000: n1506 = n1047;
      16'b0000010000000000: n1506 = n1047;
      16'b0000001000000000: n1506 = n1047;
      16'b0000000100000000: n1506 = n1047;
      16'b0000000010000000: n1506 = 1'b1;
      16'b0000000001000000: n1506 = n1047;
      16'b0000000000100000: n1506 = n1317;
      16'b0000000000010000: n1506 = n1047;
      16'b0000000000001000: n1506 = n1047;
      16'b0000000000000100: n1506 = n1047;
      16'b0000000000000010: n1506 = n1047;
      16'b0000000000000001: n1506 = n1047;
      default: n1506 = n1047;
    endcase
  /*# t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1479)
      16'b1000000000000000: n1508 = n1050;
      16'b0100000000000000: n1508 = n1050;
      16'b0010000000000000: n1508 = 1'b1;
      16'b0001000000000000: n1508 = n1050;
      16'b0000100000000000: n1508 = n1050;
      16'b0000010000000000: n1508 = n1050;
      16'b0000001000000000: n1508 = n1050;
      16'b0000000100000000: n1508 = n1050;
      16'b0000000010000000: n1508 = n1050;
      16'b0000000001000000: n1508 = n1050;
      16'b0000000000100000: n1508 = n1050;
      16'b0000000000010000: n1508 = n1050;
      16'b0000000000001000: n1508 = n1050;
      16'b0000000000000100: n1508 = n1050;
      16'b0000000000000010: n1508 = n1050;
      16'b0000000000000001: n1508 = n1050;
      default: n1508 = n1050;
    endcase
  /*# t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1479)
      16'b1000000000000000: n1510 = 1'b0;
      16'b0100000000000000: n1510 = 1'b0;
      16'b0010000000000000: n1510 = 1'b0;
      16'b0001000000000000: n1510 = 1'b0;
      16'b0000100000000000: n1510 = 1'b0;
      16'b0000010000000000: n1510 = 1'b0;
      16'b0000001000000000: n1510 = 1'b0;
      16'b0000000100000000: n1510 = 1'b0;
      16'b0000000010000000: n1510 = 1'b0;
      16'b0000000001000000: n1510 = 1'b0;
      16'b0000000000100000: n1510 = 1'b0;
      16'b0000000000010000: n1510 = 1'b0;
      16'b0000000000001000: n1510 = n1209;
      16'b0000000000000100: n1510 = n1180;
      16'b0000000000000010: n1510 = n1141;
      16'b0000000000000001: n1510 = n1104;
      default: n1510 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1479)
      16'b1000000000000000: n1512 = 1'b0;
      16'b0100000000000000: n1512 = 1'b0;
      16'b0010000000000000: n1512 = 1'b0;
      16'b0001000000000000: n1512 = 1'b0;
      16'b0000100000000000: n1512 = 1'b0;
      16'b0000010000000000: n1512 = 1'b0;
      16'b0000001000000000: n1512 = 1'b0;
      16'b0000000100000000: n1512 = 1'b0;
      16'b0000000010000000: n1512 = 1'b0;
      16'b0000000001000000: n1512 = 1'b0;
      16'b0000000000100000: n1512 = n1356;
      16'b0000000000010000: n1512 = 1'b0;
      16'b0000000000001000: n1512 = 1'b0;
      16'b0000000000000100: n1512 = 1'b0;
      16'b0000000000000010: n1512 = 1'b0;
      16'b0000000000000001: n1512 = 1'b0;
      default: n1512 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1479)
      16'b1000000000000000: n1514 = 1'b0;
      16'b0100000000000000: n1514 = 1'b0;
      16'b0010000000000000: n1514 = 1'b0;
      16'b0001000000000000: n1514 = 1'b0;
      16'b0000100000000000: n1514 = 1'b0;
      16'b0000010000000000: n1514 = 1'b0;
      16'b0000001000000000: n1514 = 1'b0;
      16'b0000000100000000: n1514 = 1'b0;
      16'b0000000010000000: n1514 = 1'b0;
      16'b0000000001000000: n1514 = 1'b0;
      16'b0000000000100000: n1514 = 1'b0;
      16'b0000000000010000: n1514 = n1273;
      16'b0000000000001000: n1514 = 1'b0;
      16'b0000000000000100: n1514 = 1'b0;
      16'b0000000000000010: n1514 = n1145;
      16'b0000000000000001: n1514 = n1109;
      default: n1514 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:225:7 */
  assign n1516 = n1069 == 5'b00000;
  /*# t65/T65_MCode.vhd:225:20 */
  assign n1518 = n1069 == 5'b01000;
  /*# t65/T65_MCode.vhd:225:20 */
  assign n1519 = n1516 | n1518;
  /*# t65/T65_MCode.vhd:225:30 */
  assign n1521 = n1069 == 5'b01010;
  /*# t65/T65_MCode.vhd:225:30 */
  assign n1522 = n1519 | n1521;
  /*# t65/T65_MCode.vhd:225:40 */
  assign n1524 = n1069 == 5'b11000;
  /*# t65/T65_MCode.vhd:225:40 */
  assign n1525 = n1522 | n1524;
  /*# t65/T65_MCode.vhd:225:50 */
  assign n1527 = n1069 == 5'b11010;
  /*# t65/T65_MCode.vhd:225:50 */
  assign n1528 = n1525 | n1527;
  /*# t65/T65_MCode.vhd:476:14 */
  assign n1529 = ir[7:6]; // extract
  /*# t65/T65_MCode.vhd:476:27 */
  assign n1531 = n1529 != 2'b10;
  /*# t65/T65_MCode.vhd:478:18 */
  assign n1533 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:478:30 */
  assign n1534 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:478:24 */
  assign n1535 = n1534 & n1533;
  /*# t65/T65_MCode.vhd:478:11 */
  assign n1538 = n1535 ? 3'b111 : 3'b101;
  /*# t65/T65_MCode.vhd:476:9 */
  assign n1540 = n1531 ? n1538 : 3'b101;
  /*# t65/T65_MCode.vhd:476:9 */
  assign n1543 = n1531 ? 1'b1 : n1041;
  /*# t65/T65_MCode.vhd:483:11 */
  assign n1545 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:487:11 */
  assign n1547 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:490:11 */
  assign n1549 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:496:18 */
  assign n1550 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:496:31 */
  assign n1552 = n1550 == 3'b100;
  /*# t65/T65_MCode.vhd:496:13 */
  assign n1555 = n1552 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:494:11 */
  assign n1557 = mcycle == 3'b100;
  /*# t65/T65_MCode.vhd:501:20 */
  assign n1559 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:501:32 */
  assign n1560 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:501:26 */
  assign n1561 = n1560 & n1559;
  /*# t65/T65_MCode.vhd:501:46 */
  assign n1562 = ir[7:6]; // extract
  /*# t65/T65_MCode.vhd:501:58 */
  assign n1564 = n1562 != 2'b10;
  /*# t65/T65_MCode.vhd:501:40 */
  assign n1565 = n1564 & n1561;
  /*# t65/T65_MCode.vhd:501:13 */
  assign n1568 = n1565 ? 2'b11 : 2'b10;
  /*# t65/T65_MCode.vhd:501:13 */
  assign n1571 = n1565 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:501:13 */
  assign n1574 = n1565 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:500:11 */
  assign n1576 = mcycle == 3'b101;
  /*# t65/T65_MCode.vhd:506:11 */
  assign n1578 = mcycle == 3'b110;
  /*# t65/T65_MCode.vhd:511:11 */
  assign n1580 = mcycle == 3'b111;
  /*# t65/T65_MCode.vhd:482:9 */
  assign n1581 = {n1580, n1578, n1576, n1557, n1549, n1547, n1545};
  /*# t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1581)
      7'b1000000: n1583 = 4'b0001;
      7'b0100000: n1583 = n1068;
      7'b0010000: n1583 = n1068;
      7'b0001000: n1583 = n1068;
      7'b0000100: n1583 = n1068;
      7'b0000010: n1583 = n1068;
      7'b0000001: n1583 = n1068;
      default: n1583 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1581)
      7'b1000000: n1590 = 2'b10;
      7'b0100000: n1590 = 2'b11;
      7'b0010000: n1590 = n1568;
      7'b0001000: n1590 = 2'b11;
      7'b0000100: n1590 = 2'b01;
      7'b0000010: n1590 = 2'b01;
      7'b0000001: n1590 = 2'b01;
      default: n1590 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1581)
      7'b1000000: n1593 = 2'b00;
      7'b0100000: n1593 = 2'b00;
      7'b0010000: n1593 = 2'b00;
      7'b0001000: n1593 = 2'b00;
      7'b0000100: n1593 = 2'b00;
      7'b0000010: n1593 = 2'b00;
      7'b0000001: n1593 = 2'b01;
      default: n1593 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1581)
      7'b1000000: n1596 = 2'b00;
      7'b0100000: n1596 = 2'b00;
      7'b0010000: n1596 = 2'b00;
      7'b0001000: n1596 = 2'b00;
      7'b0000100: n1596 = 2'b01;
      7'b0000010: n1596 = 2'b00;
      7'b0000001: n1596 = 2'b00;
      default: n1596 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1581)
      7'b1000000: n1599 = 1'b0;
      7'b0100000: n1599 = 1'b0;
      7'b0010000: n1599 = 1'b0;
      7'b0001000: n1599 = 1'b0;
      7'b0000100: n1599 = 1'b0;
      7'b0000010: n1599 = 1'b1;
      7'b0000001: n1599 = 1'b0;
      default: n1599 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1581)
      7'b1000000: n1601 = 1'b0;
      7'b0100000: n1601 = 1'b0;
      7'b0010000: n1601 = n1571;
      7'b0001000: n1601 = 1'b0;
      7'b0000100: n1601 = 1'b0;
      7'b0000010: n1601 = 1'b0;
      7'b0000001: n1601 = 1'b0;
      default: n1601 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1581)
      7'b1000000: n1604 = 1'b0;
      7'b0100000: n1604 = 1'b1;
      7'b0010000: n1604 = 1'b0;
      7'b0001000: n1604 = 1'b0;
      7'b0000100: n1604 = 1'b0;
      7'b0000010: n1604 = 1'b0;
      7'b0000001: n1604 = 1'b0;
      default: n1604 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1581)
      7'b1000000: n1607 = 1'b0;
      7'b0100000: n1607 = 1'b0;
      7'b0010000: n1607 = 1'b0;
      7'b0001000: n1607 = 1'b0;
      7'b0000100: n1607 = 1'b0;
      7'b0000010: n1607 = 1'b0;
      7'b0000001: n1607 = 1'b1;
      default: n1607 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1581)
      7'b1000000: n1610 = 1'b0;
      7'b0100000: n1610 = 1'b0;
      7'b0010000: n1610 = 1'b0;
      7'b0001000: n1610 = 1'b0;
      7'b0000100: n1610 = 1'b1;
      7'b0000010: n1610 = 1'b0;
      7'b0000001: n1610 = 1'b0;
      default: n1610 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1581)
      7'b1000000: n1613 = 1'b0;
      7'b0100000: n1613 = 1'b0;
      7'b0010000: n1613 = 1'b0;
      7'b0001000: n1613 = 1'b1;
      7'b0000100: n1613 = 1'b0;
      7'b0000010: n1613 = 1'b0;
      7'b0000001: n1613 = 1'b0;
      default: n1613 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1581)
      7'b1000000: n1616 = 1'b0;
      7'b0100000: n1616 = 1'b1;
      7'b0010000: n1616 = 1'b0;
      7'b0001000: n1616 = 1'b0;
      7'b0000100: n1616 = 1'b0;
      7'b0000010: n1616 = 1'b0;
      7'b0000001: n1616 = 1'b0;
      default: n1616 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1581)
      7'b1000000: n1619 = 1'b0;
      7'b0100000: n1619 = 1'b1;
      7'b0010000: n1619 = n1574;
      7'b0001000: n1619 = n1555;
      7'b0000100: n1619 = 1'b0;
      7'b0000010: n1619 = 1'b0;
      7'b0000001: n1619 = 1'b0;
      default: n1619 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1581)
      7'b1000000: n1622 = 1'b1;
      7'b0100000: n1622 = 1'b0;
      7'b0010000: n1622 = 1'b0;
      7'b0001000: n1622 = 1'b0;
      7'b0000100: n1622 = 1'b0;
      7'b0000010: n1622 = 1'b0;
      7'b0000001: n1622 = 1'b0;
      default: n1622 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:473:7 */
  assign n1624 = n1069 == 5'b00001;
  /*# t65/T65_MCode.vhd:473:20 */
  assign n1626 = n1069 == 5'b00011;
  /*# t65/T65_MCode.vhd:473:20 */
  assign n1627 = n1624 | n1626;
  /*# t65/T65_MCode.vhd:520:14 */
  assign n1628 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:520:26 */
  assign n1630 = n1628 != 3'b100;
  /*# t65/T65_MCode.vhd:520:9 */
  assign n1632 = n1630 ? 1'b1 : n1041;
  /*# t65/T65_MCode.vhd:524:11 */
  assign n1634 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:523:9 */
  always @*
    case (n1634)
      1'b1: n1637 = 2'b01;
      default: n1637 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:518:7 */
  assign n1639 = n1069 == 5'b01001;
  /*# t65/T65_MCode.vhd:531:16 */
  assign n1641 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:533:18 */
  assign n1642 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:534:13 */
  assign n1644 = n1642 == 3'b010;
  /*# t65/T65_MCode.vhd:534:23 */
  assign n1646 = n1642 == 3'b011;
  /*# t65/T65_MCode.vhd:534:23 */
  assign n1647 = n1644 | n1646;
  /*# t65/T65_MCode.vhd:534:29 */
  assign n1649 = n1642 == 3'b000;
  /*# t65/T65_MCode.vhd:534:29 */
  assign n1650 = n1647 | n1649;
  /*# t65/T65_MCode.vhd:534:35 */
  assign n1652 = n1642 == 3'b001;
  /*# t65/T65_MCode.vhd:534:35 */
  assign n1653 = n1650 | n1652;
  /*# t65/T65_MCode.vhd:537:13 */
  assign n1655 = n1642 == 3'b100;
  /*# t65/T65_MCode.vhd:540:13 */
  assign n1657 = n1642 == 3'b110;
  /*# t65/T65_MCode.vhd:543:13 */
  assign n1659 = n1642 == 3'b101;
  /*# t65/T65_MCode.vhd:533:11 */
  assign n1660 = {n1659, n1657, n1655, n1653};
  /*# t65/T65_MCode.vhd:533:11 */
  always @*
    case (n1660)
      4'b1000: n1665 = 4'b0111;
      4'b0100: n1665 = 4'b1001;
      4'b0010: n1665 = 4'b1000;
      4'b0001: n1665 = 4'b0110;
      default: n1665 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:533:11 */
  always @*
    case (n1660)
      4'b1000: n1670 = 1'b1;
      4'b0100: n1670 = n1041;
      4'b0010: n1670 = 1'b1;
      4'b0001: n1670 = 1'b1;
      default: n1670 = 1'b1;
    endcase
  /*# t65/T65_MCode.vhd:533:11 */
  always @*
    case (n1660)
      4'b1000: n1672 = n1044;
      4'b0100: n1672 = 1'b1;
      4'b0010: n1672 = n1044;
      4'b0001: n1672 = n1044;
      default: n1672 = n1044;
    endcase
  /*# t65/T65_MCode.vhd:550:13 */
  assign n1674 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:549:11 */
  always @*
    case (n1674)
      1'b1: n1677 = 2'b01;
      default: n1677 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:531:9 */
  assign n1678 = n1641 ? n1665 : n1068;
  /*# t65/T65_MCode.vhd:531:9 */
  assign n1680 = n1641 ? n1677 : 2'b00;
  /*# t65/T65_MCode.vhd:531:9 */
  assign n1681 = n1641 ? n1670 : n1041;
  /*# t65/T65_MCode.vhd:531:9 */
  assign n1682 = n1641 ? n1672 : n1044;
  /*# t65/T65_MCode.vhd:530:7 */
  assign n1684 = n1069 == 5'b01011;
  /*# t65/T65_MCode.vhd:561:11 */
  assign n1686 = mcycle == 3'b000;
  /*# t65/T65_MCode.vhd:563:19 */
  assign n1688 = ir == 8'b10100010;
  /*# t65/T65_MCode.vhd:567:21 */
  assign n1689 = ir[7:4]; // extract
  /*# t65/T65_MCode.vhd:567:33 */
  assign n1691 = n1689 == 4'b1000;
  /*# t65/T65_MCode.vhd:567:46 */
  assign n1692 = ir[7:4]; // extract
  /*# t65/T65_MCode.vhd:567:58 */
  assign n1694 = n1692 == 4'b1100;
  /*# t65/T65_MCode.vhd:567:41 */
  assign n1695 = n1691 | n1694;
  /*# t65/T65_MCode.vhd:567:71 */
  assign n1696 = ir[7:4]; // extract
  /*# t65/T65_MCode.vhd:567:83 */
  assign n1698 = n1696 == 4'b1110;
  /*# t65/T65_MCode.vhd:567:66 */
  assign n1699 = n1695 | n1698;
  /*# t65/T65_MCode.vhd:567:13 */
  assign n1702 = n1699 ? 2'b01 : 2'b00;
  /*# t65/T65_MCode.vhd:563:13 */
  assign n1704 = n1688 ? 2'b01 : n1702;
  /*# t65/T65_MCode.vhd:563:13 */
  assign n1706 = n1688 ? 1'b1 : n1044;
  /*# t65/T65_MCode.vhd:562:11 */
  assign n1708 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:560:9 */
  assign n1709 = {n1708, n1686};
  /*# t65/T65_MCode.vhd:560:9 */
  always @*
    case (n1709)
      2'b10: n1711 = n1704;
      2'b01: n1711 = 2'b00;
      default: n1711 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:560:9 */
  always @*
    case (n1709)
      2'b10: n1712 = n1706;
      2'b01: n1712 = n1044;
      default: n1712 = n1044;
    endcase
  /*# t65/T65_MCode.vhd:558:7 */
  assign n1714 = n1069 == 5'b00010;
  /*# t65/T65_MCode.vhd:558:20 */
  assign n1716 = n1069 == 5'b10010;
  /*# t65/T65_MCode.vhd:558:20 */
  assign n1717 = n1714 | n1716;
  /*# t65/T65_MCode.vhd:582:18 */
  assign n1718 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:582:31 */
  assign n1720 = n1718 == 3'b001;
  /*# t65/T65_MCode.vhd:582:13 */
  assign n1723 = n1720 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:581:11 */
  assign n1725 = mcycle == 3'b000;
  /*# t65/T65_MCode.vhd:588:18 */
  assign n1726 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:588:31 */
  assign n1728 = n1726 == 3'b100;
  /*# t65/T65_MCode.vhd:588:13 */
  assign n1731 = n1728 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:585:11 */
  assign n1733 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:592:11 */
  assign n1735 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:580:9 */
  assign n1736 = {n1735, n1733, n1725};
  /*# t65/T65_MCode.vhd:580:9 */
  always @*
    case (n1736)
      3'b100: n1739 = 2'b10;
      3'b010: n1739 = 2'b01;
      3'b001: n1739 = 2'b10;
      default: n1739 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:580:9 */
  always @*
    case (n1736)
      3'b100: n1742 = 2'b00;
      3'b010: n1742 = 2'b01;
      3'b001: n1742 = 2'b00;
      default: n1742 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:580:9 */
  always @*
    case (n1736)
      3'b100: n1745 = 1'b0;
      3'b010: n1745 = 1'b1;
      3'b001: n1745 = 1'b0;
      default: n1745 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:580:9 */
  always @*
    case (n1736)
      3'b100: n1747 = 1'b0;
      3'b010: n1747 = 1'b0;
      3'b001: n1747 = n1723;
      default: n1747 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:580:9 */
  always @*
    case (n1736)
      3'b100: n1749 = 1'b0;
      3'b010: n1749 = n1731;
      3'b001: n1749 = 1'b0;
      default: n1749 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:577:7 */
  assign n1751 = n1069 == 5'b00100;
  /*# t65/T65_MCode.vhd:601:14 */
  assign n1752 = ir[7:6]; // extract
  /*# t65/T65_MCode.vhd:601:27 */
  assign n1754 = n1752 != 2'b10;
  /*# t65/T65_MCode.vhd:601:41 */
  assign n1755 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:601:35 */
  assign n1756 = n1755 & n1754;
  /*# t65/T65_MCode.vhd:601:60 */
  assign n1758 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:601:71 */
  assign n1759 = ir[0]; // extract
  /*# t65/T65_MCode.vhd:601:74 */
  assign n1760 = ~n1759;
  /*# t65/T65_MCode.vhd:601:66 */
  assign n1761 = n1758 | n1760;
  /*# t65/T65_MCode.vhd:601:51 */
  assign n1762 = n1761 & n1756;
  /*# t65/T65_MCode.vhd:604:18 */
  assign n1764 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:604:30 */
  assign n1765 = ir[0]; // extract
  /*# t65/T65_MCode.vhd:604:24 */
  assign n1766 = n1765 & n1764;
  /*# t65/T65_MCode.vhd:604:11 */
  assign n1768 = n1766 ? 1'b1 : n1041;
  /*# t65/T65_MCode.vhd:608:13 */
  assign n1770 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:614:22 */
  assign n1772 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:614:15 */
  assign n1775 = n1772 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:612:13 */
  assign n1777 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:618:13 */
  assign n1779 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:624:22 */
  assign n1781 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:624:34 */
  assign n1782 = ir[0]; // extract
  /*# t65/T65_MCode.vhd:624:28 */
  assign n1783 = n1782 & n1781;
  /*# t65/T65_MCode.vhd:624:15 */
  assign n1785 = n1783 ? 4'b0001 : n1068;
  /*# t65/T65_MCode.vhd:624:15 */
  assign n1788 = n1783 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:624:15 */
  assign n1791 = n1783 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:623:13 */
  assign n1793 = mcycle == 3'b100;
  /*# t65/T65_MCode.vhd:607:11 */
  assign n1794 = {n1793, n1779, n1777, n1770};
  /*# t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1794)
      4'b1000: n1795 = n1785;
      4'b0100: n1795 = n1068;
      4'b0010: n1795 = n1068;
      4'b0001: n1795 = n1068;
      default: n1795 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1794)
      4'b1000: n1800 = 2'b10;
      4'b0100: n1800 = 2'b01;
      4'b0010: n1800 = 2'b01;
      4'b0001: n1800 = 2'b01;
      default: n1800 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1794)
      4'b1000: n1803 = 2'b00;
      4'b0100: n1803 = 2'b00;
      4'b0010: n1803 = 2'b00;
      4'b0001: n1803 = 2'b01;
      default: n1803 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1794)
      4'b1000: n1806 = n1788;
      4'b0100: n1806 = 1'b0;
      4'b0010: n1806 = 1'b1;
      4'b0001: n1806 = 1'b0;
      default: n1806 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1794)
      4'b1000: n1809 = 1'b0;
      4'b0100: n1809 = 1'b1;
      4'b0010: n1809 = 1'b0;
      4'b0001: n1809 = 1'b0;
      default: n1809 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1794)
      4'b1000: n1812 = 1'b0;
      4'b0100: n1812 = 1'b0;
      4'b0010: n1812 = 1'b0;
      4'b0001: n1812 = 1'b1;
      default: n1812 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1794)
      4'b1000: n1815 = 1'b0;
      4'b0100: n1815 = 1'b1;
      4'b0010: n1815 = 1'b0;
      4'b0001: n1815 = 1'b0;
      default: n1815 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1794)
      4'b1000: n1818 = 1'b0;
      4'b0100: n1818 = 1'b1;
      4'b0010: n1818 = n1775;
      4'b0001: n1818 = 1'b0;
      default: n1818 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1794)
      4'b1000: n1820 = n1791;
      4'b0100: n1820 = 1'b0;
      4'b0010: n1820 = 1'b0;
      4'b0001: n1820 = 1'b0;
      default: n1820 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:633:16 */
  assign n1821 = ir[7:6]; // extract
  /*# t65/T65_MCode.vhd:633:29 */
  assign n1823 = n1821 != 2'b10;
  /*# t65/T65_MCode.vhd:633:11 */
  assign n1825 = n1823 ? 1'b1 : n1041;
  /*# t65/T65_MCode.vhd:637:13 */
  assign n1827 = mcycle == 3'b000;
  /*# t65/T65_MCode.vhd:641:20 */
  assign n1828 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:641:33 */
  assign n1830 = n1828 == 3'b100;
  /*# t65/T65_MCode.vhd:641:15 */
  assign n1833 = n1830 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:638:13 */
  assign n1835 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:645:13 */
  assign n1837 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:636:11 */
  assign n1838 = {n1837, n1835, n1827};
  /*# t65/T65_MCode.vhd:636:11 */
  always @*
    case (n1838)
      3'b100: n1841 = 2'b10;
      3'b010: n1841 = 2'b01;
      3'b001: n1841 = 2'b10;
      default: n1841 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:636:11 */
  always @*
    case (n1838)
      3'b100: n1844 = 2'b00;
      3'b010: n1844 = 2'b01;
      3'b001: n1844 = 2'b00;
      default: n1844 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:636:11 */
  always @*
    case (n1838)
      3'b100: n1847 = 1'b0;
      3'b010: n1847 = 1'b1;
      3'b001: n1847 = 1'b0;
      default: n1847 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:636:11 */
  always @*
    case (n1838)
      3'b100: n1849 = 1'b0;
      3'b010: n1849 = n1833;
      3'b001: n1849 = 1'b0;
      default: n1849 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:601:9 */
  assign n1852 = n1762 ? 3'b100 : 3'b010;
  /*# t65/T65_MCode.vhd:601:9 */
  assign n1853 = n1762 ? n1795 : n1068;
  /*# t65/T65_MCode.vhd:601:9 */
  assign n1854 = n1762 ? n1800 : n1841;
  /*# t65/T65_MCode.vhd:601:9 */
  assign n1855 = n1762 ? n1803 : n1844;
  /*# t65/T65_MCode.vhd:601:9 */
  assign n1856 = n1762 ? n1768 : n1825;
  /*# t65/T65_MCode.vhd:601:9 */
  assign n1858 = n1762 ? n1806 : 1'b0;
  /*# t65/T65_MCode.vhd:601:9 */
  assign n1860 = n1762 ? n1809 : 1'b0;
  /*# t65/T65_MCode.vhd:601:9 */
  assign n1861 = n1762 ? n1812 : n1847;
  /*# t65/T65_MCode.vhd:601:9 */
  assign n1863 = n1762 ? n1815 : 1'b0;
  /*# t65/T65_MCode.vhd:601:9 */
  assign n1864 = n1762 ? n1818 : n1849;
  /*# t65/T65_MCode.vhd:601:9 */
  assign n1866 = n1762 ? n1820 : 1'b0;
  /*# t65/T65_MCode.vhd:599:7 */
  assign n1868 = n1069 == 5'b00101;
  /*# t65/T65_MCode.vhd:599:20 */
  assign n1870 = n1069 == 5'b00110;
  /*# t65/T65_MCode.vhd:599:20 */
  assign n1871 = n1868 | n1870;
  /*# t65/T65_MCode.vhd:599:30 */
  assign n1873 = n1069 == 5'b00111;
  /*# t65/T65_MCode.vhd:599:30 */
  assign n1874 = n1871 | n1873;
  /*# t65/T65_MCode.vhd:653:14 */
  assign n1875 = ir[7:6]; // extract
  /*# t65/T65_MCode.vhd:653:27 */
  assign n1877 = n1875 == 2'b01;
  /*# t65/T65_MCode.vhd:653:40 */
  assign n1878 = ir[4:0]; // extract
  /*# t65/T65_MCode.vhd:653:53 */
  assign n1880 = n1878 == 5'b01100;
  /*# t65/T65_MCode.vhd:653:34 */
  assign n1881 = n1880 & n1877;
  /*# t65/T65_MCode.vhd:654:16 */
  assign n1882 = ir[5]; // extract
  /*# t65/T65_MCode.vhd:654:20 */
  assign n1883 = ~n1882;
  /*# t65/T65_MCode.vhd:657:15 */
  assign n1885 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:660:15 */
  assign n1887 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:656:13 */
  assign n1888 = {n1887, n1885};
  /*# t65/T65_MCode.vhd:656:13 */
  always @*
    case (n1888)
      2'b10: n1892 = 2'b10;
      2'b01: n1892 = 2'b01;
      default: n1892 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:656:13 */
  always @*
    case (n1888)
      2'b10: n1895 = 1'b0;
      2'b01: n1895 = 1'b1;
      default: n1895 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:667:15 */
  assign n1897 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:673:25 */
  assign n1899 = mode != 2'b00;
  /*# t65/T65_MCode.vhd:673:17 */
  assign n1902 = n1899 ? 2'b10 : 2'b00;
  /*# t65/T65_MCode.vhd:676:25 */
  assign n1904 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:676:17 */
  assign n1907 = n1904 ? 2'b11 : 2'b10;
  /*# t65/T65_MCode.vhd:671:15 */
  assign n1909 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:681:25 */
  assign n1911 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:681:17 */
  assign n1914 = n1911 ? 2'b11 : 2'b10;
  /*# t65/T65_MCode.vhd:681:17 */
  assign n1917 = n1911 ? 2'b00 : 2'b01;
  /*# t65/T65_MCode.vhd:681:17 */
  assign n1920 = n1911 ? 2'b01 : 2'b00;
  /*# t65/T65_MCode.vhd:679:15 */
  assign n1922 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:687:15 */
  assign n1924 = mcycle == 3'b100;
  /*# t65/T65_MCode.vhd:666:13 */
  assign n1925 = {n1924, n1922, n1909, n1897};
  /*# t65/T65_MCode.vhd:666:13 */
  always @*
    case (n1925)
      4'b1000: n1927 = 2'b10;
      4'b0100: n1927 = n1914;
      4'b0010: n1927 = n1907;
      4'b0001: n1927 = 2'b10;
      default: n1927 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:666:13 */
  always @*
    case (n1925)
      4'b1000: n1931 = 2'b10;
      4'b0100: n1931 = n1917;
      4'b0010: n1931 = n1902;
      4'b0001: n1931 = 2'b01;
      default: n1931 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:666:13 */
  always @*
    case (n1925)
      4'b1000: n1933 = 2'b00;
      4'b0100: n1933 = n1920;
      4'b0010: n1933 = 2'b00;
      4'b0001: n1933 = 2'b00;
      default: n1933 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:666:13 */
  always @*
    case (n1925)
      4'b1000: n1937 = 1'b0;
      4'b0100: n1937 = 1'b1;
      4'b0010: n1937 = 1'b0;
      4'b0001: n1937 = 1'b1;
      default: n1937 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:666:13 */
  always @*
    case (n1925)
      4'b1000: n1940 = 1'b0;
      4'b0100: n1940 = 1'b0;
      4'b0010: n1940 = 1'b0;
      4'b0001: n1940 = 1'b1;
      default: n1940 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:666:13 */
  always @*
    case (n1925)
      4'b1000: n1943 = 1'b0;
      4'b0100: n1943 = 1'b0;
      4'b0010: n1943 = 1'b1;
      4'b0001: n1943 = 1'b0;
      default: n1943 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:654:11 */
  assign n1946 = n1883 ? 3'b010 : 3'b100;
  /*# t65/T65_MCode.vhd:654:11 */
  assign n1948 = n1883 ? 2'b10 : n1927;
  /*# t65/T65_MCode.vhd:654:11 */
  assign n1949 = n1883 ? n1892 : n1931;
  /*# t65/T65_MCode.vhd:654:11 */
  assign n1951 = n1883 ? 2'b00 : n1933;
  /*# t65/T65_MCode.vhd:654:11 */
  assign n1952 = n1883 ? n1895 : n1937;
  /*# t65/T65_MCode.vhd:654:11 */
  assign n1954 = n1883 ? 1'b0 : n1940;
  /*# t65/T65_MCode.vhd:654:11 */
  assign n1956 = n1883 ? 1'b0 : n1943;
  /*# t65/T65_MCode.vhd:696:20 */
  assign n1957 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:696:33 */
  assign n1959 = n1957 == 3'b001;
  /*# t65/T65_MCode.vhd:696:15 */
  assign n1962 = n1959 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:695:13 */
  assign n1964 = mcycle == 3'b000;
  /*# t65/T65_MCode.vhd:699:13 */
  assign n1966 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:705:20 */
  assign n1967 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:705:33 */
  assign n1969 = n1967 == 3'b100;
  /*# t65/T65_MCode.vhd:705:15 */
  assign n1972 = n1969 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:702:13 */
  assign n1974 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:709:13 */
  assign n1976 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:694:11 */
  assign n1977 = {n1976, n1974, n1966, n1964};
  /*# t65/T65_MCode.vhd:694:11 */
  always @*
    case (n1977)
      4'b1000: n1980 = 2'b10;
      4'b0100: n1980 = 2'b11;
      4'b0010: n1980 = 2'b10;
      4'b0001: n1980 = 2'b10;
      default: n1980 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:694:11 */
  always @*
    case (n1977)
      4'b1000: n1984 = 2'b00;
      4'b0100: n1984 = 2'b01;
      4'b0010: n1984 = 2'b01;
      4'b0001: n1984 = 2'b00;
      default: n1984 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:694:11 */
  always @*
    case (n1977)
      4'b1000: n1987 = 1'b0;
      4'b0100: n1987 = 1'b0;
      4'b0010: n1987 = 1'b1;
      4'b0001: n1987 = 1'b0;
      default: n1987 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:694:11 */
  always @*
    case (n1977)
      4'b1000: n1990 = 1'b0;
      4'b0100: n1990 = 1'b1;
      4'b0010: n1990 = 1'b0;
      4'b0001: n1990 = 1'b0;
      default: n1990 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:694:11 */
  always @*
    case (n1977)
      4'b1000: n1992 = 1'b0;
      4'b0100: n1992 = 1'b0;
      4'b0010: n1992 = 1'b0;
      4'b0001: n1992 = n1962;
      default: n1992 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:694:11 */
  always @*
    case (n1977)
      4'b1000: n1994 = 1'b0;
      4'b0100: n1994 = n1972;
      4'b0010: n1994 = 1'b0;
      4'b0001: n1994 = 1'b0;
      default: n1994 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:653:9 */
  assign n1996 = n1881 ? n1946 : 3'b011;
  /*# t65/T65_MCode.vhd:653:9 */
  assign n1997 = n1881 ? n1948 : n1980;
  /*# t65/T65_MCode.vhd:653:9 */
  assign n1998 = n1881 ? n1949 : n1984;
  /*# t65/T65_MCode.vhd:653:9 */
  assign n2000 = n1881 ? n1951 : 2'b00;
  /*# t65/T65_MCode.vhd:653:9 */
  assign n2002 = n1881 ? n1952 : 1'b0;
  /*# t65/T65_MCode.vhd:653:9 */
  assign n2003 = n1881 ? n1954 : n1987;
  /*# t65/T65_MCode.vhd:653:9 */
  assign n2004 = n1881 ? n1956 : n1990;
  /*# t65/T65_MCode.vhd:653:9 */
  assign n2006 = n1881 ? 1'b0 : n1992;
  /*# t65/T65_MCode.vhd:653:9 */
  assign n2008 = n1881 ? 1'b0 : n1994;
  /*# t65/T65_MCode.vhd:651:7 */
  assign n2010 = n1069 == 5'b01100;
  /*# t65/T65_MCode.vhd:719:14 */
  assign n2011 = ir[7:6]; // extract
  /*# t65/T65_MCode.vhd:719:27 */
  assign n2013 = n2011 != 2'b10;
  /*# t65/T65_MCode.vhd:719:41 */
  assign n2014 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:719:35 */
  assign n2015 = n2014 & n2013;
  /*# t65/T65_MCode.vhd:719:60 */
  assign n2017 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:719:71 */
  assign n2018 = ir[0]; // extract
  /*# t65/T65_MCode.vhd:719:74 */
  assign n2019 = ~n2018;
  /*# t65/T65_MCode.vhd:719:66 */
  assign n2020 = n2017 | n2019;
  /*# t65/T65_MCode.vhd:719:51 */
  assign n2021 = n2020 & n2015;
  /*# t65/T65_MCode.vhd:722:18 */
  assign n2023 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:722:30 */
  assign n2024 = ir[0]; // extract
  /*# t65/T65_MCode.vhd:722:24 */
  assign n2025 = n2024 & n2023;
  /*# t65/T65_MCode.vhd:722:11 */
  assign n2027 = n2025 ? 1'b1 : n1041;
  /*# t65/T65_MCode.vhd:726:13 */
  assign n2029 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:729:13 */
  assign n2031 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:735:22 */
  assign n2033 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:735:15 */
  assign n2036 = n2033 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:733:13 */
  assign n2038 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:739:13 */
  assign n2040 = mcycle == 3'b100;
  /*# t65/T65_MCode.vhd:745:22 */
  assign n2042 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:745:34 */
  assign n2043 = ir[0]; // extract
  /*# t65/T65_MCode.vhd:745:28 */
  assign n2044 = n2043 & n2042;
  /*# t65/T65_MCode.vhd:745:15 */
  assign n2046 = n2044 ? 4'b0001 : n1068;
  /*# t65/T65_MCode.vhd:745:15 */
  assign n2049 = n2044 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:744:13 */
  assign n2051 = mcycle == 3'b101;
  /*# t65/T65_MCode.vhd:725:11 */
  assign n2052 = {n2051, n2040, n2038, n2031, n2029};
  /*# t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2052)
      5'b10000: n2053 = n2046;
      5'b01000: n2053 = n1068;
      5'b00100: n2053 = n1068;
      5'b00010: n2053 = n1068;
      5'b00001: n2053 = n1068;
      default: n2053 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2052)
      5'b10000: n2058 = 2'b10;
      5'b01000: n2058 = 2'b11;
      5'b00100: n2058 = 2'b11;
      5'b00010: n2058 = 2'b11;
      5'b00001: n2058 = 2'b10;
      default: n2058 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2052)
      5'b10000: n2062 = 2'b00;
      5'b01000: n2062 = 2'b00;
      5'b00100: n2062 = 2'b00;
      5'b00010: n2062 = 2'b01;
      5'b00001: n2062 = 2'b01;
      default: n2062 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2052)
      5'b10000: n2065 = 1'b0;
      5'b01000: n2065 = 1'b0;
      5'b00100: n2065 = 1'b1;
      5'b00010: n2065 = 1'b0;
      5'b00001: n2065 = 1'b0;
      default: n2065 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2052)
      5'b10000: n2068 = 1'b0;
      5'b01000: n2068 = 1'b1;
      5'b00100: n2068 = 1'b0;
      5'b00010: n2068 = 1'b0;
      5'b00001: n2068 = 1'b0;
      default: n2068 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2052)
      5'b10000: n2071 = 1'b0;
      5'b01000: n2071 = 1'b0;
      5'b00100: n2071 = 1'b0;
      5'b00010: n2071 = 1'b0;
      5'b00001: n2071 = 1'b1;
      default: n2071 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2052)
      5'b10000: n2074 = 1'b0;
      5'b01000: n2074 = 1'b0;
      5'b00100: n2074 = 1'b0;
      5'b00010: n2074 = 1'b1;
      5'b00001: n2074 = 1'b0;
      default: n2074 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2052)
      5'b10000: n2077 = 1'b0;
      5'b01000: n2077 = 1'b1;
      5'b00100: n2077 = 1'b0;
      5'b00010: n2077 = 1'b0;
      5'b00001: n2077 = 1'b0;
      default: n2077 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2052)
      5'b10000: n2080 = 1'b0;
      5'b01000: n2080 = 1'b1;
      5'b00100: n2080 = n2036;
      5'b00010: n2080 = 1'b0;
      5'b00001: n2080 = 1'b0;
      default: n2080 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2052)
      5'b10000: n2082 = n2049;
      5'b01000: n2082 = 1'b0;
      5'b00100: n2082 = 1'b0;
      5'b00010: n2082 = 1'b0;
      5'b00001: n2082 = 1'b0;
      default: n2082 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:753:16 */
  assign n2083 = ir[7:6]; // extract
  /*# t65/T65_MCode.vhd:753:29 */
  assign n2085 = n2083 != 2'b10;
  /*# t65/T65_MCode.vhd:753:11 */
  assign n2087 = n2085 ? 1'b1 : n1041;
  /*# t65/T65_MCode.vhd:757:13 */
  assign n2089 = mcycle == 3'b000;
  /*# t65/T65_MCode.vhd:758:13 */
  assign n2091 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:764:20 */
  assign n2092 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:764:33 */
  assign n2094 = n2092 == 3'b100;
  /*# t65/T65_MCode.vhd:764:15 */
  assign n2097 = n2094 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:761:13 */
  assign n2099 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:768:13 */
  assign n2101 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:756:11 */
  assign n2102 = {n2101, n2099, n2091, n2089};
  /*# t65/T65_MCode.vhd:756:11 */
  always @*
    case (n2102)
      4'b1000: n2105 = 2'b10;
      4'b0100: n2105 = 2'b11;
      4'b0010: n2105 = 2'b10;
      4'b0001: n2105 = 2'b10;
      default: n2105 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:756:11 */
  always @*
    case (n2102)
      4'b1000: n2109 = 2'b00;
      4'b0100: n2109 = 2'b01;
      4'b0010: n2109 = 2'b01;
      4'b0001: n2109 = 2'b00;
      default: n2109 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:756:11 */
  always @*
    case (n2102)
      4'b1000: n2112 = 1'b0;
      4'b0100: n2112 = 1'b0;
      4'b0010: n2112 = 1'b1;
      4'b0001: n2112 = 1'b0;
      default: n2112 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:756:11 */
  always @*
    case (n2102)
      4'b1000: n2115 = 1'b0;
      4'b0100: n2115 = 1'b1;
      4'b0010: n2115 = 1'b0;
      4'b0001: n2115 = 1'b0;
      default: n2115 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:756:11 */
  always @*
    case (n2102)
      4'b1000: n2117 = 1'b0;
      4'b0100: n2117 = n2097;
      4'b0010: n2117 = 1'b0;
      4'b0001: n2117 = 1'b0;
      default: n2117 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:719:9 */
  assign n2120 = n2021 ? 3'b101 : 3'b011;
  /*# t65/T65_MCode.vhd:719:9 */
  assign n2121 = n2021 ? n2053 : n1068;
  /*# t65/T65_MCode.vhd:719:9 */
  assign n2122 = n2021 ? n2058 : n2105;
  /*# t65/T65_MCode.vhd:719:9 */
  assign n2123 = n2021 ? n2062 : n2109;
  /*# t65/T65_MCode.vhd:719:9 */
  assign n2124 = n2021 ? n2027 : n2087;
  /*# t65/T65_MCode.vhd:719:9 */
  assign n2126 = n2021 ? n2065 : 1'b0;
  /*# t65/T65_MCode.vhd:719:9 */
  assign n2128 = n2021 ? n2068 : 1'b0;
  /*# t65/T65_MCode.vhd:719:9 */
  assign n2129 = n2021 ? n2071 : n2112;
  /*# t65/T65_MCode.vhd:719:9 */
  assign n2130 = n2021 ? n2074 : n2115;
  /*# t65/T65_MCode.vhd:719:9 */
  assign n2132 = n2021 ? n2077 : 1'b0;
  /*# t65/T65_MCode.vhd:719:9 */
  assign n2133 = n2021 ? n2080 : n2117;
  /*# t65/T65_MCode.vhd:719:9 */
  assign n2135 = n2021 ? n2082 : 1'b0;
  /*# t65/T65_MCode.vhd:717:7 */
  assign n2137 = n1069 == 5'b01101;
  /*# t65/T65_MCode.vhd:717:20 */
  assign n2139 = n1069 == 5'b01110;
  /*# t65/T65_MCode.vhd:717:20 */
  assign n2140 = n2137 | n2139;
  /*# t65/T65_MCode.vhd:717:30 */
  assign n2142 = n1069 == 5'b01111;
  /*# t65/T65_MCode.vhd:717:30 */
  assign n2143 = n2140 | n2142;
  /*# t65/T65_MCode.vhd:780:9 */
  assign n2146 = branch ? 3'b011 : 3'b001;
  /*# t65/T65_MCode.vhd:794:11 */
  assign n2148 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:805:11 */
  assign n2150 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:814:11 */
  assign n2152 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:789:9 */
  assign n2153 = {n2152, n2150, n2148};
  /*# t65/T65_MCode.vhd:789:9 */
  always @*
    case (n2153)
      3'b100: n2157 = 2'b00;
      3'b010: n2157 = 2'b11;
      3'b001: n2157 = 2'b01;
      default: n2157 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:789:9 */
  always @*
    case (n2153)
      3'b100: n2160 = 1'b0;
      3'b010: n2160 = 1'b1;
      3'b001: n2160 = 1'b0;
      default: n2160 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:789:9 */
  always @*
    case (n2153)
      3'b100: n2163 = 1'b0;
      3'b010: n2163 = 1'b0;
      3'b001: n2163 = 1'b1;
      default: n2163 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:774:7 */
  assign n2165 = n1069 == 5'b10000;
  /*# t65/T65_MCode.vhd:822:14 */
  assign n2166 = ir[7:6]; // extract
  /*# t65/T65_MCode.vhd:822:27 */
  assign n2168 = n2166 != 2'b10;
  /*# t65/T65_MCode.vhd:824:18 */
  assign n2170 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:824:30 */
  assign n2171 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:824:24 */
  assign n2172 = n2171 & n2170;
  /*# t65/T65_MCode.vhd:824:11 */
  assign n2175 = n2172 ? 3'b111 : 3'b101;
  /*# t65/T65_MCode.vhd:822:9 */
  assign n2177 = n2168 ? n2175 : 3'b101;
  /*# t65/T65_MCode.vhd:822:9 */
  assign n2180 = n2168 ? 1'b1 : n1041;
  /*# t65/T65_MCode.vhd:829:11 */
  assign n2182 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:833:11 */
  assign n2184 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:837:11 */
  assign n2186 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:844:18 */
  assign n2187 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:844:31 */
  assign n2189 = n2187 == 3'b100;
  /*# t65/T65_MCode.vhd:846:21 */
  assign n2190 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:846:24 */
  assign n2191 = ~n2190;
  /*# t65/T65_MCode.vhd:846:34 */
  assign n2193 = ir == 8'b10110011;
  /*# t65/T65_MCode.vhd:846:29 */
  assign n2194 = n2191 | n2193;
  /*# t65/T65_MCode.vhd:846:13 */
  assign n2197 = n2194 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:844:13 */
  assign n2199 = n2189 ? 1'b0 : n2197;
  /*# t65/T65_MCode.vhd:844:13 */
  assign n2202 = n2189 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:842:11 */
  assign n2204 = mcycle == 3'b100;
  /*# t65/T65_MCode.vhd:851:20 */
  assign n2206 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:851:32 */
  assign n2207 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:851:26 */
  assign n2208 = n2207 & n2206;
  /*# t65/T65_MCode.vhd:851:46 */
  assign n2209 = ir[7:6]; // extract
  /*# t65/T65_MCode.vhd:851:58 */
  assign n2211 = n2209 != 2'b10;
  /*# t65/T65_MCode.vhd:851:40 */
  assign n2212 = n2211 & n2208;
  /*# t65/T65_MCode.vhd:851:13 */
  assign n2215 = n2212 ? 2'b11 : 2'b10;
  /*# t65/T65_MCode.vhd:851:13 */
  assign n2218 = n2212 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:851:13 */
  assign n2221 = n2212 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:850:11 */
  assign n2223 = mcycle == 3'b101;
  /*# t65/T65_MCode.vhd:856:11 */
  assign n2225 = mcycle == 3'b110;
  /*# t65/T65_MCode.vhd:861:11 */
  assign n2227 = mcycle == 3'b111;
  /*# t65/T65_MCode.vhd:828:9 */
  assign n2228 = {n2227, n2225, n2223, n2204, n2186, n2184, n2182};
  /*# t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2228)
      7'b1000000: n2231 = 4'b0001;
      7'b0100000: n2231 = n1068;
      7'b0010000: n2231 = n1068;
      7'b0001000: n2231 = n1068;
      7'b0000100: n2231 = 4'b0011;
      7'b0000010: n2231 = n1068;
      7'b0000001: n2231 = n1068;
      default: n2231 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2228)
      7'b1000000: n2238 = 2'b10;
      7'b0100000: n2238 = 2'b11;
      7'b0010000: n2238 = n2215;
      7'b0001000: n2238 = 2'b11;
      7'b0000100: n2238 = 2'b11;
      7'b0000010: n2238 = 2'b01;
      7'b0000001: n2238 = 2'b01;
      default: n2238 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2228)
      7'b1000000: n2241 = 2'b00;
      7'b0100000: n2241 = 2'b00;
      7'b0010000: n2241 = 2'b00;
      7'b0001000: n2241 = 2'b00;
      7'b0000100: n2241 = 2'b00;
      7'b0000010: n2241 = 2'b00;
      7'b0000001: n2241 = 2'b01;
      default: n2241 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2228)
      7'b1000000: n2246 = 2'b00;
      7'b0100000: n2246 = 2'b00;
      7'b0010000: n2246 = 2'b00;
      7'b0001000: n2246 = 2'b11;
      7'b0000100: n2246 = 2'b10;
      7'b0000010: n2246 = 2'b01;
      7'b0000001: n2246 = 2'b00;
      default: n2246 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2228)
      7'b1000000: n2248 = 1'b0;
      7'b0100000: n2248 = 1'b0;
      7'b0010000: n2248 = 1'b0;
      7'b0001000: n2248 = n2199;
      7'b0000100: n2248 = 1'b0;
      7'b0000010: n2248 = 1'b0;
      7'b0000001: n2248 = 1'b0;
      default: n2248 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2228)
      7'b1000000: n2250 = 1'b0;
      7'b0100000: n2250 = 1'b0;
      7'b0010000: n2250 = n2218;
      7'b0001000: n2250 = 1'b0;
      7'b0000100: n2250 = 1'b0;
      7'b0000010: n2250 = 1'b0;
      7'b0000001: n2250 = 1'b0;
      default: n2250 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2228)
      7'b1000000: n2253 = 1'b0;
      7'b0100000: n2253 = 1'b1;
      7'b0010000: n2253 = 1'b0;
      7'b0001000: n2253 = 1'b0;
      7'b0000100: n2253 = 1'b0;
      7'b0000010: n2253 = 1'b0;
      7'b0000001: n2253 = 1'b0;
      default: n2253 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2228)
      7'b1000000: n2256 = 1'b0;
      7'b0100000: n2256 = 1'b0;
      7'b0010000: n2256 = 1'b0;
      7'b0001000: n2256 = 1'b0;
      7'b0000100: n2256 = 1'b0;
      7'b0000010: n2256 = 1'b0;
      7'b0000001: n2256 = 1'b1;
      default: n2256 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2228)
      7'b1000000: n2259 = 1'b0;
      7'b0100000: n2259 = 1'b0;
      7'b0010000: n2259 = 1'b0;
      7'b0001000: n2259 = 1'b0;
      7'b0000100: n2259 = 1'b0;
      7'b0000010: n2259 = 1'b1;
      7'b0000001: n2259 = 1'b0;
      default: n2259 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2228)
      7'b1000000: n2262 = 1'b0;
      7'b0100000: n2262 = 1'b0;
      7'b0010000: n2262 = 1'b0;
      7'b0001000: n2262 = 1'b0;
      7'b0000100: n2262 = 1'b1;
      7'b0000010: n2262 = 1'b0;
      7'b0000001: n2262 = 1'b0;
      default: n2262 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2228)
      7'b1000000: n2265 = 1'b0;
      7'b0100000: n2265 = 1'b1;
      7'b0010000: n2265 = 1'b0;
      7'b0001000: n2265 = 1'b0;
      7'b0000100: n2265 = 1'b0;
      7'b0000010: n2265 = 1'b0;
      7'b0000001: n2265 = 1'b0;
      default: n2265 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2228)
      7'b1000000: n2268 = 1'b0;
      7'b0100000: n2268 = 1'b1;
      7'b0010000: n2268 = n2221;
      7'b0001000: n2268 = n2202;
      7'b0000100: n2268 = 1'b0;
      7'b0000010: n2268 = 1'b0;
      7'b0000001: n2268 = 1'b0;
      default: n2268 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2228)
      7'b1000000: n2271 = 1'b1;
      7'b0100000: n2271 = 1'b0;
      7'b0010000: n2271 = 1'b0;
      7'b0001000: n2271 = 1'b0;
      7'b0000100: n2271 = 1'b0;
      7'b0000010: n2271 = 1'b0;
      7'b0000001: n2271 = 1'b0;
      default: n2271 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:820:7 */
  assign n2273 = n1069 == 5'b10001;
  /*# t65/T65_MCode.vhd:820:20 */
  assign n2275 = n1069 == 5'b10011;
  /*# t65/T65_MCode.vhd:820:20 */
  assign n2276 = n2273 | n2275;
  /*# t65/T65_MCode.vhd:873:14 */
  assign n2277 = ir[7:6]; // extract
  /*# t65/T65_MCode.vhd:873:27 */
  assign n2279 = n2277 != 2'b10;
  /*# t65/T65_MCode.vhd:873:41 */
  assign n2280 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:873:35 */
  assign n2281 = n2280 & n2279;
  /*# t65/T65_MCode.vhd:873:60 */
  assign n2283 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:873:71 */
  assign n2284 = ir[0]; // extract
  /*# t65/T65_MCode.vhd:873:74 */
  assign n2285 = ~n2284;
  /*# t65/T65_MCode.vhd:873:66 */
  assign n2286 = n2283 | n2285;
  /*# t65/T65_MCode.vhd:873:51 */
  assign n2287 = n2286 & n2281;
  /*# t65/T65_MCode.vhd:875:18 */
  assign n2289 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:875:30 */
  assign n2290 = ir[0]; // extract
  /*# t65/T65_MCode.vhd:875:24 */
  assign n2291 = n2290 & n2289;
  /*# t65/T65_MCode.vhd:875:11 */
  assign n2293 = n2291 ? 1'b1 : n1041;
  /*# t65/T65_MCode.vhd:880:13 */
  assign n2295 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:884:13 */
  assign n2297 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:889:22 */
  assign n2299 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:889:15 */
  assign n2302 = n2299 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:887:13 */
  assign n2304 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:898:22 */
  assign n2306 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:898:34 */
  assign n2307 = ir[0]; // extract
  /*# t65/T65_MCode.vhd:898:28 */
  assign n2308 = n2307 & n2306;
  /*# t65/T65_MCode.vhd:898:15 */
  assign n2311 = n2308 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:893:13 */
  assign n2313 = mcycle == 3'b100;
  /*# t65/T65_MCode.vhd:902:22 */
  assign n2315 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:902:34 */
  assign n2316 = ir[0]; // extract
  /*# t65/T65_MCode.vhd:902:28 */
  assign n2317 = n2316 & n2315;
  /*# t65/T65_MCode.vhd:902:15 */
  assign n2319 = n2317 ? 4'b0001 : n1068;
  /*# t65/T65_MCode.vhd:902:15 */
  assign n2322 = n2317 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:901:13 */
  assign n2324 = mcycle == 3'b101;
  /*# t65/T65_MCode.vhd:879:11 */
  assign n2325 = {n2324, n2313, n2304, n2297, n2295};
  /*# t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2325)
      5'b10000: n2326 = n2319;
      5'b01000: n2326 = n1068;
      5'b00100: n2326 = n1068;
      5'b00010: n2326 = n1068;
      5'b00001: n2326 = n1068;
      default: n2326 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2325)
      5'b10000: n2332 = 2'b10;
      5'b01000: n2332 = 2'b01;
      5'b00100: n2332 = 2'b01;
      5'b00010: n2332 = 2'b01;
      5'b00001: n2332 = 2'b01;
      default: n2332 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2325)
      5'b10000: n2335 = 2'b00;
      5'b01000: n2335 = 2'b00;
      5'b00100: n2335 = 2'b00;
      5'b00010: n2335 = 2'b00;
      5'b00001: n2335 = 2'b01;
      default: n2335 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2325)
      5'b10000: n2338 = 1'b0;
      5'b01000: n2338 = 1'b0;
      5'b00100: n2338 = 1'b0;
      5'b00010: n2338 = 1'b1;
      5'b00001: n2338 = 1'b0;
      default: n2338 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2325)
      5'b10000: n2341 = 1'b0;
      5'b01000: n2341 = n2311;
      5'b00100: n2341 = 1'b1;
      5'b00010: n2341 = 1'b0;
      5'b00001: n2341 = 1'b0;
      default: n2341 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2325)
      5'b10000: n2344 = 1'b0;
      5'b01000: n2344 = 1'b1;
      5'b00100: n2344 = 1'b0;
      5'b00010: n2344 = 1'b0;
      5'b00001: n2344 = 1'b0;
      default: n2344 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2325)
      5'b10000: n2347 = 1'b0;
      5'b01000: n2347 = 1'b0;
      5'b00100: n2347 = 1'b0;
      5'b00010: n2347 = 1'b0;
      5'b00001: n2347 = 1'b1;
      default: n2347 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2325)
      5'b10000: n2350 = 1'b0;
      5'b01000: n2350 = 1'b1;
      5'b00100: n2350 = 1'b0;
      5'b00010: n2350 = 1'b0;
      5'b00001: n2350 = 1'b0;
      default: n2350 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2325)
      5'b10000: n2353 = 1'b0;
      5'b01000: n2353 = 1'b1;
      5'b00100: n2353 = n2302;
      5'b00010: n2353 = 1'b0;
      5'b00001: n2353 = 1'b0;
      default: n2353 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2325)
      5'b10000: n2355 = n2322;
      5'b01000: n2355 = 1'b0;
      5'b00100: n2355 = 1'b0;
      5'b00010: n2355 = 1'b0;
      5'b00001: n2355 = 1'b0;
      default: n2355 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:910:16 */
  assign n2356 = ir[7:6]; // extract
  /*# t65/T65_MCode.vhd:910:29 */
  assign n2358 = n2356 != 2'b10;
  /*# t65/T65_MCode.vhd:910:43 */
  assign n2359 = ir[0]; // extract
  /*# t65/T65_MCode.vhd:910:37 */
  assign n2360 = n2359 & n2358;
  /*# t65/T65_MCode.vhd:910:11 */
  assign n2362 = n2360 ? 1'b1 : n1041;
  /*# t65/T65_MCode.vhd:914:13 */
  assign n2364 = mcycle == 3'b000;
  /*# t65/T65_MCode.vhd:915:13 */
  assign n2366 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:922:21 */
  assign n2367 = ir[3:1]; // extract
  /*# t65/T65_MCode.vhd:922:34 */
  assign n2369 = n2367 == 3'b011;
  /*# t65/T65_MCode.vhd:922:15 */
  assign n2372 = n2369 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:925:20 */
  assign n2373 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:925:33 */
  assign n2375 = n2373 == 3'b100;
  /*# t65/T65_MCode.vhd:925:15 */
  assign n2378 = n2375 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:919:13 */
  assign n2380 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:929:13 */
  assign n2382 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:913:11 */
  assign n2383 = {n2382, n2380, n2366, n2364};
  /*# t65/T65_MCode.vhd:913:11 */
  always @*
    case (n2383)
      4'b1000: n2387 = 2'b10;
      4'b0100: n2387 = 2'b01;
      4'b0010: n2387 = 2'b01;
      4'b0001: n2387 = 2'b10;
      default: n2387 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:913:11 */
  always @*
    case (n2383)
      4'b1000: n2390 = 2'b00;
      4'b0100: n2390 = 2'b00;
      4'b0010: n2390 = 2'b01;
      4'b0001: n2390 = 2'b00;
      default: n2390 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:913:11 */
  always @*
    case (n2383)
      4'b1000: n2393 = 1'b0;
      4'b0100: n2393 = 1'b1;
      4'b0010: n2393 = 1'b0;
      4'b0001: n2393 = 1'b0;
      default: n2393 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:913:11 */
  always @*
    case (n2383)
      4'b1000: n2395 = 1'b0;
      4'b0100: n2395 = n2372;
      4'b0010: n2395 = 1'b0;
      4'b0001: n2395 = 1'b0;
      default: n2395 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:913:11 */
  always @*
    case (n2383)
      4'b1000: n2398 = 1'b0;
      4'b0100: n2398 = 1'b0;
      4'b0010: n2398 = 1'b1;
      4'b0001: n2398 = 1'b0;
      default: n2398 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:913:11 */
  always @*
    case (n2383)
      4'b1000: n2400 = 1'b0;
      4'b0100: n2400 = n2378;
      4'b0010: n2400 = 1'b0;
      4'b0001: n2400 = 1'b0;
      default: n2400 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:873:9 */
  assign n2403 = n2287 ? 3'b101 : 3'b011;
  /*# t65/T65_MCode.vhd:873:9 */
  assign n2404 = n2287 ? n2326 : n1068;
  /*# t65/T65_MCode.vhd:873:9 */
  assign n2405 = n2287 ? n2332 : n2387;
  /*# t65/T65_MCode.vhd:873:9 */
  assign n2406 = n2287 ? n2335 : n2390;
  /*# t65/T65_MCode.vhd:873:9 */
  assign n2407 = n2287 ? n2338 : n2393;
  /*# t65/T65_MCode.vhd:873:9 */
  assign n2409 = n2287 ? 1'b0 : n2395;
  /*# t65/T65_MCode.vhd:873:9 */
  assign n2410 = n2287 ? n2293 : n2362;
  /*# t65/T65_MCode.vhd:873:9 */
  assign n2412 = n2287 ? n2341 : 1'b0;
  /*# t65/T65_MCode.vhd:873:9 */
  assign n2414 = n2287 ? n2344 : 1'b0;
  /*# t65/T65_MCode.vhd:873:9 */
  assign n2415 = n2287 ? n2347 : n2398;
  /*# t65/T65_MCode.vhd:873:9 */
  assign n2417 = n2287 ? n2350 : 1'b0;
  /*# t65/T65_MCode.vhd:873:9 */
  assign n2418 = n2287 ? n2353 : n2400;
  /*# t65/T65_MCode.vhd:873:9 */
  assign n2420 = n2287 ? n2355 : 1'b0;
  /*# t65/T65_MCode.vhd:871:7 */
  assign n2422 = n1069 == 5'b10100;
  /*# t65/T65_MCode.vhd:871:20 */
  assign n2424 = n1069 == 5'b10101;
  /*# t65/T65_MCode.vhd:871:20 */
  assign n2425 = n2422 | n2424;
  /*# t65/T65_MCode.vhd:871:30 */
  assign n2427 = n1069 == 5'b10110;
  /*# t65/T65_MCode.vhd:871:30 */
  assign n2428 = n2425 | n2427;
  /*# t65/T65_MCode.vhd:871:40 */
  assign n2430 = n1069 == 5'b10111;
  /*# t65/T65_MCode.vhd:871:40 */
  assign n2431 = n2428 | n2430;
  /*# t65/T65_MCode.vhd:939:14 */
  assign n2432 = ir[7:6]; // extract
  /*# t65/T65_MCode.vhd:939:27 */
  assign n2434 = n2432 != 2'b10;
  /*# t65/T65_MCode.vhd:941:18 */
  assign n2436 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:941:30 */
  assign n2437 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:941:24 */
  assign n2438 = n2437 & n2436;
  /*# t65/T65_MCode.vhd:941:11 */
  assign n2441 = n2438 ? 3'b110 : 3'b100;
  /*# t65/T65_MCode.vhd:939:9 */
  assign n2443 = n2434 ? n2441 : 3'b100;
  /*# t65/T65_MCode.vhd:939:9 */
  assign n2446 = n2434 ? 1'b1 : n1041;
  /*# t65/T65_MCode.vhd:946:11 */
  assign n2448 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:949:11 */
  assign n2450 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:957:18 */
  assign n2451 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:957:31 */
  assign n2453 = n2451 == 3'b100;
  /*# t65/T65_MCode.vhd:959:21 */
  assign n2454 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:959:24 */
  assign n2455 = ~n2454;
  /*# t65/T65_MCode.vhd:959:34 */
  assign n2457 = ir == 8'b10111011;
  /*# t65/T65_MCode.vhd:959:29 */
  assign n2458 = n2455 | n2457;
  /*# t65/T65_MCode.vhd:959:13 */
  assign n2461 = n2458 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:957:13 */
  assign n2463 = n2453 ? 1'b0 : n2461;
  /*# t65/T65_MCode.vhd:957:13 */
  assign n2466 = n2453 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:955:11 */
  assign n2468 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:964:20 */
  assign n2470 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:964:32 */
  assign n2471 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:964:26 */
  assign n2472 = n2471 & n2470;
  /*# t65/T65_MCode.vhd:964:46 */
  assign n2473 = ir[7:6]; // extract
  /*# t65/T65_MCode.vhd:964:58 */
  assign n2475 = n2473 != 2'b10;
  /*# t65/T65_MCode.vhd:964:40 */
  assign n2476 = n2475 & n2472;
  /*# t65/T65_MCode.vhd:964:13 */
  assign n2479 = n2476 ? 2'b11 : 2'b10;
  /*# t65/T65_MCode.vhd:964:13 */
  assign n2482 = n2476 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:964:13 */
  assign n2485 = n2476 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:963:11 */
  assign n2487 = mcycle == 3'b100;
  /*# t65/T65_MCode.vhd:969:11 */
  assign n2489 = mcycle == 3'b101;
  /*# t65/T65_MCode.vhd:974:11 */
  assign n2491 = mcycle == 3'b110;
  /*# t65/T65_MCode.vhd:945:9 */
  assign n2492 = {n2491, n2489, n2487, n2468, n2450, n2448};
  /*# t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2492)
      6'b100000: n2495 = 4'b0001;
      6'b010000: n2495 = n1068;
      6'b001000: n2495 = n1068;
      6'b000100: n2495 = n1068;
      6'b000010: n2495 = 4'b0011;
      6'b000001: n2495 = n1068;
      default: n2495 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2492)
      6'b100000: n2500 = 2'b10;
      6'b010000: n2500 = 2'b11;
      6'b001000: n2500 = n2479;
      6'b000100: n2500 = 2'b11;
      6'b000010: n2500 = 2'b11;
      6'b000001: n2500 = 2'b10;
      default: n2500 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2492)
      6'b100000: n2504 = 2'b00;
      6'b010000: n2504 = 2'b00;
      6'b001000: n2504 = 2'b00;
      6'b000100: n2504 = 2'b00;
      6'b000010: n2504 = 2'b01;
      6'b000001: n2504 = 2'b01;
      default: n2504 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2492)
      6'b100000: n2508 = 2'b00;
      6'b010000: n2508 = 2'b00;
      6'b001000: n2508 = 2'b00;
      6'b000100: n2508 = 2'b11;
      6'b000010: n2508 = 2'b10;
      6'b000001: n2508 = 2'b00;
      default: n2508 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2492)
      6'b100000: n2510 = 1'b0;
      6'b010000: n2510 = 1'b0;
      6'b001000: n2510 = 1'b0;
      6'b000100: n2510 = n2463;
      6'b000010: n2510 = 1'b0;
      6'b000001: n2510 = 1'b0;
      default: n2510 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2492)
      6'b100000: n2512 = 1'b0;
      6'b010000: n2512 = 1'b0;
      6'b001000: n2512 = n2482;
      6'b000100: n2512 = 1'b0;
      6'b000010: n2512 = 1'b0;
      6'b000001: n2512 = 1'b0;
      default: n2512 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2492)
      6'b100000: n2515 = 1'b0;
      6'b010000: n2515 = 1'b1;
      6'b001000: n2515 = 1'b0;
      6'b000100: n2515 = 1'b0;
      6'b000010: n2515 = 1'b0;
      6'b000001: n2515 = 1'b0;
      default: n2515 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2492)
      6'b100000: n2518 = 1'b0;
      6'b010000: n2518 = 1'b0;
      6'b001000: n2518 = 1'b0;
      6'b000100: n2518 = 1'b0;
      6'b000010: n2518 = 1'b0;
      6'b000001: n2518 = 1'b1;
      default: n2518 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2492)
      6'b100000: n2521 = 1'b0;
      6'b010000: n2521 = 1'b0;
      6'b001000: n2521 = 1'b0;
      6'b000100: n2521 = 1'b0;
      6'b000010: n2521 = 1'b1;
      6'b000001: n2521 = 1'b0;
      default: n2521 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2492)
      6'b100000: n2524 = 1'b0;
      6'b010000: n2524 = 1'b1;
      6'b001000: n2524 = 1'b0;
      6'b000100: n2524 = 1'b0;
      6'b000010: n2524 = 1'b0;
      6'b000001: n2524 = 1'b0;
      default: n2524 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2492)
      6'b100000: n2527 = 1'b0;
      6'b010000: n2527 = 1'b1;
      6'b001000: n2527 = n2485;
      6'b000100: n2527 = n2466;
      6'b000010: n2527 = 1'b0;
      6'b000001: n2527 = 1'b0;
      default: n2527 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2492)
      6'b100000: n2530 = 1'b1;
      6'b010000: n2530 = 1'b0;
      6'b001000: n2530 = 1'b0;
      6'b000100: n2530 = 1'b0;
      6'b000010: n2530 = 1'b0;
      6'b000001: n2530 = 1'b0;
      default: n2530 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:936:7 */
  assign n2532 = n1069 == 5'b11001;
  /*# t65/T65_MCode.vhd:936:20 */
  assign n2534 = n1069 == 5'b11011;
  /*# t65/T65_MCode.vhd:936:20 */
  assign n2535 = n2532 | n2534;
  /*# t65/T65_MCode.vhd:986:14 */
  assign n2536 = ir[7:6]; // extract
  /*# t65/T65_MCode.vhd:986:27 */
  assign n2538 = n2536 != 2'b10;
  /*# t65/T65_MCode.vhd:986:41 */
  assign n2539 = ir[1]; // extract
  /*# t65/T65_MCode.vhd:986:35 */
  assign n2540 = n2539 & n2538;
  /*# t65/T65_MCode.vhd:986:60 */
  assign n2542 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:986:71 */
  assign n2543 = ir[0]; // extract
  /*# t65/T65_MCode.vhd:986:74 */
  assign n2544 = ~n2543;
  /*# t65/T65_MCode.vhd:986:66 */
  assign n2545 = n2542 | n2544;
  /*# t65/T65_MCode.vhd:986:51 */
  assign n2546 = n2545 & n2540;
  /*# t65/T65_MCode.vhd:989:18 */
  assign n2548 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:989:30 */
  assign n2549 = ir[0]; // extract
  /*# t65/T65_MCode.vhd:989:24 */
  assign n2550 = n2549 & n2548;
  /*# t65/T65_MCode.vhd:989:11 */
  assign n2552 = n2550 ? 1'b1 : n1041;
  /*# t65/T65_MCode.vhd:993:13 */
  assign n2554 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:996:13 */
  assign n2556 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:1002:13 */
  assign n2558 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:1007:22 */
  assign n2560 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:1007:15 */
  assign n2563 = n2560 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:1005:13 */
  assign n2565 = mcycle == 3'b100;
  /*# t65/T65_MCode.vhd:1011:13 */
  assign n2567 = mcycle == 3'b101;
  /*# t65/T65_MCode.vhd:1017:22 */
  assign n2569 = mode == 2'b00;
  /*# t65/T65_MCode.vhd:1017:34 */
  assign n2570 = ir[0]; // extract
  /*# t65/T65_MCode.vhd:1017:28 */
  assign n2571 = n2570 & n2569;
  /*# t65/T65_MCode.vhd:1017:15 */
  assign n2573 = n2571 ? 4'b0001 : n1068;
  /*# t65/T65_MCode.vhd:1017:15 */
  assign n2576 = n2571 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:1016:13 */
  assign n2578 = mcycle == 3'b110;
  /*# t65/T65_MCode.vhd:992:11 */
  assign n2579 = {n2578, n2567, n2565, n2558, n2556, n2554};
  /*# t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2579)
      6'b100000: n2581 = n2573;
      6'b010000: n2581 = n1068;
      6'b001000: n2581 = n1068;
      6'b000100: n2581 = n1068;
      6'b000010: n2581 = 4'b0010;
      6'b000001: n2581 = n1068;
      default: n2581 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2579)
      6'b100000: n2587 = 2'b10;
      6'b010000: n2587 = 2'b11;
      6'b001000: n2587 = 2'b11;
      6'b000100: n2587 = 2'b11;
      6'b000010: n2587 = 2'b11;
      6'b000001: n2587 = 2'b10;
      default: n2587 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2579)
      6'b100000: n2591 = 2'b00;
      6'b010000: n2591 = 2'b00;
      6'b001000: n2591 = 2'b00;
      6'b000100: n2591 = 2'b00;
      6'b000010: n2591 = 2'b01;
      6'b000001: n2591 = 2'b01;
      default: n2591 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2579)
      6'b100000: n2595 = 2'b00;
      6'b010000: n2595 = 2'b00;
      6'b001000: n2595 = 2'b00;
      6'b000100: n2595 = 2'b11;
      6'b000010: n2595 = 2'b10;
      6'b000001: n2595 = 2'b00;
      default: n2595 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2579)
      6'b100000: n2598 = 1'b0;
      6'b010000: n2598 = 1'b0;
      6'b001000: n2598 = 1'b1;
      6'b000100: n2598 = 1'b0;
      6'b000010: n2598 = 1'b0;
      6'b000001: n2598 = 1'b0;
      default: n2598 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2579)
      6'b100000: n2601 = 1'b0;
      6'b010000: n2601 = 1'b1;
      6'b001000: n2601 = 1'b0;
      6'b000100: n2601 = 1'b0;
      6'b000010: n2601 = 1'b0;
      6'b000001: n2601 = 1'b0;
      default: n2601 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2579)
      6'b100000: n2604 = 1'b0;
      6'b010000: n2604 = 1'b0;
      6'b001000: n2604 = 1'b0;
      6'b000100: n2604 = 1'b0;
      6'b000010: n2604 = 1'b0;
      6'b000001: n2604 = 1'b1;
      default: n2604 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2579)
      6'b100000: n2607 = 1'b0;
      6'b010000: n2607 = 1'b0;
      6'b001000: n2607 = 1'b0;
      6'b000100: n2607 = 1'b0;
      6'b000010: n2607 = 1'b1;
      6'b000001: n2607 = 1'b0;
      default: n2607 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2579)
      6'b100000: n2610 = 1'b0;
      6'b010000: n2610 = 1'b1;
      6'b001000: n2610 = 1'b0;
      6'b000100: n2610 = 1'b0;
      6'b000010: n2610 = 1'b0;
      6'b000001: n2610 = 1'b0;
      default: n2610 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2579)
      6'b100000: n2613 = 1'b0;
      6'b010000: n2613 = 1'b1;
      6'b001000: n2613 = n2563;
      6'b000100: n2613 = 1'b0;
      6'b000010: n2613 = 1'b0;
      6'b000001: n2613 = 1'b0;
      default: n2613 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2579)
      6'b100000: n2615 = n2576;
      6'b010000: n2615 = 1'b0;
      6'b001000: n2615 = 1'b0;
      6'b000100: n2615 = 1'b0;
      6'b000010: n2615 = 1'b0;
      6'b000001: n2615 = 1'b0;
      default: n2615 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:1025:16 */
  assign n2616 = ir[7:6]; // extract
  /*# t65/T65_MCode.vhd:1025:29 */
  assign n2618 = n2616 != 2'b10;
  /*# t65/T65_MCode.vhd:1026:20 */
  assign n2620 = mode != 2'b00;
  /*# t65/T65_MCode.vhd:1026:32 */
  assign n2621 = ir[4]; // extract
  /*# t65/T65_MCode.vhd:1026:35 */
  assign n2622 = ~n2621;
  /*# t65/T65_MCode.vhd:1026:27 */
  assign n2623 = n2620 | n2622;
  /*# t65/T65_MCode.vhd:1026:45 */
  assign n2624 = ir[1:0]; // extract
  /*# t65/T65_MCode.vhd:1026:57 */
  assign n2626 = n2624 != 2'b00;
  /*# t65/T65_MCode.vhd:1026:40 */
  assign n2627 = n2623 | n2626;
  /*# t65/T65_MCode.vhd:1025:11 */
  assign n2629 = n2630 ? 1'b1 : n1041;
  /*# t65/T65_MCode.vhd:1025:11 */
  assign n2630 = n2627 & n2618;
  /*# t65/T65_MCode.vhd:1031:13 */
  assign n2632 = mcycle == 3'b000;
  /*# t65/T65_MCode.vhd:1032:13 */
  assign n2634 = mcycle == 3'b001;
  /*# t65/T65_MCode.vhd:1038:20 */
  assign n2635 = ir[7:6]; // extract
  /*# t65/T65_MCode.vhd:1038:32 */
  assign n2637 = n2635 == 2'b10;
  /*# t65/T65_MCode.vhd:1038:44 */
  assign n2638 = ir[4:1]; // extract
  /*# t65/T65_MCode.vhd:1038:56 */
  assign n2640 = n2638 == 4'b1111;
  /*# t65/T65_MCode.vhd:1038:38 */
  assign n2641 = n2640 & n2637;
  /*# t65/T65_MCode.vhd:1038:15 */
  assign n2644 = n2641 ? 4'b0011 : 4'b0010;
  /*# t65/T65_MCode.vhd:1035:13 */
  assign n2646 = mcycle == 3'b010;
  /*# t65/T65_MCode.vhd:1048:20 */
  assign n2647 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:1048:33 */
  assign n2649 = n2647 == 3'b100;
  /*# t65/T65_MCode.vhd:1048:15 */
  assign n2652 = n2649 ? 1'b0 : 1'b1;
  /*# t65/T65_MCode.vhd:1048:15 */
  assign n2655 = n2649 ? 1'b1 : 1'b0;
  /*# t65/T65_MCode.vhd:1046:13 */
  assign n2657 = mcycle == 3'b011;
  /*# t65/T65_MCode.vhd:1054:13 */
  assign n2659 = mcycle == 3'b100;
  /*# t65/T65_MCode.vhd:1030:11 */
  assign n2660 = {n2659, n2657, n2646, n2634, n2632};
  /*# t65/T65_MCode.vhd:1030:11 */
  always @*
    case (n2660)
      5'b10000: n2661 = n1068;
      5'b01000: n2661 = n1068;
      5'b00100: n2661 = n2644;
      5'b00010: n2661 = n1068;
      5'b00001: n2661 = n1068;
      default: n2661 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:1030:11 */
  always @*
    case (n2660)
      5'b10000: n2665 = 2'b10;
      5'b01000: n2665 = 2'b11;
      5'b00100: n2665 = 2'b11;
      5'b00010: n2665 = 2'b10;
      5'b00001: n2665 = 2'b10;
      default: n2665 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:1030:11 */
  always @*
    case (n2660)
      5'b10000: n2669 = 2'b00;
      5'b01000: n2669 = 2'b00;
      5'b00100: n2669 = 2'b01;
      5'b00010: n2669 = 2'b01;
      5'b00001: n2669 = 2'b00;
      default: n2669 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:1030:11 */
  always @*
    case (n2660)
      5'b10000: n2673 = 2'b00;
      5'b01000: n2673 = 2'b11;
      5'b00100: n2673 = 2'b10;
      5'b00010: n2673 = 2'b00;
      5'b00001: n2673 = 2'b00;
      default: n2673 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:1030:11 */
  always @*
    case (n2660)
      5'b10000: n2675 = 1'b0;
      5'b01000: n2675 = n2652;
      5'b00100: n2675 = 1'b0;
      5'b00010: n2675 = 1'b0;
      5'b00001: n2675 = 1'b0;
      default: n2675 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:1030:11 */
  always @*
    case (n2660)
      5'b10000: n2678 = 1'b0;
      5'b01000: n2678 = 1'b0;
      5'b00100: n2678 = 1'b0;
      5'b00010: n2678 = 1'b1;
      5'b00001: n2678 = 1'b0;
      default: n2678 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:1030:11 */
  always @*
    case (n2660)
      5'b10000: n2681 = 1'b0;
      5'b01000: n2681 = 1'b0;
      5'b00100: n2681 = 1'b1;
      5'b00010: n2681 = 1'b0;
      5'b00001: n2681 = 1'b0;
      default: n2681 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:1030:11 */
  always @*
    case (n2660)
      5'b10000: n2683 = 1'b0;
      5'b01000: n2683 = n2655;
      5'b00100: n2683 = 1'b0;
      5'b00010: n2683 = 1'b0;
      5'b00001: n2683 = 1'b0;
      default: n2683 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:986:9 */
  assign n2686 = n2546 ? 3'b110 : 3'b100;
  /*# t65/T65_MCode.vhd:986:9 */
  assign n2687 = n2546 ? n2581 : n2661;
  /*# t65/T65_MCode.vhd:986:9 */
  assign n2688 = n2546 ? n2587 : n2665;
  /*# t65/T65_MCode.vhd:986:9 */
  assign n2689 = n2546 ? n2591 : n2669;
  /*# t65/T65_MCode.vhd:986:9 */
  assign n2690 = n2546 ? n2595 : n2673;
  /*# t65/T65_MCode.vhd:986:9 */
  assign n2692 = n2546 ? 1'b0 : n2675;
  /*# t65/T65_MCode.vhd:986:9 */
  assign n2693 = n2546 ? n2552 : n2629;
  /*# t65/T65_MCode.vhd:986:9 */
  assign n2695 = n2546 ? n2598 : 1'b0;
  /*# t65/T65_MCode.vhd:986:9 */
  assign n2697 = n2546 ? n2601 : 1'b0;
  /*# t65/T65_MCode.vhd:986:9 */
  assign n2698 = n2546 ? n2604 : n2678;
  /*# t65/T65_MCode.vhd:986:9 */
  assign n2699 = n2546 ? n2607 : n2681;
  /*# t65/T65_MCode.vhd:986:9 */
  assign n2701 = n2546 ? n2610 : 1'b0;
  /*# t65/T65_MCode.vhd:986:9 */
  assign n2702 = n2546 ? n2613 : n2683;
  /*# t65/T65_MCode.vhd:986:9 */
  assign n2704 = n2546 ? n2615 : 1'b0;
  /*# t65/T65_MCode.vhd:984:7 */
  assign n2706 = n1069 == 5'b11100;
  /*# t65/T65_MCode.vhd:984:20 */
  assign n2708 = n1069 == 5'b11101;
  /*# t65/T65_MCode.vhd:984:20 */
  assign n2709 = n2706 | n2708;
  /*# t65/T65_MCode.vhd:984:30 */
  assign n2711 = n1069 == 5'b11110;
  /*# t65/T65_MCode.vhd:984:30 */
  assign n2712 = n2709 | n2711;
  /*# t65/T65_MCode.vhd:984:40 */
  assign n2714 = n1069 == 5'b11111;
  /*# t65/T65_MCode.vhd:984:40 */
  assign n2715 = n2712 | n2714;
  /*# t65/T65_MCode.vhd:219:5 */
  assign n2716 = {n2715, n2535, n2431, n2276, n2165, n2143, n2010, n1874, n1751, n1717, n1684, n1639, n1627, n1528};
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2719 = n2686;
      14'b01000000000000: n2719 = n2443;
      14'b00100000000000: n2719 = n2403;
      14'b00010000000000: n2719 = n2177;
      14'b00001000000000: n2719 = n2146;
      14'b00000100000000: n2719 = n2120;
      14'b00000010000000: n2719 = n1996;
      14'b00000001000000: n2719 = n1852;
      14'b00000000100000: n2719 = 3'b010;
      14'b00000000010000: n2719 = 3'b001;
      14'b00000000001000: n2719 = 3'b001;
      14'b00000000000100: n2719 = 3'b001;
      14'b00000000000010: n2719 = n1540;
      14'b00000000000001: n2719 = n1485;
      default: n2719 = 3'b001;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2721 = n2687;
      14'b01000000000000: n2721 = n2495;
      14'b00100000000000: n2721 = n2404;
      14'b00010000000000: n2721 = n2231;
      14'b00001000000000: n2721 = n1068;
      14'b00000100000000: n2721 = n2121;
      14'b00000010000000: n2721 = n1068;
      14'b00000001000000: n2721 = n1853;
      14'b00000000100000: n2721 = n1068;
      14'b00000000010000: n2721 = n1068;
      14'b00000000001000: n2721 = n1678;
      14'b00000000000100: n2721 = n1068;
      14'b00000000000010: n2721 = n1583;
      14'b00000000000001: n2721 = n1487;
      default: n2721 = n1068;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2723 = n2688;
      14'b01000000000000: n2723 = n2500;
      14'b00100000000000: n2723 = n2405;
      14'b00010000000000: n2723 = n2238;
      14'b00001000000000: n2723 = 2'b10;
      14'b00000100000000: n2723 = n2122;
      14'b00000010000000: n2723 = n1997;
      14'b00000001000000: n2723 = n1854;
      14'b00000000100000: n2723 = n1739;
      14'b00000000010000: n2723 = 2'b10;
      14'b00000000001000: n2723 = 2'b10;
      14'b00000000000100: n2723 = 2'b10;
      14'b00000000000010: n2723 = n1590;
      14'b00000000000001: n2723 = n1489;
      default: n2723 = 2'b10;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2725 = n1038;
      14'b01000000000000: n2725 = n1038;
      14'b00100000000000: n2725 = n1038;
      14'b00010000000000: n2725 = n1038;
      14'b00001000000000: n2725 = n1038;
      14'b00000100000000: n2725 = n1038;
      14'b00000010000000: n2725 = n1038;
      14'b00000001000000: n2725 = n1038;
      14'b00000000100000: n2725 = n1038;
      14'b00000000010000: n2725 = n1038;
      14'b00000000001000: n2725 = n1038;
      14'b00000000000100: n2725 = n1038;
      14'b00000000000010: n2725 = n1038;
      14'b00000000000001: n2725 = n1490;
      default: n2725 = n1038;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2727 = n2689;
      14'b01000000000000: n2727 = n2504;
      14'b00100000000000: n2727 = n2406;
      14'b00010000000000: n2727 = n2241;
      14'b00001000000000: n2727 = n2157;
      14'b00000100000000: n2727 = n2123;
      14'b00000010000000: n2727 = n1998;
      14'b00000001000000: n2727 = n1855;
      14'b00000000100000: n2727 = n1742;
      14'b00000000010000: n2727 = n1711;
      14'b00000000001000: n2727 = n1680;
      14'b00000000000100: n2727 = n1637;
      14'b00000000000010: n2727 = n1593;
      14'b00000000000001: n2727 = n1492;
      default: n2727 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2730 = n2690;
      14'b01000000000000: n2730 = n2508;
      14'b00100000000000: n2730 = 2'b00;
      14'b00010000000000: n2730 = n2246;
      14'b00001000000000: n2730 = 2'b00;
      14'b00000100000000: n2730 = 2'b00;
      14'b00000010000000: n2730 = n2000;
      14'b00000001000000: n2730 = 2'b00;
      14'b00000000100000: n2730 = 2'b00;
      14'b00000000010000: n2730 = 2'b00;
      14'b00000000001000: n2730 = 2'b00;
      14'b00000000000100: n2730 = 2'b00;
      14'b00000000000010: n2730 = n1596;
      14'b00000000000001: n2730 = 2'b00;
      default: n2730 = 2'b00;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2733 = n2692;
      14'b01000000000000: n2733 = n2510;
      14'b00100000000000: n2733 = 1'b0;
      14'b00010000000000: n2733 = n2248;
      14'b00001000000000: n2733 = 1'b0;
      14'b00000100000000: n2733 = 1'b0;
      14'b00000010000000: n2733 = 1'b0;
      14'b00000001000000: n2733 = 1'b0;
      14'b00000000100000: n2733 = 1'b0;
      14'b00000000010000: n2733 = 1'b0;
      14'b00000000001000: n2733 = 1'b0;
      14'b00000000000100: n2733 = 1'b0;
      14'b00000000000010: n2733 = 1'b0;
      14'b00000000000001: n2733 = 1'b0;
      default: n2733 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2736 = 1'b0;
      14'b01000000000000: n2736 = 1'b0;
      14'b00100000000000: n2736 = n2407;
      14'b00010000000000: n2736 = 1'b0;
      14'b00001000000000: n2736 = 1'b0;
      14'b00000100000000: n2736 = 1'b0;
      14'b00000010000000: n2736 = 1'b0;
      14'b00000001000000: n2736 = 1'b0;
      14'b00000000100000: n2736 = 1'b0;
      14'b00000000010000: n2736 = 1'b0;
      14'b00000000001000: n2736 = 1'b0;
      14'b00000000000100: n2736 = 1'b0;
      14'b00000000000010: n2736 = n1599;
      14'b00000000000001: n2736 = 1'b0;
      default: n2736 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2739 = 1'b0;
      14'b01000000000000: n2739 = 1'b0;
      14'b00100000000000: n2739 = n2409;
      14'b00010000000000: n2739 = 1'b0;
      14'b00001000000000: n2739 = 1'b0;
      14'b00000100000000: n2739 = 1'b0;
      14'b00000010000000: n2739 = 1'b0;
      14'b00000001000000: n2739 = 1'b0;
      14'b00000000100000: n2739 = 1'b0;
      14'b00000000010000: n2739 = 1'b0;
      14'b00000000001000: n2739 = 1'b0;
      14'b00000000000100: n2739 = 1'b0;
      14'b00000000000010: n2739 = 1'b0;
      14'b00000000000001: n2739 = 1'b0;
      default: n2739 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2742 = 1'b0;
      14'b01000000000000: n2742 = 1'b0;
      14'b00100000000000: n2742 = 1'b0;
      14'b00010000000000: n2742 = 1'b0;
      14'b00001000000000: n2742 = n2160;
      14'b00000100000000: n2742 = 1'b0;
      14'b00000010000000: n2742 = 1'b0;
      14'b00000001000000: n2742 = 1'b0;
      14'b00000000100000: n2742 = 1'b0;
      14'b00000000010000: n2742 = 1'b0;
      14'b00000000001000: n2742 = 1'b0;
      14'b00000000000100: n2742 = 1'b0;
      14'b00000000000010: n2742 = 1'b0;
      14'b00000000000001: n2742 = 1'b0;
      default: n2742 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2745 = 1'b0;
      14'b01000000000000: n2745 = 1'b0;
      14'b00100000000000: n2745 = 1'b0;
      14'b00010000000000: n2745 = 1'b0;
      14'b00001000000000: n2745 = 1'b0;
      14'b00000100000000: n2745 = 1'b0;
      14'b00000010000000: n2745 = 1'b0;
      14'b00000001000000: n2745 = 1'b0;
      14'b00000000100000: n2745 = 1'b0;
      14'b00000000010000: n2745 = 1'b0;
      14'b00000000001000: n2745 = 1'b0;
      14'b00000000000100: n2745 = 1'b0;
      14'b00000000000010: n2745 = 1'b0;
      14'b00000000000001: n2745 = n1494;
      default: n2745 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2748 = 1'b0;
      14'b01000000000000: n2748 = 1'b0;
      14'b00100000000000: n2748 = 1'b0;
      14'b00010000000000: n2748 = 1'b0;
      14'b00001000000000: n2748 = 1'b0;
      14'b00000100000000: n2748 = 1'b0;
      14'b00000010000000: n2748 = 1'b0;
      14'b00000001000000: n2748 = 1'b0;
      14'b00000000100000: n2748 = 1'b0;
      14'b00000000010000: n2748 = 1'b0;
      14'b00000000001000: n2748 = 1'b0;
      14'b00000000000100: n2748 = 1'b0;
      14'b00000000000010: n2748 = 1'b0;
      14'b00000000000001: n2748 = n1496;
      default: n2748 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2750 = n2693;
      14'b01000000000000: n2750 = n2446;
      14'b00100000000000: n2750 = n2410;
      14'b00010000000000: n2750 = n2180;
      14'b00001000000000: n2750 = n1041;
      14'b00000100000000: n2750 = n2124;
      14'b00000010000000: n2750 = n1041;
      14'b00000001000000: n2750 = n1856;
      14'b00000000100000: n2750 = n1041;
      14'b00000000010000: n2750 = n1041;
      14'b00000000001000: n2750 = n1681;
      14'b00000000000100: n2750 = n1632;
      14'b00000000000010: n2750 = n1543;
      14'b00000000000001: n2750 = n1499;
      default: n2750 = n1041;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2752 = 1'b0;
      14'b01000000000000: n2752 = 1'b0;
      14'b00100000000000: n2752 = 1'b0;
      14'b00010000000000: n2752 = 1'b0;
      14'b00001000000000: n2752 = 1'b0;
      14'b00000100000000: n2752 = 1'b0;
      14'b00000010000000: n2752 = 1'b0;
      14'b00000001000000: n2752 = 1'b0;
      14'b00000000100000: n2752 = 1'b0;
      14'b00000000010000: n2752 = 1'b0;
      14'b00000000001000: n2752 = 1'b0;
      14'b00000000000100: n2752 = 1'b0;
      14'b00000000000010: n2752 = 1'b0;
      14'b00000000000001: n2752 = n1501;
      default: n2752 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2754 = n1044;
      14'b01000000000000: n2754 = n1044;
      14'b00100000000000: n2754 = n1044;
      14'b00010000000000: n2754 = n1044;
      14'b00001000000000: n2754 = n1044;
      14'b00000100000000: n2754 = n1044;
      14'b00000010000000: n2754 = n1044;
      14'b00000001000000: n2754 = n1044;
      14'b00000000100000: n2754 = n1044;
      14'b00000000010000: n2754 = n1712;
      14'b00000000001000: n2754 = n1682;
      14'b00000000000100: n2754 = n1044;
      14'b00000000000010: n2754 = n1044;
      14'b00000000000001: n2754 = n1504;
      default: n2754 = n1044;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2755 = n1047;
      14'b01000000000000: n2755 = n1047;
      14'b00100000000000: n2755 = n1047;
      14'b00010000000000: n2755 = n1047;
      14'b00001000000000: n2755 = n1047;
      14'b00000100000000: n2755 = n1047;
      14'b00000010000000: n2755 = n1047;
      14'b00000001000000: n2755 = n1047;
      14'b00000000100000: n2755 = n1047;
      14'b00000000010000: n2755 = n1047;
      14'b00000000001000: n2755 = n1047;
      14'b00000000000100: n2755 = n1047;
      14'b00000000000010: n2755 = n1047;
      14'b00000000000001: n2755 = n1506;
      default: n2755 = n1047;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2756 = n1050;
      14'b01000000000000: n2756 = n1050;
      14'b00100000000000: n2756 = n1050;
      14'b00010000000000: n2756 = n1050;
      14'b00001000000000: n2756 = n1050;
      14'b00000100000000: n2756 = n1050;
      14'b00000010000000: n2756 = n1050;
      14'b00000001000000: n2756 = n1050;
      14'b00000000100000: n2756 = n1050;
      14'b00000000010000: n2756 = n1050;
      14'b00000000001000: n2756 = n1050;
      14'b00000000000100: n2756 = n1050;
      14'b00000000000010: n2756 = n1050;
      14'b00000000000001: n2756 = n1508;
      default: n2756 = n1050;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2758 = n2695;
      14'b01000000000000: n2758 = n2512;
      14'b00100000000000: n2758 = n2412;
      14'b00010000000000: n2758 = n2250;
      14'b00001000000000: n2758 = n2163;
      14'b00000100000000: n2758 = n2126;
      14'b00000010000000: n2758 = n2002;
      14'b00000001000000: n2758 = n1858;
      14'b00000000100000: n2758 = 1'b0;
      14'b00000000010000: n2758 = 1'b0;
      14'b00000000001000: n2758 = 1'b0;
      14'b00000000000100: n2758 = 1'b0;
      14'b00000000000010: n2758 = n1601;
      14'b00000000000001: n2758 = n1510;
      default: n2758 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2761 = n2697;
      14'b01000000000000: n2761 = n2515;
      14'b00100000000000: n2761 = n2414;
      14'b00010000000000: n2761 = n2253;
      14'b00001000000000: n2761 = 1'b0;
      14'b00000100000000: n2761 = n2128;
      14'b00000010000000: n2761 = 1'b0;
      14'b00000001000000: n2761 = n1860;
      14'b00000000100000: n2761 = 1'b0;
      14'b00000000010000: n2761 = 1'b0;
      14'b00000000001000: n2761 = 1'b0;
      14'b00000000000100: n2761 = 1'b0;
      14'b00000000000010: n2761 = n1604;
      14'b00000000000001: n2761 = 1'b0;
      default: n2761 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2764 = 1'b0;
      14'b01000000000000: n2764 = 1'b0;
      14'b00100000000000: n2764 = n2415;
      14'b00010000000000: n2764 = n2256;
      14'b00001000000000: n2764 = 1'b0;
      14'b00000100000000: n2764 = 1'b0;
      14'b00000010000000: n2764 = 1'b0;
      14'b00000001000000: n2764 = n1861;
      14'b00000000100000: n2764 = n1745;
      14'b00000000010000: n2764 = 1'b0;
      14'b00000000001000: n2764 = 1'b0;
      14'b00000000000100: n2764 = 1'b0;
      14'b00000000000010: n2764 = n1607;
      14'b00000000000001: n2764 = 1'b0;
      default: n2764 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2767 = n2698;
      14'b01000000000000: n2767 = n2518;
      14'b00100000000000: n2767 = 1'b0;
      14'b00010000000000: n2767 = n2259;
      14'b00001000000000: n2767 = 1'b0;
      14'b00000100000000: n2767 = n2129;
      14'b00000010000000: n2767 = n2003;
      14'b00000001000000: n2767 = 1'b0;
      14'b00000000100000: n2767 = 1'b0;
      14'b00000000010000: n2767 = 1'b0;
      14'b00000000001000: n2767 = 1'b0;
      14'b00000000000100: n2767 = 1'b0;
      14'b00000000000010: n2767 = n1610;
      14'b00000000000001: n2767 = 1'b0;
      default: n2767 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2770 = n2699;
      14'b01000000000000: n2770 = n2521;
      14'b00100000000000: n2770 = 1'b0;
      14'b00010000000000: n2770 = n2262;
      14'b00001000000000: n2770 = 1'b0;
      14'b00000100000000: n2770 = n2130;
      14'b00000010000000: n2770 = n2004;
      14'b00000001000000: n2770 = 1'b0;
      14'b00000000100000: n2770 = 1'b0;
      14'b00000000010000: n2770 = 1'b0;
      14'b00000000001000: n2770 = 1'b0;
      14'b00000000000100: n2770 = 1'b0;
      14'b00000000000010: n2770 = n1613;
      14'b00000000000001: n2770 = 1'b0;
      default: n2770 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2773 = n2701;
      14'b01000000000000: n2773 = n2524;
      14'b00100000000000: n2773 = n2417;
      14'b00010000000000: n2773 = n2265;
      14'b00001000000000: n2773 = 1'b0;
      14'b00000100000000: n2773 = n2132;
      14'b00000010000000: n2773 = n2006;
      14'b00000001000000: n2773 = n1863;
      14'b00000000100000: n2773 = n1747;
      14'b00000000010000: n2773 = 1'b0;
      14'b00000000001000: n2773 = 1'b0;
      14'b00000000000100: n2773 = 1'b0;
      14'b00000000000010: n2773 = n1616;
      14'b00000000000001: n2773 = n1512;
      default: n2773 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2776 = n2702;
      14'b01000000000000: n2776 = n2527;
      14'b00100000000000: n2776 = n2418;
      14'b00010000000000: n2776 = n2268;
      14'b00001000000000: n2776 = 1'b0;
      14'b00000100000000: n2776 = n2133;
      14'b00000010000000: n2776 = n2008;
      14'b00000001000000: n2776 = n1864;
      14'b00000000100000: n2776 = n1749;
      14'b00000000010000: n2776 = 1'b0;
      14'b00000000001000: n2776 = 1'b0;
      14'b00000000000100: n2776 = 1'b0;
      14'b00000000000010: n2776 = n1619;
      14'b00000000000001: n2776 = n1514;
      default: n2776 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2716)
      14'b10000000000000: n2779 = n2704;
      14'b01000000000000: n2779 = n2530;
      14'b00100000000000: n2779 = n2420;
      14'b00010000000000: n2779 = n2271;
      14'b00001000000000: n2779 = 1'b0;
      14'b00000100000000: n2779 = n2135;
      14'b00000010000000: n2779 = 1'b0;
      14'b00000001000000: n2779 = n1866;
      14'b00000000100000: n2779 = 1'b0;
      14'b00000000010000: n2779 = 1'b0;
      14'b00000000001000: n2779 = 1'b0;
      14'b00000000000100: n2779 = 1'b0;
      14'b00000000000010: n2779 = n1622;
      14'b00000000000001: n2779 = 1'b0;
      default: n2779 = 1'b0;
    endcase
  /*# t65/T65_MCode.vhd:1066:12 */
  assign n2784 = ir[1:0]; // extract
  /*# t65/T65_MCode.vhd:1068:16 */
  assign n2785 = ir[4:2]; // extract
  /*# t65/T65_MCode.vhd:1073:18 */
  assign n2786 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:1074:13 */
  assign n2788 = n2786 == 3'b110;
  /*# t65/T65_MCode.vhd:1074:24 */
  assign n2790 = n2786 == 3'b111;
  /*# t65/T65_MCode.vhd:1074:24 */
  assign n2791 = n2788 | n2790;
  /*# t65/T65_MCode.vhd:1076:13 */
  assign n2793 = n2786 == 3'b101;
  /*# t65/T65_MCode.vhd:1078:13 */
  assign n2795 = n2786 == 3'b001;
  /*# t65/T65_MCode.vhd:1073:11 */
  assign n2796 = {n2795, n2793, n2791};
  /*# t65/T65_MCode.vhd:1073:11 */
  always @*
    case (n2796)
      3'b100: n2801 = 5'b01100;
      3'b010: n2801 = 5'b00101;
      3'b001: n2801 = 5'b00110;
      default: n2801 = 5'b00100;
    endcase
  /*# t65/T65_MCode.vhd:1072:9 */
  assign n2803 = n2785 == 3'b000;
  /*# t65/T65_MCode.vhd:1072:20 */
  assign n2805 = n2785 == 3'b001;
  /*# t65/T65_MCode.vhd:1072:20 */
  assign n2806 = n2803 | n2805;
  /*# t65/T65_MCode.vhd:1072:28 */
  assign n2808 = n2785 == 3'b011;
  /*# t65/T65_MCode.vhd:1072:28 */
  assign n2809 = n2806 | n2808;
  /*# t65/T65_MCode.vhd:1086:18 */
  assign n2810 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:1087:13 */
  assign n2812 = n2810 == 3'b111;
  /*# t65/T65_MCode.vhd:1087:24 */
  assign n2814 = n2810 == 3'b110;
  /*# t65/T65_MCode.vhd:1087:24 */
  assign n2815 = n2812 | n2814;
  /*# t65/T65_MCode.vhd:1089:13 */
  assign n2817 = n2810 == 3'b100;
  /*# t65/T65_MCode.vhd:1086:11 */
  assign n2818 = {n2817, n2815};
  /*# t65/T65_MCode.vhd:1086:11 */
  always @*
    case (n2818)
      2'b10: n2822 = 5'b01101;
      2'b01: n2822 = 5'b01110;
      default: n2822 = 5'b00101;
    endcase
  /*# t65/T65_MCode.vhd:1085:9 */
  assign n2824 = n2785 == 3'b010;
  /*# t65/T65_MCode.vhd:1097:18 */
  assign n2825 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:1098:13 */
  assign n2827 = n2825 == 3'b100;
  /*# t65/T65_MCode.vhd:1097:11 */
  always @*
    case (n2827)
      1'b1: n2830 = 5'b00101;
      default: n2830 = 5'b00100;
    endcase
  /*# t65/T65_MCode.vhd:1096:9 */
  assign n2832 = n2785 == 3'b110;
  /*# t65/T65_MCode.vhd:1108:18 */
  assign n2833 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:1109:13 */
  assign n2835 = n2833 == 3'b101;
  /*# t65/T65_MCode.vhd:1108:11 */
  always @*
    case (n2835)
      1'b1: n2838 = 5'b00101;
      default: n2838 = 5'b00100;
    endcase
  /*# t65/T65_MCode.vhd:1068:9 */
  assign n2839 = {n2832, n2824, n2809};
  /*# t65/T65_MCode.vhd:1068:9 */
  always @*
    case (n2839)
      3'b100: n2840 = n2830;
      3'b010: n2840 = n2822;
      3'b001: n2840 = n2801;
      default: n2840 = n2838;
    endcase
  /*# t65/T65_MCode.vhd:1067:7 */
  assign n2842 = n2784 == 2'b00;
  /*# t65/T65_MCode.vhd:1117:36 */
  assign n2843 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:1117:14 */
  assign n2844 = {28'b0, n2843};  // uext
  /*# t65/T65_MCode.vhd:1118:11 */
  assign n2846 = n2844 == 31'b0000000000000000000000000000000;
  /*# t65/T65_MCode.vhd:1120:11 */
  assign n2848 = n2844 == 31'b0000000000000000000000000000001;
  /*# t65/T65_MCode.vhd:1122:11 */
  assign n2850 = n2844 == 31'b0000000000000000000000000000010;
  /*# t65/T65_MCode.vhd:1124:11 */
  assign n2852 = n2844 == 31'b0000000000000000000000000000011;
  /*# t65/T65_MCode.vhd:1126:11 */
  assign n2854 = n2844 == 31'b0000000000000000000000000000100;
  /*# t65/T65_MCode.vhd:1128:11 */
  assign n2856 = n2844 == 31'b0000000000000000000000000000101;
  /*# t65/T65_MCode.vhd:1130:11 */
  assign n2858 = n2844 == 31'b0000000000000000000000000000110;
  /*# t65/T65_MCode.vhd:1117:9 */
  assign n2859 = {n2858, n2856, n2854, n2852, n2850, n2848, n2846};
  /*# t65/T65_MCode.vhd:1117:9 */
  always @*
    case (n2859)
      7'b1000000: n2868 = 5'b00110;
      7'b0100000: n2868 = 5'b00101;
      7'b0010000: n2868 = 5'b00100;
      7'b0001000: n2868 = 5'b00011;
      7'b0000100: n2868 = 5'b00010;
      7'b0000010: n2868 = 5'b00001;
      7'b0000001: n2868 = 5'b00000;
      default: n2868 = 5'b00111;
    endcase
  /*# t65/T65_MCode.vhd:1116:7 */
  assign n2870 = n2784 == 2'b01;
  /*# t65/T65_MCode.vhd:1137:36 */
  assign n2871 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:1137:14 */
  assign n2872 = {28'b0, n2871};  // uext
  /*# t65/T65_MCode.vhd:1140:18 */
  assign n2873 = ir[4:2]; // extract
  /*# t65/T65_MCode.vhd:1140:31 */
  assign n2875 = n2873 == 3'b110;
  /*# t65/T65_MCode.vhd:1140:47 */
  assign n2877 = mode != 2'b00;
  /*# t65/T65_MCode.vhd:1140:39 */
  assign n2878 = n2877 & n2875;
  /*# t65/T65_MCode.vhd:1140:13 */
  assign n2881 = n2878 ? 5'b01110 : 5'b01000;
  /*# t65/T65_MCode.vhd:1138:11 */
  assign n2884 = n2872 == 31'b0000000000000000000000000000000;
  /*# t65/T65_MCode.vhd:1145:18 */
  assign n2885 = ir[4:2]; // extract
  /*# t65/T65_MCode.vhd:1145:31 */
  assign n2887 = n2885 == 3'b110;
  /*# t65/T65_MCode.vhd:1145:47 */
  assign n2889 = mode != 2'b00;
  /*# t65/T65_MCode.vhd:1145:39 */
  assign n2890 = n2889 & n2887;
  /*# t65/T65_MCode.vhd:1145:13 */
  assign n2893 = n2890 ? 5'b01101 : 5'b01001;
  /*# t65/T65_MCode.vhd:1143:11 */
  assign n2896 = n2872 == 31'b0000000000000000000000000000001;
  /*# t65/T65_MCode.vhd:1148:11 */
  assign n2898 = n2872 == 31'b0000000000000000000000000000010;
  /*# t65/T65_MCode.vhd:1150:11 */
  assign n2900 = n2872 == 31'b0000000000000000000000000000011;
  /*# t65/T65_MCode.vhd:1154:18 */
  assign n2901 = ir[4:2]; // extract
  /*# t65/T65_MCode.vhd:1154:31 */
  assign n2903 = n2901 == 3'b010;
  /*# t65/T65_MCode.vhd:1154:13 */
  assign n2906 = n2903 ? 5'b00101 : 5'b00100;
  /*# t65/T65_MCode.vhd:1152:11 */
  assign n2909 = n2872 == 31'b0000000000000000000000000000100;
  /*# t65/T65_MCode.vhd:1159:11 */
  assign n2911 = n2872 == 31'b0000000000000000000000000000101;
  /*# t65/T65_MCode.vhd:1161:11 */
  assign n2913 = n2872 == 31'b0000000000000000000000000000110;
  /*# t65/T65_MCode.vhd:1137:9 */
  assign n2914 = {n2913, n2911, n2909, n2900, n2898, n2896, n2884};
  /*# t65/T65_MCode.vhd:1137:9 */
  always @*
    case (n2914)
      7'b1000000: n2920 = 5'b01101;
      7'b0100000: n2920 = 5'b00101;
      7'b0010000: n2920 = n2906;
      7'b0001000: n2920 = 5'b01011;
      7'b0000100: n2920 = 5'b01010;
      7'b0000010: n2920 = n2893;
      7'b0000001: n2920 = n2881;
      default: n2920 = 5'b01110;
    endcase
  /*# t65/T65_MCode.vhd:1136:7 */
  assign n2922 = n2784 == 2'b10;
  /*# t65/T65_MCode.vhd:1168:36 */
  assign n2923 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:1168:14 */
  assign n2924 = {28'b0, n2923};  // uext
  /*# t65/T65_MCode.vhd:1171:18 */
  assign n2926 = ir == 8'b10111011;
  /*# t65/T65_MCode.vhd:1171:13 */
  assign n2929 = n2926 ? 5'b00001 : 5'b00101;
  /*# t65/T65_MCode.vhd:1170:11 */
  assign n2931 = n2924 == 31'b0000000000000000000000000000101;
  /*# t65/T65_MCode.vhd:1185:18 */
  assign n2933 = ir == 8'b01101011;
  /*# t65/T65_MCode.vhd:1187:21 */
  assign n2935 = ir == 8'b10001011;
  /*# t65/T65_MCode.vhd:1189:21 */
  assign n2937 = ir == 8'b00001011;
  /*# t65/T65_MCode.vhd:1189:33 */
  assign n2939 = ir == 8'b00101011;
  /*# t65/T65_MCode.vhd:1189:28 */
  assign n2940 = n2937 | n2939;
  /*# t65/T65_MCode.vhd:1191:21 */
  assign n2942 = ir == 8'b11101011;
  /*# t65/T65_MCode.vhd:1194:42 */
  assign n2943 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:1194:20 */
  assign n2944 = {28'b0, n2943};  // uext
  /*# t65/T65_MCode.vhd:1195:17 */
  assign n2946 = n2944 == 31'b0000000000000000000000000000000;
  /*# t65/T65_MCode.vhd:1197:17 */
  assign n2948 = n2944 == 31'b0000000000000000000000000000001;
  /*# t65/T65_MCode.vhd:1199:17 */
  assign n2950 = n2944 == 31'b0000000000000000000000000000010;
  /*# t65/T65_MCode.vhd:1201:17 */
  assign n2952 = n2944 == 31'b0000000000000000000000000000011;
  /*# t65/T65_MCode.vhd:1203:17 */
  assign n2954 = n2944 == 31'b0000000000000000000000000000100;
  /*# t65/T65_MCode.vhd:1205:17 */
  assign n2956 = n2944 == 31'b0000000000000000000000000000101;
  /*# t65/T65_MCode.vhd:1207:17 */
  assign n2958 = n2944 == 31'b0000000000000000000000000000110;
  /*# t65/T65_MCode.vhd:1194:15 */
  assign n2959 = {n2958, n2956, n2954, n2952, n2950, n2948, n2946};
  /*# t65/T65_MCode.vhd:1194:15 */
  always @*
    case (n2959)
      7'b1000000: n2968 = 5'b00110;
      7'b0100000: n2968 = 5'b00101;
      7'b0010000: n2968 = 5'b00100;
      7'b0001000: n2968 = 5'b00011;
      7'b0000100: n2968 = 5'b00010;
      7'b0000010: n2968 = 5'b00001;
      7'b0000001: n2968 = 5'b00000;
      default: n2968 = 5'b00111;
    endcase
  /*# t65/T65_MCode.vhd:1213:42 */
  assign n2969 = ir[7:5]; // extract
  /*# t65/T65_MCode.vhd:1213:20 */
  assign n2970 = {28'b0, n2969};  // uext
  /*# t65/T65_MCode.vhd:1214:17 */
  assign n2972 = n2970 == 31'b0000000000000000000000000000000;
  /*# t65/T65_MCode.vhd:1216:17 */
  assign n2974 = n2970 == 31'b0000000000000000000000000000001;
  /*# t65/T65_MCode.vhd:1218:17 */
  assign n2976 = n2970 == 31'b0000000000000000000000000000010;
  /*# t65/T65_MCode.vhd:1220:17 */
  assign n2978 = n2970 == 31'b0000000000000000000000000000011;
  /*# t65/T65_MCode.vhd:1222:17 */
  assign n2980 = n2970 == 31'b0000000000000000000000000000100;
  /*# t65/T65_MCode.vhd:1224:17 */
  assign n2982 = n2970 == 31'b0000000000000000000000000000101;
  /*# t65/T65_MCode.vhd:1228:24 */
  assign n2983 = ir[4:2]; // extract
  /*# t65/T65_MCode.vhd:1228:36 */
  assign n2985 = n2983 == 3'b010;
  /*# t65/T65_MCode.vhd:1228:19 */
  assign n2988 = n2985 ? 5'b10001 : 5'b01101;
  /*# t65/T65_MCode.vhd:1226:17 */
  assign n2991 = n2970 == 31'b0000000000000000000000000000110;
  /*# t65/T65_MCode.vhd:1213:15 */
  assign n2992 = {n2991, n2982, n2980, n2978, n2976, n2974, n2972};
  /*# t65/T65_MCode.vhd:1213:15 */
  always @*
    case (n2992)
      7'b1000000: n3000 = n2988;
      7'b0100000: n3000 = 5'b00101;
      7'b0010000: n3000 = 5'b01100;
      7'b0001000: n3000 = 5'b01011;
      7'b0000100: n3000 = 5'b01010;
      7'b0000010: n3000 = 5'b01001;
      7'b0000001: n3000 = 5'b01000;
      default: n3000 = 5'b01110;
    endcase
  /*# t65/T65_MCode.vhd:1193:13 */
  assign n3001 = alumore ? n2968 : n3000;
  /*# t65/T65_MCode.vhd:1191:13 */
  assign n3003 = n2942 ? 5'b00111 : n3001;
  /*# t65/T65_MCode.vhd:1189:13 */
  assign n3005 = n2940 ? 5'b10000 : n3003;
  /*# t65/T65_MCode.vhd:1187:13 */
  assign n3007 = n2935 ? 5'b10010 : n3005;
  /*# t65/T65_MCode.vhd:1185:13 */
  assign n3009 = n2933 ? 5'b01111 : n3007;
  /*# t65/T65_MCode.vhd:1168:9 */
  always @*
    case (n2931)
      1'b1: n3010 = n2929;
      default: n3010 = n3009;
    endcase
  /*# t65/T65_MCode.vhd:1066:5 */
  assign n3011 = {n2922, n2870, n2842};
  /*# t65/T65_MCode.vhd:1066:5 */
  always @*
    case (n3011)
      3'b100: n3012 = n2920;
      3'b010: n3012 = n2868;
      3'b001: n3012 = n2840;
      default: n3012 = n3010;
    endcase
endmodule

module T65
  (input  [1:0] Mode,
   input  BCD_en,
   input  Res_n,
   input  Clk,
   input  Enable,
   output [23:0] A,
   input  [7:0] DI,
   output [7:0] DO,
   input  Rdy,
   input  Abort_n,
   input  IRQ_n,
   input  NMI_n,
   input  SO_n,
   output R_W_n,
   output Sync,
   output EF,
   output MF,
   output XF,
   output ML_n,
   output VP_n,
   output VDA,
   output VPA,
   output [7:0] \DEBUG[I] ,
   output [7:0] \DEBUG[A] ,
   output [7:0] \DEBUG[X] ,
   output [7:0] \DEBUG[Y] ,
   output [7:0] \DEBUG[S] ,
   output [7:0] \DEBUG[P] ,
   output NMI_ack);
  wire [7:0] n12;
  wire [7:0] n13;
  wire [7:0] n14;
  wire [7:0] n15;
  wire [7:0] n16;
  wire [7:0] n17;
  wire [15:0] abc;
  wire [15:0] x;
  wire [15:0] y;
  reg [7:0] p;
  reg [7:0] ad;
  reg [7:0] dl;
  wire [7:0] pwithb;
  wire [7:0] bah;
  wire [8:0] bal;
  wire [7:0] pbr;
  wire [7:0] dbr;
  wire [15:0] pc;
  wire [15:0] s;
  wire ef_i;
  wire mf_i;
  wire xf_i;
  wire [7:0] ir;
  wire [2:0] mcycle;
  wire [1:0] mode_r;
  wire bcd_en_r;
  wire [4:0] alu_op_r;
  wire [3:0] write_data_r;
  wire [1:0] set_addr_to_r;
  wire [8:0] pcadder;
  wire rstcycle;
  wire irqcycle;
  wire nmicycle;
  wire so_n_o;
  wire irq_n_o;
  wire nmi_n_o;
  wire nmiact;
  wire break_i;
  wire [7:0] busa;
  wire [7:0] busa_r;
  wire [7:0] busb;
  wire [7:0] busb_r;
  wire [7:0] alu_q;
  wire [7:0] p_out;
  wire [2:0] lcycle;
  wire [4:0] alu_op;
  wire [3:0] set_busa_to;
  wire [1:0] set_addr_to;
  wire [3:0] write_data;
  wire [1:0] jump;
  wire [1:0] baadd;
  wire breakatna;
  wire adadd;
  wire addy;
  wire pcadd;
  wire inc_s;
  wire dec_s;
  wire lda;
  wire ldp;
  wire ldx;
  wire ldy;
  wire lds;
  wire lddi;
  wire ldalu;
  wire ldad;
  wire ldbal;
  wire ldbah;
  wire savep;
  wire write;
  wire res_n_i;
  wire res_n_d;
  wire really_rdy;
  wire wrn_i;
  wire nmi_entered;
  wire n22;
  wire n23;
  wire n26;
  wire n27;
  wire [1:0] n30;
  wire n32;
  wire [1:0] n33;
  wire n35;
  wire n36;
  wire [1:0] n37;
  wire n39;
  wire n40;
  wire n41;
  wire n45;
  wire n47;
  wire n48;
  wire n49;
  wire n50;
  wire n54;
  wire n55;
  wire n58;
  wire n59;
  wire n60;
  wire [7:0] n62;
  wire [7:0] n63;
  wire [7:0] n64;
  wire [7:0] n65;
  wire n95;
  wire n107;
  wire n109;
  wire n110;
  wire n112;
  wire n113;
  wire n114;
  wire n115;
  wire [15:0] n117;
  wire [15:0] n118;
  wire n119;
  wire [7:0] n121;
  wire [7:0] n122;
  wire [7:0] n123;
  wire n124;
  wire n126;
  wire [1:0] n131;
  wire [15:0] n133;
  wire [7:0] n134;
  wire [15:0] n135;
  wire [15:0] n136;
  wire n137;
  wire n139;
  wire n140;
  wire n141;
  wire [15:0] n143;
  wire [15:0] n144;
  wire n146;
  wire n148;
  wire n149;
  wire n150;
  wire n151;
  wire n152;
  wire n153;
  wire [15:0] n155;
  wire [15:0] n156;
  wire [15:0] n158;
  wire n160;
  wire [15:0] n161;
  wire n163;
  wire n164;
  wire n165;
  wire n166;
  wire [7:0] n167;
  wire [7:0] n169;
  wire [7:0] n170;
  wire [7:0] n172;
  wire [7:0] n173;
  wire [7:0] n174;
  wire [7:0] n175;
  wire [7:0] n176;
  wire n178;
  wire [2:0] n179;
  wire [7:0] n180;
  wire [7:0] n181;
  wire [7:0] n182;
  reg [7:0] n183;
  wire [7:0] n184;
  wire [7:0] n185;
  wire [7:0] n186;
  reg [7:0] n187;
  wire [15:0] n193;
  wire n202;
  wire n203;
  wire n204;
  wire n209;
  wire n210;
  wire n211;
  wire n212;
  wire n213;
  wire n214;
  wire n215;
  wire n216;
  wire n217;
  wire n218;
  wire n219;
  wire n220;
  wire n221;
  wire n222;
  wire [7:0] n266;
  wire [8:0] n267;
  wire n268;
  wire [8:0] n269;
  wire [8:0] n270;
  wire [8:0] n271;
  wire [7:0] n272;
  wire [8:0] n274;
  wire n278;
  wire n281;
  wire n288;
  wire n289;
  wire [7:0] n290;
  wire n292;
  wire n294;
  wire n296;
  wire n297;
  wire [7:0] n298;
  wire [7:0] n299;
  wire [4:0] n300;
  wire n302;
  wire [2:0] n303;
  wire n306;
  wire n309;
  wire n312;
  wire n315;
  wire n318;
  wire n321;
  wire n324;
  wire [6:0] n325;
  wire n326;
  reg n327;
  wire n328;
  reg n329;
  wire n330;
  reg n331;
  wire n332;
  reg n333;
  wire [1:0] n334;
  wire n335;
  wire n336;
  wire [1:0] n337;
  wire [1:0] n338;
  wire n339;
  wire n340;
  wire n343;
  wire n344;
  wire n349;
  wire n351;
  wire n352;
  wire n353;
  wire n354;
  wire n356;
  wire n357;
  wire n358;
  wire [1:0] n361;
  wire [1:0] n362;
  wire [1:0] n363;
  wire [7:0] n365;
  wire [4:0] n366;
  wire n368;
  wire n370;
  wire n371;
  wire n374;
  wire n376;
  wire n378;
  wire [7:0] n379;
  wire n380;
  wire [4:0] n383;
  wire n385;
  wire n387;
  wire n388;
  wire n391;
  wire n393;
  wire n395;
  wire n396;
  wire n397;
  wire n398;
  wire n400;
  wire n401;
  wire n403;
  wire n404;
  wire n405;
  wire [5:0] n406;
  wire [7:0] n413;
  wire n434;
  wire n437;
  wire n439;
  wire n440;
  wire [7:0] n442;
  wire [7:0] n445;
  wire [8:0] n447;
  wire n449;
  wire [7:0] n450;
  wire [8:0] n451;
  wire [8:0] n452;
  wire [8:0] n453;
  wire n455;
  wire n456;
  wire [7:0] n458;
  wire [7:0] n459;
  wire n461;
  wire [2:0] n462;
  reg [7:0] n463;
  reg [7:0] n464;
  reg [8:0] n465;
  wire [7:0] n466;
  wire [7:0] n467;
  wire [7:0] n468;
  wire [7:0] n469;
  wire [7:0] n470;
  wire [7:0] n471;
  wire n473;
  wire n476;
  wire n477;
  wire n478;
  wire n479;
  wire n482;
  wire n485;
  wire [2:0] n487;
  wire n489;
  wire [2:0] n490;
  localparam [8:0] n491 = 9'b111111111;
  wire [5:0] n492;
  wire n494;
  wire n496;
  wire n498;
  wire n499;
  wire [1:0] n500;
  wire [7:0] n502;
  wire [8:0] n503;
  wire [8:0] n504;
  wire n506;
  wire [7:0] n508;
  wire [7:0] n509;
  wire [7:0] n510;
  wire [7:0] n511;
  wire [7:0] n512;
  wire n513;
  wire [7:0] n514;
  wire [8:0] n518;
  wire n522;
  wire n524;
  wire n525;
  wire n526;
  wire n527;
  wire n528;
  wire n529;
  wire n530;
  wire n531;
  wire n556;
  wire n557;
  wire n558;
  wire n559;
  wire n560;
  wire n561;
  wire n562;
  wire n564;
  wire [7:0] n565;
  wire n567;
  wire [7:0] n568;
  wire n570;
  wire [7:0] n571;
  wire n573;
  wire [7:0] n574;
  wire n576;
  wire n578;
  wire [7:0] n579;
  wire [7:0] n580;
  wire n582;
  wire [7:0] n583;
  wire [7:0] n585;
  wire [7:0] n586;
  wire n588;
  wire [7:0] n589;
  wire [7:0] n591;
  wire [7:0] n592;
  wire [7:0] n593;
  wire [7:0] n594;
  wire n596;
  wire [7:0] n597;
  wire [7:0] n598;
  wire [7:0] n599;
  wire n601;
  wire n604;
  wire [10:0] n605;
  reg [7:0] n607;
  wire [7:0] n608;
  wire [23:0] n610;
  wire n612;
  wire [15:0] n614;
  wire [23:0] n615;
  wire n617;
  wire [15:0] n619;
  wire [7:0] n620;
  wire [23:0] n621;
  wire n623;
  wire [7:0] n624;
  wire [15:0] n625;
  wire [7:0] n626;
  wire [23:0] n627;
  wire n629;
  wire [3:0] n630;
  reg [23:0] n632;
  wire [7:0] n634;
  wire n635;
  wire [7:0] n636;
  wire n638;
  wire [7:0] n639;
  wire n641;
  wire [7:0] n642;
  wire n644;
  wire [7:0] n645;
  wire n647;
  wire [7:0] n648;
  wire n650;
  wire n652;
  wire [7:0] n653;
  wire n655;
  wire [7:0] n656;
  wire n658;
  wire [7:0] n659;
  wire [7:0] n660;
  wire [7:0] n661;
  wire n663;
  wire [7:0] n664;
  wire [7:0] n665;
  wire [7:0] n666;
  wire [7:0] n667;
  wire n669;
  wire [7:0] n670;
  wire [7:0] n671;
  wire n673;
  wire [7:0] n674;
  wire [7:0] n675;
  wire n677;
  wire n680;
  wire [12:0] n681;
  reg [7:0] n683;
  wire n686;
  wire n688;
  wire n689;
  wire n691;
  wire n692;
  wire n693;
  wire n694;
  wire n695;
  wire n696;
  wire n699;
  wire n701;
  wire n705;
  wire n708;
  wire [2:0] n710;
  wire [2:0] n712;
  wire n717;
  wire n719;
  wire n720;
  wire n721;
  wire n722;
  wire n723;
  wire [4:0] n724;
  wire n726;
  wire n728;
  wire n729;
  wire n730;
  wire n731;
  wire n733;
  wire n735;
  wire n736;
  wire n737;
  wire n738;
  wire n739;
  wire [15:0] n758;
  wire [15:0] n760;
  wire [15:0] n762;
  wire [47:0] n763;
  wire n764;
  wire n765;
  wire [7:0] n766;
  wire [7:0] n767;
  reg [7:0] n768;
  wire n769;
  wire n770;
  wire [7:0] n771;
  wire [7:0] n772;
  reg [7:0] n773;
  wire n774;
  wire n775;
  wire [7:0] n776;
  wire [7:0] n777;
  reg [7:0] n778;
  reg [7:0] n779;
  wire [7:0] n780;
  reg [7:0] n781;
  wire [7:0] n782;
  reg [7:0] n783;
  wire [7:0] n784;
  reg [7:0] n785;
  wire [8:0] n786;
  reg [8:0] n787;
  wire [7:0] n788;
  reg [7:0] n789;
  wire [7:0] n790;
  reg [7:0] n791;
  wire [15:0] n792;
  reg [15:0] n793;
  wire [15:0] n794;
  reg [15:0] n795;
  wire n796;
  reg n797;
  wire n798;
  reg n799;
  wire n800;
  reg n801;
  wire [7:0] n802;
  reg [7:0] n803;
  wire [2:0] n804;
  reg [2:0] n805;
  wire [1:0] n806;
  reg [1:0] n807;
  wire n808;
  reg n809;
  wire [4:0] n810;
  reg [4:0] n811;
  wire [3:0] n812;
  reg [3:0] n813;
  wire [1:0] n814;
  reg [1:0] n815;
  wire n816;
  reg n817;
  wire n818;
  reg n819;
  wire n820;
  reg n821;
  wire n822;
  wire n823;
  reg n824;
  wire n825;
  wire n826;
  wire n827;
  reg n828;
  wire n829;
  wire n830;
  wire n831;
  reg n832;
  wire n833;
  reg n834;
  wire [7:0] n835;
  reg [7:0] n836;
  wire [7:0] n837;
  reg [7:0] n838;
  wire [7:0] n839;
  reg [7:0] n840;
  reg n841;
  reg n842;
  wire n843;
  reg n844;
  wire n845;
  wire n846;
  wire n847;
  reg n848;
  assign A = n632; //(module output)
  assign DO = n683; //(module output)
  assign R_W_n = wrn_i; //(module output)
  assign Sync = n27; //(module output)
  assign EF = ef_i; //(module output)
  assign MF = mf_i; //(module output)
  assign XF = xf_i; //(module output)
  assign ML_n = n41; //(module output)
  assign VP_n = n50; //(module output)
  assign VDA = n55; //(module output)
  assign VPA = n60; //(module output)
  assign \DEBUG[I]  = n12; //(module output)
  assign \DEBUG[A]  = n13; //(module output)
  assign \DEBUG[X]  = n14; //(module output)
  assign \DEBUG[Y]  = n15; //(module output)
  assign \DEBUG[S]  = n16; //(module output)
  assign \DEBUG[P]  = n17; //(module output)
  assign NMI_ack = nmiact; //(module output)
  /*# t65/T65.vhd:130:8 */
  assign n12 = n763[7:0]; // extract
  /*# t65/T65.vhd:130:8 */
  assign n13 = n763[15:8]; // extract
  /*# t65/T65.vhd:130:8 */
  assign n14 = n763[23:16]; // extract
  /*# t65/T65.vhd:130:8 */
  assign n15 = n763[31:24]; // extract
  /*# t65/T65.vhd:130:8 */
  assign n16 = n763[39:32]; // extract
  /*# t65/T65.vhd:130:8 */
  assign n17 = n763[47:40]; // extract
  /*# t65/T65.vhd:166:10 */
  assign abc = n758; // (signal)
  /*# t65/T65.vhd:166:15 */
  assign x = n760; // (signal)
  /*# t65/T65.vhd:166:18 */
  assign y = n762; // (signal)
  /*# t65/T65.vhd:167:10 */
  always @*
    p = n779; // (isignal)
  initial
    p = 8'b00000000;
  /*# t65/T65.vhd:167:13 */
  always @*
    ad = n781; // (isignal)
  initial
    ad = 8'b00000000;
  /*# t65/T65.vhd:167:17 */
  always @*
    dl = n783; // (isignal)
  initial
    dl = 8'b00000000;
  /*# t65/T65.vhd:168:10 */
  assign pwithb = n636; // (signal)
  /*# t65/T65.vhd:169:10 */
  assign bah = n785; // (signal)
  /*# t65/T65.vhd:170:10 */
  assign bal = n787; // (signal)
  /*# t65/T65.vhd:171:10 */
  assign pbr = n789; // (signal)
  /*# t65/T65.vhd:172:10 */
  assign dbr = n791; // (signal)
  /*# t65/T65.vhd:173:10 */
  assign pc = n793; // (signal)
  /*# t65/T65.vhd:174:10 */
  assign s = n795; // (signal)
  /*# t65/T65.vhd:175:10 */
  assign ef_i = n797; // (signal)
  /*# t65/T65.vhd:176:10 */
  assign mf_i = n799; // (signal)
  /*# t65/T65.vhd:177:10 */
  assign xf_i = n801; // (signal)
  /*# t65/T65.vhd:179:10 */
  assign ir = n803; // (signal)
  /*# t65/T65.vhd:180:10 */
  assign mcycle = n805; // (signal)
  /*# t65/T65.vhd:182:10 */
  assign mode_r = n807; // (signal)
  /*# t65/T65.vhd:183:10 */
  assign bcd_en_r = n809; // (signal)
  /*# t65/T65.vhd:184:10 */
  assign alu_op_r = n811; // (signal)
  /*# t65/T65.vhd:185:10 */
  assign write_data_r = n813; // (signal)
  /*# t65/T65.vhd:186:10 */
  assign set_addr_to_r = n815; // (signal)
  /*# t65/T65.vhd:187:10 */
  assign pcadder = n271; // (signal)
  /*# t65/T65.vhd:189:10 */
  assign rstcycle = n817; // (signal)
  /*# t65/T65.vhd:190:10 */
  assign irqcycle = n819; // (signal)
  /*# t65/T65.vhd:191:10 */
  assign nmicycle = n821; // (signal)
  /*# t65/T65.vhd:193:10 */
  assign so_n_o = n824; // (signal)
  /*# t65/T65.vhd:194:10 */
  assign irq_n_o = n828; // (signal)
  /*# t65/T65.vhd:195:10 */
  assign nmi_n_o = n832; // (signal)
  /*# t65/T65.vhd:196:10 */
  assign nmiact = n834; // (signal)
  /*# t65/T65.vhd:198:10 */
  assign break_i = n562; // (signal)
  /*# t65/T65.vhd:201:10 */
  assign busa = n607; // (signal)
  /*# t65/T65.vhd:202:10 */
  assign busa_r = n836; // (signal)
  /*# t65/T65.vhd:203:10 */
  assign busb = n838; // (signal)
  /*# t65/T65.vhd:204:10 */
  assign busb_r = n840; // (signal)
  /*# t65/T65.vhd:235:10 */
  assign res_n_i = n841; // (signal)
  /*# t65/T65.vhd:236:10 */
  assign res_n_d = n842; // (signal)
  /*# t65/T65.vhd:238:10 */
  assign really_rdy = n23; // (signal)
  /*# t65/T65.vhd:239:10 */
  assign wrn_i = n844; // (signal)
  /*# t65/T65.vhd:241:10 */
  assign nmi_entered = n848; // (signal)
  /*# t65/T65.vhd:247:24 */
  assign n22 = ~wrn_i;
  /*# t65/T65.vhd:247:21 */
  assign n23 = Rdy | n22;
  /*# t65/T65.vhd:248:27 */
  assign n26 = mcycle == 3'b000;
  /*# t65/T65.vhd:248:15 */
  assign n27 = n26 ? 1'b1 : 1'b0;
  /*# t65/T65.vhd:253:22 */
  assign n30 = ir[7:6]; // extract
  /*# t65/T65.vhd:253:35 */
  assign n32 = n30 != 2'b10;
  /*# t65/T65.vhd:253:49 */
  assign n33 = ir[2:1]; // extract
  /*# t65/T65.vhd:253:62 */
  assign n35 = n33 == 2'b11;
  /*# t65/T65.vhd:253:43 */
  assign n36 = n35 & n32;
  /*# t65/T65.vhd:253:79 */
  assign n37 = mcycle[2:1]; // extract
  /*# t65/T65.vhd:253:92 */
  assign n39 = n37 != 2'b00;
  /*# t65/T65.vhd:253:69 */
  assign n40 = n39 & n36;
  /*# t65/T65.vhd:253:15 */
  assign n41 = n40 ? 1'b0 : 1'b1;
  /*# t65/T65.vhd:254:47 */
  assign n45 = mcycle == 3'b101;
  /*# t65/T65.vhd:254:65 */
  assign n47 = mcycle == 3'b110;
  /*# t65/T65.vhd:254:55 */
  assign n48 = n45 | n47;
  /*# t65/T65.vhd:254:35 */
  assign n49 = n48 & irqcycle;
  /*# t65/T65.vhd:254:15 */
  assign n50 = n49 ? 1'b0 : 1'b1;
  /*# t65/T65.vhd:255:33 */
  assign n54 = set_addr_to_r != 2'b10;
  /*# t65/T65.vhd:255:14 */
  assign n55 = n54 ? 1'b1 : 1'b0;
  /*# t65/T65.vhd:256:23 */
  assign n58 = jump[1]; // extract
  /*# t65/T65.vhd:256:27 */
  assign n59 = ~n58;
  /*# t65/T65.vhd:256:14 */
  assign n60 = n59 ? 1'b1 : 1'b0;
  /*# t65/T65.vhd:260:17 */
  assign n62 = abc[7:0]; // extract
  /*# t65/T65.vhd:261:15 */
  assign n63 = x[7:0]; // extract
  /*# t65/T65.vhd:262:15 */
  assign n64 = y[7:0]; // extract
  /*# t65/T65.vhd:263:32 */
  assign n65 = s[7:0]; // extract
  /*# t65/T65.vhd:266:3 */
  t65_mcode_Brtl mcode (
    .mode(mode_r),
    .ir(ir),
    .mcycle(mcycle),
    .p(p),
    .lcycle(lcycle),
    .alu_op(alu_op),
    .set_busa_to(set_busa_to),
    .set_addr_to(set_addr_to),
    .write_data(write_data),
    .jump(jump),
    .baadd(baadd),
    .breakatna(breakatna),
    .adadd(adadd),
    .addy(addy),
    .pcadd(pcadd),
    .inc_s(inc_s),
    .dec_s(dec_s),
    .lda(lda),
    .ldp(ldp),
    .ldx(ldx),
    .ldy(ldy),
    .lds(lds),
    .lddi(lddi),
    .ldalu(ldalu),
    .ldad(ldad),
    .ldbal(ldbal),
    .ldbah(ldbah),
    .savep(savep),
    .write(write));
  /*# t65/T65.vhd:301:3 */
  t65_alu_Brtl alu (
    .mode(mode_r),
    .bcd_en(bcd_en_r),
    .op(alu_op_r),
    .busa(busa_r),
    .busb(busb),
    .p_in(p),
    .p_out(p_out),
    .q(alu_q));
  /*# t65/T65.vhd:317:14 */
  assign n95 = ~Res_n;
  /*# t65/T65.vhd:328:16 */
  assign n107 = ~res_n_i;
  /*# t65/T65.vhd:349:20 */
  assign n109 = ~write;
  /*# t65/T65.vhd:349:30 */
  assign n110 = n109 | rstcycle;
  /*# t65/T65.vhd:357:22 */
  assign n112 = mcycle == 3'b000;
  /*# t65/T65.vhd:361:25 */
  assign n113 = ~irqcycle;
  /*# t65/T65.vhd:361:44 */
  assign n114 = ~nmicycle;
  /*# t65/T65.vhd:361:31 */
  assign n115 = n114 & n113;
  /*# t65/T65.vhd:362:24 */
  assign n117 = pc + 16'b0000000000000001;
  /*# t65/T65.vhd:357:11 */
  assign n118 = n124 ? n117 : pc;
  /*# t65/T65.vhd:365:31 */
  assign n119 = irqcycle | nmicycle;
  /*# t65/T65.vhd:365:13 */
  assign n121 = n119 ? 8'b00000000 : DI;
  /*# t65/T65.vhd:174:10 */
  assign n122 = s[7:0]; // extract
  /*# t65/T65.vhd:357:11 */
  assign n123 = n126 ? alu_q : n122;
  /*# t65/T65.vhd:357:11 */
  assign n124 = n115 & n112;
  /*# t65/T65.vhd:357:11 */
  assign n126 = lds & n112;
  /*# t65/T65.vhd:378:11 */
  assign n131 = break_i ? 2'b10 : set_addr_to;
  /*# t65/T65.vhd:385:20 */
  assign n133 = s + 16'b0000000000000001;
  /*# t65/T65.vhd:174:10 */
  assign n134 = s[15:8]; // extract
  /*# t65/T65.vhd:174:10 */
  assign n135 = {n134, n123};
  /*# t65/T65.vhd:384:11 */
  assign n136 = inc_s ? n133 : n135;
  /*# t65/T65.vhd:387:40 */
  assign n137 = ~rstcycle;
  /*# t65/T65.vhd:387:53 */
  assign n139 = Mode == 2'b00;
  /*# t65/T65.vhd:387:46 */
  assign n140 = n137 | n139;
  /*# t65/T65.vhd:387:26 */
  assign n141 = n140 & dec_s;
  /*# t65/T65.vhd:388:20 */
  assign n143 = s - 16'b0000000000000001;
  /*# t65/T65.vhd:387:11 */
  assign n144 = n141 ? n143 : n136;
  /*# t65/T65.vhd:391:17 */
  assign n146 = ir == 8'b00000000;
  /*# t65/T65.vhd:391:41 */
  assign n148 = mcycle == 3'b001;
  /*# t65/T65.vhd:391:30 */
  assign n149 = n148 & n146;
  /*# t65/T65.vhd:391:62 */
  assign n150 = ~irqcycle;
  /*# t65/T65.vhd:391:49 */
  assign n151 = n150 & n149;
  /*# t65/T65.vhd:391:81 */
  assign n152 = ~nmicycle;
  /*# t65/T65.vhd:391:68 */
  assign n153 = n152 & n151;
  /*# t65/T65.vhd:392:22 */
  assign n155 = pc + 16'b0000000000000001;
  /*# t65/T65.vhd:391:11 */
  assign n156 = n153 ? n155 : n118;
  /*# t65/T65.vhd:399:24 */
  assign n158 = pc + 16'b0000000000000001;
  /*# t65/T65.vhd:398:13 */
  assign n160 = jump == 2'b01;
  /*# t65/T65.vhd:401:33 */
  assign n161 = {DI, dl};
  /*# t65/T65.vhd:400:13 */
  assign n163 = jump == 2'b10;
  /*# t65/T65.vhd:403:25 */
  assign n164 = pcadder[8]; // extract
  /*# t65/T65.vhd:404:22 */
  assign n165 = dl[7]; // extract
  /*# t65/T65.vhd:404:26 */
  assign n166 = ~n165;
  /*# t65/T65.vhd:405:40 */
  assign n167 = pc[15:8]; // extract
  /*# t65/T65.vhd:405:54 */
  assign n169 = n167 + 8'b00000001;
  /*# t65/T65.vhd:407:40 */
  assign n170 = pc[15:8]; // extract
  /*# t65/T65.vhd:407:54 */
  assign n172 = n170 - 8'b00000001;
  /*# t65/T65.vhd:404:17 */
  assign n173 = n166 ? n169 : n172;
  /*# t65/T65.vhd:173:10 */
  assign n174 = n156[15:8]; // extract
  /*# t65/T65.vhd:403:15 */
  assign n175 = n164 ? n173 : n174;
  /*# t65/T65.vhd:410:40 */
  assign n176 = pcadder[7:0]; // extract
  /*# t65/T65.vhd:402:13 */
  assign n178 = jump == 2'b11;
  /*# t65/T65.vhd:397:11 */
  assign n179 = {n178, n163, n160};
  /*# t65/T65.vhd:399:24 */
  assign n180 = n158[7:0]; // extract
  /*# t65/T65.vhd:401:33 */
  assign n181 = n161[7:0]; // extract
  /*# t65/T65.vhd:173:10 */
  assign n182 = n156[7:0]; // extract
  /*# t65/T65.vhd:397:11 */
  always @*
    case (n179)
      3'b100: n183 = n176;
      3'b010: n183 = n181;
      3'b001: n183 = n180;
      default: n183 = n182;
    endcase
  /*# t65/T65.vhd:399:24 */
  assign n184 = n158[15:8]; // extract
  /*# t65/T65.vhd:401:33 */
  assign n185 = n161[15:8]; // extract
  /*# t65/T65.vhd:173:10 */
  assign n186 = n156[15:8]; // extract
  /*# t65/T65.vhd:397:11 */
  always @*
    case (n179)
      3'b100: n187 = n175;
      3'b010: n187 = n185;
      3'b001: n187 = n184;
      default: n187 = n186;
    endcase
  /*# t65/T65.vhd:348:9 */
  assign n193 = {n187, n183};
  /*# t65/T65.vhd:348:9 */
  assign n202 = n112 & really_rdy;
  /*# t65/T65.vhd:348:9 */
  assign n203 = n112 & really_rdy;
  /*# t65/T65.vhd:348:9 */
  assign n204 = n112 & really_rdy;
  /*# t65/T65.vhd:347:7 */
  assign n209 = really_rdy & Enable;
  /*# t65/T65.vhd:347:7 */
  assign n210 = really_rdy & Enable;
  /*# t65/T65.vhd:347:7 */
  assign n211 = really_rdy & Enable;
  /*# t65/T65.vhd:347:7 */
  assign n212 = really_rdy & Enable;
  /*# t65/T65.vhd:347:7 */
  assign n213 = really_rdy & Enable;
  /*# t65/T65.vhd:347:7 */
  assign n214 = really_rdy & Enable;
  /*# t65/T65.vhd:347:7 */
  assign n215 = really_rdy & Enable;
  /*# t65/T65.vhd:347:7 */
  assign n216 = n202 & Enable;
  /*# t65/T65.vhd:347:7 */
  assign n217 = n203 & Enable;
  /*# t65/T65.vhd:347:7 */
  assign n218 = n204 & Enable;
  /*# t65/T65.vhd:347:7 */
  assign n219 = really_rdy & Enable;
  /*# t65/T65.vhd:347:7 */
  assign n220 = really_rdy & Enable;
  /*# t65/T65.vhd:347:7 */
  assign n221 = really_rdy & Enable;
  /*# t65/T65.vhd:347:7 */
  assign n222 = really_rdy & Enable;
  /*# t65/T65.vhd:418:23 */
  assign n266 = pc[7:0]; // extract
  /*# t65/T65.vhd:418:14 */
  assign n267 = {1'b0, n266};  // uext
  /*# t65/T65.vhd:418:59 */
  assign n268 = dl[7]; // extract
  /*# t65/T65.vhd:418:63 */
  assign n269 = {n268, dl};
  /*# t65/T65.vhd:418:39 */
  assign n270 = n267 + n269;
  /*# t65/T65.vhd:418:72 */
  assign n271 = pcadd ? n270 : n274;
  /*# t65/T65.vhd:419:23 */
  assign n272 = pc[7:0]; // extract
  /*# t65/T65.vhd:419:19 */
  assign n274 = {1'b0, n272};
  /*# t65/T65.vhd:424:16 */
  assign n278 = ~res_n_i;
  /*# t65/T65.vhd:430:21 */
  assign n281 = mcycle == 3'b000;
  /*# t65/T65.vhd:440:21 */
  assign n288 = lda | ldx;
  /*# t65/T65.vhd:440:28 */
  assign n289 = n288 | ldy;
  /*# t65/T65.vhd:430:11 */
  assign n290 = n297 ? p_out : p;
  /*# t65/T65.vhd:430:11 */
  assign n292 = lda & n281;
  /*# t65/T65.vhd:430:11 */
  assign n294 = ldx & n281;
  /*# t65/T65.vhd:430:11 */
  assign n296 = ldy & n281;
  /*# t65/T65.vhd:430:11 */
  assign n297 = n289 & n281;
  /*# t65/T65.vhd:444:11 */
  assign n298 = savep ? p_out : n290;
  /*# t65/T65.vhd:447:11 */
  assign n299 = ldp ? alu_q : n298;
  /*# t65/T65.vhd:450:16 */
  assign n300 = ir[4:0]; // extract
  /*# t65/T65.vhd:450:29 */
  assign n302 = n300 == 5'b11000;
  /*# t65/T65.vhd:451:20 */
  assign n303 = ir[7:5]; // extract
  /*# t65/T65.vhd:452:13 */
  assign n306 = n303 == 3'b000;
  /*# t65/T65.vhd:454:13 */
  assign n309 = n303 == 3'b001;
  /*# t65/T65.vhd:456:13 */
  assign n312 = n303 == 3'b010;
  /*# t65/T65.vhd:458:13 */
  assign n315 = n303 == 3'b011;
  /*# t65/T65.vhd:460:13 */
  assign n318 = n303 == 3'b101;
  /*# t65/T65.vhd:462:13 */
  assign n321 = n303 == 3'b110;
  /*# t65/T65.vhd:464:13 */
  assign n324 = n303 == 3'b111;
  /*# t65/T65.vhd:451:13 */
  assign n325 = {n324, n321, n318, n315, n312, n309, n306};
  /*# t65/T65.vhd:422:14 */
  assign n326 = n299[0]; // extract
  /*# t65/T65.vhd:451:13 */
  always @*
    case (n325)
      7'b1000000: n327 = n326;
      7'b0100000: n327 = n326;
      7'b0010000: n327 = n326;
      7'b0001000: n327 = n326;
      7'b0000100: n327 = n326;
      7'b0000010: n327 = 1'b1;
      7'b0000001: n327 = 1'b0;
      default: n327 = n326;
    endcase
  /*# t65/T65.vhd:422:14 */
  assign n328 = n299[2]; // extract
  /*# t65/T65.vhd:451:13 */
  always @*
    case (n325)
      7'b1000000: n329 = n328;
      7'b0100000: n329 = n328;
      7'b0010000: n329 = n328;
      7'b0001000: n329 = 1'b1;
      7'b0000100: n329 = 1'b0;
      7'b0000010: n329 = n328;
      7'b0000001: n329 = n328;
      default: n329 = n328;
    endcase
  /*# t65/T65.vhd:422:14 */
  assign n330 = n299[3]; // extract
  /*# t65/T65.vhd:451:13 */
  always @*
    case (n325)
      7'b1000000: n331 = 1'b1;
      7'b0100000: n331 = 1'b0;
      7'b0010000: n331 = n330;
      7'b0001000: n331 = n330;
      7'b0000100: n331 = n330;
      7'b0000010: n331 = n330;
      7'b0000001: n331 = n330;
      default: n331 = n330;
    endcase
  /*# t65/T65.vhd:422:14 */
  assign n332 = n299[6]; // extract
  /*# t65/T65.vhd:451:13 */
  always @*
    case (n325)
      7'b1000000: n333 = n332;
      7'b0100000: n333 = n332;
      7'b0010000: n333 = 1'b0;
      7'b0001000: n333 = n332;
      7'b0000100: n333 = n332;
      7'b0000010: n333 = n332;
      7'b0000001: n333 = n332;
      default: n333 = n332;
    endcase
  /*# t65/T65.vhd:450:11 */
  assign n334 = {n331, n329};
  /*# t65/T65.vhd:422:14 */
  assign n335 = n299[0]; // extract
  /*# t65/T65.vhd:450:11 */
  assign n336 = n302 ? n327 : n335;
  /*# t65/T65.vhd:422:14 */
  assign n337 = n299[3:2]; // extract
  /*# t65/T65.vhd:450:11 */
  assign n338 = n302 ? n334 : n337;
  /*# t65/T65.vhd:422:14 */
  assign n339 = n299[6]; // extract
  /*# t65/T65.vhd:450:11 */
  assign n340 = n302 ? n333 : n339;
  /*# t65/T65.vhd:422:14 */
  assign n343 = n299[1]; // extract
  /*# t65/T65.vhd:422:14 */
  assign n344 = n299[7]; // extract
  /*# t65/T65.vhd:470:17 */
  assign n349 = ir == 8'b00000000;
  /*# t65/T65.vhd:470:41 */
  assign n351 = mcycle == 3'b100;
  /*# t65/T65.vhd:470:30 */
  assign n352 = n351 & n349;
  /*# t65/T65.vhd:470:62 */
  assign n353 = ~rstcycle;
  /*# t65/T65.vhd:470:49 */
  assign n354 = n353 & n352;
  /*# t65/T65.vhd:422:14 */
  assign n356 = n338[0]; // extract
  /*# t65/T65.vhd:470:11 */
  assign n357 = n354 ? 1'b1 : n356;
  /*# t65/T65.vhd:422:14 */
  assign n358 = n338[1]; // extract
  /*# t65/T65.vhd:474:11 */
  assign n361 = {1'b0, 1'b1};
  /*# t65/T65.vhd:422:14 */
  assign n362 = {n358, n357};
  /*# t65/T65.vhd:474:11 */
  assign n363 = rstcycle ? n361 : n362;
  /*# t65/T65.vhd:422:14 */
  assign n365 = {n344, n340, 1'b1, 1'b1, n363, n343, n336};
  /*# t65/T65.vhd:482:16 */
  assign n366 = ir[4:0]; // extract
  /*# t65/T65.vhd:482:28 */
  assign n368 = n366 != 5'b10000;
  /*# t65/T65.vhd:482:45 */
  assign n370 = jump != 2'b01;
  /*# t65/T65.vhd:482:38 */
  assign n371 = n368 | n370;
  /*# t65/T65.vhd:429:9 */
  assign n374 = n292 & really_rdy;
  /*# t65/T65.vhd:429:9 */
  assign n376 = n294 & really_rdy;
  /*# t65/T65.vhd:429:9 */
  assign n378 = n296 & really_rdy;
  /*# t65/T65.vhd:428:7 */
  assign n379 = n396 ? n365 : p;
  /*# t65/T65.vhd:429:9 */
  assign n380 = n371 & really_rdy;
  /*# t65/T65.vhd:487:14 */
  assign n383 = ir[4:0]; // extract
  /*# t65/T65.vhd:487:26 */
  assign n385 = n383 != 5'b10000;
  /*# t65/T65.vhd:487:43 */
  assign n387 = jump != 2'b01;
  /*# t65/T65.vhd:487:36 */
  assign n388 = n385 | n387;
  /*# t65/T65.vhd:428:7 */
  assign n391 = n374 & Enable;
  /*# t65/T65.vhd:428:7 */
  assign n393 = n376 & Enable;
  /*# t65/T65.vhd:428:7 */
  assign n395 = n378 & Enable;
  /*# t65/T65.vhd:428:7 */
  assign n396 = really_rdy & Enable;
  /*# t65/T65.vhd:428:7 */
  assign n397 = n380 & Enable;
  /*# t65/T65.vhd:428:7 */
  assign n398 = n388 & Enable;
  /*# t65/T65.vhd:494:42 */
  assign n400 = ~SO_n;
  /*# t65/T65.vhd:494:33 */
  assign n401 = n400 & so_n_o;
  /*# t65/T65.vhd:167:10 */
  assign n403 = n379[6]; // extract
  /*# t65/T65.vhd:494:17 */
  assign n404 = n401 ? 1'b1 : n403;
  /*# t65/T65.vhd:167:10 */
  assign n405 = n379[7]; // extract
  /*# t65/T65.vhd:167:10 */
  assign n406 = n379[5:0]; // extract
  /*# t65/T65.vhd:426:5 */
  assign n413 = {n405, n404, n406};
  /*# t65/T65.vhd:509:16 */
  assign n434 = ~res_n_i;
  /*# t65/T65.vhd:525:28 */
  assign n437 = set_addr_to_r == 2'b10;
  /*# t65/T65.vhd:525:63 */
  assign n439 = set_addr_to_r == 2'b01;
  /*# t65/T65.vhd:525:46 */
  assign n440 = n437 | n439;
  /*# t65/T65.vhd:526:65 */
  assign n442 = DI + 8'b00000001;
  /*# t65/T65.vhd:532:49 */
  assign n445 = ad + 8'b00000001;
  /*# t65/T65.vhd:533:51 */
  assign n447 = bal + 9'b000000001;
  /*# t65/T65.vhd:530:11 */
  assign n449 = baadd == 2'b01;
  /*# t65/T65.vhd:536:56 */
  assign n450 = bal[7:0]; // extract
  /*# t65/T65.vhd:536:37 */
  assign n451 = {1'b0, n450};  // uext
  /*# t65/T65.vhd:536:75 */
  assign n452 = {1'b0, busa};  // uext
  /*# t65/T65.vhd:536:73 */
  assign n453 = n451 + n452;
  /*# t65/T65.vhd:534:11 */
  assign n455 = baadd == 2'b10;
  /*# t65/T65.vhd:539:19 */
  assign n456 = bal[8]; // extract
  /*# t65/T65.vhd:540:53 */
  assign n458 = bah + 8'b00000001;
  /*# t65/T65.vhd:539:13 */
  assign n459 = n456 ? n458 : bah;
  /*# t65/T65.vhd:537:11 */
  assign n461 = baadd == 2'b11;
  /*# t65/T65.vhd:529:11 */
  assign n462 = {n461, n455, n449};
  /*# t65/T65.vhd:529:11 */
  always @*
    case (n462)
      3'b100: n463 = ad;
      3'b010: n463 = ad;
      3'b001: n463 = n445;
      default: n463 = ad;
    endcase
  /*# t65/T65.vhd:529:11 */
  always @*
    case (n462)
      3'b100: n464 = n459;
      3'b010: n464 = bah;
      3'b001: n464 = bah;
      default: n464 = bah;
    endcase
  /*# t65/T65.vhd:529:11 */
  always @*
    case (n462)
      3'b100: n465 = bal;
      3'b010: n465 = n453;
      3'b001: n465 = n447;
      default: n465 = bal;
    endcase
  /*# t65/T65.vhd:548:63 */
  assign n466 = y[7:0]; // extract
  /*# t65/T65.vhd:548:51 */
  assign n467 = ad + n466;
  /*# t65/T65.vhd:550:63 */
  assign n468 = x[7:0]; // extract
  /*# t65/T65.vhd:550:51 */
  assign n469 = ad + n468;
  /*# t65/T65.vhd:547:13 */
  assign n470 = addy ? n467 : n469;
  /*# t65/T65.vhd:546:11 */
  assign n471 = adadd ? n470 : n463;
  /*# t65/T65.vhd:554:17 */
  assign n473 = ir == 8'b00000000;
  /*# t65/T65.vhd:559:61 */
  assign n476 = mcycle == 3'b100;
  /*# t65/T65.vhd:559:51 */
  assign n477 = n476 & nmiact;
  /*# t65/T65.vhd:559:34 */
  assign n478 = nmicycle | n477;
  /*# t65/T65.vhd:559:69 */
  assign n479 = n478 | nmi_entered;
  /*# t65/T65.vhd:561:24 */
  assign n482 = mcycle == 3'b100;
  /*# t65/T65.vhd:561:15 */
  assign n485 = n482 ? 1'b1 : 1'b0;
  /*# t65/T65.vhd:559:13 */
  assign n487 = n479 ? 3'b010 : 3'b110;
  /*# t65/T65.vhd:559:13 */
  assign n489 = n479 ? n485 : 1'b0;
  /*# t65/T65.vhd:557:13 */
  assign n490 = rstcycle ? 3'b100 : n487;
  /*# t65/T65.vhd:170:10 */
  assign n492 = n491[8:3]; // extract
  /*# t65/T65.vhd:557:13 */
  assign n494 = rstcycle ? 1'b0 : n489;
  /*# t65/T65.vhd:567:30 */
  assign n496 = set_addr_to_r == 2'b11;
  /*# t65/T65.vhd:170:10 */
  assign n498 = n490[0]; // extract
  /*# t65/T65.vhd:567:13 */
  assign n499 = n496 ? 1'b1 : n498;
  /*# t65/T65.vhd:170:10 */
  assign n500 = n490[2:1]; // extract
  /*# t65/T65.vhd:554:11 */
  assign n502 = n473 ? 8'b11111111 : n464;
  /*# t65/T65.vhd:554:11 */
  assign n503 = {n492, n500, n499};
  /*# t65/T65.vhd:554:11 */
  assign n504 = n473 ? n503 : n465;
  /*# t65/T65.vhd:554:11 */
  assign n506 = n473 ? n494 : 1'b0;
  /*# t65/T65.vhd:572:11 */
  assign n508 = lddi ? DI : dl;
  /*# t65/T65.vhd:575:11 */
  assign n509 = ldalu ? alu_q : n508;
  /*# t65/T65.vhd:578:11 */
  assign n510 = ldad ? DI : n471;
  /*# t65/T65.vhd:170:10 */
  assign n511 = n504[7:0]; // extract
  /*# t65/T65.vhd:581:11 */
  assign n512 = ldbal ? DI : n511;
  /*# t65/T65.vhd:170:10 */
  assign n513 = n504[8]; // extract
  /*# t65/T65.vhd:584:11 */
  assign n514 = ldbah ? DI : n502;
  /*# t65/T65.vhd:519:9 */
  assign n518 = {n513, n512};
  /*# t65/T65.vhd:519:9 */
  assign n522 = n440 & really_rdy;
  /*# t65/T65.vhd:518:7 */
  assign n524 = really_rdy & Enable;
  /*# t65/T65.vhd:518:7 */
  assign n525 = really_rdy & Enable;
  /*# t65/T65.vhd:518:7 */
  assign n526 = really_rdy & Enable;
  /*# t65/T65.vhd:518:7 */
  assign n527 = really_rdy & Enable;
  /*# t65/T65.vhd:518:7 */
  assign n528 = really_rdy & Enable;
  /*# t65/T65.vhd:518:7 */
  assign n529 = really_rdy & Enable;
  /*# t65/T65.vhd:518:7 */
  assign n530 = n522 & Enable;
  /*# t65/T65.vhd:518:7 */
  assign n531 = really_rdy & Enable;
  /*# t65/T65.vhd:592:34 */
  assign n556 = bal[8]; // extract
  /*# t65/T65.vhd:592:27 */
  assign n557 = ~n556;
  /*# t65/T65.vhd:592:23 */
  assign n558 = breakatna & n557;
  /*# t65/T65.vhd:592:64 */
  assign n559 = pcadder[8]; // extract
  /*# t65/T65.vhd:592:53 */
  assign n560 = ~n559;
  /*# t65/T65.vhd:592:49 */
  assign n561 = pcadd & n560;
  /*# t65/T65.vhd:592:39 */
  assign n562 = n558 | n561;
  /*# t65/T65.vhd:596:45 */
  assign n564 = set_busa_to == 4'b0000;
  /*# t65/T65.vhd:597:10 */
  assign n565 = abc[7:0]; // extract
  /*# t65/T65.vhd:597:45 */
  assign n567 = set_busa_to == 4'b0001;
  /*# t65/T65.vhd:598:8 */
  assign n568 = x[7:0]; // extract
  /*# t65/T65.vhd:598:45 */
  assign n570 = set_busa_to == 4'b0010;
  /*# t65/T65.vhd:599:8 */
  assign n571 = y[7:0]; // extract
  /*# t65/T65.vhd:599:45 */
  assign n573 = set_busa_to == 4'b0011;
  /*# t65/T65.vhd:600:25 */
  assign n574 = s[7:0]; // extract
  /*# t65/T65.vhd:600:45 */
  assign n576 = set_busa_to == 4'b0100;
  /*# t65/T65.vhd:601:45 */
  assign n578 = set_busa_to == 4'b0101;
  /*# t65/T65.vhd:602:10 */
  assign n579 = abc[7:0]; // extract
  /*# t65/T65.vhd:602:23 */
  assign n580 = n579 & DI;
  /*# t65/T65.vhd:602:45 */
  assign n582 = set_busa_to == 4'b0110;
  /*# t65/T65.vhd:603:11 */
  assign n583 = abc[7:0]; // extract
  /*# t65/T65.vhd:603:24 */
  assign n585 = n583 | 8'b11101110;
  /*# t65/T65.vhd:603:34 */
  assign n586 = n585 & DI;
  /*# t65/T65.vhd:603:45 */
  assign n588 = set_busa_to == 4'b0111;
  /*# t65/T65.vhd:604:11 */
  assign n589 = abc[7:0]; // extract
  /*# t65/T65.vhd:604:24 */
  assign n591 = n589 | 8'b11101110;
  /*# t65/T65.vhd:604:34 */
  assign n592 = n591 & DI;
  /*# t65/T65.vhd:604:46 */
  assign n593 = x[7:0]; // extract
  /*# t65/T65.vhd:604:41 */
  assign n594 = n592 & n593;
  /*# t65/T65.vhd:604:62 */
  assign n596 = set_busa_to == 4'b1000;
  /*# t65/T65.vhd:605:10 */
  assign n597 = abc[7:0]; // extract
  /*# t65/T65.vhd:605:28 */
  assign n598 = x[7:0]; // extract
  /*# t65/T65.vhd:605:23 */
  assign n599 = n597 & n598;
  /*# t65/T65.vhd:605:45 */
  assign n601 = set_busa_to == 4'b1001;
  /*# t65/T65.vhd:606:45 */
  assign n604 = set_busa_to == 4'b1010;
  /*# t65/T65.vhd:594:3 */
  assign n605 = {n604, n601, n596, n588, n582, n578, n576, n573, n570, n567, n564};
  /*# t65/T65.vhd:594:3 */
  always @*
    case (n605)
      11'b10000000000: n607 = 8'bX;
      11'b01000000000: n607 = n599;
      11'b00100000000: n607 = n594;
      11'b00010000000: n607 = n586;
      11'b00001000000: n607 = n580;
      11'b00000100000: n607 = p;
      11'b00000010000: n607 = n574;
      11'b00000001000: n607 = n571;
      11'b00000000100: n607 = n568;
      11'b00000000010: n607 = n565;
      11'b00000000001: n607 = DI;
      default: n607 = 8'bX;
    endcase
  /*# t65/T65.vhd:610:46 */
  assign n608 = s[7:0]; // extract
  /*# t65/T65.vhd:610:26 */
  assign n610 = {16'b0000000000000001, n608};
  /*# t65/T65.vhd:610:87 */
  assign n612 = set_addr_to_r == 2'b00;
  /*# t65/T65.vhd:611:11 */
  assign n614 = {dbr, 8'b00000000};
  /*# t65/T65.vhd:611:24 */
  assign n615 = {n614, ad};
  /*# t65/T65.vhd:611:87 */
  assign n617 = set_addr_to_r == 2'b01;
  /*# t65/T65.vhd:612:18 */
  assign n619 = {8'b00000000, bah};
  /*# t65/T65.vhd:612:29 */
  assign n620 = bal[7:0]; // extract
  /*# t65/T65.vhd:612:24 */
  assign n621 = {n619, n620};
  /*# t65/T65.vhd:612:87 */
  assign n623 = set_addr_to_r == 2'b11;
  /*# t65/T65.vhd:613:32 */
  assign n624 = pc[15:8]; // extract
  /*# t65/T65.vhd:613:11 */
  assign n625 = {pbr, n624};
  /*# t65/T65.vhd:613:73 */
  assign n626 = pcadder[7:0]; // extract
  /*# t65/T65.vhd:613:47 */
  assign n627 = {n625, n626};
  /*# t65/T65.vhd:613:87 */
  assign n629 = set_addr_to_r == 2'b10;
  /*# t65/T65.vhd:608:3 */
  assign n630 = {n629, n623, n617, n612};
  /*# t65/T65.vhd:608:3 */
  always @*
    case (n630)
      4'b1000: n632 = n627;
      4'b0100: n632 = n621;
      4'b0010: n632 = n615;
      4'b0001: n632 = n610;
      default: n632 = 24'bX;
    endcase
  /*# t65/T65.vhd:616:14 */
  assign n634 = p & 8'b11101111;
  /*# t65/T65.vhd:616:44 */
  assign n635 = irqcycle | nmicycle;
  /*# t65/T65.vhd:616:25 */
  assign n636 = n635 ? n634 : p;
  /*# t65/T65.vhd:620:43 */
  assign n638 = write_data_r == 4'b0000;
  /*# t65/T65.vhd:621:10 */
  assign n639 = abc[7:0]; // extract
  /*# t65/T65.vhd:621:43 */
  assign n641 = write_data_r == 4'b0001;
  /*# t65/T65.vhd:622:8 */
  assign n642 = x[7:0]; // extract
  /*# t65/T65.vhd:622:43 */
  assign n644 = write_data_r == 4'b0010;
  /*# t65/T65.vhd:623:8 */
  assign n645 = y[7:0]; // extract
  /*# t65/T65.vhd:623:43 */
  assign n647 = write_data_r == 4'b0011;
  /*# t65/T65.vhd:624:25 */
  assign n648 = s[7:0]; // extract
  /*# t65/T65.vhd:624:43 */
  assign n650 = write_data_r == 4'b0100;
  /*# t65/T65.vhd:625:43 */
  assign n652 = write_data_r == 4'b0101;
  /*# t65/T65.vhd:626:26 */
  assign n653 = pc[7:0]; // extract
  /*# t65/T65.vhd:626:43 */
  assign n655 = write_data_r == 4'b0110;
  /*# t65/T65.vhd:627:26 */
  assign n656 = pc[15:8]; // extract
  /*# t65/T65.vhd:627:43 */
  assign n658 = write_data_r == 4'b0111;
  /*# t65/T65.vhd:628:10 */
  assign n659 = abc[7:0]; // extract
  /*# t65/T65.vhd:628:28 */
  assign n660 = x[7:0]; // extract
  /*# t65/T65.vhd:628:23 */
  assign n661 = n659 & n660;
  /*# t65/T65.vhd:628:43 */
  assign n663 = write_data_r == 4'b1000;
  /*# t65/T65.vhd:629:10 */
  assign n664 = abc[7:0]; // extract
  /*# t65/T65.vhd:629:28 */
  assign n665 = x[7:0]; // extract
  /*# t65/T65.vhd:629:23 */
  assign n666 = n664 & n665;
  /*# t65/T65.vhd:629:41 */
  assign n667 = n666 & busb_r;
  /*# t65/T65.vhd:629:64 */
  assign n669 = write_data_r == 4'b1001;
  /*# t65/T65.vhd:630:8 */
  assign n670 = x[7:0]; // extract
  /*# t65/T65.vhd:630:21 */
  assign n671 = n670 & busb_r;
  /*# t65/T65.vhd:630:44 */
  assign n673 = write_data_r == 4'b1010;
  /*# t65/T65.vhd:631:8 */
  assign n674 = y[7:0]; // extract
  /*# t65/T65.vhd:631:21 */
  assign n675 = n674 & busb_r;
  /*# t65/T65.vhd:631:44 */
  assign n677 = write_data_r == 4'b1011;
  /*# t65/T65.vhd:632:43 */
  assign n680 = write_data_r == 4'b1100;
  /*# t65/T65.vhd:618:3 */
  assign n681 = {n680, n677, n673, n669, n663, n658, n655, n652, n650, n647, n644, n641, n638};
  /*# t65/T65.vhd:618:3 */
  always @*
    case (n681)
      13'b1000000000000: n683 = 8'bX;
      13'b0100000000000: n683 = n675;
      13'b0010000000000: n683 = n671;
      13'b0001000000000: n683 = n667;
      13'b0000100000000: n683 = n661;
      13'b0000010000000: n683 = n656;
      13'b0000001000000: n683 = n653;
      13'b0000000100000: n683 = pwithb;
      13'b0000000010000: n683 = n648;
      13'b0000000001000: n683 = n645;
      13'b0000000000100: n683 = n642;
      13'b0000000000010: n683 = n639;
      13'b0000000000001: n683 = dl;
      default: n683 = 8'bX;
    endcase
  /*# t65/T65.vhd:643:16 */
  assign n686 = ~res_n_i;
  /*# t65/T65.vhd:652:21 */
  assign n688 = mcycle == lcycle;
  /*# t65/T65.vhd:652:30 */
  assign n689 = n688 | break_i;
  /*# t65/T65.vhd:657:35 */
  assign n691 = ir != 8'b00000000;
  /*# t65/T65.vhd:657:29 */
  assign n692 = n691 & nmiact;
  /*# t65/T65.vhd:660:27 */
  assign n693 = ~irq_n_o;
  /*# t65/T65.vhd:660:38 */
  assign n694 = p[2]; // extract
  /*# t65/T65.vhd:660:47 */
  assign n695 = ~n694;
  /*# t65/T65.vhd:660:33 */
  assign n696 = n695 & n693;
  /*# t65/T65.vhd:660:13 */
  assign n699 = n696 ? 1'b1 : 1'b0;
  /*# t65/T65.vhd:657:13 */
  assign n701 = n692 ? 1'b0 : n699;
  /*# t65/T65.vhd:657:13 */
  assign n705 = n692 ? 1'b1 : 1'b0;
  /*# t65/T65.vhd:651:9 */
  assign n708 = n722 ? 1'b0 : nmiact;
  /*# t65/T65.vhd:664:57 */
  assign n710 = mcycle + 3'b001;
  /*# t65/T65.vhd:652:11 */
  assign n712 = n689 ? 3'b000 : n710;
  /*# t65/T65.vhd:652:11 */
  assign n717 = n692 & n689;
  /*# t65/T65.vhd:651:9 */
  assign n719 = n689 & really_rdy;
  /*# t65/T65.vhd:651:9 */
  assign n720 = n689 & really_rdy;
  /*# t65/T65.vhd:651:9 */
  assign n721 = n689 & really_rdy;
  /*# t65/T65.vhd:651:9 */
  assign n722 = n717 & really_rdy;
  /*# t65/T65.vhd:668:37 */
  assign n723 = ~NMI_n;
  /*# t65/T65.vhd:668:50 */
  assign n724 = ir[4:0]; // extract
  /*# t65/T65.vhd:668:62 */
  assign n726 = n724 != 5'b10000;
  /*# t65/T65.vhd:668:79 */
  assign n728 = jump != 2'b01;
  /*# t65/T65.vhd:668:72 */
  assign n729 = n726 | n728;
  /*# t65/T65.vhd:668:43 */
  assign n730 = n729 & n723;
  /*# t65/T65.vhd:668:26 */
  assign n731 = n730 & nmi_n_o;
  /*# t65/T65.vhd:668:9 */
  assign n733 = n731 ? 1'b1 : n708;
  /*# t65/T65.vhd:672:9 */
  assign n735 = nmi_entered ? 1'b0 : n733;
  /*# t65/T65.vhd:650:7 */
  assign n736 = really_rdy & Enable;
  /*# t65/T65.vhd:650:7 */
  assign n737 = n719 & Enable;
  /*# t65/T65.vhd:650:7 */
  assign n738 = n720 & Enable;
  /*# t65/T65.vhd:650:7 */
  assign n739 = n721 & Enable;
  /*# t65/T65.vhd:166:10 */
  assign n758 = {8'bZ, n768};
  /*# t65/T65.vhd:166:15 */
  assign n760 = {8'bZ, n773};
  /*# t65/T65.vhd:166:18 */
  assign n762 = {8'bZ, n778};
  /*# t65/T65.vhd:158:5 */
  assign n763 = {p, n65, n64, n63, n62, ir};
  /*# t65/T65.vhd:166:10 */
  assign n764 = ~n278;
  /*# t65/T65.vhd:166:10 */
  assign n765 = n391 & n764;
  /*# t65/T65.vhd:426:5 */
  assign n766 = abc[7:0]; // extract
  /*# t65/T65.vhd:426:5 */
  assign n767 = n765 ? alu_q : n766;
  /*# t65/T65.vhd:426:5 */
  always @(posedge Clk)
    n768 <= n767;
  /*# t65/T65.vhd:166:15 */
  assign n769 = ~n278;
  /*# t65/T65.vhd:166:15 */
  assign n770 = n393 & n769;
  /*# t65/T65.vhd:426:5 */
  assign n771 = x[7:0]; // extract
  /*# t65/T65.vhd:426:5 */
  assign n772 = n770 ? alu_q : n771;
  /*# t65/T65.vhd:426:5 */
  always @(posedge Clk)
    n773 <= n772;
  /*# t65/T65.vhd:166:18 */
  assign n774 = ~n278;
  /*# t65/T65.vhd:166:18 */
  assign n775 = n395 & n774;
  /*# t65/T65.vhd:426:5 */
  assign n776 = y[7:0]; // extract
  /*# t65/T65.vhd:426:5 */
  assign n777 = n775 ? alu_q : n776;
  /*# t65/T65.vhd:426:5 */
  always @(posedge Clk)
    n778 <= n777;
  /*# t65/T65.vhd:426:5 */
  always @(posedge Clk or posedge n278)
    if (n278)
      n779 <= 8'b00000000;
    else
      n779 <= n413;
  /*# t65/T65.vhd:517:5 */
  assign n780 = n524 ? n510 : ad;
  /*# t65/T65.vhd:517:5 */
  always @(posedge Clk or posedge n434)
    if (n434)
      n781 <= 8'b00000000;
    else
      n781 <= n780;
  /*# t65/T65.vhd:517:5 */
  assign n782 = n525 ? n509 : dl;
  /*# t65/T65.vhd:517:5 */
  always @(posedge Clk or posedge n434)
    if (n434)
      n783 <= 8'b00000000;
    else
      n783 <= n782;
  /*# t65/T65.vhd:517:5 */
  assign n784 = n526 ? n514 : bah;
  /*# t65/T65.vhd:517:5 */
  always @(posedge Clk or posedge n434)
    if (n434)
      n785 <= 8'b00000000;
    else
      n785 <= n784;
  /*# t65/T65.vhd:517:5 */
  assign n786 = n527 ? n518 : bal;
  /*# t65/T65.vhd:517:5 */
  always @(posedge Clk or posedge n434)
    if (n434)
      n787 <= 9'b000000000;
    else
      n787 <= n786;
  /*# t65/T65.vhd:346:5 */
  assign n788 = n209 ? 8'b11111111 : pbr;
  /*# t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n107)
    if (n107)
      n789 <= 8'b00000000;
    else
      n789 <= n788;
  /*# t65/T65.vhd:346:5 */
  assign n790 = n210 ? 8'b11111111 : dbr;
  /*# t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n107)
    if (n107)
      n791 <= 8'b00000000;
    else
      n791 <= n790;
  /*# t65/T65.vhd:346:5 */
  assign n792 = n211 ? n193 : pc;
  /*# t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n107)
    if (n107)
      n793 <= 16'b0000000000000000;
    else
      n793 <= n792;
  /*# t65/T65.vhd:346:5 */
  assign n794 = n212 ? n144 : s;
  /*# t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n107)
    if (n107)
      n795 <= 16'b0000000000000000;
    else
      n795 <= n794;
  /*# t65/T65.vhd:346:5 */
  assign n796 = n213 ? 1'b0 : ef_i;
  /*# t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n107)
    if (n107)
      n797 <= 1'b1;
    else
      n797 <= n796;
  /*# t65/T65.vhd:346:5 */
  assign n798 = n214 ? 1'b0 : mf_i;
  /*# t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n107)
    if (n107)
      n799 <= 1'b1;
    else
      n799 <= n798;
  /*# t65/T65.vhd:346:5 */
  assign n800 = n215 ? 1'b0 : xf_i;
  /*# t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n107)
    if (n107)
      n801 <= 1'b1;
    else
      n801 <= n800;
  /*# t65/T65.vhd:346:5 */
  assign n802 = n216 ? n121 : ir;
  /*# t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n107)
    if (n107)
      n803 <= 8'b00000000;
    else
      n803 <= n802;
  /*# t65/T65.vhd:649:5 */
  assign n804 = n736 ? n712 : mcycle;
  /*# t65/T65.vhd:649:5 */
  always @(posedge Clk or posedge n686)
    if (n686)
      n805 <= 3'b001;
    else
      n805 <= n804;
  /*# t65/T65.vhd:346:5 */
  assign n806 = n217 ? Mode : mode_r;
  /*# t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n107)
    if (n107)
      n807 <= 2'b00;
    else
      n807 <= n806;
  /*# t65/T65.vhd:346:5 */
  assign n808 = n218 ? BCD_en : bcd_en_r;
  /*# t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n107)
    if (n107)
      n809 <= 1'b1;
    else
      n809 <= n808;
  /*# t65/T65.vhd:346:5 */
  assign n810 = n219 ? alu_op : alu_op_r;
  /*# t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n107)
    if (n107)
      n811 <= 5'b01100;
    else
      n811 <= n810;
  /*# t65/T65.vhd:346:5 */
  assign n812 = n220 ? write_data : write_data_r;
  /*# t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n107)
    if (n107)
      n813 <= 4'b0000;
    else
      n813 <= n812;
  /*# t65/T65.vhd:346:5 */
  assign n814 = n221 ? n131 : set_addr_to_r;
  /*# t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n107)
    if (n107)
      n815 <= 2'b10;
    else
      n815 <= n814;
  /*# t65/T65.vhd:649:5 */
  assign n816 = n737 ? 1'b0 : rstcycle;
  /*# t65/T65.vhd:649:5 */
  always @(posedge Clk or posedge n686)
    if (n686)
      n817 <= 1'b1;
    else
      n817 <= n816;
  /*# t65/T65.vhd:649:5 */
  assign n818 = n738 ? n701 : irqcycle;
  /*# t65/T65.vhd:649:5 */
  always @(posedge Clk or posedge n686)
    if (n686)
      n819 <= 1'b0;
    else
      n819 <= n818;
  /*# t65/T65.vhd:649:5 */
  assign n820 = n739 ? n705 : nmicycle;
  /*# t65/T65.vhd:649:5 */
  always @(posedge Clk or posedge n686)
    if (n686)
      n821 <= 1'b0;
    else
      n821 <= n820;
  /*# t65/T65.vhd:193:10 */
  assign n822 = ~n278;
  /*# t65/T65.vhd:426:5 */
  assign n823 = n822 ? SO_n : so_n_o;
  /*# t65/T65.vhd:426:5 */
  always @(posedge Clk)
    n824 <= n823;
  /*# t65/T65.vhd:194:10 */
  assign n825 = ~n278;
  /*# t65/T65.vhd:194:10 */
  assign n826 = n397 & n825;
  /*# t65/T65.vhd:426:5 */
  assign n827 = n826 ? IRQ_n : irq_n_o;
  /*# t65/T65.vhd:426:5 */
  always @(posedge Clk)
    n828 <= n827;
  /*# t65/T65.vhd:195:10 */
  assign n829 = ~n278;
  /*# t65/T65.vhd:195:10 */
  assign n830 = n398 & n829;
  /*# t65/T65.vhd:426:5 */
  assign n831 = n830 ? NMI_n : nmi_n_o;
  /*# t65/T65.vhd:426:5 */
  always @(posedge Clk)
    n832 <= n831;
  /*# t65/T65.vhd:649:5 */
  assign n833 = Enable ? n735 : nmiact;
  /*# t65/T65.vhd:649:5 */
  always @(posedge Clk or posedge n686)
    if (n686)
      n834 <= 1'b0;
    else
      n834 <= n833;
  /*# t65/T65.vhd:517:5 */
  assign n835 = n528 ? busa : busa_r;
  /*# t65/T65.vhd:517:5 */
  always @(posedge Clk or posedge n434)
    if (n434)
      n836 <= 8'b00000000;
    else
      n836 <= n835;
  /*# t65/T65.vhd:517:5 */
  assign n837 = n529 ? DI : busb;
  /*# t65/T65.vhd:517:5 */
  always @(posedge Clk or posedge n434)
    if (n434)
      n838 <= 8'b00000000;
    else
      n838 <= n837;
  /*# t65/T65.vhd:517:5 */
  assign n839 = n530 ? n442 : busb_r;
  /*# t65/T65.vhd:517:5 */
  always @(posedge Clk or posedge n434)
    if (n434)
      n840 <= 8'b00000000;
    else
      n840 <= n839;
  /*# t65/T65.vhd:320:5 */
  always @(posedge Clk or posedge n95)
    if (n95)
      n841 <= 1'b0;
    else
      n841 <= res_n_d;
  /*# t65/T65.vhd:320:5 */
  always @(posedge Clk or posedge n95)
    if (n95)
      n842 <= 1'b0;
    else
      n842 <= 1'b1;
  /*# t65/T65.vhd:346:5 */
  assign n843 = n222 ? n110 : wrn_i;
  /*# t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n107)
    if (n107)
      n844 <= 1'b1;
    else
      n844 <= n843;
  /*# t65/T65.vhd:241:10 */
  assign n845 = ~n434;
  /*# t65/T65.vhd:241:10 */
  assign n846 = n531 & n845;
  /*# t65/T65.vhd:517:5 */
  assign n847 = n846 ? n506 : nmi_entered;
  /*# t65/T65.vhd:517:5 */
  always @(posedge Clk)
    n848 <= n847;
endmodule

