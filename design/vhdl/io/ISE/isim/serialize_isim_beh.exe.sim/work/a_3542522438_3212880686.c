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
static const char *ng0 = "/home/brian/gfau/design/vhdl/io/ISE/serialize.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_13554554585326073636_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_3542522438_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(53, ng0);

LAB3:    t1 = (t0 + 2632U);
    t2 = *((char **)t1);
    t1 = (t0 + 4448);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 16U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 4352);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_3542522438_3212880686_p_1(char *t0)
{
    unsigned char t1;
    unsigned char t2;
    char *t3;
    unsigned char t4;
    char *t5;
    char *t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    unsigned char t10;
    unsigned char t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;

LAB0:    xsi_set_current_line(57, ng0);
    t3 = (t0 + 992U);
    t4 = ieee_p_2592010699_sub_13554554585326073636_503743352(IEEE_P_2592010699, t3, 0U, 0U);
    if (t4 == 1)
        goto LAB8;

LAB9:    t2 = (unsigned char)0;

LAB10:    if (t2 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:    t3 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_13554554585326073636_503743352(IEEE_P_2592010699, t3, 0U, 0U);
    if (t2 == 1)
        goto LAB40;

LAB41:    t1 = (unsigned char)0;

LAB42:    if (t1 != 0)
        goto LAB38;

LAB39:
LAB3:    t3 = (t0 + 4368);
    *((int *)t3) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(59, ng0);
    t5 = (t0 + 4512);
    t12 = (t5 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    *((unsigned char *)t15) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t5);
    xsi_set_current_line(60, ng0);
    t3 = (t0 + 1832U);
    t5 = *((char **)t3);
    t3 = (t0 + 6913);
    t1 = 1;
    if (2U == 2U)
        goto LAB14;

LAB15:    t1 = 0;

LAB16:    if (t1 != 0)
        goto LAB11;

LAB13:    xsi_set_current_line(83, ng0);
    t3 = (t0 + 1512U);
    t5 = *((char **)t3);
    t3 = (t0 + 4576);
    t6 = (t3 + 56U);
    t9 = *((char **)t6);
    t12 = (t9 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t5, 16U);
    xsi_driver_first_trans_fast(t3);
    xsi_set_current_line(84, ng0);
    t3 = (t0 + 4512);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t12 = *((char **)t9);
    *((unsigned char *)t12) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(85, ng0);
    t3 = (t0 + 4640);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t12 = *((char **)t9);
    *((unsigned char *)t12) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t3);

LAB12:    goto LAB3;

LAB5:    t5 = (t0 + 1352U);
    t9 = *((char **)t5);
    t10 = *((unsigned char *)t9);
    t11 = (t10 == (unsigned char)2);
    t1 = t11;
    goto LAB7;

LAB8:    t5 = (t0 + 1192U);
    t6 = *((char **)t5);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)3);
    t2 = t8;
    goto LAB10;

LAB11:    xsi_set_current_line(62, ng0);
    t13 = (t0 + 1992U);
    t14 = *((char **)t13);
    t13 = (t0 + 6915);
    t2 = 1;
    if (2U == 2U)
        goto LAB23;

LAB24:    t2 = 0;

LAB25:    if (t2 != 0)
        goto LAB20;

LAB22:    xsi_set_current_line(70, ng0);
    t3 = (t0 + 1672U);
    t5 = *((char **)t3);
    t3 = (t0 + 6917);
    t1 = 1;
    if (2U == 2U)
        goto LAB32;

LAB33:    t1 = 0;

LAB34:    if (t1 != 0)
        goto LAB29;

LAB31:    xsi_set_current_line(74, ng0);
    t3 = (t0 + 1512U);
    t5 = *((char **)t3);
    t16 = (15 - 15);
    t17 = (t16 * 1U);
    t22 = (0 + t17);
    t3 = (t5 + t22);
    t6 = (t0 + 4576);
    t9 = (t6 + 56U);
    t12 = *((char **)t9);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t3, 8U);
    xsi_driver_first_trans_delta(t6, 8U, 8U, 0LL);
    xsi_set_current_line(75, ng0);
    t3 = (t0 + 4512);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t12 = *((char **)t9);
    *((unsigned char *)t12) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(76, ng0);
    t3 = (t0 + 4640);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t12 = *((char **)t9);
    *((unsigned char *)t12) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t3);

LAB30:
LAB21:    goto LAB12;

LAB14:    t16 = 0;

LAB17:    if (t16 < 2U)
        goto LAB18;
    else
        goto LAB16;

LAB18:    t9 = (t5 + t16);
    t12 = (t3 + t16);
    if (*((unsigned char *)t9) != *((unsigned char *)t12))
        goto LAB15;

LAB19:    t16 = (t16 + 1);
    goto LAB17;

LAB20:    xsi_set_current_line(64, ng0);
    t20 = (t0 + 1512U);
    t21 = *((char **)t20);
    t22 = (15 - 7);
    t23 = (t22 * 1U);
    t24 = (0 + t23);
    t20 = (t21 + t24);
    t25 = (t0 + 4576);
    t26 = (t25 + 56U);
    t27 = *((char **)t26);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    memcpy(t29, t20, 8U);
    xsi_driver_first_trans_delta(t25, 8U, 8U, 0LL);
    xsi_set_current_line(65, ng0);
    t3 = (t0 + 4512);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t12 = *((char **)t9);
    *((unsigned char *)t12) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(66, ng0);
    t3 = (t0 + 4640);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t12 = *((char **)t9);
    *((unsigned char *)t12) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t3);
    goto LAB21;

LAB23:    t17 = 0;

LAB26:    if (t17 < 2U)
        goto LAB27;
    else
        goto LAB25;

LAB27:    t18 = (t14 + t17);
    t19 = (t13 + t17);
    if (*((unsigned char *)t18) != *((unsigned char *)t19))
        goto LAB24;

LAB28:    t17 = (t17 + 1);
    goto LAB26;

LAB29:    xsi_set_current_line(71, ng0);
    t13 = (t0 + 4512);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t18 = (t15 + 56U);
    t19 = *((char **)t18);
    *((unsigned char *)t19) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t13);
    xsi_set_current_line(72, ng0);
    t3 = (t0 + 1512U);
    t5 = *((char **)t3);
    t16 = (15 - 7);
    t17 = (t16 * 1U);
    t22 = (0 + t17);
    t3 = (t5 + t22);
    t6 = (t0 + 4576);
    t9 = (t6 + 56U);
    t12 = *((char **)t9);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t3, 8U);
    xsi_driver_first_trans_delta(t6, 8U, 8U, 0LL);
    goto LAB30;

LAB32:    t16 = 0;

LAB35:    if (t16 < 2U)
        goto LAB36;
    else
        goto LAB34;

LAB36:    t9 = (t5 + t16);
    t12 = (t3 + t16);
    if (*((unsigned char *)t9) != *((unsigned char *)t12))
        goto LAB33;

LAB37:    t16 = (t16 + 1);
    goto LAB35;

LAB38:    xsi_set_current_line(91, ng0);
    t5 = (t0 + 4512);
    t9 = (t5 + 56U);
    t12 = *((char **)t9);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    *((unsigned char *)t14) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t5);
    xsi_set_current_line(92, ng0);
    t3 = (t0 + 4640);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t12 = *((char **)t9);
    *((unsigned char *)t12) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t3);
    goto LAB3;

LAB40:    t5 = (t0 + 1352U);
    t6 = *((char **)t5);
    t4 = *((unsigned char *)t6);
    t7 = (t4 == (unsigned char)3);
    t1 = t7;
    goto LAB42;

}


extern void work_a_3542522438_3212880686_init()
{
	static char *pe[] = {(void *)work_a_3542522438_3212880686_p_0,(void *)work_a_3542522438_3212880686_p_1};
	xsi_register_didat("work_a_3542522438_3212880686", "isim/serialize_isim_beh.exe.sim/work/a_3542522438_3212880686.didat");
	xsi_register_executes(pe);
}
