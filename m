From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] percpu: make this_cpu_generic_read() atomic w.r.t. interrupts
Date: Mon, 25 Sep 2017 14:24:32 +0100
Message-ID: <1506345872-30559-1-git-send-email-mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux.com>, Peter Zijlstra <peterz@infradead.org>, Pranith Kumar <bobby.prani@gmail.com>, Tejun Heo <tj@kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

As raw_cpu_generic_read() is a plain read from a raw_cpu_ptr() address,
it's possible (albeit unlikely) that the compiler will split the access
across multiple instructions.

In this_cpu_generic_read() we disable preemption but not interrupts
before calling raw_cpu_generic_read(). Thus, an interrupt could be taken
in the middle of the split load instructions. If a this_cpu_write() or
RMW this_cpu_*() op is made to the same variable in the interrupt
handling path, this_cpu_read() will return a torn value.

Avoid this by using READ_ONCE() to inhibit tearing.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Lameter <cl@linux.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Pranith Kumar <bobby.prani@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-arch@vger.kernel.org
---
 include/asm-generic/percpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 0504ef8..79a8a58 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -67,7 +67,7 @@
 
 #define raw_cpu_generic_read(pcp)					\
 ({									\
-	*raw_cpu_ptr(&(pcp));						\
+	READ_ONCE(*raw_cpu_ptr(&(pcp)));				\
 })
 
 #define raw_cpu_generic_to_op(pcp, val, op)				\
-- 
1.9.1
