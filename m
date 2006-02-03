Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:25559 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932137AbWBCJUD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2006 04:20:03 -0500
Date: Fri, 3 Feb 2006 01:17:48 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: percpu data changes
Message-Id: <20060203011748.6fe3fee3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Mikael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>, Kyle McMartin <kyle@parisc-linux.org>, Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@muc.de>, Christian Zankel <chris@zankel.net>, Philippe Elie <phil.el@wanadoo.fr>, Nathan Scott <nathans@sgi.com>, Jens Axboe <axboe@suse.de>
Cc: linux-arch@vger.kernel.org, Eric Dumazet <dada1@cosmosbay.com>
List-ID: <linux-arch.vger.kernel.org>


It seems that powerpc has gone and changed their implementation of percpu
data so that there is no memory allocated for not-possible CPUs.  To save a
bit of RAM.

This means that any code which does

	for (i = 0; i < NR_CPUS; i++)
		touch(percpudata(i))

will explode on powerpc.

I have a patch queued up (for 2.6.16) which fixes most users of percpu
data.  Make them use for_each_cpu().  I'll send that in a moment.

I also have a patch queued up (from Eric Dumazet) which will convert
architectures which use asm-generic/percpu.h to not allocate memory for
!possible CPUs.  I don't intend to merge this until after 2.6.16.  Once
this is merged, code which _does_ touch percpu data for !possible CPUs will
explode.

As part of this I've just done a kernel-wide sweep for all instances of
NR_CPUS.  I don't _think_ I found any percpu bugs such as the above, but
sometimes it's not clear.

While I was there I did a general cleanup of quite a lot of open-coded
cruft, make it use the nice macros.



So please review the below post-2.6.16 patch with an eye to the following:

- Any stuff you don't want added to your arch

- Any code which _does_ affect percpu data and which might possibly be
  used on powerpc.  Such changes will need to go into 2.6.16.

Thanks.



From: Andrew Morton <akpm@osdl.org>

When we stop allocating percpu memory for not-possible CPUs we must not touch
the percpu data for not-possible CPUs at all.  The correct way of doing this
is to test cpu_possible() or to use for_each_cpu().

This patch is a kernel-wide sweep of all instances of NR_CPUS.  I found very
few instances of this bug, if any.  But the patch converts lots of open-coded
test to use the preferred helper macros.

Cc: Mikael Starvik <starvik@axis.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kyle McMartin <kyle@parisc-linux.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: William Lee Irwin III <wli@holomorphy.com>
Cc: Andi Kleen <ak@muc.de>
Cc: Christian Zankel <chris@zankel.net>
Cc: Philippe Elie <phil.el@wanadoo.fr>
Cc: Nathan Scott <nathans@sgi.com>
Cc: Jens Axboe <axboe@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/cris/kernel/irq.c                     |   10 ++----
 arch/frv/kernel/irq.c                      |   10 ++----
 arch/i386/kernel/cpu/cpufreq/powernow-k8.c |    4 --
 arch/i386/kernel/io_apic.c                 |   22 +++++--------
 arch/i386/kernel/nmi.c                     |    4 +-
 arch/i386/oprofile/nmi_int.c               |    7 +---
 arch/m32r/kernel/irq.c                     |   10 ++----
 arch/mips/kernel/irq.c                     |   10 ++----
 arch/mips/kernel/smp.c                     |    4 +-
 arch/mips/sgi-ip27/ip27-irq.c              |    5 ---
 arch/parisc/kernel/smp.c                   |   25 ++++++---------
 arch/powerpc/kernel/irq.c                  |    5 +--
 arch/powerpc/kernel/setup-common.c         |    5 +--
 arch/powerpc/kernel/setup_32.c             |    5 +--
 arch/powerpc/platforms/powermac/smp.c      |    4 --
 arch/ppc/kernel/setup.c                    |   10 ++----
 arch/s390/kernel/smp.c                     |    4 --
 arch/sh/kernel/irq.c                       |    5 +--
 arch/sh/kernel/setup.c                     |    5 +--
 arch/sh64/kernel/irq.c                     |    5 +--
 arch/sparc/kernel/irq.c                    |    5 +--
 arch/sparc/kernel/smp.c                    |   24 ++++++---------
 arch/sparc/kernel/sun4d_irq.c              |    8 +----
 arch/sparc/kernel/sun4d_smp.c              |    8 +----
 arch/sparc/kernel/sun4m_smp.c              |    6 +--
 arch/sparc64/kernel/irq.c                  |    4 --
 arch/sparc64/kernel/setup.c                |   15 +++------
 arch/sparc64/kernel/smp.c                  |   30 +++++++------------
 arch/x86_64/kernel/irq.c                   |   21 +++++--------
 arch/x86_64/kernel/nmi.c                   |    6 +--
 arch/xtensa/kernel/irq.c                   |   15 +++------
 drivers/net/loopback.c                     |    4 --
 drivers/oprofile/cpu_buffer.c              |    3 -
 fs/xfs/linux-2.6/xfs_stats.c               |    7 +---
 fs/xfs/linux-2.6/xfs_sysctl.c              |    3 -
 include/asm-alpha/mmu_context.h            |    5 +--
 include/asm-alpha/topology.h               |    4 +-
 include/asm-generic/percpu.h               |    7 +---
 include/asm-powerpc/percpu.h               |    7 +---
 include/asm-s390/percpu.h                  |    7 +---
 include/asm-sparc64/percpu.h               |    7 +---
 include/asm-x86_64/percpu.h                |    7 +---
 include/linux/genhd.h                      |   14 ++------
 43 files changed, 144 insertions(+), 232 deletions(-)

diff -puN arch/cris/kernel/irq.c~more-for_each_cpu-conversions arch/cris/kernel/irq.c
--- devel/arch/cris/kernel/irq.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/cris/kernel/irq.c	2006-02-03 01:00:28.000000000 -0800
@@ -52,9 +52,8 @@ int show_interrupts(struct seq_file *p, 
 
 	if (i == 0) {
 		seq_printf(p, "           ");
-		for (j=0; j<NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "CPU%d       ",j);
+		for_each_online_cpu(j)
+			seq_printf(p, "CPU%d       ",j);
 		seq_putc(p, '\n');
 	}
 
@@ -67,9 +66,8 @@ int show_interrupts(struct seq_file *p, 
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
 		seq_printf(p, "  %s", action->name);
diff -puN arch/frv/kernel/irq.c~more-for_each_cpu-conversions arch/frv/kernel/irq.c
--- devel/arch/frv/kernel/irq.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/frv/kernel/irq.c	2006-02-03 01:00:28.000000000 -0800
@@ -75,9 +75,8 @@ int show_interrupts(struct seq_file *p, 
 	switch (i) {
 	case 0:
 		seq_printf(p, "           ");
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "CPU%d       ",j);
+		for_each_online_cpu(j)
+			seq_printf(p, "CPU%d       ",j);
 
 		seq_putc(p, '\n');
 		break;
@@ -100,9 +99,8 @@ int show_interrupts(struct seq_file *p, 
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i - 1]);
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i - 1]);
 #endif
 
 		level = group->sources[ix]->level - frv_irq_levels;
diff -puN arch/i386/kernel/cpu/cpufreq/powernow-k8.c~more-for_each_cpu-conversions arch/i386/kernel/cpu/cpufreq/powernow-k8.c
--- devel/arch/i386/kernel/cpu/cpufreq/powernow-k8.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2006-02-03 01:00:28.000000000 -0800
@@ -1145,9 +1145,7 @@ static int __cpuinit powernowk8_init(voi
 {
 	unsigned int i, supported_cpus = 0;
 
-	for (i=0; i<NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
+	for_each_cpu(i) {
 		if (check_supported_cpu(i))
 			supported_cpus++;
 	}
diff -puN arch/i386/kernel/io_apic.c~more-for_each_cpu-conversions arch/i386/kernel/io_apic.c
--- devel/arch/i386/kernel/io_apic.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/i386/kernel/io_apic.c	2006-02-03 01:00:28.000000000 -0800
@@ -349,8 +349,8 @@ static inline void rotate_irqs_among_cpu
 {
 	int i, j;
 	Dprintk("Rotating IRQs among CPUs.\n");
-	for (i = 0; i < NR_CPUS; i++) {
-		for (j = 0; cpu_online(i) && (j < NR_IRQS); j++) {
+	for_each_online_cpu(i) {
+		for (j = 0; j < NR_IRQS; j++) {
 			if (!irq_desc[j].action)
 				continue;
 			/* Is it a significant load ?  */
@@ -379,7 +379,7 @@ static void do_irq_balance(void)
 	unsigned long imbalance = 0;
 	cpumask_t allowed_mask, target_cpu_mask, tmp;
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		int package_index;
 		CPU_IRQ(i) = 0;
 		if (!cpu_online(i))
@@ -420,9 +420,7 @@ static void do_irq_balance(void)
 		}
 	}
 	/* Find the least loaded processor package */
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
+	for_each_online_cpu(i) {
 		if (i != CPU_TO_PACKAGEINDEX(i))
 			continue;
 		if (min_cpu_irq > CPU_IRQ(i)) {
@@ -439,9 +437,7 @@ tryanothercpu:
 	 */
 	tmp_cpu_irq = 0;
 	tmp_loaded = -1;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
+	for_each_online_cpu(i) {
 		if (i != CPU_TO_PACKAGEINDEX(i))
 			continue;
 		if (max_cpu_irq <= CPU_IRQ(i)) 
@@ -617,9 +613,7 @@ static int __init balanced_irq_init(void
 	if (smp_num_siblings > 1 && !cpus_empty(tmp))
 		physical_balance = 1;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
+	for_each_online_cpu(i) {
 		irq_cpu_data[i].irq_delta = kmalloc(sizeof(unsigned long) * NR_IRQS, GFP_KERNEL);
 		irq_cpu_data[i].last_irq = kmalloc(sizeof(unsigned long) * NR_IRQS, GFP_KERNEL);
 		if (irq_cpu_data[i].irq_delta == NULL || irq_cpu_data[i].last_irq == NULL) {
@@ -636,9 +630,11 @@ static int __init balanced_irq_init(void
 	else 
 		printk(KERN_ERR "balanced_irq_init: failed to spawn balanced_irq");
 failed:
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		kfree(irq_cpu_data[i].irq_delta);
+		irq_cpu_data[i].irq_delta = NULL;
 		kfree(irq_cpu_data[i].last_irq);
+		irq_cpu_data[i].last_irq = NULL;
 	}
 	return 0;
 }
diff -puN arch/i386/kernel/nmi.c~more-for_each_cpu-conversions arch/i386/kernel/nmi.c
--- devel/arch/i386/kernel/nmi.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/i386/kernel/nmi.c	2006-02-03 01:00:28.000000000 -0800
@@ -143,7 +143,7 @@ static int __init check_nmi_watchdog(voi
 	local_irq_enable();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+	for_each_cpu(cpu) {
 #ifdef CONFIG_SMP
 		/* Check cpu_callin_map here because that is set
 		   after the timer is started. */
@@ -510,7 +510,7 @@ void touch_nmi_watchdog (void)
 	 * Just reset the alert counters, (other CPUs might be
 	 * spinning on locks we hold):
 	 */
-	for (i = 0; i < NR_CPUS; i++)
+	for_each_cpu(i)
 		alert_counter[i] = 0;
 
 	/*
diff -puN arch/i386/oprofile/nmi_int.c~more-for_each_cpu-conversions arch/i386/oprofile/nmi_int.c
--- devel/arch/i386/oprofile/nmi_int.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/i386/oprofile/nmi_int.c	2006-02-03 01:00:28.000000000 -0800
@@ -122,7 +122,7 @@ static void nmi_save_registers(void * du
 static void free_msrs(void)
 {
 	int i;
-	for (i = 0; i < NR_CPUS; ++i) {
+	for_each_cpu(i) {
 		kfree(cpu_msrs[i].counters);
 		cpu_msrs[i].counters = NULL;
 		kfree(cpu_msrs[i].controls);
@@ -138,10 +138,7 @@ static int allocate_msrs(void)
 	size_t counters_size = sizeof(struct op_msr) * model->num_counters;
 
 	int i;
-	for (i = 0; i < NR_CPUS; ++i) {
-		if (!cpu_online(i))
-			continue;
-
+	for_each_online_cpu(i) {
 		cpu_msrs[i].counters = kmalloc(counters_size, GFP_KERNEL);
 		if (!cpu_msrs[i].counters) {
 			success = 0;
diff -puN arch/m32r/kernel/irq.c~more-for_each_cpu-conversions arch/m32r/kernel/irq.c
--- devel/arch/m32r/kernel/irq.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/m32r/kernel/irq.c	2006-02-03 01:00:28.000000000 -0800
@@ -37,9 +37,8 @@ int show_interrupts(struct seq_file *p, 
 
 	if (i == 0) {
 		seq_printf(p, "           ");
-		for (j=0; j<NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "CPU%d       ",j);
+		for_each_online_cpu(j)
+			seq_printf(p, "CPU%d       ",j);
 		seq_putc(p, '\n');
 	}
 
@@ -52,9 +51,8 @@ int show_interrupts(struct seq_file *p, 
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
 		seq_printf(p, "  %s", action->name);
diff -puN arch/mips/kernel/irq.c~more-for_each_cpu-conversions arch/mips/kernel/irq.c
--- devel/arch/mips/kernel/irq.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/mips/kernel/irq.c	2006-02-03 01:00:28.000000000 -0800
@@ -68,9 +68,8 @@ int show_interrupts(struct seq_file *p, 
 
 	if (i == 0) {
 		seq_printf(p, "           ");
-		for (j=0; j<NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "CPU%d       ",j);
+		for_each_online_cpu(j)
+			seq_printf(p, "CPU%d       ",j);
 		seq_putc(p, '\n');
 	}
 
@@ -83,9 +82,8 @@ int show_interrupts(struct seq_file *p, 
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
 		seq_printf(p, "  %s", action->name);
diff -puN arch/mips/kernel/smp.c~more-for_each_cpu-conversions arch/mips/kernel/smp.c
--- devel/arch/mips/kernel/smp.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/mips/kernel/smp.c	2006-02-03 01:00:28.000000000 -0800
@@ -166,8 +166,8 @@ int smp_call_function (void (*func) (voi
 	mb();
 
 	/* Send a message to all other CPUs and wait for them to respond */
-	for (i = 0; i < NR_CPUS; i++)
-		if (cpu_online(i) && i != cpu)
+	for_each_online_cpu(i)
+		if (i != cpu)
 			core_send_ipi(i, SMP_CALL_FUNCTION);
 
 	/* Wait for response */
diff -puN arch/mips/sgi-ip27/ip27-irq.c~more-for_each_cpu-conversions arch/mips/sgi-ip27/ip27-irq.c
--- devel/arch/mips/sgi-ip27/ip27-irq.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/mips/sgi-ip27/ip27-irq.c	2006-02-03 01:00:28.000000000 -0800
@@ -88,12 +88,9 @@ static inline int find_level(cpuid_t *cp
 {
 	int cpu, i;
 
-	for (cpu = 0; cpu <= NR_CPUS; cpu++) {
+	for_each_online_cpu(cpu) {
 		struct slice_data *si = cpu_data[cpu].data;
 
-		if (!cpu_online(cpu))
-			continue;
-
 		for (i = BASE_PCI_IRQ; i < LEVELS_PER_SLICE; i++)
 			if (si->level_to_irq[i] == irq) {
 				*cpunum = cpu;
diff -puN arch/parisc/kernel/smp.c~more-for_each_cpu-conversions arch/parisc/kernel/smp.c
--- devel/arch/parisc/kernel/smp.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/parisc/kernel/smp.c	2006-02-03 01:00:28.000000000 -0800
@@ -298,8 +298,8 @@ send_IPI_allbutself(enum ipi_message_typ
 {
 	int i;
 	
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_online(i) && i != smp_processor_id())
+	for_each_online_cpu(i) {
+		if (i != smp_processor_id())
 			send_IPI_single(i, op);
 	}
 }
@@ -643,14 +643,13 @@ int sys_cpus(int argc, char **argv)
 	if ( argc == 1 ){
 	
 #ifdef DUMP_MORE_STATE
-		for(i=0; i<NR_CPUS; i++) {
+		for_each_online_cpu(i) {
 			int cpus_per_line = 4;
-			if(cpu_online(i)) {
-				if (j++ % cpus_per_line)
-					printk(" %3d",i);
-				else
-					printk("\n %3d",i);
-			}
+
+			if (j++ % cpus_per_line)
+				printk(" %3d",i);
+			else
+				printk("\n %3d",i);
 		}
 		printk("\n"); 
 #else
@@ -659,9 +658,7 @@ int sys_cpus(int argc, char **argv)
 	} else if((argc==2) && !(strcmp(argv[1],"-l"))) {
 		printk("\nCPUSTATE  TASK CPUNUM CPUID HARDCPU(HPA)\n");
 #ifdef DUMP_MORE_STATE
-		for(i=0;i<NR_CPUS;i++) {
-			if (!cpu_online(i))
-				continue;
+		for_each_online_cpu(i) {
 			if (cpu_data[i].cpuid != NO_PROC_ID) {
 				switch(cpu_data[i].state) {
 					case STATE_RENDEZVOUS:
@@ -695,9 +692,7 @@ int sys_cpus(int argc, char **argv)
 	} else if ((argc==2) && !(strcmp(argv[1],"-s"))) { 
 #ifdef DUMP_MORE_STATE
      		printk("\nCPUSTATE   CPUID\n");
-		for (i=0;i<NR_CPUS;i++) {
-			if (!cpu_online(i))
-				continue;
+		for_each_online_cpu(i) {
 			if (cpu_data[i].cpuid != NO_PROC_ID) {
 				switch(cpu_data[i].state) {
 					case STATE_RENDEZVOUS:
diff -puN arch/powerpc/kernel/irq.c~more-for_each_cpu-conversions arch/powerpc/kernel/irq.c
--- devel/arch/powerpc/kernel/irq.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/powerpc/kernel/irq.c	2006-02-03 01:00:28.000000000 -0800
@@ -137,9 +137,8 @@ skip:
 #ifdef CONFIG_TAU_INT
 		if (tau_initialized){
 			seq_puts(p, "TAU: ");
-			for (j = 0; j < NR_CPUS; j++)
-				if (cpu_online(j))
-					seq_printf(p, "%10u ", tau_interrupts(j));
+			for_each_online_cpu(j)
+				seq_printf(p, "%10u ", tau_interrupts(j));
 			seq_puts(p, "  PowerPC             Thermal Assist (cpu temp)\n");
 		}
 #endif
diff -puN arch/powerpc/kernel/setup_32.c~more-for_each_cpu-conversions arch/powerpc/kernel/setup_32.c
--- devel/arch/powerpc/kernel/setup_32.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/powerpc/kernel/setup_32.c	2006-02-03 01:00:28.000000000 -0800
@@ -272,9 +272,8 @@ int __init ppc_init(void)
 	if ( ppc_md.progress ) ppc_md.progress("             ", 0xffff);
 
 	/* register CPU devices */
-	for (i = 0; i < NR_CPUS; i++)
-		if (cpu_possible(i))
-			register_cpu(&cpu_devices[i], i, NULL);
+	for_each_cpu(i)
+		register_cpu(&cpu_devices[i], i, NULL);
 
 	/* call platform init */
 	if (ppc_md.init != NULL) {
diff -puN arch/powerpc/kernel/setup-common.c~more-for_each_cpu-conversions arch/powerpc/kernel/setup-common.c
--- devel/arch/powerpc/kernel/setup-common.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/powerpc/kernel/setup-common.c	2006-02-03 01:00:28.000000000 -0800
@@ -162,9 +162,8 @@ static int show_cpuinfo(struct seq_file 
 #if defined(CONFIG_SMP) && defined(CONFIG_PPC32)
 		unsigned long bogosum = 0;
 		int i;
-		for (i = 0; i < NR_CPUS; ++i)
-			if (cpu_online(i))
-				bogosum += loops_per_jiffy;
+		for_each_online_cpu(i)
+			bogosum += loops_per_jiffy;
 		seq_printf(m, "total bogomips\t: %lu.%02lu\n",
 			   bogosum/(500000/HZ), bogosum/(5000/HZ) % 100);
 #endif /* CONFIG_SMP && CONFIG_PPC32 */
diff -puN arch/powerpc/platforms/powermac/smp.c~more-for_each_cpu-conversions arch/powerpc/platforms/powermac/smp.c
--- devel/arch/powerpc/platforms/powermac/smp.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/powerpc/platforms/powermac/smp.c	2006-02-03 01:00:28.000000000 -0800
@@ -191,9 +191,7 @@ static void smp_psurge_message_pass(int 
 	if (num_online_cpus() < 2)
 		return;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
+	for_each_online_cpu(i) {
 		if (target == MSG_ALL
 		    || (target == MSG_ALL_BUT_SELF && i != smp_processor_id())
 		    || target == i) {
diff -puN arch/ppc/kernel/setup.c~more-for_each_cpu-conversions arch/ppc/kernel/setup.c
--- devel/arch/ppc/kernel/setup.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/ppc/kernel/setup.c	2006-02-03 01:00:28.000000000 -0800
@@ -168,9 +168,8 @@ int show_cpuinfo(struct seq_file *m, voi
 		/* Show summary information */
 #ifdef CONFIG_SMP
 		unsigned long bogosum = 0;
-		for (i = 0; i < NR_CPUS; ++i)
-			if (cpu_online(i))
-				bogosum += cpu_data[i].loops_per_jiffy;
+		for_each_online_cpu(i)
+			bogosum += cpu_data[i].loops_per_jiffy;
 		seq_printf(m, "total bogomips\t: %lu.%02lu\n",
 			   bogosum/(500000/HZ), bogosum/(5000/HZ) % 100);
 #endif /* CONFIG_SMP */
@@ -712,9 +711,8 @@ int __init ppc_init(void)
 	if ( ppc_md.progress ) ppc_md.progress("             ", 0xffff);
 
 	/* register CPU devices */
-	for (i = 0; i < NR_CPUS; i++)
-		if (cpu_possible(i))
-			register_cpu(&cpu_devices[i], i, NULL);
+	for_each_cpu(i)
+		register_cpu(&cpu_devices[i], i, NULL);
 
 	/* call platform init */
 	if (ppc_md.init != NULL) {
diff -puN arch/s390/kernel/smp.c~more-for_each_cpu-conversions arch/s390/kernel/smp.c
--- devel/arch/s390/kernel/smp.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/s390/kernel/smp.c	2006-02-03 01:00:28.000000000 -0800
@@ -767,9 +767,7 @@ void __init smp_prepare_cpus(unsigned in
          */
 	print_cpu_info(&S390_lowcore.cpu_data);
 
-        for(i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
+        for_each_cpu(i) {
 		lowcore_ptr[i] = (struct _lowcore *)
 			__get_free_pages(GFP_KERNEL|GFP_DMA, 
 					sizeof(void*) == 8 ? 1 : 0);
diff -puN arch/sh64/kernel/irq.c~more-for_each_cpu-conversions arch/sh64/kernel/irq.c
--- devel/arch/sh64/kernel/irq.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/sh64/kernel/irq.c	2006-02-03 01:00:28.000000000 -0800
@@ -53,9 +53,8 @@ int show_interrupts(struct seq_file *p, 
 
 	if (i == 0) {
 		seq_puts(p, "           ");
-		for (j=0; j<NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "CPU%d       ",j);
+		for_each_online_cpu(j)
+			seq_printf(p, "CPU%d       ",j);
 		seq_putc(p, '\n');
 	}
 
diff -puN arch/sh/kernel/irq.c~more-for_each_cpu-conversions arch/sh/kernel/irq.c
--- devel/arch/sh/kernel/irq.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/sh/kernel/irq.c	2006-02-03 01:00:28.000000000 -0800
@@ -35,9 +35,8 @@ int show_interrupts(struct seq_file *p, 
 
 	if (i == 0) {
 		seq_puts(p, "           ");
-		for (j=0; j<NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "CPU%d       ",j);
+		for_each_online_cpu(j)
+			seq_printf(p, "CPU%d       ",j);
 		seq_putc(p, '\n');
 	}
 
diff -puN arch/sh/kernel/setup.c~more-for_each_cpu-conversions arch/sh/kernel/setup.c
--- devel/arch/sh/kernel/setup.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/sh/kernel/setup.c	2006-02-03 01:00:28.000000000 -0800
@@ -404,9 +404,8 @@ static int __init topology_init(void)
 {
 	int cpu_id;
 
-	for (cpu_id = 0; cpu_id < NR_CPUS; cpu_id++)
-		if (cpu_possible(cpu_id))
-			register_cpu(&cpu[cpu_id], cpu_id, NULL);
+	for_each_cpu(cpu_id)
+		register_cpu(&cpu[cpu_id], cpu_id, NULL);
 
 	return 0;
 }
diff -puN arch/sparc64/kernel/irq.c~more-for_each_cpu-conversions arch/sparc64/kernel/irq.c
--- devel/arch/sparc64/kernel/irq.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/sparc64/kernel/irq.c	2006-02-03 01:00:28.000000000 -0800
@@ -115,9 +115,7 @@ int show_interrupts(struct seq_file *p, 
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for (j = 0; j < NR_CPUS; j++) {
-			if (!cpu_online(j))
-				continue;
+		for_each_online_cpu(j) {
 			seq_printf(p, "%10u ",
 				   kstat_cpu(j).irqs[i]);
 		}
diff -puN arch/sparc64/kernel/setup.c~more-for_each_cpu-conversions arch/sparc64/kernel/setup.c
--- devel/arch/sparc64/kernel/setup.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/sparc64/kernel/setup.c	2006-02-03 01:00:28.000000000 -0800
@@ -690,15 +690,12 @@ static int __init topology_init(void)
 	while (!cpu_find_by_instance(ncpus_probed, NULL, NULL))
 		ncpus_probed++;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_possible(i)) {
-			struct cpu *p = kmalloc(sizeof(*p), GFP_KERNEL);
-
-			if (p) {
-				memset(p, 0, sizeof(*p));
-				register_cpu(p, i, NULL);
-				err = 0;
-			}
+	for_each_cpu(i) {
+		struct cpu *p = kmalloc(sizeof(*p), GFP_KERNEL);
+		if (p) {
+			memset(p, 0, sizeof(*p));
+			register_cpu(p, i, NULL);
+			err = 0;
 		}
 	}
 
diff -puN arch/sparc64/kernel/smp.c~more-for_each_cpu-conversions arch/sparc64/kernel/smp.c
--- devel/arch/sparc64/kernel/smp.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/sparc64/kernel/smp.c	2006-02-03 01:00:28.000000000 -0800
@@ -54,25 +54,21 @@ void smp_info(struct seq_file *m)
 	int i;
 	
 	seq_printf(m, "State:\n");
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_online(i))
-			seq_printf(m,
-				   "CPU%d:\t\tonline\n", i);
-	}
+	for_each_online_cpu(i)
+		seq_printf(m, "CPU%d:\t\tonline\n", i);
 }
 
 void smp_bogo(struct seq_file *m)
 {
 	int i;
 	
-	for (i = 0; i < NR_CPUS; i++)
-		if (cpu_online(i))
-			seq_printf(m,
-				   "Cpu%dBogo\t: %lu.%02lu\n"
-				   "Cpu%dClkTck\t: %016lx\n",
-				   i, cpu_data(i).udelay_val / (500000/HZ),
-				   (cpu_data(i).udelay_val / (5000/HZ)) % 100,
-				   i, cpu_data(i).clock_tick);
+	for_each_online_cpu(i)
+		seq_printf(m,
+			   "Cpu%dBogo\t: %lu.%02lu\n"
+			   "Cpu%dClkTck\t: %016lx\n",
+			   i, cpu_data(i).udelay_val / (500000/HZ),
+			   (cpu_data(i).udelay_val / (5000/HZ)) % 100,
+			   i, cpu_data(i).clock_tick);
 }
 
 void __init smp_store_cpu_info(int id)
@@ -1071,7 +1067,7 @@ int setup_profiling_timer(unsigned int m
 		return -EINVAL;
 
 	spin_lock_irqsave(&prof_setup_lock, flags);
-	for (i = 0; i < NR_CPUS; i++)
+	for_each_cpu(i)
 		prof_multiplier(i) = multiplier;
 	current_tick_offset = (timer_tick_offset / multiplier);
 	spin_unlock_irqrestore(&prof_setup_lock, flags);
@@ -1140,10 +1136,8 @@ void __init smp_cpus_done(unsigned int m
 	unsigned long bogosum = 0;
 	int i;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_online(i))
-			bogosum += cpu_data(i).udelay_val;
-	}
+	for_each_online_cpu(i)
+		bogosum += cpu_data(i).udelay_val;
 	printk("Total of %ld processors activated "
 	       "(%lu.%02lu BogoMIPS).\n",
 	       (long) num_online_cpus(),
diff -puN arch/sparc/kernel/irq.c~more-for_each_cpu-conversions arch/sparc/kernel/irq.c
--- devel/arch/sparc/kernel/irq.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/sparc/kernel/irq.c	2006-02-03 01:00:28.000000000 -0800
@@ -184,9 +184,8 @@ int show_interrupts(struct seq_file *p, 
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for (j = 0; j < NR_CPUS; j++) {
-			if (cpu_online(j))
-				seq_printf(p, "%10u ",
+		for_each_online_cpu(j) {
+			seq_printf(p, "%10u ",
 				    kstat_cpu(cpu_logical_map(j)).irqs[i]);
 		}
 #endif
diff -puN arch/sparc/kernel/smp.c~more-for_each_cpu-conversions arch/sparc/kernel/smp.c
--- devel/arch/sparc/kernel/smp.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/sparc/kernel/smp.c	2006-02-03 01:00:28.000000000 -0800
@@ -243,9 +243,8 @@ int setup_profiling_timer(unsigned int m
 		return -EINVAL;
 
 	spin_lock_irqsave(&prof_setup_lock, flags);
-	for(i = 0; i < NR_CPUS; i++) {
-		if (cpu_possible(i))
-			load_profile_irq(i, lvl14_resolution / multiplier);
+	for_each_cpu(i) {
+		load_profile_irq(i, lvl14_resolution / multiplier);
 		prof_multiplier(i) = multiplier;
 	}
 	spin_unlock_irqrestore(&prof_setup_lock, flags);
@@ -273,13 +272,12 @@ void smp_bogo(struct seq_file *m)
 {
 	int i;
 	
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_online(i))
-			seq_printf(m,
-				   "Cpu%dBogo\t: %lu.%02lu\n", 
-				   i,
-				   cpu_data(i).udelay_val/(500000/HZ),
-				   (cpu_data(i).udelay_val/(5000/HZ))%100);
+	for_each_online_cpu(i) {
+		seq_printf(m,
+			   "Cpu%dBogo\t: %lu.%02lu\n",
+			   i,
+			   cpu_data(i).udelay_val/(500000/HZ),
+			   (cpu_data(i).udelay_val/(5000/HZ))%100);
 	}
 }
 
@@ -288,8 +286,6 @@ void smp_info(struct seq_file *m)
 	int i;
 
 	seq_printf(m, "State:\n");
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_online(i))
-			seq_printf(m, "CPU%d\t\t: online\n", i);
-	}
+	for_each_online_cpu(i)
+		seq_printf(m, "CPU%d\t\t: online\n", i);
 }
diff -puN arch/sparc/kernel/sun4d_irq.c~more-for_each_cpu-conversions arch/sparc/kernel/sun4d_irq.c
--- devel/arch/sparc/kernel/sun4d_irq.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/sparc/kernel/sun4d_irq.c	2006-02-03 01:00:28.000000000 -0800
@@ -103,11 +103,9 @@ found_it:	seq_printf(p, "%3d: ", i);
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for (x = 0; x < NR_CPUS; x++) {
-			if (cpu_online(x))
-				seq_printf(p, "%10u ",
-				       kstat_cpu(cpu_logical_map(x)).irqs[i]);
-		}
+		for_each_online_cpu(x)
+			seq_printf(p, "%10u ",
+			       kstat_cpu(cpu_logical_map(x)).irqs[i]);
 #endif
 		seq_printf(p, "%c %s",
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
diff -puN arch/sparc/kernel/sun4d_smp.c~more-for_each_cpu-conversions arch/sparc/kernel/sun4d_smp.c
--- devel/arch/sparc/kernel/sun4d_smp.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/sparc/kernel/sun4d_smp.c	2006-02-03 01:00:28.000000000 -0800
@@ -249,11 +249,9 @@ void __init smp4d_boot_cpus(void)
 	} else {
 		unsigned long bogosum = 0;
 		
-		for(i = 0; i < NR_CPUS; i++) {
-			if (cpu_isset(i, cpu_present_map)) {
-				bogosum += cpu_data(i).udelay_val;
-				smp_highest_cpu = i;
-			}
+		for_each_present_cpu(i) {
+			bogosum += cpu_data(i).udelay_val;
+			smp_highest_cpu = i;
 		}
 		SMP_PRINTK(("Total of %d Processors activated (%lu.%02lu BogoMIPS).\n", cpucount + 1, bogosum/(500000/HZ), (bogosum/(5000/HZ))%100));
 		printk("Total of %d Processors activated (%lu.%02lu BogoMIPS).\n",
diff -puN arch/sparc/kernel/sun4m_smp.c~more-for_each_cpu-conversions arch/sparc/kernel/sun4m_smp.c
--- devel/arch/sparc/kernel/sun4m_smp.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/sparc/kernel/sun4m_smp.c	2006-02-03 01:00:28.000000000 -0800
@@ -218,10 +218,8 @@ void __init smp4m_boot_cpus(void)
 		cpu_present_map = cpumask_of_cpu(smp_processor_id());
 	} else {
 		unsigned long bogosum = 0;
-		for(i = 0; i < NR_CPUS; i++) {
-			if (cpu_isset(i, cpu_present_map))
-				bogosum += cpu_data(i).udelay_val;
-		}
+		for_each_present_cpu(i)
+			bogosum += cpu_data(i).udelay_val;
 		printk("Total of %d Processors activated (%lu.%02lu BogoMIPS).\n",
 		       cpucount + 1,
 		       bogosum/(500000/HZ),
diff -puN arch/x86_64/kernel/irq.c~more-for_each_cpu-conversions arch/x86_64/kernel/irq.c
--- devel/arch/x86_64/kernel/irq.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/x86_64/kernel/irq.c	2006-02-03 01:00:28.000000000 -0800
@@ -38,9 +38,8 @@ int show_interrupts(struct seq_file *p, 
 
 	if (i == 0) {
 		seq_printf(p, "           ");
-		for (j=0; j<NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "CPU%d       ",j);
+		for_each_online_cpu(j)
+			seq_printf(p, "CPU%d       ",j);
 		seq_putc(p, '\n');
 	}
 
@@ -53,10 +52,8 @@ int show_interrupts(struct seq_file *p, 
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for (j=0; j<NR_CPUS; j++)
-			if (cpu_online(j))
-			seq_printf(p, "%10u ",
-				kstat_cpu(j).irqs[i]);
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
 
@@ -68,15 +65,13 @@ skip:
 		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 	} else if (i == NR_IRQS) {
 		seq_printf(p, "NMI: ");
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ", cpu_pda(j)->__nmi_count);
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", cpu_pda(j)->__nmi_count);
 		seq_putc(p, '\n');
 #ifdef CONFIG_X86_LOCAL_APIC
 		seq_printf(p, "LOC: ");
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ", cpu_pda(j)->apic_timer_irqs);
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", cpu_pda(j)->apic_timer_irqs);
 		seq_putc(p, '\n');
 #endif
 		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
diff -puN arch/x86_64/kernel/nmi.c~more-for_each_cpu-conversions arch/x86_64/kernel/nmi.c
--- devel/arch/x86_64/kernel/nmi.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/x86_64/kernel/nmi.c	2006-02-03 01:00:28.000000000 -0800
@@ -161,9 +161,7 @@ int __init check_nmi_watchdog (void)
 	local_irq_enable();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (!cpu_online(cpu))
-			continue;
+	for_each_online_cpu(cpu) {
 		if (cpu_pda(cpu)->__nmi_count - counts[cpu] <= 5) {
 			endflag = 1;
 			printk("CPU#%d: NMI appears to be stuck (%d->%d)!\n",
@@ -462,7 +460,7 @@ void touch_nmi_watchdog (void)
 	 * do it ourselves because the alert count increase is not
 	 * atomic.
 	 */
-	for (i = 0; i < NR_CPUS; i++)
+	for_each_cpu(i)
 		per_cpu(nmi_touch, i) = 1;
 
  	touch_softlockup_watchdog();
diff -puN arch/xtensa/kernel/irq.c~more-for_each_cpu-conversions arch/xtensa/kernel/irq.c
--- devel/arch/xtensa/kernel/irq.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/arch/xtensa/kernel/irq.c	2006-02-03 01:00:28.000000000 -0800
@@ -83,9 +83,8 @@ int show_interrupts(struct seq_file *p, 
 
 	if (i == 0) {
 		seq_printf(p, "           ");
-		for (j=0; j<NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "CPU%d       ",j);
+		for_each_online_cpu(j)
+			seq_printf(p, "CPU%d       ",j);
 		seq_putc(p, '\n');
 	}
 
@@ -98,9 +97,8 @@ int show_interrupts(struct seq_file *p, 
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
 		seq_printf(p, "  %s", action->name);
@@ -113,9 +111,8 @@ skip:
 		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 	} else if (i == NR_IRQS) {
 		seq_printf(p, "NMI: ");
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ", nmi_count(j));
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", nmi_count(j));
 		seq_putc(p, '\n');
 		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
 	}
diff -puN drivers/net/loopback.c~more-for_each_cpu-conversions drivers/net/loopback.c
--- devel/drivers/net/loopback.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/drivers/net/loopback.c	2006-02-03 01:00:28.000000000 -0800
@@ -172,11 +172,9 @@ static struct net_device_stats *get_stat
 
 	memset(stats, 0, sizeof(struct net_device_stats));
 
-	for (i=0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		struct net_device_stats *lb_stats;
 
-		if (!cpu_possible(i)) 
-			continue;
 		lb_stats = &per_cpu(loopback_stats, i);
 		stats->rx_bytes   += lb_stats->rx_bytes;
 		stats->tx_bytes   += lb_stats->tx_bytes;
diff -puN drivers/oprofile/cpu_buffer.c~more-for_each_cpu-conversions drivers/oprofile/cpu_buffer.c
--- devel/drivers/oprofile/cpu_buffer.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/drivers/oprofile/cpu_buffer.c	2006-02-03 01:00:28.000000000 -0800
@@ -38,9 +38,8 @@ void free_cpu_buffers(void)
 {
 	int i;
  
-	for_each_online_cpu(i) {
+	for_each_online_cpu(i)
 		vfree(cpu_buffer[i].buffer);
-	}
 }
 
 int alloc_cpu_buffers(void)
diff -puN fs/xfs/linux-2.6/xfs_stats.c~more-for_each_cpu-conversions fs/xfs/linux-2.6/xfs_stats.c
--- devel/fs/xfs/linux-2.6/xfs_stats.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/fs/xfs/linux-2.6/xfs_stats.c	2006-02-03 01:00:28.000000000 -0800
@@ -62,18 +62,15 @@ xfs_read_xfsstats(
 		while (j < xstats[i].endpoint) {
 			val = 0;
 			/* sum over all cpus */
-			for (c = 0; c < NR_CPUS; c++) {
-				if (!cpu_possible(c)) continue;
+			for_each_cpu(c)
 				val += *(((__u32*)&per_cpu(xfsstats, c) + j));
-			}
 			len += sprintf(buffer + len, " %u", val);
 			j++;
 		}
 		buffer[len++] = '\n';
 	}
 	/* extra precision counters */
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i)) continue;
+	for_each_cpu(i) {
 		xs_xstrat_bytes += per_cpu(xfsstats, i).xs_xstrat_bytes;
 		xs_write_bytes += per_cpu(xfsstats, i).xs_write_bytes;
 		xs_read_bytes += per_cpu(xfsstats, i).xs_read_bytes;
diff -puN fs/xfs/linux-2.6/xfs_sysctl.c~more-for_each_cpu-conversions fs/xfs/linux-2.6/xfs_sysctl.c
--- devel/fs/xfs/linux-2.6/xfs_sysctl.c~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/fs/xfs/linux-2.6/xfs_sysctl.c	2006-02-03 01:00:28.000000000 -0800
@@ -38,8 +38,7 @@ xfs_stats_clear_proc_handler(
 
 	if (!ret && write && *valp) {
 		printk("XFS Clearing xfsstats\n");
-		for (c = 0; c < NR_CPUS; c++) {
-			if (!cpu_possible(c)) continue;
+		for_each_cpu(c) {
 			preempt_disable();
 			/* save vn_active, it's a universal truth! */
 			vn_active = per_cpu(xfsstats, c).vn_active;
diff -puN include/asm-alpha/mmu_context.h~more-for_each_cpu-conversions include/asm-alpha/mmu_context.h
--- devel/include/asm-alpha/mmu_context.h~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/include/asm-alpha/mmu_context.h	2006-02-03 01:00:28.000000000 -0800
@@ -231,9 +231,8 @@ init_new_context(struct task_struct *tsk
 {
 	int i;
 
-	for (i = 0; i < NR_CPUS; i++)
-		if (cpu_online(i))
-			mm->context[i] = 0;
+	for_each_online_cpu(i)
+		mm->context[i] = 0;
 	if (tsk != current)
 		task_thread_info(tsk)->pcb.ptbr
 		  = ((unsigned long)mm->pgd - IDENT_ADDR) >> PAGE_SHIFT;
diff -puN include/asm-alpha/topology.h~more-for_each_cpu-conversions include/asm-alpha/topology.h
--- devel/include/asm-alpha/topology.h~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/include/asm-alpha/topology.h	2006-02-03 01:00:28.000000000 -0800
@@ -27,8 +27,8 @@ static inline cpumask_t node_to_cpumask(
 	cpumask_t node_cpu_mask = CPU_MASK_NONE;
 	int cpu;
 
-	for(cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (cpu_online(cpu) && (cpu_to_node(cpu) == node))
+	for_each_online_cpu(cpu) {
+		if (cpu_to_node(cpu) == node)
 			cpu_set(cpu, node_cpu_mask);
 	}
 
diff -puN include/asm-generic/percpu.h~more-for_each_cpu-conversions include/asm-generic/percpu.h
--- devel/include/asm-generic/percpu.h~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/include/asm-generic/percpu.h	2006-02-03 01:00:28.000000000 -0800
@@ -19,10 +19,9 @@ extern unsigned long __per_cpu_offset[NR
 #define percpu_modcopy(pcpudst, src, size)			\
 do {								\
 	unsigned int __i;					\
-	for (__i = 0; __i < NR_CPUS; __i++)			\
-		if (cpu_possible(__i))				\
-			memcpy((pcpudst)+__per_cpu_offset[__i],	\
-			       (src), (size));			\
+	for_each_cpu(__i)					\
+		memcpy((pcpudst)+__per_cpu_offset[__i],		\
+		       (src), (size));				\
 } while (0)
 #else /* ! SMP */
 
diff -puN include/asm-powerpc/percpu.h~more-for_each_cpu-conversions include/asm-powerpc/percpu.h
--- devel/include/asm-powerpc/percpu.h~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/include/asm-powerpc/percpu.h	2006-02-03 01:00:28.000000000 -0800
@@ -27,10 +27,9 @@
 #define percpu_modcopy(pcpudst, src, size)			\
 do {								\
 	unsigned int __i;					\
-	for (__i = 0; __i < NR_CPUS; __i++)			\
-		if (cpu_possible(__i))				\
-			memcpy((pcpudst)+__per_cpu_offset(__i),	\
-			       (src), (size));			\
+	for_each_cpu(__i)					\
+		memcpy((pcpudst)+__per_cpu_offset(__i),		\
+		       (src), (size));				\
 } while (0)
 
 extern void setup_per_cpu_areas(void);
diff -puN include/asm-s390/percpu.h~more-for_each_cpu-conversions include/asm-s390/percpu.h
--- devel/include/asm-s390/percpu.h~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/include/asm-s390/percpu.h	2006-02-03 01:00:28.000000000 -0800
@@ -46,10 +46,9 @@ extern unsigned long __per_cpu_offset[NR
 #define percpu_modcopy(pcpudst, src, size)			\
 do {								\
 	unsigned int __i;					\
-	for (__i = 0; __i < NR_CPUS; __i++)			\
-		if (cpu_possible(__i))				\
-			memcpy((pcpudst)+__per_cpu_offset[__i],	\
-			       (src), (size));			\
+	for_each_cpu(__i)					\
+		memcpy((pcpudst)+__per_cpu_offset[__i],		\
+		       (src), (size));				\
 } while (0)
 
 #else /* ! SMP */
diff -puN include/asm-sparc64/percpu.h~more-for_each_cpu-conversions include/asm-sparc64/percpu.h
--- devel/include/asm-sparc64/percpu.h~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/include/asm-sparc64/percpu.h	2006-02-03 01:00:28.000000000 -0800
@@ -26,10 +26,9 @@ register unsigned long __local_per_cpu_o
 #define percpu_modcopy(pcpudst, src, size)			\
 do {								\
 	unsigned int __i;					\
-	for (__i = 0; __i < NR_CPUS; __i++)			\
-		if (cpu_possible(__i))				\
-			memcpy((pcpudst)+__per_cpu_offset(__i),	\
-			       (src), (size));			\
+	for_each_cpu(__i)					\
+		memcpy((pcpudst)+__per_cpu_offset(__i),		\
+		       (src), (size));				\
 } while (0)
 #else /* ! SMP */
 
diff -puN include/asm-x86_64/percpu.h~more-for_each_cpu-conversions include/asm-x86_64/percpu.h
--- devel/include/asm-x86_64/percpu.h~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/include/asm-x86_64/percpu.h	2006-02-03 01:00:28.000000000 -0800
@@ -26,10 +26,9 @@
 #define percpu_modcopy(pcpudst, src, size)			\
 do {								\
 	unsigned int __i;					\
-	for (__i = 0; __i < NR_CPUS; __i++)			\
-		if (cpu_possible(__i))				\
-			memcpy((pcpudst)+__per_cpu_offset(__i),	\
-			       (src), (size));			\
+	for_each_cpu(__i)					\
+		memcpy((pcpudst)+__per_cpu_offset(__i),		\
+		       (src), (size));				\
 } while (0)
 
 extern void setup_per_cpu_areas(void);
diff -puN include/linux/genhd.h~more-for_each_cpu-conversions include/linux/genhd.h
--- devel/include/linux/genhd.h~more-for_each_cpu-conversions	2006-02-03 01:00:28.000000000 -0800
+++ devel-akpm/include/linux/genhd.h	2006-02-03 01:00:28.000000000 -0800
@@ -149,22 +149,16 @@ struct disk_attribute {
 ({									\
 	typeof(gendiskp->dkstats->field) res = 0;			\
 	int i;								\
-	for (i=0; i < NR_CPUS; i++) {					\
-		if (!cpu_possible(i))					\
-			continue;					\
+	for_each_cpu(i)							\
 		res += per_cpu_ptr(gendiskp->dkstats, i)->field;	\
-	}								\
 	res;								\
 })
 
 static inline void disk_stat_set_all(struct gendisk *gendiskp, int value)	{
 	int i;
-	for (i=0; i < NR_CPUS; i++) {
-		if (cpu_possible(i)) {
-			memset(per_cpu_ptr(gendiskp->dkstats, i), value,	
-					sizeof (struct disk_stats));
-		}
-	}
+	for_each_cpu(i)
+		memset(per_cpu_ptr(gendiskp->dkstats, i), value,
+				sizeof (struct disk_stats));
 }		
 				
 #else
_

