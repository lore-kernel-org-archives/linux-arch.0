From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v2 1/1] nds32: Power management for nds32
Date: Thu, 25 Oct 2018 18:14:22 +0800
Message-ID: <CAEbi=3fp0YJh9iJw+D0apTa6-Atio-sscu1KuQZ0qbB5ie6cNg@mail.gmail.com>
References: <cover.1540375392.git.nickhu@andestech.com> <8ce923ff55f75b764888fc82d97bc3b744858be1.1540375392.git.nickhu@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8ce923ff55f75b764888fc82d97bc3b744858be1.1540375392.git.nickhu@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nickhu <nickhu@andestech.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, rjw@rjwysocki.net, pavel@ucw.cz, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Zong Li <zong@andestech.com>, linux-pm@vger.kernel.org, alankao@andestech.com
List-Id: linux-arch.vger.kernel.org

Nick Hu <nickhu@andestech.com> =E6=96=BC 2018=E5=B9=B410=E6=9C=8824=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> There are three sleep states in nds32:
>         suspend to idle,
>         suspend to standby,
>         suspend to ram
>
> In suspend to ram, we use the 'standby' instruction to emulate
> power management device to hang the system util wakeup source
> send wakeup events to break the loop.
>
> First, we push the general purpose registers and system registers
> to stack. Second, we translate stack pointer to physical address
> and store to memory to save the stack pointer. Third, after write
> back and invalid the cache we hang in 'standby' intruction.
> When wakeup source trigger wake up events, the loop will be break
> and resume the system.
>
> Signed-off-by: Nick Hu <nickhu@andestech.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>  arch/nds32/Kconfig               |  10 +++
>  arch/nds32/include/asm/suspend.h |  11 +++
>  arch/nds32/kernel/Makefile       |   2 +-
>  arch/nds32/kernel/pm.c           |  79 +++++++++++++++++++
>  arch/nds32/kernel/sleep.S        | 129 +++++++++++++++++++++++++++++++
>  drivers/irqchip/irq-ativic32.c   |  31 ++++++++
>  6 files changed, 261 insertions(+), 1 deletion(-)
>  create mode 100644 arch/nds32/include/asm/suspend.h
>  create mode 100644 arch/nds32/kernel/pm.c
>  create mode 100644 arch/nds32/kernel/sleep.S
>
> diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
> index dd448d431f5a..8e2c5ac6acd1 100644
> --- a/arch/nds32/Kconfig
> +++ b/arch/nds32/Kconfig
> @@ -95,3 +95,13 @@ endmenu
>  menu "Kernel Features"
>  source "kernel/Kconfig.hz"
>  endmenu
> +
> +menu "Power management options"
> +config SYS_SUPPORTS_APM_EMULATION
> +       bool
> +
> +config ARCH_SUSPEND_POSSIBLE
> +       def_bool y
> +
> +source "kernel/power/Kconfig"
> +endmenu
> diff --git a/arch/nds32/include/asm/suspend.h b/arch/nds32/include/asm/su=
spend.h
> new file mode 100644
> index 000000000000..6ed2418af1ac
> --- /dev/null
> +++ b/arch/nds32/include/asm/suspend.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (C) 2008-2017 Andes Technology Corporation
> +
> +#ifndef __ASM_NDS32_SUSPEND_H
> +#define __ASM_NDS32_SUSPEND_H
> +
> +extern void suspend2ram(void);
> +extern void cpu_resume(void);
> +extern unsigned long wake_mask;
> +
> +#endif
> diff --git a/arch/nds32/kernel/Makefile b/arch/nds32/kernel/Makefile
> index f52bd2744f50..8d62f2ecb1ab 100644
> --- a/arch/nds32/kernel/Makefile
> +++ b/arch/nds32/kernel/Makefile
> @@ -16,7 +16,7 @@ obj-$(CONFIG_STACKTRACE)      +=3D stacktrace.o
>  obj-$(CONFIG_OF)               +=3D devtree.o
>  obj-$(CONFIG_CACHE_L2)         +=3D atl2c.o
>  obj-$(CONFIG_PERF_EVENTS) +=3D perf_event_cpu.o
> -
> +obj-$(CONFIG_PM)               +=3D pm.o sleep.o
>  extra-y :=3D head.o vmlinux.lds
>
>  obj-y                          +=3D vdso/
> diff --git a/arch/nds32/kernel/pm.c b/arch/nds32/kernel/pm.c
> new file mode 100644
> index 000000000000..6989560abf4e
> --- /dev/null
> +++ b/arch/nds32/kernel/pm.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2008-2017 Andes Technology Corporation
> +
> +#include <linux/init.h>
> +#include <linux/suspend.h>
> +#include <linux/device.h>
> +#include <linux/printk.h>
> +#include <linux/suspend.h>
> +#include <asm/suspend.h>
> +#include <nds32_intrinsic.h>
> +
> +unsigned int resume_addr;
> +unsigned int *phy_addr_sp_tmp;
> +
> +static void nds32_suspend2ram(void)
> +{
> +       pgd_t *pgdv;
> +       pud_t *pudv;
> +       pmd_t *pmdv;
> +       pte_t *ptev;
> +
> +       pgdv =3D (pgd_t *)__va((__nds32__mfsr(NDS32_SR_L1_PPTB) &
> +               L1_PPTB_mskBASE)) + pgd_index((unsigned int)cpu_resume);
> +
> +       pudv =3D pud_offset(pgdv, (unsigned int)cpu_resume);
> +       pmdv =3D pmd_offset(pudv, (unsigned int)cpu_resume);
> +       ptev =3D pte_offset_map(pmdv, (unsigned int)cpu_resume);
> +
> +       resume_addr =3D ((*ptev) & TLB_DATA_mskPPN)
> +                       | ((unsigned int)cpu_resume & 0x00000fff);
> +
> +       suspend2ram();
> +}
> +
> +static void nds32_suspend_cpu(void)
> +{
> +       while (!(__nds32__mfsr(NDS32_SR_INT_PEND) & wake_mask))
> +               __asm__ volatile ("standby no_wake_grant\n\t");
> +}
> +
> +static int nds32_pm_valid(suspend_state_t state)
> +{
> +       switch (state) {
> +       case PM_SUSPEND_ON:
> +       case PM_SUSPEND_STANDBY:
> +       case PM_SUSPEND_MEM:
> +               return 1;
> +       default:
> +               return 0;
> +       }
> +}
> +
> +static int nds32_pm_enter(suspend_state_t state)
> +{
> +       pr_debug("%s:state:%d\n", __func__, state);
> +       switch (state) {
> +       case PM_SUSPEND_STANDBY:
> +               nds32_suspend_cpu();
> +               return 0;
> +       case PM_SUSPEND_MEM:
> +               nds32_suspend2ram();
> +               return 0;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static const struct platform_suspend_ops nds32_pm_ops =3D {
> +       .valid =3D nds32_pm_valid,
> +       .enter =3D nds32_pm_enter,
> +};
> +
> +static int __init nds32_pm_init(void)
> +{
> +       pr_debug("Enter %s\n", __func__);
> +       suspend_set_ops(&nds32_pm_ops);
> +       return 0;
> +}
> +late_initcall(nds32_pm_init);
> diff --git a/arch/nds32/kernel/sleep.S b/arch/nds32/kernel/sleep.S
> new file mode 100644
> index 000000000000..60c64bfbc901
> --- /dev/null
> +++ b/arch/nds32/kernel/sleep.S
> @@ -0,0 +1,129 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2017 Andes Technology Corporation */
> +
> +#include <asm/memory.h>
> +
> +.data
> +.global sp_tmp
> +sp_tmp:
> +.long
> +
> +.text
> +.globl suspend2ram
> +.globl cpu_resume
> +
> +suspend2ram:
> +       pushm   $r0, $r31
> +#if defined(CONFIG_HWZOL)
> +       mfusr   $r0, $lc
> +       mfusr   $r1, $le
> +       mfusr   $r2, $lb
> +#endif
> +       mfsr    $r3, $mr0
> +       mfsr    $r4, $mr1
> +       mfsr    $r5, $mr4
> +       mfsr    $r6, $mr6
> +       mfsr    $r7, $mr7
> +       mfsr    $r8, $mr8
> +       mfsr    $r9, $ir0
> +       mfsr    $r10, $ir1
> +       mfsr    $r11, $ir2
> +       mfsr    $r12, $ir3
> +       mfsr    $r13, $ir9
> +       mfsr    $r14, $ir10
> +       mfsr    $r15, $ir12
> +       mfsr    $r16, $ir13
> +       mfsr    $r17, $ir14
> +       mfsr    $r18, $ir15
> +       pushm   $r0, $r19
> +
> +       tlbop   FlushAll
> +       isb
> +
> +       // transfer $sp from va to pa
> +       sethi   $r0, hi20(PAGE_OFFSET)
> +       ori     $r0, $r0, lo12(PAGE_OFFSET)
> +       movi    $r2, PHYS_OFFSET
> +       sub     $r1, $sp, $r0
> +       add     $r2, $r1, $r2
> +
> +       // store pa($sp) to sp_tmp
> +       sethi   $r1, hi20(sp_tmp)
> +       swi     $r2, [$r1 + lo12(sp_tmp)]
> +
> +       pushm   $r16, $r25
> +       pushm   $r29, $r30
> +#ifdef CONFIG_CACHE_L2
> +       jal     dcache_wb_all_level
> +#else
> +       jal     cpu_dcache_wb_all
> +#endif
> +       popm    $r29, $r30
> +       popm    $r16, $r25
> +
> +       // get wake_mask and loop in standby
> +       la      $r1, wake_mask
> +       lwi     $r1, [$r1]
> +self_loop:
> +       standby wake_grant
> +       mfsr    $r2, $ir15
> +       and     $r2, $r1, $r2
> +       beqz    $r2, self_loop
> +
> +       // set ipc to resume address
> +       la      $r1, resume_addr
> +       lwi     $r1, [$r1]
> +       mtsr    $r1, $ipc
> +       isb
> +
> +       // reset psw, turn off the address translation
> +       li      $r2, 0x7000a
> +       mtsr    $r2, $ipsw
> +       isb
> +
> +       iret
> +cpu_resume:
> +       // translate the address of sp_tmp variable to pa
> +       la      $r1, sp_tmp
> +       sethi   $r0, hi20(PAGE_OFFSET)
> +       ori     $r0, $r0, lo12(PAGE_OFFSET)
> +       movi    $r2, PHYS_OFFSET
> +       sub     $r1, $r1, $r0
> +       add     $r1, $r1, $r2
> +
> +       // access the sp_tmp to get stack pointer
> +       lwi     $sp, [$r1]
> +
> +       popm    $r0, $r19
> +#if defined(CONFIG_HWZOL)
> +       mtusr   $r0, $lb
> +       mtusr   $r1, $lc
> +       mtusr   $r2, $le
> +#endif
> +       mtsr    $r3, $mr0
> +       mtsr    $r4, $mr1
> +       mtsr    $r5, $mr4
> +       mtsr    $r6, $mr6
> +       mtsr    $r7, $mr7
> +       mtsr    $r8, $mr8
> +       // set original psw to ipsw
> +       mtsr    $r9, $ir1
> +
> +       mtsr    $r11, $ir2
> +       mtsr    $r12, $ir3
> +
> +       // set ipc to RR
> +       la      $r13, RR
> +       mtsr    $r13, $ir9
> +
> +       mtsr    $r14, $ir10
> +       mtsr    $r15, $ir12
> +       mtsr    $r16, $ir13
> +       mtsr    $r17, $ir14
> +       mtsr    $r18, $ir15
> +       popm    $r0, $r31
> +
> +       isb
> +       iret
> +RR:
> +       ret
> diff --git a/drivers/irqchip/irq-ativic32.c b/drivers/irqchip/irq-ativic3=
2.c
> index f69a8588521c..85cf6e0e0e52 100644
> --- a/drivers/irqchip/irq-ativic32.c
> +++ b/drivers/irqchip/irq-ativic32.c
> @@ -10,6 +10,8 @@
>  #include <linux/irqchip.h>
>  #include <nds32_intrinsic.h>
>
> +unsigned long wake_mask;
> +
>  static void ativic32_ack_irq(struct irq_data *data)
>  {
>         __nds32__mtsr_dsb(BIT(data->hwirq), NDS32_SR_INT_PEND2);
> @@ -27,11 +29,40 @@ static void ativic32_unmask_irq(struct irq_data *data=
)
>         __nds32__mtsr_dsb(int_mask2 | (BIT(data->hwirq)), NDS32_SR_INT_MA=
SK2);
>  }
>
> +static int nointc_set_wake(struct irq_data *data, unsigned int on)
> +{
> +       unsigned long int_mask =3D __nds32__mfsr(NDS32_SR_INT_MASK);
> +       static unsigned long irq_orig_bit;
> +       u32 bit =3D 1 << data->hwirq;
> +
> +       if (on) {
> +               if (int_mask & bit)
> +                       __assign_bit(data->hwirq, &irq_orig_bit, true);
> +               else
> +                       __assign_bit(data->hwirq, &irq_orig_bit, false);
> +
> +               __assign_bit(data->hwirq, &int_mask, true);
> +               __assign_bit(data->hwirq, &wake_mask, true);
> +
> +       } else {
> +               if (!(irq_orig_bit & bit))
> +                       __assign_bit(data->hwirq, &int_mask, false);
> +
> +               __assign_bit(data->hwirq, &wake_mask, false);
> +               __assign_bit(data->hwirq, &irq_orig_bit, false);
> +       }
> +
> +       __nds32__mtsr_dsb(int_mask, NDS32_SR_INT_MASK);
> +
> +       return 0;
> +}
> +
>  static struct irq_chip ativic32_chip =3D {
>         .name =3D "ativic32",
>         .irq_ack =3D ativic32_ack_irq,
>         .irq_mask =3D ativic32_mask_irq,
>         .irq_unmask =3D ativic32_unmask_irq,
> +       .irq_set_wake =3D nointc_set_wake,
>  };
>
>  static unsigned int __initdata nivic_map[6] =3D { 6, 2, 10, 16, 24, 32 }=
;
Hi Nick,

Thank you.
Acked-by: Greentime Hu <greentime@andestech.com>
