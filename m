From: realmz paranoid <realmz6@gmail.com>
Subject: Re: [PATCH v4 21/36] Hexagon: Add SMP support
Date: Wed, 21 Sep 2011 10:10:27 +0800
Message-ID: <CAMk6uBmBqJsYSW+X9iY8Zc6BaC0jRy+a0CW0UV93gBAo98CzyA@mail.gmail.com>
References: <093448$3hstu8@wolverine01.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60784 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab1IUCKa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2011 22:10:30 -0400
In-Reply-To: <093448$3hstu8@wolverine01.qualcomm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Sep 15, 2011 at 2:19 AM, Richard Kuo <rkuo@codeaurora.org> wrot=
e:
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
> Signed-off-by: Linas Vepstas <linas@codeaurora.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> =C2=A0arch/hexagon/include/asm/smp.h | =C2=A0 44 +++++++
> =C2=A0arch/hexagon/kernel/smp.c =C2=A0 =C2=A0 =C2=A0| =C2=A0280 +++++=
+++++++++++++++++++++++++++++++++++
> =C2=A0arch/hexagon/kernel/topology.c | =C2=A0 52 ++++++++
> =C2=A03 files changed, 376 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 arch/hexagon/include/asm/smp.h
> =C2=A0create mode 100644 arch/hexagon/kernel/smp.c
> =C2=A0create mode 100644 arch/hexagon/kernel/topology.c
>
> diff --git a/arch/hexagon/include/asm/smp.h b/arch/hexagon/include/as=
m/smp.h
> new file mode 100644
> index 0000000..87c869a
> --- /dev/null
> +++ b/arch/hexagon/include/asm/smp.h
> @@ -0,0 +1,44 @@
> +/*
> + * SMP definitions for the Hexagon architecture
> + *
> + * Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 an=
d
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See th=
e
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + */
> +
> +#ifndef __ASM_SMP_H
> +#define __ASM_SMP_H
> +
> +#include <linux/cpumask.h>
> +
> +#define raw_smp_processor_id() (current_thread_info()->cpu)
> +
> +enum ipi_message_type {
> + =C2=A0 =C2=A0 =C2=A0 IPI_NOP =3D 0,
> + =C2=A0 =C2=A0 =C2=A0 IPI_RESCHEDULE =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 IPI_CALL_FUNC,
> + =C2=A0 =C2=A0 =C2=A0 IPI_CALL_FUNC_SINGLE,
> + =C2=A0 =C2=A0 =C2=A0 IPI_CPU_STOP,
> + =C2=A0 =C2=A0 =C2=A0 IPI_TIMER,
> +};
> +
> +extern void send_ipi(const struct cpumask *cpumask, enum ipi_message=
_type msg);
> +extern void smp_start_cpus(void);
> +extern void arch_send_call_function_single_ipi(int cpu);
> +extern void arch_send_call_function_ipi_mask(const struct cpumask *m=
ask);
> +
> +extern void smp_vm_unmask_irq(void *info);
> +
> +#endif
> diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
> new file mode 100644
> index 0000000..96bf6c2
> --- /dev/null
> +++ b/arch/hexagon/kernel/smp.c
> @@ -0,0 +1,280 @@
> +/*
> + * SMP support for Hexagon
> + *
> + * Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 an=
d
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See th=
e
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/percpu.h>
> +#include <linux/sched.h>
> +#include <linux/smp.h>
> +#include <linux/spinlock.h>
> +
> +#include <asm/system.h> =C2=A0/* =C2=A0xchg =C2=A0*/
> +#include <asm/time.h> =C2=A0 =C2=A0/* =C2=A0timer_interrupt =C2=A0*/
> +#include <asm/hexagon_vm.h>
> +
> +#define BASE_IPI_IRQ 26
> +
> +/*
> + * cpu_possible_map needs to be filled out prior to setup_per_cpu_ar=
eas
> + * (which is prior to any of our smp_prepare_cpu crap), in order to =
set
> + * up the... =C2=A0per_cpu areas.
> + */
> +
> +struct ipi_data {
> + =C2=A0 =C2=A0 =C2=A0 unsigned long bits;
> +};
> +
> +static DEFINE_PER_CPU(struct ipi_data, ipi_data);
> +
> +static inline void __handle_ipi(unsigned long *ops, struct ipi_data =
*ipi,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int cpu)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned long msg =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 do {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =3D find_next_=
bit(ops, BITS_PER_LONG, msg+1);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (msg) {
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPI_TIMER:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ipi_timer();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPI_CALL_FUNC=
:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 generic_smp_call_function_interrupt();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPI_CALL_FUNC=
_SINGLE:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 generic_smp_call_function_single_interrupt();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPI_CPU_STOP:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0* call vmstop()
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __vmstop();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPI_RESCHEDUL=
E:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0* need to revisit our exit path; see comments for
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0* scheduler_ipi()
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 scheduler_ipi();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 } while (msg < BITS_PER_LONG);
> +}
> +
> +/* =C2=A0Used for IPI call from other CPU's to unmask int =C2=A0*/
> +void smp_vm_unmask_irq(void *info)
> +{
> + =C2=A0 =C2=A0 =C2=A0 __vmintop_locen((long) info);
> +}
> +
> +
> +/*
> + * This is based on Alpha's IPI stuff.
> + * Supposed to take (int, void*) as args now.
> + * Specifically, first arg is irq, second is the irq_desc.
> + */
> +
> +irqreturn_t handle_ipi(int irq, void *desc)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int cpu =3D smp_processor_id();
> + =C2=A0 =C2=A0 =C2=A0 struct ipi_data *ipi =3D &per_cpu(ipi_data, cp=
u);
> + =C2=A0 =C2=A0 =C2=A0 unsigned long ops;
> +
> + =C2=A0 =C2=A0 =C2=A0 while ((ops =3D xchg(&ipi->bits, 0)) !=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __handle_ipi(&ops,=
 ipi, cpu);
> + =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;
> +}
> +
> +void send_ipi(const struct cpumask *cpumask, enum ipi_message_type m=
sg)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned long flags;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long cpu;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long retval;
> +
> + =C2=A0 =C2=A0 =C2=A0 local_irq_save(flags);
> +
> + =C2=A0 =C2=A0 =C2=A0 for_each_cpu(cpu, cpumask) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ipi_data *i=
pi =3D &per_cpu(ipi_data, cpu);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_bit(msg, &ipi-=
>bits);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =C2=A0Possible =
barrier here =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D __vmint=
op_post(BASE_IPI_IRQ+cpu);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (retval !=3D 0)=
 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 printk(KERN_ERR "interrupt %ld not configured?\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BASE_IPI_IRQ+cpu);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 local_irq_restore(flags);
> +}
> +
> +static struct irqaction ipi_intdesc =3D {
> + =C2=A0 =C2=A0 =C2=A0 .handler =3D handle_ipi,
> + =C2=A0 =C2=A0 =C2=A0 .flags =3D IRQF_DISABLED | IRQF_TRIGGER_RISING=
,
> + =C2=A0 =C2=A0 =C2=A0 .name =3D "ipi_handler"
> +};
> +
> +void __init smp_prepare_boot_cpu(void)
> +{
> +}
> +
> +/*
> + * interrupts should already be disabled from the VM
> + * SP should already be correct; need to set THREADINFO_REG
> + * to point to current thread info
> + */
> +
> +void __cpuinit start_secondary(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned int cpu;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long thread_ptr;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* =C2=A0Calculate thread_info pointer from st=
ack pointer =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 __asm__ __volatile__(
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "%0 =3D SP;\n"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : "=3Dr" (thread_p=
tr)
> + =C2=A0 =C2=A0 =C2=A0 );
> +
> + =C2=A0 =C2=A0 =C2=A0 thread_ptr =3D thread_ptr & ~(THREAD_SIZE-1);
> +
> + =C2=A0 =C2=A0 =C2=A0 __asm__ __volatile__(
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QUOTED_THREADINFO_=
REG " =3D %0;\n"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : "r" (thread_ptr)
> + =C2=A0 =C2=A0 =C2=A0 );
> +
> + =C2=A0 =C2=A0 =C2=A0 /* =C2=A0Set the memory struct =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 atomic_inc(&init_mm.mm_count);
> + =C2=A0 =C2=A0 =C2=A0 current->active_mm =3D &init_mm;
> +
> + =C2=A0 =C2=A0 =C2=A0 cpu =3D smp_processor_id();
> +
> + =C2=A0 =C2=A0 =C2=A0 setup_irq(BASE_IPI_IRQ + cpu, &ipi_intdesc);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* =C2=A0Register the clock_event dummy =C2=A0=
*/
> + =C2=A0 =C2=A0 =C2=A0 setup_percpu_clockdev();
> +
> + =C2=A0 =C2=A0 =C2=A0 printk(KERN_INFO "%s cpu %d\n", __func__, curr=
ent_thread_info()->cpu);
> +
> + =C2=A0 =C2=A0 =C2=A0 set_cpu_online(cpu, true);
> + =C2=A0 =C2=A0 =C2=A0 while (!cpumask_test_cpu(cpu, cpu_active_mask)=
)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_relax();
> + =C2=A0 =C2=A0 =C2=A0 local_irq_enable();
> +
> + =C2=A0 =C2=A0 =C2=A0 cpu_idle();
> +}
> +
> +
> +/*
> + * called once for each present cpu
> + * apparently starts up the CPU and then
> + * maintains control until "cpu_online(cpu)" is set.
> + */
> +
__cpu_up only called once?

> +int __cpuinit __cpu_up(unsigned int cpu)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct task_struct *idle;
> + =C2=A0 =C2=A0 =C2=A0 struct thread_info *thread;
> + =C2=A0 =C2=A0 =C2=A0 void *stack_start;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* =C2=A0Create new init task for the CPU =C2=A0=
*/
> + =C2=A0 =C2=A0 =C2=A0 idle =3D fork_idle(cpu);
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(idle))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 panic(KERN_ERR "fo=
rk_idle failed\n");
> +
> + =C2=A0 =C2=A0 =C2=A0 thread =3D (struct thread_info *)idle->stack;
> + =C2=A0 =C2=A0 =C2=A0 thread->cpu =3D cpu;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* =C2=A0Boot to the head. =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 stack_start =3D =C2=A0((void *) thread) + THRE=
AD_SIZE;
> + =C2=A0 =C2=A0 =C2=A0 __vmstart(start_secondary, stack_start);
> +
> + =C2=A0 =C2=A0 =C2=A0 while (!cpu_isset(cpu, cpu_online_map))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 barrier();
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +void __init smp_cpus_done(unsigned int max_cpus)
> +{
> +}
> +
> +void __init smp_prepare_cpus(unsigned int max_cpus)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int i;
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* should eventually have some sort of ma=
chine
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* descriptor that has this stuff
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> +
> + =C2=A0 =C2=A0 =C2=A0 /* =C2=A0Right now, let's just fake it. */
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < max_cpus; i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set(i, cpu_pre=
sent_map);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* =C2=A0Also need to register the interrupts =
for IPI =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 if (max_cpus > 1)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setup_irq(BASE_IPI=
_IRQ, &ipi_intdesc);
> +}
> +
> +void smp_send_reschedule(int cpu)
> +{
> + =C2=A0 =C2=A0 =C2=A0 send_ipi(cpumask_of(cpu), IPI_RESCHEDULE);
> +}
> +
> +void smp_send_stop(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct cpumask targets;
> + =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&targets, cpu_online_mask);
> + =C2=A0 =C2=A0 =C2=A0 cpumask_clear_cpu(smp_processor_id(), &targets=
);
> + =C2=A0 =C2=A0 =C2=A0 send_ipi(&targets, IPI_CPU_STOP);
> +}
> +
> +void arch_send_call_function_single_ipi(int cpu)
> +{
> + =C2=A0 =C2=A0 =C2=A0 send_ipi(cpumask_of(cpu), IPI_CALL_FUNC_SINGLE=
);
> +}
> +
> +void arch_send_call_function_ipi_mask(const struct cpumask *mask)
> +{
> + =C2=A0 =C2=A0 =C2=A0 send_ipi(mask, IPI_CALL_FUNC);
> +}
> +
> +int setup_profiling_timer(unsigned int multiplier)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> +}
> +
> +void smp_start_cpus(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int i;
> +
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < NR_CPUS; i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set(i, cpu_pos=
sible_map);
> +}
> diff --git a/arch/hexagon/kernel/topology.c b/arch/hexagon/kernel/top=
ology.c
> new file mode 100644
> index 0000000..ba44751
> --- /dev/null
> +++ b/arch/hexagon/kernel/topology.c
> @@ -0,0 +1,52 @@
> +/*
> + * CPU topology for Hexagon
> + *
> + * Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 an=
d
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See th=
e
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/init.h>
> +#include <linux/node.h>
> +#include <linux/nodemask.h>
> +#include <linux/percpu.h>
> +
> +/* =C2=A0Swiped from MIPS. =C2=A0*/
> +
> +static DEFINE_PER_CPU(struct cpu, cpu_devices);
> +
> +static int __init topology_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int i, ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 for_each_present_cpu(i) {
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* register_c=
pu takes a per_cpu pointer and
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* just point=
s it at another per_cpu struct...
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D register_c=
pu(&per_cpu(cpu_devices, i), i);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 printk(KERN_WARNING "topology_init: register_cpu %d "
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"failed (%d)\n", i, ret);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +subsys_initcall(topology_init);
> --
> 1.7.1
>
>
> --
>
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora F=
orum.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>
