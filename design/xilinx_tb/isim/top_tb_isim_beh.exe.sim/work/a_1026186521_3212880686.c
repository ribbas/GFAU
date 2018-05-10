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
static const char *ng0 = "/home/sabbir/projects/GFAU/design/vhdl/ops/mods/addsub.vhd";
extern char *WORK_P_0696720821;
extern char *IEEE_P_2592010699;

char *ieee_p_2592010699_sub_16439989833707593767_503743352(char *, char *, char *, char *, char *, char *);


static void work_a_1026186521_3212880686_p_0(char *t0)
{
    char t14[16];
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    unsigned int t15;
    unsigned int t16;
    char *t17;
    char *t18;
    char *t19;

LAB0:    xsi_set_current_line(34, ng0);
    t2 = (t0 + 1352U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:    t2 = (t0 + 1352U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)2);
    if (t5 == 1)
        goto LAB10;

LAB11:    t1 = (unsigned char)0;

LAB12:    if (t1 != 0)
        goto LAB8;

LAB9:    t2 = (t0 + 1352U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB15;

LAB16:    t1 = (unsigned char)0;

LAB17:    if (t1 != 0)
        goto LAB13;

LAB14:    xsi_set_current_line(51, ng0);
    t2 = (t0 + 1032U);
    t3 = *((char **)t2);
    t2 = (t0 + 5192U);
    t6 = (t0 + 1192U);
    t9 = *((char **)t6);
    t6 = (t0 + 5208U);
    t10 = ieee_p_2592010699_sub_16439989833707593767_503743352(IEEE_P_2592010699, t14, t3, t2, t9, t6);
    t11 = (t14 + 12U);
    t15 = *((unsigned int *)t11);
    t16 = (1U * t15);
    t1 = (8U != t16);
    if (t1 == 1)
        goto LAB18;

LAB19:    t12 = (t0 + 3344);
    t13 = (t12 + 56U);
    t17 = *((char **)t13);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memcpy(t19, t10, 8U);
    xsi_driver_first_trans_fast_port(t12);

LAB3:    t2 = (t0 + 3264);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(36, ng0);
    t2 = (t0 + 1192U);
    t9 = *((char **)t2);
    t2 = (t0 + 3344);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t9, 8U);
    xsi_driver_first_trans_fast_port(t2);
    goto LAB3;

LAB5:    t2 = (t0 + 1512U);
    t6 = *((char **)t2);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)2);
    t1 = t8;
    goto LAB7;

LAB8:    xsi_set_current_line(41, ng0);
    t2 = (t0 + 1032U);
    t9 = *((char **)t2);
    t2 = (t0 + 3344);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t9, 8U);
    xsi_driver_first_trans_fast_port(t2);
    goto LAB3;

LAB10:    t2 = (t0 + 1512U);
    t6 = *((char **)t2);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)3);
    t1 = t8;
    goto LAB12;

LAB13:    xsi_set_current_line(46, ng0);
    t2 = ((WORK_P_0696720821) + 1768U);
    t9 = *((char **)t2);
    t2 = (t0 + 3344);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t9, 8U);
    xsi_driver_first_trans_fast_port(t2);
    goto LAB3;

LAB15:    t2 = (t0 + 1512U);
    t6 = *((char **)t2);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)3);
    t1 = t8;
    goto LAB17;

LAB18:    xsi_size_not_matching(8U, t16, 0);
    goto LAB19;

}


extern void work_a_1026186521_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1026186521_3212880686_p_0};
	xsi_register_didat("work_a_1026186521_3212880686", "isim/top_tb_isim_beh.exe.sim/work/a_1026186521_3212880686.didat");
	xsi_register_executes(pe);
}
