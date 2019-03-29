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
static const char *ng0 = "C:/Users/CSLab/Desktop/4_alu/testbench.v";
static unsigned int ng1[] = {2048U, 0U};
static int ng2[] = {0, 0, 0, 0};



static void Initial_43_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;

LAB0:    t1 = (t0 + 2688U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(43, ng0);

LAB4:    xsi_set_current_line(45, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1448);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 12);
    xsi_set_current_line(46, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1608);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 64);
    xsi_set_current_line(47, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1768);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 64);
    xsi_set_current_line(50, ng0);
    t2 = (t0 + 2496);
    xsi_process_wait(t2, 100000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    goto LAB1;

}

static void Always_55_1(char *t0)
{
    char t3[8];
    char t5[16];
    char t23[16];
    char *t1;
    char *t2;
    char *t4;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    unsigned int t20;
    char *t21;
    unsigned int t22;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    char *t34;
    unsigned int t35;
    unsigned int t36;
    char *t37;
    unsigned int t38;
    char *t39;
    unsigned int t40;
    char *t41;

LAB0:    t1 = (t0 + 2936U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(55, ng0);
    t2 = (t0 + 2744);
    xsi_process_wait(t2, 100000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(55, ng0);
    *((int *)t3) = xsi_vlog_rtl_dist_uniform(0, 0, -2147483648, 2147483647);
    t4 = (t3 + 4);
    *((int *)t4) = 0;
    memcpy(t5, t3, 8);
    t6 = (t5 + 8);
    memset(t6, 0, 8);
    t9 = *((unsigned int *)t3);
    t10 = (t9 & 2147483648U);
    t7 = t10;
    t11 = (t3 + 4);
    t12 = *((unsigned int *)t11);
    t13 = (t12 & 2147483648U);
    t8 = t13;
    t14 = (t10 != 0);
    if (t14 == 1)
        goto LAB5;

LAB6:    t18 = (t13 != 0);
    if (t18 == 1)
        goto LAB7;

LAB8:    memcpy(t23, t5, 8);
    t24 = (t23 + 8);
    memset(t24, 0, 8);
    t27 = *((unsigned int *)t5);
    t28 = (t27 & 2147483648U);
    t25 = t28;
    t29 = (t5 + 4);
    t30 = *((unsigned int *)t29);
    t31 = (t30 & 2147483648U);
    t26 = t31;
    t32 = (t28 != 0);
    if (t32 == 1)
        goto LAB9;

LAB10:    t36 = (t31 != 0);
    if (t36 == 1)
        goto LAB11;

LAB12:    t41 = (t0 + 1608);
    xsi_vlogvar_assign_value(t41, t23, 0, 0, 64);
    goto LAB2;

LAB5:    t15 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t15 | 0U);
    t16 = (t5 + 8);
    t17 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t17 | 4294967295U);
    goto LAB6;

LAB7:    t19 = (t5 + 4);
    t20 = *((unsigned int *)t19);
    *((unsigned int *)t19) = (t20 | 0U);
    t21 = (t5 + 12);
    t22 = *((unsigned int *)t21);
    *((unsigned int *)t21) = (t22 | 4294967295U);
    goto LAB8;

LAB9:    t33 = *((unsigned int *)t23);
    *((unsigned int *)t23) = (t33 | 0U);
    t34 = (t23 + 8);
    t35 = *((unsigned int *)t34);
    *((unsigned int *)t34) = (t35 | 4294967295U);
    goto LAB10;

LAB11:    t37 = (t23 + 4);
    t38 = *((unsigned int *)t37);
    *((unsigned int *)t37) = (t38 | 0U);
    t39 = (t23 + 12);
    t40 = *((unsigned int *)t39);
    *((unsigned int *)t39) = (t40 | 4294967295U);
    goto LAB12;

}

static void Always_56_2(char *t0)
{
    char t3[8];
    char t5[16];
    char t23[16];
    char *t1;
    char *t2;
    char *t4;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    unsigned int t20;
    char *t21;
    unsigned int t22;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    char *t34;
    unsigned int t35;
    unsigned int t36;
    char *t37;
    unsigned int t38;
    char *t39;
    unsigned int t40;
    char *t41;

LAB0:    t1 = (t0 + 3184U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(56, ng0);
    t2 = (t0 + 2992);
    xsi_process_wait(t2, 100000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(56, ng0);
    *((int *)t3) = xsi_vlog_rtl_dist_uniform(0, 0, -2147483648, 2147483647);
    t4 = (t3 + 4);
    *((int *)t4) = 0;
    memcpy(t5, t3, 8);
    t6 = (t5 + 8);
    memset(t6, 0, 8);
    t9 = *((unsigned int *)t3);
    t10 = (t9 & 2147483648U);
    t7 = t10;
    t11 = (t3 + 4);
    t12 = *((unsigned int *)t11);
    t13 = (t12 & 2147483648U);
    t8 = t13;
    t14 = (t10 != 0);
    if (t14 == 1)
        goto LAB5;

LAB6:    t18 = (t13 != 0);
    if (t18 == 1)
        goto LAB7;

LAB8:    memcpy(t23, t5, 8);
    t24 = (t23 + 8);
    memset(t24, 0, 8);
    t27 = *((unsigned int *)t5);
    t28 = (t27 & 2147483648U);
    t25 = t28;
    t29 = (t5 + 4);
    t30 = *((unsigned int *)t29);
    t31 = (t30 & 2147483648U);
    t26 = t31;
    t32 = (t28 != 0);
    if (t32 == 1)
        goto LAB9;

LAB10:    t36 = (t31 != 0);
    if (t36 == 1)
        goto LAB11;

LAB12:    t41 = (t0 + 1768);
    xsi_vlogvar_assign_value(t41, t23, 0, 0, 64);
    goto LAB2;

LAB5:    t15 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t15 | 0U);
    t16 = (t5 + 8);
    t17 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t17 | 4294967295U);
    goto LAB6;

LAB7:    t19 = (t5 + 4);
    t20 = *((unsigned int *)t19);
    *((unsigned int *)t19) = (t20 | 0U);
    t21 = (t5 + 12);
    t22 = *((unsigned int *)t21);
    *((unsigned int *)t21) = (t22 | 4294967295U);
    goto LAB8;

LAB9:    t33 = *((unsigned int *)t23);
    *((unsigned int *)t23) = (t33 | 0U);
    t34 = (t23 + 8);
    t35 = *((unsigned int *)t34);
    *((unsigned int *)t34) = (t35 | 4294967295U);
    goto LAB10;

LAB11:    t37 = (t23 + 4);
    t38 = *((unsigned int *)t37);
    *((unsigned int *)t37) = (t38 | 0U);
    t39 = (t23 + 12);
    t40 = *((unsigned int *)t39);
    *((unsigned int *)t39) = (t40 | 4294967295U);
    goto LAB12;

}


extern void work_m_00000000000846301280_1949178628_init()
{
	static char *pe[] = {(void *)Initial_43_0,(void *)Always_55_1,(void *)Always_56_2};
	xsi_register_didat("work_m_00000000000846301280_1949178628", "isim/testbench_isim_beh.exe.sim/work/m_00000000000846301280_1949178628.didat");
	xsi_register_executes(pe);
}
