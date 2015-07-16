From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 05/28] arm64: Provide atomic_{or,xor,and}
Date: Thu, 16 Jul 2015 19:21:15 +0200
Message-ID: <20150716172924.658524949@infradead.org>
References: <20150716172110.587529075@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-arm64-atomic_logic_ops.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/include/asm/atomic.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -85,6 +85,14 @@ static inline int atomic_##op##_return(i
 ATOMIC_OPS(add, add)
 ATOMIC_OPS(sub, sub)
 
+#define CONFIG_ARCH_HAS_ATOMIC_OR
+#define atomic_andnot atomic_andnot
+
+ATOMIC_OP(and, and)
+ATOMIC_OP(andnot, bic)
+ATOMIC_OP(or, orr)
+ATOMIC_OP(xor, eor)
+
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
@@ -183,6 +191,13 @@ static inline long atomic64_##op##_retur
 ATOMIC64_OPS(add, add)
 ATOMIC64_OPS(sub, sub)
 
+#define atomic64_andnot atomic64_andnot
+
+ATOMIC64_OP(and, and)
+ATOMIC64_OP(andnot, bic)
+ATOMIC64_OP(or, orr)
+ATOMIC64_OP(xor, eor)
+
 #undef ATOMIC64_OPS
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
