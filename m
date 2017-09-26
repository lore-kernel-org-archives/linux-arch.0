From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCHv2] percpu: make this_cpu_generic_read() atomic w.r.t. interrupts
Date: Tue, 26 Sep 2017 12:41:52 +0100
Message-ID: <1506426112-19826-1-git-send-email-mark.rutland@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751450AbdIZLnW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Sep 2017 07:43:22 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux.com>, Peter Zijlstra <peterz@infradead.org>, Pranith Kumar <bobby.prani@gmail.com>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org

As raw_cpu_generic_read() is a plain read from a raw_cpu_ptr() address,
it's possible (albeit unlikely) that the compiler will split the access
across multiple instructions.

In this_cpu_generic_read() we disable preemption but not interrupts
before calling raw_cpu_generic_read(). Thus, an interrupt could be taken
in the middle of the split load instructions. If a this_cpu_write() or
RMW this_cpu_*() op is made to the same variable in the interrupt
handling path, this_cpu_read() will return a torn value.

For native word types, we can avoid tearing using READ_ONCE(), but this
won't work in all cases (e.g. 64-bit types on most 32-bit platforms).
This patch reworks this_cpu_generic_read() to use READ_ONCE() where
possible, otherwise falling back to disabling interrupts.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Lameter <cl@linux.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Pranith Kumar <bobby.prani@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
---
 include/asm-generic/percpu.h | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

Since v1 [1]:
* Use READ_ONCE() only for native word types
* Disable IRQs for non-native word types

[1] https://lkml.kernel.org/r/1506345872-30559-1-git-send-email-mark.rutland@arm.com

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 0504ef8..976f8ac 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -115,15 +115,35 @@
 	(__ret);							\
 })
 
-#define this_cpu_generic_read(pcp)					\
+#define __this_cpu_generic_read_nopreempt(pcp)				\
 ({									\
 	typeof(pcp) __ret;						\
 	preempt_disable_notrace();					\
-	__ret = raw_cpu_generic_read(pcp);				\
+	__ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));			\
 	preempt_enable_notrace();					\
 	__ret;								\
 })
 
+#define __this_cpu_generic_read_noirq(pcp)				\
+({									\
+	typeof(pcp) __ret;						\
+	unsigned long __flags;						\
+	raw_local_irq_save(__flags);					\
+	__ret = raw_cpu_generic_read(pcp);				\
+	raw_local_irq_restore(__flags);					\
+	__ret;								\
+})
+
+#define this_cpu_generic_read(pcp)					\
+({									\
+	typeof(pcp) __ret;						\
+	if (__native_word(pcp))						\
+		__ret = __this_cpu_generic_read_nopreempt(pcp);		\
+	else								\
+		__ret = __this_cpu_generic_read_noirq(pcp);		\
+	__ret;								\
+})
+
 #define this_cpu_generic_to_op(pcp, val, op)				\
 do {									\
 	unsigned long __flags;						\
-- 
1.9.1
