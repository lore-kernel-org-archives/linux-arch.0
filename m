From: Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/5] x86/smp: Add saturated +1/+2 1-byte cpu numbers
Date: Thu, 16 Jul 2020 15:29:23 -0400
Message-ID: <20200716192927.12944-2-longman@redhat.com>
References: <20200716192927.12944-1-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200716192927.12944-1-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

Both qspinlock and qrwlock use one whole byte to store the binary
lock/unlock state. We can actually store more information in the
lock byte like an encoded lock holder cpu number to aid debugging
and crash dump analysis.

To make that possible, a saturated +1 and +2 1-byte per-cpu cpu numbers
are added. The qrwlock can use the +1 number for the lock holding writer
and the qspinlock can use the +2 number for the lock holder.

The new per-cpu numbers are placed right after the commonly used
cpu_number (smp_processor_id()) which has more 1700 references in the
kernel. Therefore these new cpu numbers are very likely to be located
in the same hot cacheline as cpu_number.  As these numbers are before
the unsigned long this_cpu_off, no additional percpu space will be
consumed in x86-64.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/include/asm/spinlock.h |  5 +++++
 arch/x86/kernel/setup_percpu.c  | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 5b6bc7016c22..319fa58caa9b 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -10,6 +10,11 @@
 #include <asm/paravirt.h>
 #include <asm/bitops.h>
 
+DECLARE_PER_CPU_READ_MOSTLY(u8, cpu_number_sadd1);
+DECLARE_PER_CPU_READ_MOSTLY(u8, cpu_number_sadd2);
+#define __cpu_number_sadd1	this_cpu_read(cpu_number_sadd1)
+#define __cpu_number_sadd2	this_cpu_read(cpu_number_sadd2)
+
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
  *
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index fd945ce78554..859c5b950d08 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -26,6 +26,14 @@
 DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
 EXPORT_PER_CPU_SYMBOL(cpu_number);
 
+/*
+ * Saturated +1 and +2 1-byte cpu numbers
+ */
+DEFINE_PER_CPU_READ_MOSTLY(u8, cpu_number_sadd1); /* +1 saturated cpu# */
+DEFINE_PER_CPU_READ_MOSTLY(u8, cpu_number_sadd2); /* +2 saturated cpu# */
+EXPORT_PER_CPU_SYMBOL(cpu_number_sadd1);
+EXPORT_PER_CPU_SYMBOL(cpu_number_sadd2);
+
 #ifdef CONFIG_X86_64
 #define BOOT_PERCPU_OFFSET ((unsigned long)__per_cpu_load)
 #else
@@ -223,6 +231,9 @@ void __init setup_per_cpu_areas(void)
 		per_cpu_offset(cpu) = delta + pcpu_unit_offsets[cpu];
 		per_cpu(this_cpu_off, cpu) = per_cpu_offset(cpu);
 		per_cpu(cpu_number, cpu) = cpu;
+		per_cpu(cpu_number_sadd1, cpu) = (cpu + 1 < 0x100) ? cpu + 1 : 0xff;
+		per_cpu(cpu_number_sadd2, cpu) = (cpu + 2 < 0x100) ? cpu + 2 : 0xff;
+
 		setup_percpu_segment(cpu);
 		setup_stack_canary_segment(cpu);
 		/*
-- 
2.18.1
