From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -v2 14/33] locking,m68k: Implement
 atomic_fetch_{add,sub,and,or,xor}()
Date: Fri, 17 Jun 2016 17:40:24 +0200
Message-ID: <20160617154024.GY30154@twins.programming.kicks-ass.net>
References: <20160531101925.702692792@infradead.org>
 <20160531102642.333689893@infradead.org>
 <CAMuHMdXG4veEOqr5vcZQEQH55=CT6CPXOfqrc_m=fpXEseAdLA@mail.gmail.com>
 <20160616101309.GD30921@twins.programming.kicks-ass.net>
 <mvmk2hpxq1a.fsf@hawking.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56028 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139AbcFQPk7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2016 11:40:59 -0400
Content-Disposition: inline
In-Reply-To: <mvmk2hpxq1a.fsf@hawking.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, boqun.feng@gmail.com, waiman.long@hpe.com, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>Ja


Could either of you comment on the below patch?

All atomic functions that return a value should imply full memory
barrier semantics -- this very much includes a compiler barrier / memory
clobber.



---

 arch/m68k/include/asm/atomic.h  | 19 ++++++++++++-------
 arch/m68k/include/asm/cmpxchg.h |  9 ++++++---
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/include/asm/atomic.h b/arch/m68k/include/asm/atomic.h
index 3e03de7ae33b..062a60417cb9 100644
--- a/arch/m68k/include/asm/atomic.h
+++ b/arch/m68k/include/asm/atomic.h
@@ -56,7 +56,8 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 			"	casl %2,%1,%0\n"			\
 			"	jne 1b"					\
 			: "+m" (*v), "=&d" (t), "=&d" (tmp)		\
-			: "g" (i), "2" (atomic_read(v)));		\
+			: "g" (i), "2" (atomic_read(v))			\
+			: "memory");					\
 	return t;							\
 }
 
@@ -71,7 +72,8 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 			"	casl %2,%1,%0\n"			\
 			"	jne 1b"					\
 			: "+m" (*v), "=&d" (t), "=&d" (tmp)		\
-			: "g" (i), "2" (atomic_read(v)));		\
+			: "g" (i), "2" (atomic_read(v))			\
+			: "memory");					\
 	return tmp;							\
 }
 
@@ -141,7 +143,7 @@ static inline void atomic_dec(atomic_t *v)
 static inline int atomic_dec_and_test(atomic_t *v)
 {
 	char c;
-	__asm__ __volatile__("subql #1,%1; seq %0" : "=d" (c), "+m" (*v));
+	__asm__ __volatile__("subql #1,%1; seq %0" : "=d" (c), "+m" (*v) : : "memory");
 	return c != 0;
 }
 
@@ -151,14 +153,15 @@ static inline int atomic_dec_and_test_lt(atomic_t *v)
 	__asm__ __volatile__(
 		"subql #1,%1; slt %0"
 		: "=d" (c), "=m" (*v)
-		: "m" (*v));
+		: "m" (*v)
+		: "memory");
 	return c != 0;
 }
 
 static inline int atomic_inc_and_test(atomic_t *v)
 {
 	char c;
-	__asm__ __volatile__("addql #1,%1; seq %0" : "=d" (c), "+m" (*v));
+	__asm__ __volatile__("addql #1,%1; seq %0" : "=d" (c), "+m" (*v) : : "memory");
 	return c != 0;
 }
 
@@ -204,7 +207,8 @@ static inline int atomic_sub_and_test(int i, atomic_t *v)
 	char c;
 	__asm__ __volatile__("subl %2,%1; seq %0"
 			     : "=d" (c), "+m" (*v)
-			     : ASM_DI (i));
+			     : ASM_DI (i)
+			     : "memory");
 	return c != 0;
 }
 
@@ -213,7 +217,8 @@ static inline int atomic_add_negative(int i, atomic_t *v)
 	char c;
 	__asm__ __volatile__("addl %2,%1; smi %0"
 			     : "=d" (c), "+m" (*v)
-			     : ASM_DI (i));
+			     : ASM_DI (i)
+			     : "memory");
 	return c != 0;
 }
 
diff --git a/arch/m68k/include/asm/cmpxchg.h b/arch/m68k/include/asm/cmpxchg.h
index 83b1df80f0ac..d8b3d2b48785 100644
--- a/arch/m68k/include/asm/cmpxchg.h
+++ b/arch/m68k/include/asm/cmpxchg.h
@@ -98,17 +98,20 @@ static inline unsigned long __cmpxchg(volatile void *p, unsigned long old,
 	case 1:
 		__asm__ __volatile__ ("casb %0,%2,%1"
 				      : "=d" (old), "=m" (*(char *)p)
-				      : "d" (new), "0" (old), "m" (*(char *)p));
+				      : "d" (new), "0" (old), "m" (*(char *)p)
+				      : "memory");
 		break;
 	case 2:
 		__asm__ __volatile__ ("casw %0,%2,%1"
 				      : "=d" (old), "=m" (*(short *)p)
-				      : "d" (new), "0" (old), "m" (*(short *)p));
+				      : "d" (new), "0" (old), "m" (*(short *)p)
+				      : "memory");
 		break;
 	case 4:
 		__asm__ __volatile__ ("casl %0,%2,%1"
 				      : "=d" (old), "=m" (*(int *)p)
-				      : "d" (new), "0" (old), "m" (*(int *)p));
+				      : "d" (new), "0" (old), "m" (*(int *)p)
+				      : "memory");
 		break;
 	default:
 		old = __invalid_cmpxchg_size(p, old, new, size);
