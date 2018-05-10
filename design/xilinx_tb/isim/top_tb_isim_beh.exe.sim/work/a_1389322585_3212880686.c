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
static const char *ng0 = "/home/sabbir/projects/GFAU/design/vhdl/alu/mods/twoscmp.vhd";
extern char *IEEE_P_1242562249;
extern char *IEEE_P_2592010699;
extern char *WORK_P_0696720821;

char *ieee_p_1242562249_sub_1701011461141717515_1035706684(char *, char *, char *, char *, char *, char *);
char *ieee_p_2592010699_sub_207919886985903570_503743352(char *, char *, char *, char *);


static void work_a_1389322585_3212880686_p_0(char *t0)
{
    char t1[16];
    char t2[16];
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;

LAB0:    xsi_set_current_line(29, ng0);

LAB3:    t3 = (t0 + 1032U);
    t4 = *((char **)t3);
    t3 = (t0 + 4528U);
    t5 = ieee_p_2592010699_sub_207919886985903570_503743352(IEEE_P_2592010699, t2, t4, t3);
    t6 = ((WORK_P_0696720821) + 2128U);
    t7 = *((char **)t6);
    t6 = ((WORK_P_0696720821) + 6000U);
    t8 = ieee_p_1242562249_sub_1701011461141717515_1035706684(IEEE_P_1242562249, t1, t5, t2, t7, t6);
    t9 = (t0 + 2864);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t8, 8U);
    xsi_driver_first_trans_fast_port(t9);

LAB2:    t14 = (t0 + 2784);
    *((int *)t14) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_1389322585_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1389322585_3212880686_p_0};
	xsi_register_didat("work_a_1389322585_3212880686", "isim/top_tb_isim_beh.exe.sim/work/a_1389322585_3212880686.didat");
	xsi_register_executes(pe);
}
