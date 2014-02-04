From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH] ia64: Fix atomic ops vs memory barriers
Date: Tue, 4 Feb 2014 14:37:00 +0100
Message-ID: <20140204133700.GE3229@twins.programming.kicks-ass.net>
References: <20140204122212.GO8874@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45599 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbaBDNhL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2014 08:37:11 -0500
Content-Disposition: inline
In-Reply-To: <20140204122212.GO8874@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>

On Tue, Feb 04, 2014 at 01:22:12PM +0100, Peter Zijlstra wrote:
> 
> The IA64 SDM V1-4.4.7 describes the memory ordering rules of IA64.
> 
> It states that the cmpxchg.{rel,acq} really have release and acquire
> semantics and that xchg has acquire semantics.
> 
> Despite this the ia64 atomic_t code says that all atomic ops are fully
> serialized, and its smp_mb__{before,after}_atomic_{inc,dec} are
> barrier().
> 
> OTOH the atomic bitops, which are identically implemented (using
> cmpxchg.acq), state that they have acquire semantics and set
> smp_mb__before_clear_bit() to smp_mb().
> 
> Now either the SDM and the bitops are right, which means the atomic_t,
> cmpxchg() and xchg() implementations are wrong, or the SDM is wrong and
> cmpxchg.acq is actually fully serialized after all and the bitops
> implementation is wrong, not to mention there's a big fat comment
> missing someplace.
> 
> 
> The below patch assumes the SDM is right (TM), and fixes the atomic_t,
> cmpxchg() and xchg() implementations by inserting a mf before the
> cmpxchg.acq (or xchg).
> 
> This way loads/stores before the mf stay there, loads/stores after the
> cmpxchg.acq also stay after and the entire thing acts as a fully
> serialized op the way it is supposed to.
> 
> For things like ia64_atomic_sub() which is a cmpxchg.acq loop with an
> unordered load in, it still works because there is a control dependency
> upon the cmpxchg op, therefore the load cannot escape.
> 

And assuming all that is true; we also need the below on top.

Because when one writes:

  atomic_dec();
  smp_mb__after_atomic_dec();

One actually expects a full barrier, not an acquire.

---
--- a/arch/ia64/include/asm/atomic.h
+++ b/arch/ia64/include/asm/atomic.h
@@ -225,8 +225,8 @@ atomic64_add_negative (__s64 i, atomic64
 
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()	smp_mb()
-#define smp_mb__after_atomic_dec()	barrier()
+#define smp_mb__after_atomic_dec()	smp_mb()
 #define smp_mb__before_atomic_inc()	smp_mb()
-#define smp_mb__after_atomic_inc()	barrier()
+#define smp_mb__after_atomic_inc()	smp_mb()
 
 #endif /* _ASM_IA64_ATOMIC_H */
--- a/arch/ia64/include/asm/bitops.h
+++ b/arch/ia64/include/asm/bitops.h
@@ -69,7 +69,7 @@ __set_bit (int nr, volatile void *addr)
  * clear_bit() has "acquire" semantics.
  */
 #define smp_mb__before_clear_bit()	smp_mb()
-#define smp_mb__after_clear_bit()	barrier()
+#define smp_mb__after_clear_bit()	smp_mb()
 
 /**
  * clear_bit - Clears a bit in memory
