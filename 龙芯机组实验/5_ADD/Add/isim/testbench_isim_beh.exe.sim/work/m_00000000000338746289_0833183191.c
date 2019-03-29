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

/* This file is designed for use with ISim build 0x1cce1bb2 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/CSLab/Documents/ADD/Add/adder.v";



static void Cont_16_0(char *t0)
{
    char t5[16];
    char t7[16];
    char t9[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t6;
    char *t8;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;

LAB0:    t1 = (t0 + 3008U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(16, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    t2 = (t0 + 1208U);
    t4 = *((char **)t2);
    xsi_vlog_unsigned_add(t5, 33, t3, 32, t4, 32);
    t2 = (t0 + 1368U);
    t6 = *((char **)t2);
    xsi_vlog_unsigned_add(t7, 33, t5, 33, t6, 32);
    t2 = (t0 + 1528U);
    t8 = *((char **)t2);
    xsi_vlog_unsigned_add(t9, 33, t7, 33, t8, 1);
    t2 = (t0 + 3472);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    xsi_vlog_bit_copy(t13, 0, t9, 0, 32);
    xsi_driver_vfirst_trans(t2, 0, 31);
    t14 = (t0 + 3408);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    xsi_vlog_bit_copy(t18, 0, t9, 32, 1);
    xsi_driver_vfirst_trans(t14, 0, 0);
    t19 = (t0 + 3328);
    *((int *)t19) = 1;

LAB1:    return;
}


extern void work_m_00000000000338746289_0833183191_init()
{
	static char *pe[] = {(void *)Cont_16_0};
	xsi_register_didat("work_m_00000000000338746289_0833183191", "isim/testbench_isim_beh.exe.sim/work/m_00000000000338746289_0833183191.didat");
	xsi_register_executes(pe);
}
