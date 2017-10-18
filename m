From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4.1.y] percpu: make this_cpu_generic_read() atomic w.r.t. interrupts
Date: Wed, 18 Oct 2017 14:33:43 +0100
Message-ID: <20171018133343.55337-1-mark.rutland@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40672 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752652AbdJRNdw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Oct 2017 09:33:52 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux.com>, Peter Zijlstra <peterz@infradead.org>, Pranith Kumar <bobby.prani@gmail.com>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org

Commit e88d62cd4b2f0b1ae55e9008e79c2794b1fc914d upstream.

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
Cc: stable@vger.kernel.org
Signed-off-by: Tejun Heo <tj@kernel.org>
[Mark: backport to v4.1.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 include/asm-generic/percpu.h | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 4d9f233c4ba8..7d58ffdacd62 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -105,15 +105,35 @@ do {									\
 	(__ret);							\
 })
 
-#define this_cpu_generic_read(pcp)					\
+#define __this_cpu_generic_read_nopreempt(pcp)				\
 ({									\
 	typeof(pcp) __ret;						\
 	preempt_disable();						\
-	__ret = *this_cpu_ptr(&(pcp));					\
+	__ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));			\
 	preempt_enable();						\
 	__ret;								\
 })
 
+#define __this_cpu_generic_read_noirq(pcp)				\
+({									\
+	typeof(pcp) __ret;						\
+	unsigned long __flags;						\
+	raw_local_irq_save(__flags);					\
+	__ret = *raw_cpu_ptr(&(pcp));					\
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
2.11.0
