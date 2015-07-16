From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 01/28] atomic: Prepare generic atomic implementation for logic ops
Date: Thu, 16 Jul 2015 19:21:11 +0200
Message-ID: <20150716172924.340646096@infradead.org>
References: <20150716172110.587529075@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-generic-prepare.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Clean up the #ifdef guards a bit to prepare for architectures to
supply their own logic ops.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/atomic.h |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -98,14 +98,22 @@ ATOMIC_OP_RETURN(add, +)
 ATOMIC_OP_RETURN(sub, -)
 #endif
 
-#ifndef atomic_clear_mask
+#ifndef atomic_and
 ATOMIC_OP(and, &)
+#endif
+
+#ifndef atomic_clear_mask
 #define atomic_clear_mask(i, v) atomic_and(~(i), (v))
 #endif
 
-#ifndef atomic_set_mask
+#ifndef atomic_or
+#ifndef CONFIG_ARCH_HAS_ATOMIC_OR
 #define CONFIG_ARCH_HAS_ATOMIC_OR
+#endif
 ATOMIC_OP(or, |)
+#endif
+
+#ifndef atomic_set_mask
 #define atomic_set_mask(i, v)	atomic_or((i), (v))
 #endif
 
