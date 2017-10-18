From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3.10.y] percpu: make this_cpu_generic_read() atomic w.r.t. interrupts
Date: Wed, 18 Oct 2017 14:36:41 +0100
Message-ID: <20171018133641.25078-1-mark.rutland@arm.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux.com>, Peter Zijlstra <peterz@infradead.org>, Pranith Kumar <bobby.prani@gmail.com>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
[Mark: backport to v3.10.y:
 folded in __native_word from upstream commits
 - 47933ad41a86a4a9 ("arch: Introduce smp_load_acquire(), smp_store_release()")
 - 536fa402221f0963 ("compiler: Allow 1- and 2-byte smp_load_acquire() and smp_store_release()")
]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/compiler.h |  5 +++++
 include/linux/percpu.h   | 29 +++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index a2ce6f8871c4..84d36b5ce832 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -302,6 +302,11 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
 # define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 #endif
 
+/* Is this type a native word size -- useful for atomic operations */
+#ifndef __native_word
+# define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
+#endif
+
 /* Compile time object size, -1 for unknown */
 #ifndef __compiletime_object_size
 # define __compiletime_object_size(obj) -1
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index cc88172c7d9a..3c047cd54ca0 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -267,12 +267,33 @@ do {									\
  *    used.
  */
 
-#define _this_cpu_generic_read(pcp)					\
-({	typeof(pcp) ret__;						\
+#define __this_cpu_generic_read_nopreempt(pcp)				\
+({									\
+	typeof(pcp) __ret;						\
 	preempt_disable();						\
-	ret__ = *this_cpu_ptr(&(pcp));					\
+	__ret = ACCESS_ONCE(*this_cpu_ptr(&(pcp)));			\
 	preempt_enable();						\
-	ret__;								\
+	__ret;								\
+})
+
+#define __this_cpu_generic_read_noirq(pcp)				\
+({									\
+	typeof(pcp) __ret;						\
+	unsigned long __flags;						\
+	raw_local_irq_save(__flags);					\
+	__ret = *this_cpu_ptr(&(pcp)); 					\
+	raw_local_irq_restore(__flags);					\
+	__ret;								\
+})
+
+#define _this_cpu_generic_read(pcp)					\
+({									\
+	typeof(pcp) __ret;						\
+	if (__native_word(pcp))						\
+		__ret = __this_cpu_generic_read_nopreempt(pcp);		\
+	else								\
+		__ret = __this_cpu_generic_read_noirq(pcp);		\
+	__ret;								\
 })
 
 #ifndef this_cpu_read
-- 
2.11.0
