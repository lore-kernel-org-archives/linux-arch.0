From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC][PATCH 05/31] locking,arm64: Implement
 atomic{,64}_fetch_{add,sub,and,andnot,or,xor}{,_relaxed,_acquire,_release}()
Date: Fri, 22 Apr 2016 15:23:16 +0100
Message-ID: <20160422142316.GI10289@arm.com>
References: <20160422090413.393652501@infradead.org>
 <20160422093923.366551860@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34838 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850AbcDVOXY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 22 Apr 2016 10:23:24 -0400
Content-Disposition: inline
In-Reply-To: <20160422093923.366551860@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com

On Fri, Apr 22, 2016 at 11:04:18AM +0200, Peter Zijlstra wrote:
> Implement FETCH-OP atomic primitives, these are very similar to the
> existing OP-RETURN primitives we already have, except they return the
> value of the atomic variable _before_ modification.
> 
> This is especially useful for irreversible operations -- such as
> bitops (because it becomes impossible to reconstruct the state prior
> to modification).

The LSE bits will take me some time, but you're also missing some stuff
for the LL/SC variants. Fixup below.

Will

--->8

From ff2863445fb2a11dcd0cab4aaaeebe28aa5c9937 Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Fri, 22 Apr 2016 14:30:54 +0100
Subject: [PATCH] fixup! locking,arm64: Implement
 atomic{,64}_fetch_{add,sub,and,andnot,or,xor}{,_relaxed,_acquire,_release}()

Get the ll/sc stuff building and working

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic.h       | 30 ++++++++++++++++++++++++++++++
 arch/arm64/include/asm/atomic_ll_sc.h |  8 ++++----
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index 83b74b67c04b..c0235e0ff849 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -155,6 +155,36 @@
 #define atomic64_dec_return_release(v)	atomic64_sub_return_release(1, (v))
 #define atomic64_dec_return(v)		atomic64_sub_return(1, (v))
 
+#define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
+#define atomic64_fetch_add_acquire	atomic64_fetch_add_acquire
+#define atomic64_fetch_add_release	atomic64_fetch_add_release
+#define atomic64_fetch_add		atomic64_fetch_add
+
+#define atomic64_fetch_sub_relaxed	atomic64_fetch_sub_relaxed
+#define atomic64_fetch_sub_acquire	atomic64_fetch_sub_acquire
+#define atomic64_fetch_sub_release	atomic64_fetch_sub_release
+#define atomic64_fetch_sub		atomic64_fetch_sub
+
+#define atomic64_fetch_and_relaxed	atomic64_fetch_and_relaxed
+#define atomic64_fetch_and_acquire	atomic64_fetch_and_acquire
+#define atomic64_fetch_and_release	atomic64_fetch_and_release
+#define atomic64_fetch_and		atomic64_fetch_and
+
+#define atomic64_fetch_andnot_relaxed	atomic64_fetch_andnot_relaxed
+#define atomic64_fetch_andnot_acquire	atomic64_fetch_andnot_acquire
+#define atomic64_fetch_andnot_release	atomic64_fetch_andnot_release
+#define atomic64_fetch_andnot		atomic64_fetch_andnot
+
+#define atomic64_fetch_or_relaxed	atomic64_fetch_or_relaxed
+#define atomic64_fetch_or_acquire	atomic64_fetch_or_acquire
+#define atomic64_fetch_or_release	atomic64_fetch_or_release
+#define atomic64_fetch_or		atomic64_fetch_or
+
+#define atomic64_fetch_xor_relaxed	atomic64_fetch_xor_relaxed
+#define atomic64_fetch_xor_acquire	atomic64_fetch_xor_acquire
+#define atomic64_fetch_xor_release	atomic64_fetch_xor_release
+#define atomic64_fetch_xor		atomic64_fetch_xor
+
 #define atomic64_xchg_relaxed		atomic_xchg_relaxed
 #define atomic64_xchg_acquire		atomic_xchg_acquire
 #define atomic64_xchg_release		atomic_xchg_release
diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index f92806390c9a..2b29db9593c7 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -127,6 +127,7 @@ ATOMIC_OPS(or, orr)
 ATOMIC_OPS(xor, eor)
 
 #undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
@@ -195,11 +196,10 @@ __LL_SC_EXPORT(atomic64_##op##_return##name);
 #define ATOMIC64_OPS(...)						\
 	ATOMIC64_OP(__VA_ARGS__)					\
 	ATOMIC64_OP_RETURN(, dmb ish,  , l, "memory", __VA_ARGS__)	\
-	ATOMIC64_FETCH_OP (, dmb ish,  , l, "memory", __VA_ARGS__)	\
-	ATOMIC64_OPS(__VA_ARGS__)					\
 	ATOMIC64_OP_RETURN(_relaxed,,  ,  ,         , __VA_ARGS__)	\
 	ATOMIC64_OP_RETURN(_acquire,, a,  , "memory", __VA_ARGS__)	\
 	ATOMIC64_OP_RETURN(_release,,  , l, "memory", __VA_ARGS__)	\
+	ATOMIC64_FETCH_OP (, dmb ish,  , l, "memory", __VA_ARGS__)	\
 	ATOMIC64_FETCH_OP (_relaxed,,  ,  ,         , __VA_ARGS__)	\
 	ATOMIC64_FETCH_OP (_acquire,, a,  , "memory", __VA_ARGS__)	\
 	ATOMIC64_FETCH_OP (_release,,  , l, "memory", __VA_ARGS__)
@@ -207,11 +207,10 @@ __LL_SC_EXPORT(atomic64_##op##_return##name);
 ATOMIC64_OPS(add, add)
 ATOMIC64_OPS(sub, sub)
 
-#undef ATOMIC_OPS
+#undef ATOMIC64_OPS
 #define ATOMIC64_OPS(...)						\
 	ATOMIC64_OP(__VA_ARGS__)					\
 	ATOMIC64_FETCH_OP (, dmb ish,  , l, "memory", __VA_ARGS__)	\
-	ATOMIC64_OPS(__VA_ARGS__)					\
 	ATOMIC64_FETCH_OP (_relaxed,,  ,  ,         , __VA_ARGS__)	\
 	ATOMIC64_FETCH_OP (_acquire,, a,  , "memory", __VA_ARGS__)	\
 	ATOMIC64_FETCH_OP (_release,,  , l, "memory", __VA_ARGS__)
@@ -222,6 +221,7 @@ ATOMIC64_OPS(or, orr)
 ATOMIC64_OPS(xor, eor)
 
 #undef ATOMIC64_OPS
+#undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-- 
2.1.4
