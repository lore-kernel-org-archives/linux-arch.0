From: Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Wed, 03 Jan 2018 16:15:03 -0800
Message-ID: <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20180103223827.39601-1-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103223827.39601-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

The 'if_nospec' primitive marks locations where the kernel is disabling
speculative execution that could potentially access privileged data. It
is expected to be paired with a 'nospec_{ptr,load}' where the user
controlled value is actually consumed. Architectures can optionally
implement a speculation barrier in 'if_nospec' or a speculation sync in
each 'nospec_{ptr,load}' depending what is best/feasible for the
architecture.

The pairing of if_nospec and nospec_load documents which branch
is sensitive to which load(s) in a code block. For example:

	if_nospec(foo < bar) {
		ptr = array_base + foo;
		array_max = array_base + bar;
		baz = nospec_load(ptr, array_base, array_max);
	}

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

This proposal builds on Mark's nospec_load RFC here:

    https://lkml.org/lkml/2018/1/3/754

...and combines it with a suggestion from Peter to introduce if_nospec.
The goal is to both document which loads must not be speculated behind
which branches, and allow architectures like x86 that can do a single
barrier after the branch to coexist with architectures like ARM that
want to instrument each load.

 include/asm-generic/barrier.h |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 5eba6ae0c34e..25c1b47f84b7 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -55,6 +55,27 @@
 #endif
 
 /**
+ * if_nospec() - block speculative execution of this branch
+ *
+ * @cond: condition that if true should barrier speculation
+ *
+ * Architectures should override the definition of nospec_barrier() to
+ * inject a speculative execution barrier for any conditional branches
+ * that might speculatively execute reads based on user controlled
+ * value.  Architectures that can more efficiently flush speculation via
+ * nospec_load can leave nospec_barrier as a nop.
+ *
+ * The expectation is that nospec_{load,ptr} are always used inside an
+ * if_nospec block so that architectures that can use a single barrier
+ * after the branch can do that once rather than per access.
+ */
+#define if_nospec(cond)	if (({ bool ret = (cond); nospec_barrier(); ret }))
+
+#ifndef nospec_barrier
+#define nospec_barrier() do { } while (0)
+#endif
+
+/**
  * nospec_ptr() - Ensure a  pointer is bounded, even under speculation.
  *
  * @ptr: the pointer to test
@@ -68,6 +89,11 @@
  * interval both under architectural execution and under speculation,
  * preventing propagation of an out-of-bounds pointer to code which is
  * speculatively executed.
+ *
+ * Architectures that can more efficiently flush speculation via
+ * nospec_barrier can define nospec_ptr as a nop.
+ *
+ * The expectation is that if_nospec and nospec_ptr are always paired.
  */
 #ifndef nospec_ptr
 #define nospec_ptr(ptr, lo, hi)						\
@@ -93,6 +119,11 @@
  * Architectures should override this to ensure that ptr falls in the [lo, hi)
  * interval both under architectural execution and under speculation,
  * preventing speculative out-of-bounds reads.
+ *
+ * Architectures that can more efficiently flush speculation via
+ * nospec_barrier can define nospec_load as a nop.
+ *
+ * The expectation is that if_nospec and nospec_load are always paired.
  */
 #ifndef nospec_load
 #define nospec_load(ptr, lo, hi)					\
