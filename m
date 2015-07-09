From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 05/24] avr32: Provide atomic_{or,xor,and}
Date: Thu, 09 Jul 2015 19:29:00 +0200
Message-ID: <20150709175308.450714909@infradead.org>
References: <20150709172855.564686637@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-avr32-atomic_logic_ops.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/avr32/include/asm/atomic.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/arch/avr32/include/asm/atomic.h
+++ b/arch/avr32/include/asm/atomic.h
@@ -44,6 +44,18 @@ static inline int __atomic_##op##_return
 ATOMIC_OP_RETURN(sub, sub, rKs21)
 ATOMIC_OP_RETURN(add, add, r)
 
+#define ATOMIC_OP(op, asm_op)						\
+ATOMIC_OP_RETURN(op, asm_op, r)						\
+static inline void atomic_##op(int i, atomic_t *v)			\
+{									\
+	(void)__atomic_##op##_return(i, v);				\
+}
+
+ATOMIC_OP(and, and)
+ATOMIC_OP(or, or)
+ATOMIC_OP(xor, eor)
+
+#undef ATOMIC_OP
 #undef ATOMIC_OP_RETURN
 
 /*
