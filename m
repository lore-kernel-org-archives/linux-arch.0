From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Date: Tue, 4 Apr 2017 14:11:21 +1000
Message-ID: <20170404141121.5510e925@roar.ozlabs.ibm.com>
References: <20170403081328.30266-1-npiggin@gmail.com>
        <CA+55aFx92vOh28CWp5zid8RzbM=5pO0Or51zS4D8M97L=69hHA@mail.gmail.com>
        <20170404095001.664718b8@roar.ozlabs.ibm.com>
        <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
        <20170404130233.1f45115b@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34744 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbdDDELd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2017 00:11:33 -0400
In-Reply-To: <20170404130233.1f45115b@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>

On Tue, 4 Apr 2017 13:02:33 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Mon, 3 Apr 2017 17:43:05 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 

> > But that depends on architectures having some pattern that we *can*
> > abstract. Would some "begin/in-loop/end" pattern like the above be
> > sufficient?  
> 
> Yes. begin/in/end would be sufficient for powerpc SMT priority, and
> for x86, and it looks like sparc64 too. So we could do that if you
> prefer.

How's this? I changed your name a bit just so we have a common spin_
prefix. With example powerpc implementation and one caller converted
to see the effect.

---
 arch/powerpc/include/asm/processor.h | 17 +++++++++++++
 include/linux/processor.h            | 48 ++++++++++++++++++++++++++++++++++++
 kernel/sched/idle.c                  |  7 +++++-
 3 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/processor.h

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index e9bbd450d966..1274dc818e74 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -402,6 +402,23 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
 
 #ifdef CONFIG_PPC64
 #define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
+
+#ifndef spin_begin
+#define spin_begin()	HMT_low()
+#endif
+
+#ifndef spin_cpu_relax
+#define spin_cpu_relax()	barrier()
+#endif
+
+#ifndef spin_cpu_yield
+#define spin_cpu_yield()
+#endif
+
+#ifndef spin_end
+#define spin_end()	HMT_medium()
+#endif
+
 #else
 #define cpu_relax()	barrier()
 #endif
diff --git a/include/linux/processor.h b/include/linux/processor.h
new file mode 100644
index 000000000000..65e5635d0069
--- /dev/null
+++ b/include/linux/processor.h
@@ -0,0 +1,48 @@
+/* Misc low level processor primitives */
+#ifndef _LINUX_PROCESSOR_H
+#define _LINUX_PROCESSOR_H
+
+#include <asm/processor.h>
+
+/*
+ * spin_begin is used before beginning a busy-wait loop, and must be paired
+ * with spin_end when the loop is exited. spin_cpu_relax must be called
+ * within the loop.
+ *
+ * These loop body should be as small and fast as possible, on the order of
+ * tens of instructions/cycles as a guide. It should and avoid calling
+ * cpu_relax, or any "spin" or sleep type of primitive including nested uses
+ * of these primitives. It should not lock or take any other resource.
+ * Violations of this will not cause a bug, but may cause sub optimal
+ * performance.
+ *
+ * These loops are optimized to be used where wait times are expected to be
+ * less than the cost of a context switch (and associated overhead).
+ *
+ * Detection of resource owner and decision to spin or sleep or guest-yield
+ * (e.g., spin lock holder vcpu preempted, or mutex owner not on CPU) can be
+ * tested within the busy loop body if necessary.
+ */
+#ifndef spin_begin
+#define spin_begin()
+#endif
+
+#ifndef spin_cpu_relax
+#define spin_cpu_relax() cpu_relax()
+#endif
+
+/*
+ * spin_cpu_yield may be called to yield (undirected) to the hypervisor if
+ * necessary. This should be used if the wait is expected to take longer
+ * than context switch overhead, but we can't sleep or do a directed yield.
+ */
+#ifndef spin_cpu_yield
+#define spin_cpu_yield() cpu_relax_yield()
+#endif
+
+#ifndef spin_end
+#define spin_end()
+#endif
+
+#endif /* _LINUX_PROCESSOR_H */
+
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index ac6d5176463d..99a032d9f4a9 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/stackprotector.h>
 #include <linux/suspend.h>
+#include <linux/processor.h>
 
 #include <asm/tlb.h>
 
@@ -63,9 +64,13 @@ static noinline int __cpuidle cpu_idle_poll(void)
 	trace_cpu_idle_rcuidle(0, smp_processor_id());
 	local_irq_enable();
 	stop_critical_timings();
+
+	spin_begin();
 	while (!tif_need_resched() &&
 		(cpu_idle_force_poll || tick_check_broadcast_expired()))
-		cpu_relax();
+		spin_cpu_relax();
+	spin_end();
+
 	start_critical_timings();
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 	rcu_idle_exit();
-- 
2.11.0
