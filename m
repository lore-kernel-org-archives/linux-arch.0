From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Date: Sun, 4 Feb 2018 11:37:59 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1802041119590.16222-100000@netrider.rowland.org>
References: <20180204101700.GA25520@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:55097 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751597AbeBDQiA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Feb 2018 11:38:00 -0500
In-Reply-To: <20180204101700.GA25520@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, 4 Feb 2018, Paul E. McKenney wrote:

> --- a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
> +++ b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
> @@ -1,5 +1,11 @@
>  C CoRW+poonceonce+Once
>  
> +(*
> + * Test of read-write coherence, that is, whether or not a read from a
> + * given variable followed by a write to that same variable are ordered.

The syntax of this sentence is a little tortured.  Suggestion:

	... whether or not a read from a given variable and a later
	write to that same variable are ordered.

> + * This should be ordered, that is, this test should be forbidden.

s/This/They/

> --- a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
> +++ b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
> @@ -1,5 +1,11 @@
>  C CoWR+poonceonce+Once
>  
> +(*
> + * Test of write-read coherence, that is, whether or not a write to a
> + * given variable followed by a read from that same variable are ordered.

Same syntax issue as above.

> --- a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
> +++ b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
> @@ -1,5 +1,13 @@
>  C ISA2+poonceonces
>  
> +(*
> + * Given a release-acquire chain ordering the first process's store
> + * against the last process's load, is ordering preserved if all of the
> + * smp_store_release() invocations be replaced by WRITE_ONCE() and all

s/be/are/

> + * of the smp_load_acquire() invocations be replaced by READ_ONCE()?

s/be/are/

> --- a/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
> +++ b/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
> @@ -1,5 +1,14 @@
>  C LB+ctrlonceonce+mbonceonce
>  
> +(*
> + * This litmus test demonstrates that lightweight ordering suffices for
> + * the load-buffering pattern, in other words, preventing all processes
> + * reading from the preceding process's write.  In this example, the
> + * combination of a control dependency and a full memory barrier are to do

s/are to/are enough to/

> --- a/tools/memory-model/litmus-tests/MP+polocks.litmus
> +++ b/tools/memory-model/litmus-tests/MP+polocks.litmus
> @@ -1,5 +1,14 @@
>  C MP+polocks
>  
> +(*
> + * This litmus test demonstrates how lock acquisitions and releases can
> + * stand in for smp_load_acquire() and smp_store_release(), respectively.
> + * In other words, when holding a given lock (or indeed after relaasing a

s/relaasing/releasing/

> + * given lock), a CPU is not only guaranteed to see the accesses that other
> + * CPOs made while previously holding that lock, it are also guaranteed

s/CPO/CPU/
s/are/is/

> + * to see all prior accesses by those other CPUs.

Doesn't say whether the test should be allowed.  This is true of several
other litmus tests too.

> --- a/tools/memory-model/litmus-tests/MP+porevlocks.litmus
> +++ b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
> @@ -1,5 +1,14 @@
>  C MP+porevlocks
>  
> +(*
> + * This litmus test demonstrates how lock acquisitions and releases can
> + * stand in for smp_load_acquire() and smp_store_release(), respectively.
> + * In other words, when holding a given lock (or indeed after relaasing a

s/relaasing/releasing

> + * given lock), a CPU is not only guaranteed to see the accesses that other
> + * CPOs made while previously holding that lock, it are also guaranteed

s/CPO/CPU/
s/are/is/

> --- a/tools/memory-model/litmus-tests/R+poonceonces.litmus
> +++ b/tools/memory-model/litmus-tests/R+poonceonces.litmus
> @@ -1,5 +1,11 @@
>  C R+poonceonces
>  
> +(*
> + * This is the unordered (via smp_mb()) version of one of the classic

Does "unordered (via smp_mb())" mean that the test uses smp_mb() to
"unorder" the accesses, or does it mean that the test doesn't use smp_mb()
to order the accesses?

> --- a/tools/memory-model/litmus-tests/S+poonceonces.litmus
> +++ b/tools/memory-model/litmus-tests/S+poonceonces.litmus
> @@ -1,5 +1,13 @@
>  C S+poonceonces
>  
> +(*
> + * Starting with a two-process release-acquire chain ordering P0()'s
> + * first store against P1()'s final load, if the smp_store_release()
> + * is replaced by WRITE_ONCE() and the smp_load_acquire() replaced by
> + * READ_ONCE(), is ordering preserved.  The answer is "of course not!",

s/./?/

> --- a/tools/memory-model/litmus-tests/SB+mbonceonces.litmus
> +++ b/tools/memory-model/litmus-tests/SB+mbonceonces.litmus
> @@ -1,5 +1,12 @@
>  C SB+mbonceonces
>  
> +(*
> + * This litmus test demonstrates that full memory barriers suffice to
> + * order the store-buffering pattern, where each process writes to the
> + * variable that the preceding process read.  (Locking and RCU can also

s/read/reads/

> --- a/tools/memory-model/litmus-tests/SB+poonceonces.litmus
> +++ b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
> @@ -1,5 +1,11 @@
>  C SB+poonceonces
>  
> +(*
> + * This litmus test demonstrates that at least some ordering is required
> + * to order the store-buffering pattern, where each process writes to the
> + * variable that the preceding process read.  This test should be allowed.

s/read/reads/

> --- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
> +++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
> @@ -1,5 +1,11 @@
>  C Z6.0+pooncelock+pooncelock+pombonce
>  
> +(*
> + * This example demonstrates that a pair of accesses made by different
> + * processes each while holding a given lock will not necessarily be
> + * seen as ordered by a third process not holding that lock.
> + *)

Note that the outcome of this test will be changed by one of the
patches in our "pending" list.

Alan
