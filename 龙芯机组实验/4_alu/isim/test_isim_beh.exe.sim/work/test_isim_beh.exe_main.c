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
    work_m_00000000003717066445_0833183191_init();
    work_m_00000000001076515311_2725559894_init();
    work_m_00000000002681960717_2244835778_init();
    work_m_00000000002326621365_3727679599_init();
    work_m_00000000004066045981_1985558087_init();
    work_m_00000000004093713498_2073120511_init();


    xsi_register_tops("work_m_00000000004066045981_1985558087");
    xsi_register_tops("work_m_00000000004093713498_2073120511");


    return xsi_run_simulation(argc, argv);

}
