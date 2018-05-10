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
static const char *ng0 = "/home/sabbir/projects/GFAU/design/vhdl/top_tb.vhd";
extern char *WORK_P_1871661363;
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_374109322130769762_503743352(char *, unsigned char );


static void work_a_3115858369_2372691052_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    char *t5;
    int t6;
    int t7;
    char *t8;
    char *t9;
    unsigned char t10;
    unsigned char t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    int64 t16;
    int64 t17;

LAB0:    t1 = (t0 + 6384U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(161, ng0);
    t2 = ((WORK_P_1871661363) + 1168U);
    t3 = *((char **)t2);
    t4 = *((int *)t3);
    t2 = (t0 + 11071);
    *((int *)t2) = 1;
    t5 = (t0 + 11075);
    *((int *)t5) = t4;
    t6 = 1;
    t7 = t4;

LAB4:    if (t6 <= t7)
        goto LAB5;

LAB7:    goto LAB2;

LAB5:    xsi_set_current_line(162, ng0);
    t8 = (t0 + 1032U);
    t9 = *((char **)t8);
    t10 = *((unsigned char *)t9);
    t11 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t10);
    t8 = (t0 + 7016);
    t12 = (t8 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    *((unsigned char *)t15) = t11;
    xsi_driver_first_trans_fast(t8);
    xsi_set_current_line(163, ng0);
    t2 = ((WORK_P_1871661363) + 1288U);
    t3 = *((char **)t2);
    t16 = *((int64 *)t3);
    t17 = (t16 / 2);
    t2 = (t0 + 6192);
    xsi_process_wait(t2, t17);

LAB10:    *((char **)t1) = &&LAB11;

LAB1:    return;
LAB6:    t2 = (t0 + 11071);
    t6 = *((int *)t2);
    t3 = (t0 + 11075);
    t7 = *((int *)t3);
    if (t6 == t7)
        goto LAB7;

LAB12:    t4 = (t6 + 1);
    t6 = t4;
    t5 = (t0 + 11071);
    *((int *)t5) = t6;
    goto LAB4;

LAB8:    goto LAB6;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_3115858369_2372691052_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    int64 t9;
    int64 t10;

LAB0:    t1 = (t0 + 6632U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(173, ng0);
    t2 = (t0 + 11079);
    t4 = (t0 + 7080);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 8U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(174, ng0);
    t2 = (t0 + 11087);
    t4 = (t0 + 7144);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 8U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(175, ng0);
    t2 = (t0 + 11095);
    t4 = (t0 + 7208);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 8U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(177, ng0);
    t2 = ((WORK_P_1871661363) + 1288U);
    t3 = *((char **)t2);
    t9 = *((int64 *)t3);
    t10 = (t9 * 1);
    t2 = (t0 + 6440);
    xsi_process_wait(t2, t10);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(179, ng0);
    t2 = (t0 + 7272);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(180, ng0);
    t2 = (t0 + 7336);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(182, ng0);
    t2 = ((WORK_P_1871661363) + 1288U);
    t3 = *((char **)t2);
    t9 = *((int64 *)t3);
    t10 = (t9 * 2);
    t2 = (t0 + 6440);
    xsi_process_wait(t2, t10);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    xsi_set_current_line(184, ng0);
    t2 = (t0 + 11103);
    t4 = (t0 + 7400);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 6U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(186, ng0);
    t2 = ((WORK_P_1871661363) + 1288U);
    t3 = *((char **)t2);
    t9 = *((int64 *)t3);
    t10 = (t9 * 40);
    t2 = (t0 + 6440);
    xsi_process_wait(t2, t10);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

LAB12:    xsi_set_current_line(188, ng0);
    t2 = (t0 + 11109);
    t4 = (t0 + 7400);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 6U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(190, ng0);
    t2 = ((WORK_P_1871661363) + 1288U);
    t3 = *((char **)t2);
    t9 = *((int64 *)t3);
    t10 = (t9 * 4);
    t2 = (t0 + 6440);
    xsi_process_wait(t2, t10);

LAB18:    *((char **)t1) = &&LAB19;
    goto LAB1;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

LAB16:    xsi_set_current_line(192, ng0);
    if ((unsigned char)0 == 0)
        goto LAB20;

LAB21:    xsi_set_current_line(194, ng0);

LAB24:    *((char **)t1) = &&LAB25;
    goto LAB1;

LAB17:    goto LAB16;

LAB19:    goto LAB17;

LAB20:    t2 = (t0 + 11115);
    xsi_report(t2, 16U, (unsigned char)3);
    goto LAB21;

LAB22:    goto LAB2;

LAB23:    goto LAB22;

LAB25:    goto LAB23;

}


extern void work_a_3115858369_2372691052_init()
{
	static char *pe[] = {(void *)work_a_3115858369_2372691052_p_0,(void *)work_a_3115858369_2372691052_p_1};
	xsi_register_didat("work_a_3115858369_2372691052", "isim/top_tb_isim_beh.exe.sim/work/a_3115858369_2372691052.didat");
	xsi_register_executes(pe);
}
