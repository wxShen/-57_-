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



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000000107067897_2351635246_init();
    work_m_00000000000315175229_1119861224_init();
    work_m_00000000003717066445_0833183191_init();
    work_m_00000000001076515311_2725559894_init();
    work_m_00000000001804102596_2809259415_init();
    work_m_00000000003972020753_2523189691_init();
    work_m_00000000001042698105_1774216237_init();
    work_m_00000000002436710154_4059336135_init();
    xilinxcorelib_ver_m_00000000001358910285_0503051228_init();
    xilinxcorelib_ver_m_00000000001687936702_3555156003_init();
    xilinxcorelib_ver_m_00000000000277421008_3379498321_init();
    xilinxcorelib_ver_m_00000000002856723387_2334657535_init();
    work_m_00000000002489990758_1397843898_init();
    work_m_00000000000621465885_1621107508_init();
    xilinxcorelib_ver_m_00000000001268786500_2959423745_init();
    xilinxcorelib_ver_m_00000000002856723387_1343695797_init();
    work_m_00000000003289761879_0362415942_init();
    work_m_00000000002607855829_3331168678_init();
    work_m_00000000001751514058_3671711236_init();
    work_m_00000000004093713498_2073120511_init();


    xsi_register_tops("work_m_00000000001751514058_3671711236");
    xsi_register_tops("work_m_00000000004093713498_2073120511");


    return xsi_run_simulation(argc, argv);

}
