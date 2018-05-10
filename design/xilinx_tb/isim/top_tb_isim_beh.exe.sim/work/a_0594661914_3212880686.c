/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/sabbir/projects/GFAU/design/vhdl/ops/mods/outconvert.vhd";
extern char *IEEE_P_2592010699;
extern char *WORK_P_0696720821;
extern char *IEEE_P_0017514958;

unsigned char ieee_p_0017514958_sub_896298246495612401_1861681735(char *, char *, char *);
char *ieee_p_2592010699_sub_16439989832805790689_503743352(char *, char *, char *, char *, char *, char *);
unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_0594661914_3212880686_p_0(char *t0)
{
    char t19[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned char t11;
    unsigned char t12;
    unsigned char t13;
    unsigned char t14;
    unsigned char t15;
    char *t16;
    char *t17;
    char *t18;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    char *t23;
    char *t24;
    static char *nl0[] = {&&LAB18, &&LAB19};

LAB0:    xsi_set_current_line(54, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 4544);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(56, ng0);
    t3 = (t0 + 1352U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)3);
    if (t6 != 0)
        goto LAB5;

LAB7:
LAB6:    xsi_set_current_line(65, ng0);
    t1 = (t0 + 1192U);
    t3 = *((char **)t1);
    t5 = *((unsigned char *)t3);
    t6 = (t5 == (unsigned char)3);
    if (t6 == 1)
        goto LAB11;

LAB12:    t2 = (unsigned char)0;

LAB13:    if (t2 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(137, ng0);
    t1 = (t0 + 4816);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);

LAB9:    goto LAB3;

LAB5:    xsi_set_current_line(58, ng0);
    t3 = (t0 + 4624);
    t7 = (t3 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(59, ng0);
    t1 = ((WORK_P_0696720821) + 1528U);
    t3 = *((char **)t1);
    t1 = (t0 + 4688);
    t4 = (t1 + 56U);
    t7 = *((char **)t4);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t3, 8U);
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(60, ng0);
    t1 = ((WORK_P_0696720821) + 1528U);
    t3 = *((char **)t1);
    t1 = (t0 + 4752);
    t4 = (t1 + 56U);
    t7 = *((char **)t4);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t3, 8U);
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(61, ng0);
    t1 = (t0 + 4816);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB6;

LAB8:    xsi_set_current_line(68, ng0);
    t1 = (t0 + 1512U);
    t7 = *((char **)t1);
    t13 = *((unsigned char *)t7);
    t14 = (t13 == (unsigned char)3);
    if (t14 != 0)
        goto LAB14;

LAB16:    xsi_set_current_line(118, ng0);
    t1 = (t0 + 4624);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(119, ng0);
    t1 = (t0 + 4816);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(121, ng0);
    t1 = ((WORK_P_0696720821) + 1528U);
    t3 = *((char **)t1);
    t1 = (t0 + 4688);
    t4 = (t1 + 56U);
    t7 = *((char **)t4);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t3, 8U);
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(123, ng0);
    t1 = (t0 + 1832U);
    t3 = *((char **)t1);
    t1 = (t0 + 7520U);
    t2 = ieee_p_0017514958_sub_896298246495612401_1861681735(IEEE_P_0017514958, t3, t1);
    t5 = (t2 == (unsigned char)2);
    if (t5 != 0)
        goto LAB26;

LAB28:    xsi_set_current_line(129, ng0);
    t1 = (t0 + 1832U);
    t3 = *((char **)t1);
    t1 = (t0 + 4752);
    t4 = (t1 + 56U);
    t7 = *((char **)t4);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t3, 8U);
    xsi_driver_first_trans_fast_port(t1);

LAB27:
LAB15:    goto LAB9;

LAB11:    t1 = (t0 + 1352U);
    t4 = *((char **)t1);
    t11 = *((unsigned char *)t4);
    t12 = (t11 == (unsigned char)2);
    t2 = t12;
    goto LAB13;

LAB14:    xsi_set_current_line(70, ng0);
    t1 = (t0 + 2952U);
    t8 = *((char **)t1);
    t15 = *((unsigned char *)t8);
    t1 = (char *)((nl0) + t15);
    goto **((char **)t1);

LAB17:    goto LAB15;

LAB18:    xsi_set_current_line(76, ng0);
    t9 = (t0 + 4624);
    t10 = (t9 + 56U);
    t16 = *((char **)t10);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    *((unsigned char *)t18) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t9);
    xsi_set_current_line(77, ng0);
    t1 = (t0 + 4816);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(79, ng0);
    t1 = (t0 + 1832U);
    t3 = *((char **)t1);
    t1 = (t0 + 4688);
    t4 = (t1 + 56U);
    t7 = *((char **)t4);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t3, 8U);
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(80, ng0);
    t1 = ((WORK_P_0696720821) + 1528U);
    t3 = *((char **)t1);
    t1 = (t0 + 4752);
    t4 = (t1 + 56U);
    t7 = *((char **)t4);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t3, 8U);
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(82, ng0);
    t1 = (t0 + 4880);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    goto LAB17;

LAB19:    xsi_set_current_line(87, ng0);
    t1 = (t0 + 4624);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(88, ng0);
    t1 = (t0 + 1832U);
    t3 = *((char **)t1);
    t1 = (t0 + 4688);
    t4 = (t1 + 56U);
    t7 = *((char **)t4);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t3, 8U);
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(90, ng0);
    t1 = (t0 + 2152U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t5 = (t2 == (unsigned char)3);
    if (t5 != 0)
        goto LAB21;

LAB23:    xsi_set_current_line(97, ng0);
    t1 = ((WORK_P_0696720821) + 1528U);
    t3 = *((char **)t1);
    t1 = (t0 + 4752);
    t4 = (t1 + 56U);
    t7 = *((char **)t4);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t3, 8U);
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(98, ng0);
    t1 = (t0 + 4816);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(99, ng0);
    t1 = (t0 + 4880);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);

LAB22:    goto LAB17;

LAB20:    xsi_set_current_line(106, ng0);
    t1 = (t0 + 4624);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(107, ng0);
    t1 = (t0 + 4816);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(109, ng0);
    t1 = ((WORK_P_0696720821) + 1528U);
    t3 = *((char **)t1);
    t1 = (t0 + 4688);
    t4 = (t1 + 56U);
    t7 = *((char **)t4);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t3, 8U);
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(110, ng0);
    t1 = ((WORK_P_0696720821) + 1528U);
    t3 = *((char **)t1);
    t1 = (t0 + 4752);
    t4 = (t1 + 56U);
    t7 = *((char **)t4);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t3, 8U);
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(111, ng0);
    t1 = (t0 + 4880);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB17;

LAB21:    xsi_set_current_line(92, ng0);
    t1 = (t0 + 2472U);
    t4 = *((char **)t1);
    t1 = (t0 + 7552U);
    t7 = (t0 + 1672U);
    t8 = *((char **)t7);
    t7 = (t0 + 7504U);
    t9 = ieee_p_2592010699_sub_16439989832805790689_503743352(IEEE_P_2592010699, t19, t4, t1, t8, t7);
    t10 = (t19 + 12U);
    t20 = *((unsigned int *)t10);
    t21 = (1U * t20);
    t6 = (8U != t21);
    if (t6 == 1)
        goto LAB24;

LAB25:    t16 = (t0 + 4752);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t22 = (t18 + 56U);
    t23 = *((char **)t22);
    memcpy(t23, t9, 8U);
    xsi_driver_first_trans_fast_port(t16);
    xsi_set_current_line(93, ng0);
    t1 = (t0 + 4816);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB22;

LAB24:    xsi_size_not_matching(8U, t21, 0);
    goto LAB25;

LAB26:    xsi_set_current_line(125, ng0);
    t4 = (t0 + 1832U);
    t7 = *((char **)t4);
    t4 = (t0 + 7520U);
    t8 = (t0 + 1672U);
    t9 = *((char **)t8);
    t8 = (t0 + 7504U);
    t10 = ieee_p_2592010699_sub_16439989832805790689_503743352(IEEE_P_2592010699, t19, t7, t4, t9, t8);
    t16 = (t19 + 12U);
    t20 = *((unsigned int *)t16);
    t21 = (1U * t20);
    t6 = (8U != t21);
    if (t6 == 1)
        goto LAB29;

LAB30:    t17 = (t0 + 4752);
    t18 = (t17 + 56U);
    t22 = *((char **)t18);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    memcpy(t24, t10, 8U);
    xsi_driver_first_trans_fast_port(t17);
    goto LAB27;

LAB29:    xsi_size_not_matching(8U, t21, 0);
    goto LAB30;

}


extern void work_a_0594661914_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0594661914_3212880686_p_0};
	xsi_register_didat("work_a_0594661914_3212880686", "isim/top_tb_isim_beh.exe.sim/work/a_0594661914_3212880686.didat");
	xsi_register_executes(pe);
}
