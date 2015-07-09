From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 14/24] parisc: Provide atomic_{or,xor,and}
Date: Thu, 09 Jul 2015 19:29:09 +0200
Message-ID: <20150709175309.268840015@infradead.org>
References: <20150709172855.564686637@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-parisc-atomic_logic_ops.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/parisc/include/asm/atomic.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -125,6 +125,9 @@ static __inline__ int atomic_##op##_retu
 
 ATOMIC_OPS(add, +=)
 ATOMIC_OPS(sub, -=)
+ATOMIC_OP(and, &=)
+ATOMIC_OP(or, |=)
+ATOMIC_OP(xor, ^=)
 
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
@@ -185,6 +188,9 @@ static __inline__ s64 atomic64_##op##_re
 
 ATOMIC64_OPS(add, +=)
 ATOMIC64_OPS(sub, -=)
+ATOMIC64_OP(and, &=)
+ATOMIC64_OP(or, |=)
+ATOMIC64_OP(xor, ^=)
 
 #undef ATOMIC64_OPS
 #undef ATOMIC64_OP_RETURN
