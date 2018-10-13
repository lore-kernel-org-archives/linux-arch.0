From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V8 16/21] csky: SMP support
Date: Sat, 13 Oct 2018 14:10:03 +0800
Message-ID: <20181013060901.GA633@guoren-Inspiron-7460>
References: <cover.1539315390.git.ren_guo@c-sky.com>
 <608ece7942caa7c4b677b3cedd699e1a85b39d0f.1539315391.git.ren_guo@c-sky.com>
 <50781e74-e19b-e0e0-8ce5-d906878e249d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50781e74-e19b-e0e0-8ce5-d906878e249d@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, hch@infradead.org, mark.rutland@arm.com, peterz@infradead.org, robh@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, c-sky_gcc_upstream@c-sky.com
List-Id: linux-arch.vger.kernel.org

Hi Marc,
Thx for the review.

On Fri, Oct 12, 2018 at 12:09:52PM +0100, Marc Zyngier wrote:
> On 12/10/18 05:42, Guo Ren wrote:
> > This patch adds boot, ipi, hotplug code for SMP.

> > +static struct {
> > +	unsigned long bits ____cacheline_aligned;
> > +} ipi_data[NR_CPUS] __cacheline_aligned;
> 
> Why isn't this a per-cpu variable?
Ok, use per-cpu.


> > +void *__cpu_up_stack_pointer[NR_CPUS];
> > +void *__cpu_up_task_pointer[NR_CPUS];
> 
> Why aren't these per-cpu variables? More importantly, what are they used
> for? None of the patches in this series are using them.
No use at all, remove them :-P

> > +void __init enable_smp_ipi(void)
> > +{
> > +	enable_percpu_irq(ipi_irq, 0);
> > +}
> 
> Why isn't this function static?
Ok, static. and remove the declaration in asm/smp.h

> > +volatile unsigned int secondary_hint;
> > +volatile unsigned int secondary_ccr;
> > +volatile unsigned int secondary_stack;
> 
> This looks pretty dodgy.
It's not dodgy. They are used to pass hint,ccr,sp regs value for
seconardy CPU in smp.c:csky_start_secondary().

> Shouldn't you be using READ_ONCE/WRITE_ONCE instead?
The most problem is all other CPUs is in reset state not running and
CIU just fake signal for MESI. So we must flush all data into the
DRAM/L2cache. When secondary CPUs bootup from reset, they could see
right value in RAM.

So barrier is no use at all, we must flush dcache here and I'll add a
comment for explain.

Here is my modification with your feedback:

diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 5ea9516..36ebaf9 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -22,9 +22,10 @@
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
 
-static struct {
+struct ipi_data_struct {
 	unsigned long bits ____cacheline_aligned;
-} ipi_data[NR_CPUS] __cacheline_aligned;
+};
+static DEFINE_PER_CPU(struct ipi_data_struct, ipi_data);
 
 enum ipi_message_type {
 	IPI_EMPTY,
@@ -35,12 +36,10 @@ enum ipi_message_type {
 
 static irqreturn_t handle_ipi(int irq, void *dev)
 {
-	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
-
 	while (true) {
 		unsigned long ops;
 
-		ops = xchg(pending_ipis, 0);
+		ops = xchg(&this_cpu_ptr(&ipi_data)->bits, 0);
 		if (ops == 0)
 			return IRQ_HANDLED;
 
@@ -74,7 +73,7 @@ send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
 	int i;
 
 	for_each_cpu(i, to_whom)
-		set_bit(operation, &ipi_data[i].bits);
+		set_bit(operation, &per_cpu_ptr(&ipi_data, i)->bits);
 
 	smp_mb();
 	send_arch_ipi(to_whom);
@@ -105,9 +104,6 @@ void smp_send_reschedule(int cpu)
 	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
 }
 
-void *__cpu_up_stack_pointer[NR_CPUS];
-void *__cpu_up_task_pointer[NR_CPUS];
-
 void __init smp_prepare_boot_cpu(void)
 {
 }
@@ -116,7 +112,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 }
 
-void __init enable_smp_ipi(void)
+static void __init enable_smp_ipi(void)
 {
 	enable_percpu_irq(ipi_irq, 0);
 }
@@ -173,7 +169,11 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 
 	secondary_ccr  = mfcr("cr18");
 
-	/* Flush dcache */
+	/*
+	 * Because other CPUs are in reset status, we must flush data
+	 * from cache to out and secondary CPUs use them in
+	 * csky_start_secondary(void)
+	 */
 	mtcr("cr17", 0x22);
 
 	/* Enable cpu in SMP reset ctrl reg */

Best Regards
 Guo Ren
