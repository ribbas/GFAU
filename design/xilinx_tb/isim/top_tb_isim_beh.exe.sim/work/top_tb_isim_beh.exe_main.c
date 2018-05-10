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

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_3499444699;
char *IEEE_P_1242562249;
char *IEEE_P_2592010699;
char *IEEE_P_3620187407;
char *STD_STANDARD;
char *UNISIM_P_0947159679;
char *WORK_P_0696720821;
char *IEEE_P_0017514958;
char *SYNOPSYS_P_3308480207;
char *WORK_P_1871661363;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_1242562249_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    work_p_0696720821_init();
    work_p_1871661363_init();
    synopsys_p_3308480207_init();
    ieee_p_0017514958_init();
    work_a_2350501171_3212880686_init();
    work_a_2917038937_3212880686_init();
    work_a_3659527332_3212880686_init();
    work_a_2410018453_3212880686_init();
    work_a_1728636091_3212880686_init();
    work_a_1217357384_2030911003_init();
    work_a_1389322585_3212880686_init();
    work_a_3609889693_3212880686_init();
    work_a_1026186521_3212880686_init();
    work_a_2737570607_3212880686_init();
    work_a_3879031440_3212880686_init();
    work_a_2831103491_3212880686_init();
    work_a_0594661914_3212880686_init();
    work_a_1649619629_3212880686_init();
    unisim_p_0947159679_init();
    work_a_1754715519_3212880686_init();
    work_a_2238304878_3212880686_init();
    work_a_2565316925_3212880686_init();
    work_a_3115858369_2372691052_init();


    xsi_register_tops("work_a_3115858369_2372691052");

    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    UNISIM_P_0947159679 = xsi_get_engine_memory("unisim_p_0947159679");
    WORK_P_0696720821 = xsi_get_engine_memory("work_p_0696720821");
    IEEE_P_0017514958 = xsi_get_engine_memory("ieee_p_0017514958");
    SYNOPSYS_P_3308480207 = xsi_get_engine_memory("synopsys_p_3308480207");
    WORK_P_1871661363 = xsi_get_engine_memory("work_p_1871661363");

    return xsi_run_simulation(argc, argv);

}
