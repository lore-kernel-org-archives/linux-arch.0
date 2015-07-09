From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 12/24] mips: Provide atomic_{or,xor,and}
Date: Thu, 09 Jul 2015 19:29:07 +0200
Message-ID: <20150709175309.098420045@infradead.org>
References: <20150709172855.564686637@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-mips-atomic_logic_ops.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mips/include/asm/atomic.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -136,6 +136,9 @@ static __inline__ int atomic_##op##_retu
 
 ATOMIC_OPS(add, +=, addu)
 ATOMIC_OPS(sub, -=, subu)
+ATOMIC_OP(and, &=, and)
+ATOMIC_OP(or, |=, or)
+ATOMIC_OP(xor, ^=, xor)
 
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
@@ -416,6 +419,9 @@ static __inline__ long atomic64_##op##_r
 
 ATOMIC64_OPS(add, +=, daddu)
 ATOMIC64_OPS(sub, -=, dsubu)
+ATOMIC64_OP(and, &=, and)
+ATOMIC64_OP(or, |=, or)
+ATOMIC64_OP(xor, ^=, xor)
 
 #undef ATOMIC64_OPS
 #undef ATOMIC64_OP_RETURN
