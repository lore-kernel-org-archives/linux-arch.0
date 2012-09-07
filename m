Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34443 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab2IGQ1z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 12:27:55 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 15/31] arm64: SMP support
Date: Fri,  7 Sep 2012 17:26:50 +0100
Message-ID: <1347035226-18649-16-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120907162650.c6fWFbYqmcVoy6z8an69-2xXBLbYFj8G9xyj2RG_gt4@z>

This patch adds SMP initialisation and spinlocks implementation for
AArch64. The spinlock support uses the new load-acquire/store-release
instructions to avoid explicit barriers. The architecture also specifies
that an event is automatically generated when clearing the exclusive
monitor state to wake up processors in WFE, so there is no need for an
explicit DSB/SEV instruction sequence. The SEVL instruction is used to
set the exclusive monitor locally as there is no conditional WFE and a
branch is more expensive.

For the SMP booting protocol, see Documentation/arm64/booting.txt.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm64/include/asm/hardirq.h        |    5 +
 arch/arm64/include/asm/smp.h            |   69 +++++
 arch/arm64/include/asm/spinlock.h       |  202 +++++++++++++
 arch/arm64/include/asm/spinlock_types.h |   38 +++
 arch/arm64/kernel/smp.c                 |  469 +++++++++++++++++++++++++++=
++++
 5 files changed, 783 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/smp.h
 create mode 100644 arch/arm64/include/asm/spinlock.h
 create mode 100644 arch/arm64/include/asm/spinlock_types.h
 create mode 100644 arch/arm64/kernel/smp.c

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hard=
irq.h
index c6c9514..5075463 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -20,8 +20,13 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
=20
+#define NR_IPI=094
+
 typedef struct {
 =09unsigned int __softirq_pending;
+#ifdef CONFIG_SMP
+=09unsigned int ipi_irqs[NR_IPI];
+#endif
 } ____cacheline_aligned irq_cpustat_t;
=20
 #include <linux/irq_cpustat.h>=09/* Standard mappings for irq_cpustat_t ab=
ove */
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
new file mode 100644
index 0000000..7e34295
--- /dev/null
+++ b/arch/arm64/include/asm/smp.h
@@ -0,0 +1,69 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_SMP_H
+#define __ASM_SMP_H
+
+#include <linux/threads.h>
+#include <linux/cpumask.h>
+#include <linux/thread_info.h>
+
+#ifndef CONFIG_SMP
+# error "<asm/smp.h> included in non-SMP build"
+#endif
+
+#define raw_smp_processor_id() (current_thread_info()->cpu)
+
+struct seq_file;
+
+/*
+ * generate IPI list text
+ */
+extern void show_ipi_list(struct seq_file *p, int prec);
+
+/*
+ * Called from C code, this handles an IPI.
+ */
+extern void handle_IPI(int ipinr, struct pt_regs *regs);
+
+/*
+ * Setup the set of possible CPUs (via set_cpu_possible)
+ */
+extern void smp_init_cpus(void);
+
+/*
+ * Provide a function to raise an IPI cross call on CPUs in callmap.
+ */
+extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned i=
nt));
+
+/*
+ * Called from the secondary holding pen, this is the secondary CPU entry =
point.
+ */
+asmlinkage void secondary_start_kernel(void);
+
+/*
+ * Initial data for bringing up a secondary CPU.
+ */
+struct secondary_data {
+=09void *stack;
+};
+extern struct secondary_data secondary_data;
+extern void secondary_holding_pen(void);
+extern volatile unsigned long secondary_holding_pen_release;
+
+extern void arch_send_call_function_single_ipi(int cpu);
+extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
+
+#endif /* ifndef __ASM_SMP_H */
diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spi=
nlock.h
new file mode 100644
index 0000000..41112fe
--- /dev/null
+++ b/arch/arm64/include/asm/spinlock.h
@@ -0,0 +1,202 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_SPINLOCK_H
+#define __ASM_SPINLOCK_H
+
+#include <asm/spinlock_types.h>
+#include <asm/processor.h>
+
+/*
+ * Spinlock implementation.
+ *
+ * The old value is read exclusively and the new one, if unlocked, is writ=
ten
+ * exclusively. In case of failure, the loop is restarted.
+ *
+ * The memory barriers are implicit with the load-acquire and store-releas=
e
+ * instructions.
+ *
+ * Unlocked value: 0
+ * Locked value: 1
+ */
+
+#define arch_spin_is_locked(x)=09=09((x)->lock !=3D 0)
+#define arch_spin_unlock_wait(lock) \
+=09do { while (arch_spin_is_locked(lock)) cpu_relax(); } while (0)
+
+#define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
+
+static inline void arch_spin_lock(arch_spinlock_t *lock)
+{
+=09unsigned int tmp;
+
+=09asm volatile(
+=09"=09sevl\n"
+=09"1:=09wfe\n"
+=09"2:=09ldaxr=09%w0, [%1]\n"
+=09"=09cbnz=09%w0, 1b\n"
+=09"=09stxr=09%w0, %w2, [%1]\n"
+=09"=09cbnz=09%w0, 2b\n"
+=09: "=3D&r" (tmp)
+=09: "r" (&lock->lock), "r" (1)
+=09: "memory");
+}
+
+static inline int arch_spin_trylock(arch_spinlock_t *lock)
+{
+=09unsigned int tmp;
+
+=09asm volatile(
+=09"=09ldaxr=09%w0, [%1]\n"
+=09"=09cbnz=09%w0, 1f\n"
+=09"=09stxr=09%w0, %w2, [%1]\n"
+=09"1:\n"
+=09: "=3D&r" (tmp)
+=09: "r" (&lock->lock), "r" (1)
+=09: "memory");
+
+=09return !tmp;
+}
+
+static inline void arch_spin_unlock(arch_spinlock_t *lock)
+{
+=09asm volatile(
+=09"=09stlr=09%w1, [%0]\n"
+=09: : "r" (&lock->lock), "r" (0) : "memory");
+}
+
+/*
+ * Write lock implementation.
+ *
+ * Write locks set bit 31. Unlocking, is done by writing 0 since the lock =
is
+ * exclusively held.
+ *
+ * The memory barriers are implicit with the load-acquire and store-releas=
e
+ * instructions.
+ */
+
+static inline void arch_write_lock(arch_rwlock_t *rw)
+{
+=09unsigned int tmp;
+
+=09asm volatile(
+=09"=09sevl\n"
+=09"1:=09wfe\n"
+=09"2:=09ldaxr=09%w0, [%1]\n"
+=09"=09cbnz=09%w0, 1b\n"
+=09"=09stxr=09%w0, %w2, [%1]\n"
+=09"=09cbnz=09%w0, 2b\n"
+=09: "=3D&r" (tmp)
+=09: "r" (&rw->lock), "r" (0x80000000)
+=09: "memory");
+}
+
+static inline int arch_write_trylock(arch_rwlock_t *rw)
+{
+=09unsigned int tmp;
+
+=09asm volatile(
+=09"=09ldaxr=09%w0, [%1]\n"
+=09"=09cbnz=09%w0, 1f\n"
+=09"=09stxr=09%w0, %w2, [%1]\n"
+=09"1:\n"
+=09: "=3D&r" (tmp)
+=09: "r" (&rw->lock), "r" (0x80000000)
+=09: "memory");
+
+=09return !tmp;
+}
+
+static inline void arch_write_unlock(arch_rwlock_t *rw)
+{
+=09asm volatile(
+=09"=09stlr=09%w1, [%0]\n"
+=09: : "r" (&rw->lock), "r" (0) : "memory");
+}
+
+/* write_can_lock - would write_trylock() succeed? */
+#define arch_write_can_lock(x)=09=09((x)->lock =3D=3D 0)
+
+/*
+ * Read lock implementation.
+ *
+ * It exclusively loads the lock value, increments it and stores the new v=
alue
+ * back if positive and the CPU still exclusively owns the location. If th=
e
+ * value is negative, the lock is already held.
+ *
+ * During unlocking there may be multiple active read locks but no write l=
ock.
+ *
+ * The memory barriers are implicit with the load-acquire and store-releas=
e
+ * instructions.
+ */
+static inline void arch_read_lock(arch_rwlock_t *rw)
+{
+=09unsigned int tmp, tmp2;
+
+=09asm volatile(
+=09"=09sevl\n"
+=09"1:=09wfe\n"
+=09"2:=09ldaxr=09%w0, [%2]\n"
+=09"=09add=09%w0, %w0, #1\n"
+=09"=09tbnz=09%w0, #31, 1b\n"
+=09"=09stxr=09%w1, %w0, [%2]\n"
+=09"=09cbnz=09%w1, 2b\n"
+=09: "=3D&r" (tmp), "=3D&r" (tmp2)
+=09: "r" (&rw->lock)
+=09: "memory");
+}
+
+static inline void arch_read_unlock(arch_rwlock_t *rw)
+{
+=09unsigned int tmp, tmp2;
+
+=09asm volatile(
+=09"1:=09ldxr=09%w0, [%2]\n"
+=09"=09sub=09%w0, %w0, #1\n"
+=09"=09stlxr=09%w1, %w0, [%2]\n"
+=09"=09cbnz=09%w1, 1b\n"
+=09: "=3D&r" (tmp), "=3D&r" (tmp2)
+=09: "r" (&rw->lock)
+=09: "memory");
+}
+
+static inline int arch_read_trylock(arch_rwlock_t *rw)
+{
+=09unsigned int tmp, tmp2 =3D 1;
+
+=09asm volatile(
+=09"=09ldaxr=09%w0, [%2]\n"
+=09"=09add=09%w0, %w0, #1\n"
+=09"=09tbnz=09%w0, #31, 1f\n"
+=09"=09stxr=09%w1, %w0, [%2]\n"
+=09"1:\n"
+=09: "=3D&r" (tmp), "+r" (tmp2)
+=09: "r" (&rw->lock)
+=09: "memory");
+
+=09return !tmp2;
+}
+
+/* read_can_lock - would read_trylock() succeed? */
+#define arch_read_can_lock(x)=09=09((x)->lock < 0x80000000)
+
+#define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
+#define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
+
+#define arch_spin_relax(lock)=09cpu_relax()
+#define arch_read_relax(lock)=09cpu_relax()
+#define arch_write_relax(lock)=09cpu_relax()
+
+#endif /* __ASM_SPINLOCK_H */
diff --git a/arch/arm64/include/asm/spinlock_types.h b/arch/arm64/include/a=
sm/spinlock_types.h
new file mode 100644
index 0000000..9a49434
--- /dev/null
+++ b/arch/arm64/include/asm/spinlock_types.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_SPINLOCK_TYPES_H
+#define __ASM_SPINLOCK_TYPES_H
+
+#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__ASM_SPINLOCK_H)
+# error "please don't include this file directly"
+#endif
+
+/* We only require natural alignment for exclusive accesses. */
+#define __lock_aligned
+
+typedef struct {
+=09volatile unsigned int lock;
+} arch_spinlock_t;
+
+#define __ARCH_SPIN_LOCK_UNLOCKED=09{ 0 }
+
+typedef struct {
+=09volatile unsigned int lock;
+} arch_rwlock_t;
+
+#define __ARCH_RW_LOCK_UNLOCKED=09=09{ 0 }
+
+#endif
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
new file mode 100644
index 0000000..b711525
--- /dev/null
+++ b/arch/arm64/kernel/smp.c
@@ -0,0 +1,469 @@
+/*
+ * SMP initialisation and IPI support
+ * Based on arch/arm/kernel/smp.c
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/cache.h>
+#include <linux/profile.h>
+#include <linux/errno.h>
+#include <linux/mm.h>
+#include <linux/err.h>
+#include <linux/cpu.h>
+#include <linux/smp.h>
+#include <linux/seq_file.h>
+#include <linux/irq.h>
+#include <linux/percpu.h>
+#include <linux/clockchips.h>
+#include <linux/completion.h>
+#include <linux/of.h>
+
+#include <asm/atomic.h>
+#include <asm/cacheflush.h>
+#include <asm/cputype.h>
+#include <asm/mmu_context.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/processor.h>
+#include <asm/sections.h>
+#include <asm/tlbflush.h>
+#include <asm/ptrace.h>
+#include <asm/mmu_context.h>
+
+/*
+ * as from 2.5, kernels no longer have an init_tasks structure
+ * so we need some other way of telling a new secondary core
+ * where to place its SVC stack
+ */
+struct secondary_data secondary_data;
+volatile unsigned long secondary_holding_pen_release =3D -1;
+
+enum ipi_msg_type {
+=09IPI_RESCHEDULE,
+=09IPI_CALL_FUNC,
+=09IPI_CALL_FUNC_SINGLE,
+=09IPI_CPU_STOP,
+};
+
+static DEFINE_RAW_SPINLOCK(boot_lock);
+
+/*
+ * Write secondary_holding_pen_release in a way that is guaranteed to be
+ * visible to all observers, irrespective of whether they're taking part
+ * in coherency or not.  This is necessary for the hotplug code to work
+ * reliably.
+ */
+static void __cpuinit write_pen_release(int val)
+{
+=09void *start =3D (void *)&secondary_holding_pen_release;
+=09unsigned long size =3D sizeof(secondary_holding_pen_release);
+
+=09secondary_holding_pen_release =3D val;
+=09__flush_dcache_area(start, size);
+}
+
+/*
+ * Boot a secondary CPU, and assign it the specified idle task.
+ * This also gives us the initial stack to use for this CPU.
+ */
+static int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *=
idle)
+{
+=09unsigned long timeout;
+
+=09/*
+=09 * Set synchronisation state between this boot processor
+=09 * and the secondary one
+=09 */
+=09raw_spin_lock(&boot_lock);
+
+=09/*
+=09 * Update the pen release flag.
+=09 */
+=09write_pen_release(cpu);
+
+=09/*
+=09 * Send an event, causing the secondaries to read pen_release.
+=09 */
+=09sev();
+
+=09timeout =3D jiffies + (1 * HZ);
+=09while (time_before(jiffies, timeout)) {
+=09=09if (secondary_holding_pen_release =3D=3D -1UL)
+=09=09=09break;
+=09=09udelay(10);
+=09}
+
+=09/*
+=09 * Now the secondary core is starting up let it run its
+=09 * calibrations, then wait for it to finish
+=09 */
+=09raw_spin_unlock(&boot_lock);
+
+=09return secondary_holding_pen_release !=3D -1 ? -ENOSYS : 0;
+}
+
+static DECLARE_COMPLETION(cpu_running);
+
+int __cpuinit __cpu_up(unsigned int cpu, struct task_struct *idle)
+{
+=09int ret;
+
+=09/*
+=09 * We need to tell the secondary core where to find its stack and the
+=09 * page tables.
+=09 */
+=09secondary_data.stack =3D task_stack_page(idle) + THREAD_START_SP;
+=09__flush_dcache_area(&secondary_data, sizeof(secondary_data));
+
+=09/*
+=09 * Now bring the CPU into our world.
+=09 */
+=09ret =3D boot_secondary(cpu, idle);
+=09if (ret =3D=3D 0) {
+=09=09/*
+=09=09 * CPU was successfully started, wait for it to come online or
+=09=09 * time out.
+=09=09 */
+=09=09wait_for_completion_timeout(&cpu_running,
+=09=09=09=09=09    msecs_to_jiffies(1000));
+
+=09=09if (!cpu_online(cpu)) {
+=09=09=09pr_crit("CPU%u: failed to come online\n", cpu);
+=09=09=09ret =3D -EIO;
+=09=09}
+=09} else {
+=09=09pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
+=09}
+
+=09secondary_data.stack =3D NULL;
+
+=09return ret;
+}
+
+/*
+ * This is the secondary CPU boot entry.  We're using this CPUs
+ * idle thread stack, but a set of temporary page tables.
+ */
+asmlinkage void __cpuinit secondary_start_kernel(void)
+{
+=09struct mm_struct *mm =3D &init_mm;
+=09unsigned int cpu =3D smp_processor_id();
+
+=09printk("CPU%u: Booted secondary processor\n", cpu);
+
+=09/*
+=09 * All kernel threads share the same mm context; grab a
+=09 * reference and switch to it.
+=09 */
+=09atomic_inc(&mm->mm_count);
+=09current->active_mm =3D mm;
+=09cpumask_set_cpu(cpu, mm_cpumask(mm));
+
+=09/*
+=09 * TTBR0 is only used for the identity mapping at this stage. Make it
+=09 * point to zero page to avoid speculatively fetching new entries.
+=09 */
+=09cpu_set_reserved_ttbr0();
+=09flush_tlb_all();
+
+=09preempt_disable();
+=09trace_hardirqs_off();
+
+=09/*
+=09 * Let the primary processor know we're out of the
+=09 * pen, then head off into the C entry point
+=09 */
+=09write_pen_release(-1);
+
+=09/*
+=09 * Synchronise with the boot thread.
+=09 */
+=09raw_spin_lock(&boot_lock);
+=09raw_spin_unlock(&boot_lock);
+
+=09/*
+=09 * Enable local interrupts.
+=09 */
+=09notify_cpu_starting(cpu);
+=09local_irq_enable();
+=09local_fiq_enable();
+
+=09/*
+=09 * OK, now it's safe to let the boot CPU continue.  Wait for
+=09 * the CPU migration code to notice that the CPU is online
+=09 * before we continue.
+=09 */
+=09set_cpu_online(cpu, true);
+=09while (!cpu_active(cpu))
+=09=09cpu_relax();
+
+=09/*
+=09 * OK, it's off to the idle thread for us
+=09 */
+=09cpu_idle();
+}
+
+void __init smp_cpus_done(unsigned int max_cpus)
+{
+=09unsigned long bogosum =3D loops_per_jiffy * num_online_cpus();
+
+=09pr_info("SMP: Total of %d processors activated (%lu.%02lu BogoMIPS).\n"=
,
+=09=09num_online_cpus(), bogosum / (500000/HZ),
+=09=09(bogosum / (5000/HZ)) % 100);
+}
+
+void __init smp_prepare_boot_cpu(void)
+{
+}
+
+static void (*smp_cross_call)(const struct cpumask *, unsigned int);
+static phys_addr_t cpu_release_addr[NR_CPUS];
+
+/*
+ * Enumerate the possible CPU set from the device tree.
+ */
+void __init smp_init_cpus(void)
+{
+=09const char *enable_method;
+=09struct device_node *dn =3D NULL;
+=09int cpu =3D 0;
+
+=09while ((dn =3D of_find_node_by_type(dn, "cpu"))) {
+=09=09if (cpu >=3D NR_CPUS)
+=09=09=09goto next;
+
+=09=09/*
+=09=09 * We currently support only the "spin-table" enable-method.
+=09=09 */
+=09=09enable_method =3D of_get_property(dn, "enable-method", NULL);
+=09=09if (!enable_method || strcmp(enable_method, "spin-table")) {
+=09=09=09pr_err("CPU %d: missing or invalid enable-method property: %s\n",
+=09=09=09       cpu, enable_method);
+=09=09=09goto next;
+=09=09}
+
+=09=09/*
+=09=09 * Determine the address from which the CPU is polling.
+=09=09 */
+=09=09if (of_property_read_u64(dn, "cpu-release-addr",
+=09=09=09=09=09 &cpu_release_addr[cpu])) {
+=09=09=09pr_err("CPU %d: missing or invalid cpu-release-addr property\n",
+=09=09=09       cpu);
+=09=09=09goto next;
+=09=09}
+
+=09=09set_cpu_possible(cpu, true);
+next:
+=09=09cpu++;
+=09}
+
+=09/* sanity check */
+=09if (cpu > NR_CPUS)
+=09=09pr_warning("no. of cores (%d) greater than configured maximum of %d =
- clipping\n",
+=09=09=09   cpu, NR_CPUS);
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+=09int cpu;
+=09void **release_addr;
+=09unsigned int ncores =3D num_possible_cpus();
+
+=09/*
+=09 * are we trying to boot more cores than exist?
+=09 */
+=09if (max_cpus > ncores)
+=09=09max_cpus =3D ncores;
+
+=09/*
+=09 * Initialise the present map (which describes the set of CPUs
+=09 * actually populated at the present time) and release the
+=09 * secondaries from the bootloader.
+=09 */
+=09for_each_possible_cpu(cpu) {
+=09=09if (max_cpus =3D=3D 0)
+=09=09=09break;
+
+=09=09if (!cpu_release_addr[cpu])
+=09=09=09continue;
+
+=09=09release_addr =3D __va(cpu_release_addr[cpu]);
+=09=09release_addr[0] =3D (void *)__pa(secondary_holding_pen);
+=09=09__flush_dcache_area(release_addr, sizeof(release_addr[0]));
+
+=09=09set_cpu_present(cpu, true);
+=09=09max_cpus--;
+=09}
+
+=09/*
+=09 * Send an event to wake up the secondaries.
+=09 */
+=09sev();
+}
+
+
+void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned=
 int))
+{
+=09smp_cross_call =3D fn;
+}
+
+void arch_send_call_function_ipi_mask(const struct cpumask *mask)
+{
+=09smp_cross_call(mask, IPI_CALL_FUNC);
+}
+
+void arch_send_call_function_single_ipi(int cpu)
+{
+=09smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC_SINGLE);
+}
+
+static const char *ipi_types[NR_IPI] =3D {
+#define S(x,s)=09[x - IPI_RESCHEDULE] =3D s
+=09S(IPI_RESCHEDULE, "Rescheduling interrupts"),
+=09S(IPI_CALL_FUNC, "Function call interrupts"),
+=09S(IPI_CALL_FUNC_SINGLE, "Single function call interrupts"),
+=09S(IPI_CPU_STOP, "CPU stop interrupts"),
+};
+
+void show_ipi_list(struct seq_file *p, int prec)
+{
+=09unsigned int cpu, i;
+
+=09for (i =3D 0; i < NR_IPI; i++) {
+=09=09seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i + IPI_RESCHEDULE,
+=09=09=09   prec >=3D 4 ? " " : "");
+=09=09for_each_present_cpu(cpu)
+=09=09=09seq_printf(p, "%10u ",
+=09=09=09=09   __get_irq_stat(cpu, ipi_irqs[i]));
+=09=09seq_printf(p, "      %s\n", ipi_types[i]);
+=09}
+}
+
+u64 smp_irq_stat_cpu(unsigned int cpu)
+{
+=09u64 sum =3D 0;
+=09int i;
+
+=09for (i =3D 0; i < NR_IPI; i++)
+=09=09sum +=3D __get_irq_stat(cpu, ipi_irqs[i]);
+
+=09return sum;
+}
+
+static DEFINE_RAW_SPINLOCK(stop_lock);
+
+/*
+ * ipi_cpu_stop - handle IPI from smp_send_stop()
+ */
+static void ipi_cpu_stop(unsigned int cpu)
+{
+=09if (system_state =3D=3D SYSTEM_BOOTING ||
+=09    system_state =3D=3D SYSTEM_RUNNING) {
+=09=09raw_spin_lock(&stop_lock);
+=09=09pr_crit("CPU%u: stopping\n", cpu);
+=09=09dump_stack();
+=09=09raw_spin_unlock(&stop_lock);
+=09}
+
+=09set_cpu_online(cpu, false);
+
+=09local_fiq_disable();
+=09local_irq_disable();
+
+=09while (1)
+=09=09cpu_relax();
+}
+
+/*
+ * Main handler for inter-processor interrupts
+ */
+void handle_IPI(int ipinr, struct pt_regs *regs)
+{
+=09unsigned int cpu =3D smp_processor_id();
+=09struct pt_regs *old_regs =3D set_irq_regs(regs);
+
+=09if (ipinr >=3D IPI_RESCHEDULE && ipinr < IPI_RESCHEDULE + NR_IPI)
+=09=09__inc_irq_stat(cpu, ipi_irqs[ipinr - IPI_RESCHEDULE]);
+
+=09switch (ipinr) {
+=09case IPI_RESCHEDULE:
+=09=09scheduler_ipi();
+=09=09break;
+
+=09case IPI_CALL_FUNC:
+=09=09irq_enter();
+=09=09generic_smp_call_function_interrupt();
+=09=09irq_exit();
+=09=09break;
+
+=09case IPI_CALL_FUNC_SINGLE:
+=09=09irq_enter();
+=09=09generic_smp_call_function_single_interrupt();
+=09=09irq_exit();
+=09=09break;
+
+=09case IPI_CPU_STOP:
+=09=09irq_enter();
+=09=09ipi_cpu_stop(cpu);
+=09=09irq_exit();
+=09=09break;
+
+=09default:
+=09=09pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
+=09=09break;
+=09}
+=09set_irq_regs(old_regs);
+}
+
+void smp_send_reschedule(int cpu)
+{
+=09smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
+}
+
+void smp_send_stop(void)
+{
+=09unsigned long timeout;
+
+=09if (num_online_cpus() > 1) {
+=09=09cpumask_t mask;
+
+=09=09cpumask_copy(&mask, cpu_online_mask);
+=09=09cpu_clear(smp_processor_id(), mask);
+
+=09=09smp_cross_call(&mask, IPI_CPU_STOP);
+=09}
+
+=09/* Wait up to one second for other CPUs to stop */
+=09timeout =3D USEC_PER_SEC;
+=09while (num_online_cpus() > 1 && timeout--)
+=09=09udelay(1);
+
+=09if (num_online_cpus() > 1)
+=09=09pr_warning("SMP: failed to stop secondary CPUs\n");
+}
+
+/*
+ * not supported here
+ */
+int setup_profiling_timer(unsigned int multiplier)
+{
+=09return -EINVAL;
+}

