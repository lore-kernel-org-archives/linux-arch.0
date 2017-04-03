From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC][PATCH] spin loop arch primitives for busy waiting
Date: Mon,  3 Apr 2017 18:13:28 +1000
Message-ID: <20170403081328.30266-1-npiggin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, Anton Blanchard <anton@samba.org>
List-Id: linux-arch.vger.kernel.org

Hi,

I would like to revisit this again and see if people are opposed to this
arch primitive. We have attributed cases of suboptimal performance on
real customer workloads to this, so I'd like to find a solution.

Since last posting, I promised the s390 people I'd consider hypervisor
yield additions. I'd like to punt that until after getting the basic
primitives in. HV yielding can still be done within these loops, but
there's no real simple recipe that's useful to add, that I've found yet.
We have cpu_relax_yield, but it's barely used so I prefer to avoid
over-engineering something that's not well tested.

Thanks,
Nick


Current busy-wait loops are implemented by once calling cpu_relax() to
give a low latency arch option for improving power and/or SMT resource
consumption.

This poses some difficulties for powerpc, which has SMT priority setting
instructions where relative priorities between threads determine how
ifetch cycles are apportioned. cpu_relax() is implemented by setting a
low priority then setting normal priority. This has several problems:

 - Changing thread priority can have some execution cost and potential
   impact to other threads in the core. It's inefficient to execute them
   every time around a busy-wait loop.

 - Depending on implementation details, a `low ; medium` sequence may
   not have much if any affect. Some software with similar pattern
   actually inserts a lot of nops between, in order to cause a few
   fetch cycles with the low priority.

 - The rest of the busy-wait loop runs with regular priority. This
   might only be a few fetch cycles, but if there are several threads
   running such loops, they could cause a noticable impact on a non-idle
   thread.

Implement spin_do {} spin_while(), and spin_do {} spin_until()
primitives ("until" tends to be quite readable for busy-wait loops),
which allows powerpc to enter low SMT priority, run the loop, then enter
normal SMT priority.

The loops have some restrictions on what can be used, but they are
intended to be small and simple so it's not generally a problem:
 - Don't use cpu_relax.
 - Don't use return or goto.
 - Don't use sleeping or spinning primitives.

---
 include/linux/processor.h            | 43 ++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 include/linux/processor.h

diff --git a/include/linux/processor.h b/include/linux/processor.h
new file mode 100644
index 000000000000..282457cd9b67
--- /dev/null
+++ b/include/linux/processor.h
@@ -0,0 +1,43 @@
+/* Misc low level processor primitives */
+#ifndef _LINUX_PROCESSOR_H
+#define _LINUX_PROCESSOR_H
+
+#include <asm/processor.h>
+
+/*
+ * Begin a busy-wait loop, terminated with spin_while() or spin_until().
+ * This can be used in place of cpu_relax, and should be optimized to be
+ * used where wait times are expected to be less than the cost of a context
+ * switch.
+ *
+ * These loops should be very simple, and avoid calling cpu_relax, or
+ * any "spin" or sleep type of primitive. That should not cause a bug, just
+ * possible suboptimal behaviour on some implementations.
+ *
+ * The most common / fastpath exit case(s) should be tested in the
+ * spin_while / spin_until conditions. Uncommon cases can use break from
+ * within the loop. Return and goto must not be used to exit from the
+ * loop.
+ *
+ * Guest yielding and such techniques are to be implemented by the caller.
+ */
+#ifndef spin_do
+#define spin_do								\
+do {									\
+	do {								\
+		cpu_relax();						\
+#endif
+
+#ifndef spin_while
+#define spin_while(cond)						\
+	} while (cond);							\
+} while (0)
+#endif
+
+#ifndef spin_until
+#define spin_until(cond)						\
+	} while (!(cond));						\
+} while (0)
+#endif
+
+#endif /* _LINUX_PROCESSOR_H */
-- 
2.11.0
