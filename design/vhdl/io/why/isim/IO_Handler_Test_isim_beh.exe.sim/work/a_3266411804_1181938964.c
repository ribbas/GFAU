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
static const char *ng0 = "/media/sf_Xilinx/gfau/design/vhdl/io/why/gt8.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_3488546069778340532_503743352(char *, unsigned char , unsigned char );
unsigned char ieee_p_2592010699_sub_3488768496604610246_503743352(char *, unsigned char , unsigned char );


static void work_a_3266411804_1181938964_p_0(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    unsigned int t4;
    unsigned int t5;
    unsigned int t6;
    unsigned char t7;
    char *t8;
    char *t9;
    int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned char t14;
    char *t15;
    char *t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned char t21;
    unsigned char t22;
    char *t23;
    char *t24;
    int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned char t29;
    unsigned char t30;
    unsigned char t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;

LAB0:    xsi_set_current_line(19, ng0);

LAB3:    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t3 = (3 - 3);
    t4 = (t3 * -1);
    t5 = (1U * t4);
    t6 = (0 + t5);
    t1 = (t2 + t6);
    t7 = *((unsigned char *)t1);
    t8 = (t0 + 1032U);
    t9 = *((char **)t8);
    t10 = (2 - 3);
    t11 = (t10 * -1);
    t12 = (1U * t11);
    t13 = (0 + t12);
    t8 = (t9 + t13);
    t14 = *((unsigned char *)t8);
    t15 = (t0 + 1032U);
    t16 = *((char **)t15);
    t17 = (1 - 3);
    t18 = (t17 * -1);
    t19 = (1U * t18);
    t20 = (0 + t19);
    t15 = (t16 + t20);
    t21 = *((unsigned char *)t15);
    t22 = ieee_p_2592010699_sub_3488546069778340532_503743352(IEEE_P_2592010699, t14, t21);
    t23 = (t0 + 1032U);
    t24 = *((char **)t23);
    t25 = (0 - 3);
    t26 = (t25 * -1);
    t27 = (1U * t26);
    t28 = (0 + t27);
    t23 = (t24 + t28);
    t29 = *((unsigned char *)t23);
    t30 = ieee_p_2592010699_sub_3488546069778340532_503743352(IEEE_P_2592010699, t22, t29);
    t31 = ieee_p_2592010699_sub_3488768496604610246_503743352(IEEE_P_2592010699, t7, t30);
    t32 = (t0 + 2744);
    t33 = (t32 + 56U);
    t34 = *((char **)t33);
    t35 = (t34 + 56U);
    t36 = *((char **)t35);
    *((unsigned char *)t36) = t31;
    xsi_driver_first_trans_fast_port(t32);

LAB2:    t37 = (t0 + 2664);
    *((int *)t37) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_3266411804_1181938964_init()
{
	static char *pe[] = {(void *)work_a_3266411804_1181938964_p_0};
	xsi_register_didat("work_a_3266411804_1181938964", "isim/IO_Handler_Test_isim_beh.exe.sim/work/a_3266411804_1181938964.didat");
	xsi_register_executes(pe);
}
