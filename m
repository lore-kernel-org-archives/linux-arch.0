From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled synchronisation with actual irq state
Date: Thu, 23 Jul 2020 20:56:14 +1000
Message-ID: <20200723105615.1268126-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgGWK40 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 06:56:26 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

If an interrupt is not masked by local_irq_disable (e.g., a powerpc perf
interrupt), then it can hit in local_irq_enable() after trace_hardirqs_on()
and before raw_local_irq_enable().

If that interrupt handler calls local_irq_save(), it will call
trace_hardirqs_off() but the local_irq_restore() will not call
trace_hardirqs_on() again because raw_irqs_disabled_flags(flags) is true.

This can lead lockdep_assert_irqs_enabled() to trigger false positive
warnings.

Fix this by being careful to only enable and disable trace_hardirqs with
the outer-most irq enable/disable.

Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

I haven't tested on other architectures but I imagine NMIs in general
might cause a similar problem.

Other architectures might have to be updated for patch 2, but there's
a lot of asm around interrupt/return, so I didn't have a very good
lock. The warnings should be harmless enough and uncover most places
that need updating.

 arch/powerpc/include/asm/hw_irq.h | 11 ++++-------
 include/linux/irqflags.h          | 29 ++++++++++++++++++-----------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 3a0db7b0b46e..35060be09073 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
 #define powerpc_local_irq_pmu_save(flags)			\
 	 do {							\
 		raw_local_irq_pmu_save(flags);			\
-		trace_hardirqs_off();				\
+		if (!raw_irqs_disabled_flags(flags))		\
+			trace_hardirqs_off();			\
 	} while(0)
 #define powerpc_local_irq_pmu_restore(flags)			\
 	do {							\
-		if (raw_irqs_disabled_flags(flags)) {		\
-			raw_local_irq_pmu_restore(flags);	\
-			trace_hardirqs_off();			\
-		} else {					\
+		if (!raw_irqs_disabled_flags(flags))		\
 			trace_hardirqs_on();			\
-			raw_local_irq_pmu_restore(flags);	\
-		}						\
+		raw_local_irq_pmu_restore(flags);		\
 	} while(0)
 #else
 #define powerpc_local_irq_pmu_save(flags)			\
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 6384d2813ded..571ee29ecefc 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -163,26 +163,33 @@ do {						\
  * if !TRACE_IRQFLAGS.
  */
 #ifdef CONFIG_TRACE_IRQFLAGS
-#define local_irq_enable() \
-	do { trace_hardirqs_on(); raw_local_irq_enable(); } while (0)
-#define local_irq_disable() \
-	do { raw_local_irq_disable(); trace_hardirqs_off(); } while (0)
+#define local_irq_enable()				\
+	do {						\
+		trace_hardirqs_on();			\
+		raw_local_irq_enable();			\
+	} while (0)
+
+#define local_irq_disable()				\
+	do {						\
+		bool was_disabled = raw_irqs_disabled(); \
+		raw_local_irq_disable();		\
+		if (!was_disabled)			\
+			trace_hardirqs_off();		\
+	} while (0)
+
 #define local_irq_save(flags)				\
 	do {						\
 		raw_local_irq_save(flags);		\
-		trace_hardirqs_off();			\
+		if (!raw_irqs_disabled_flags(flags))	\
+			trace_hardirqs_off();		\
 	} while (0)
 
 
 #define local_irq_restore(flags)			\
 	do {						\
-		if (raw_irqs_disabled_flags(flags)) {	\
-			raw_local_irq_restore(flags);	\
-			trace_hardirqs_off();		\
-		} else {				\
+		if (!raw_irqs_disabled_flags(flags))	\
 			trace_hardirqs_on();		\
-			raw_local_irq_restore(flags);	\
-		}					\
+		raw_local_irq_restore(flags);		\
 	} while (0)
 
 #define safe_halt()				\
-- 
2.23.0
