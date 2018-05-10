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

char *IEEE_P_1242562249;
char *IEEE_P_2592010699;
char *UNISIM_P_0947159679;
char *STD_STANDARD;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    unisim_p_0947159679_init();
    ieee_p_1242562249_init();
    work_a_1708250025_3212880686_init();
    work_a_3411958602_3212880686_init();
    work_a_3097487762_3212880686_init();
    work_a_0612732424_1181938964_init();
    work_a_3266411804_1181938964_init();
    work_a_1660540654_1181938964_init();
    work_a_3064411315_1181938964_init();
    work_a_3116802879_3212880686_init();
    work_a_3936581633_3212880686_init();
    work_a_4082526947_3212880686_init();
    work_a_3196746905_2372691052_init();


    xsi_register_tops("work_a_3196746905_2372691052");

    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    UNISIM_P_0947159679 = xsi_get_engine_memory("unisim_p_0947159679");
    STD_STANDARD = xsi_get_engine_memory("std_standard");

    return xsi_run_simulation(argc, argv);

}
