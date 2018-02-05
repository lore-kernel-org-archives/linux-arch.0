From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Date: Sun, 4 Feb 2018 21:00:25 -0800
Message-ID: <20180205050025.GU3617@linux.vnet.ibm.com>
References: <20180203084809.GE3617@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802031708380.29515-100000@netrider.rowland.org>
 <20180204091601.GO3617@linux.vnet.ibm.com>
 <20180204101700.GA25520@linux.vnet.ibm.com>
 <20180204162900.GA8519@andrea>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750718AbeBEFAY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Feb 2018 00:00:24 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w154xGjn043336
        for <linux-arch@vger.kernel.org>; Mon, 5 Feb 2018 00:00:24 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fxfry1htm-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 05 Feb 2018 00:00:23 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 5 Feb 2018 00:00:22 -0500
Content-Disposition: inline
In-Reply-To: <20180204162900.GA8519@andrea>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Feb 04, 2018 at 05:29:00PM +0100, Andrea Parri wrote:
> On Sun, Feb 04, 2018 at 02:17:00AM -0800, Paul E. McKenney wrote:
> 
> [...]
> 
> > And here is the updated commit adding comments to the litmus test,
> > which adds comments for the three litmus tests added above.  I have also
> > marked this commit with "EXP" indicating that it has not yet had time
> > for review.  This marking appears only on my commits -- others' commits
> > don't get pulled until there has been time for review.  (I have to put
> > my commits somewhere, and maintaining two different branches would be
> > a real mess given the likelihood of depeendencies among comits.)
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 49af6e403afab890a54518980d345431d74234a4
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Sat Feb 3 00:04:49 2018 -0800
> > 
> >     EXP litmus_tests:  Add comments explaining tests' purposes
> >     
> >     This commit adds comments to the litmus tests summarizing what these
> >     tests are intended to demonstrate.
> >     
> >     Suggested-by: Ingo Molnar <mingo@kernel.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > diff --git a/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
> > index 5b83d57f6ac5..8e8ae8989085 100644
> > --- a/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
> > +++ b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
> > @@ -1,5 +1,11 @@
> >  C CoRR+poonceonce+Once
> >  
> > +(*
> > + * Test of read-read coherence, that is, whether or not two successive
> > + * reads from the same variable are ordered.  They should be ordered,
> > + * that is, this test should be forbidden.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x)
> > diff --git a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
> > index fab91c13d52c..0078ecd76f5e 100644
> > --- a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
> > +++ b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
> > @@ -1,5 +1,11 @@
> >  C CoRW+poonceonce+Once
> >  
> > +(*
> > + * Test of read-write coherence, that is, whether or not a read from a
> > + * given variable followed by a write to that same variable are ordered.
> > + * This should be ordered, that is, this test should be forbidden.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x)
> > diff --git a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
> > index 6a35ec2042ea..c9d342c8fbec 100644
> > --- a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
> > +++ b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
> > @@ -1,5 +1,11 @@
> >  C CoWR+poonceonce+Once
> >  
> > +(*
> > + * Test of write-read coherence, that is, whether or not a write to a
> > + * given variable followed by a read from that same variable are ordered.
> > + * They should be ordered, that is, this test should be forbidden.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x)
> > diff --git a/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
> > index 32a96b832021..ad51c7b17f7b 100644
> > --- a/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
> > +++ b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
> > @@ -1,5 +1,11 @@
> >  C CoWW+poonceonce
> >  
> > +(*
> > + * Test of write-write coherence, that is, whether or not two successive
> > + * writes to the same variable are ordered.  They should be ordered, that
> > + * is, this test should be forbidden.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x)
> > diff --git a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
> > index 7eba2c68992b..8a58abce69fe 100644
> > --- a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
> > +++ b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
> > @@ -1,5 +1,14 @@
> >  C IRIW+mbonceonces+OnceOnce
> >  
> > +(*
> > + * Test of independent reads from independent writes with smp_mb()
> > + * between each pairs of reads.  In other words, is smp_mb() sufficient to
> > + * cause two different reading processes to agree on the order of a pair
> > + * of writes, where each write is to a different variable by a different
> > + * process?  The smp_mb()s should be sufficient, that is, this test should
> > + * be forbidden.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x)
> > diff --git a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
> > index b0556c6c75d4..c736cd372207 100644
> > --- a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
> > +++ b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
> > @@ -1,5 +1,14 @@
> >  C IRIW+poonceonces+OnceOnce
> >  
> > +(*
> > + * Test of independent reads from independent writes with nothing
> > + * between each pairs of reads.  In other words, is anything at all
> > + * needed to cause two different reading processes to agree on the order
> > + * of a pair of writes, where each write is to a different variable by a
> > + * different process?  Something is needed, in other words, this test
> > + * should be allowed.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x)
> > diff --git a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
> > index 9a1a233d70c3..1f1c4220c92d 100644
> > --- a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
> > +++ b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
> > @@ -1,5 +1,13 @@
> >  C ISA2+poonceonces
> >  
> > +(*
> > + * Given a release-acquire chain ordering the first process's store
> > + * against the last process's load, is ordering preserved if all of the
> > + * smp_store_release() invocations be replaced by WRITE_ONCE() and all
> > + * of the smp_load_acquire() invocations be replaced by READ_ONCE()?
> > + * The answer is "no", that is, this test should be allowed.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y)
> > diff --git a/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
> > index 235195e87d4e..aa4b25838519 100644
> > --- a/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
> > +++ b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
> > @@ -1,5 +1,14 @@
> >  C ISA2+pooncerelease+poacquirerelease+poacquireonce
> >  
> > +(*
> > + * This litmus test demonstrates that a release-acquire chain suffices
> > + * to order P0()'s initial write against P2()'s final read.  The reason
> > + * that the release-acquire chain suffices is because in all but one
> > + * case (P2() to P0()), each process reads from the preceding process's
> > + * write.  In memory-model-speak, there is only one non-reads-from
> > + * (AKA non-rf) link, so release-acquire is all that is needed.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y)
> > diff --git a/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus b/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
> > index dd5ac3a8974a..0b65048ad4db 100644
> > --- a/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
> > +++ b/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
> > @@ -1,5 +1,14 @@
> >  C LB+ctrlonceonce+mbonceonce
> >  
> > +(*
> > + * This litmus test demonstrates that lightweight ordering suffices for
> > + * the load-buffering pattern, in other words, preventing all processes
> > + * reading from the preceding process's write.  In this example, the
> > + * combination of a control dependency and a full memory barrier are to do
> > + * the trick.  (But the full memory barrier could be replaced with another
> > + * control dependency and order would still be maintained.)
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y)
> > diff --git a/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
> > index 47bd61319d93..1d1f45ff1940 100644
> > --- a/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
> > +++ b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
> > @@ -1,5 +1,12 @@
> >  C LB+poacquireonce+pooncerelease
> >  
> > +(*
> > + * Does a release-acquire pair suffice for the load-buffering litmus
> > + * test, where each process reads from one of two variables then writes
> > + * to the other?  The answer is "yes", that is, this test should be
> > + * forbidden.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y)
> > diff --git a/tools/memory-model/litmus-tests/LB+poonceonces.litmus b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
> > index a5cdf027e34b..383e3e0adb4e 100644
> > --- a/tools/memory-model/litmus-tests/LB+poonceonces.litmus
> > +++ b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
> > @@ -1,5 +1,11 @@
> >  C LB+poonceonces
> >  
> > +(*
> > + * Can the counter-intuitive outcome for the load-buffering pattern
> > + * be prevented even with no explicit ordering?  The answer should be
> > + * "no", that is, this test should be allowed.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y)
> > diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
> > index 1a2fe5830381..86ddc88a26a2 100644
> > --- a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
> > +++ b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
> > @@ -1,5 +1,12 @@
> >  C MP+onceassign+derefonce.litmus
> >  
> > +(*
> > + * This litmus test demonstrates that rcu_assign_pointer() and
> > + * rcu_dereference() suffice to ensure that an RCU reader will not see
> > + * pre-initialization garbage when it traverses an RCU-protected data
> > + * structure containing a newly inserted element.
> > + *)
> > +
> >  {
> >  y=z;
> >  z=0;
> > diff --git a/tools/memory-model/litmus-tests/MP+polocks.litmus b/tools/memory-model/litmus-tests/MP+polocks.litmus
> > index 5fe6f1e3c452..3e5d3fe01054 100644
> > --- a/tools/memory-model/litmus-tests/MP+polocks.litmus
> > +++ b/tools/memory-model/litmus-tests/MP+polocks.litmus
> > @@ -1,5 +1,14 @@
> >  C MP+polocks
> >  
> > +(*
> > + * This litmus test demonstrates how lock acquisitions and releases can
> > + * stand in for smp_load_acquire() and smp_store_release(), respectively.
> > + * In other words, when holding a given lock (or indeed after relaasing a
> 
> s/relaasing/releasing
> 
> 
> > + * given lock), a CPU is not only guaranteed to see the accesses that other
> > + * CPOs made while previously holding that lock, it are also guaranteed
> 
> s/CPOs/CPUs
> 
> (same two typos for MP+porevlocks)

Good eyes, fixed in both files.

> > + * to see all prior accesses by those other CPUs.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y, spinlock_t *mylock)
> > diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
> > index 46e1ac7ba126..16a1d45e3fde 100644
> > --- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
> > +++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
> > @@ -1,5 +1,11 @@
> >  C MP+poonceonces
> >  
> > +(*
> > + * Can the counter-intuitive message-passing outcome be prevented with
> > + * no ordering at all?  The answer should be "no", that is, this test
> > + * should be prohibited.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y)
> > diff --git a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
> > index 0b00cc7293ba..f7fbe2636287 100644
> > --- a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
> > +++ b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
> > @@ -1,5 +1,11 @@
> >  C MP+pooncerelease+poacquireonce
> >  
> > +(*
> > + * This litmus test demonstrates that smp_store_release() and
> > + * smp_load_acquire() provide sufficient ordering for the message-passing
> > + * pattern.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y)
> > diff --git a/tools/memory-model/litmus-tests/MP+porevlocks.litmus b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
> > index 90d011c34f33..bd68debfaa95 100644
> > --- a/tools/memory-model/litmus-tests/MP+porevlocks.litmus
> > +++ b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
> > @@ -1,5 +1,14 @@
> >  C MP+porevlocks
> >  
> > +(*
> > + * This litmus test demonstrates how lock acquisitions and releases can
> > + * stand in for smp_load_acquire() and smp_store_release(), respectively.
> > + * In other words, when holding a given lock (or indeed after relaasing a
> > + * given lock), a CPU is not only guaranteed to see the accesses that other
> > + * CPOs made while previously holding that lock, it are also guaranteed
> > + * to see all prior accesses by those other CPUs.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y, spinlock_t *mylock)
> > diff --git a/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus b/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus
> > index 604ad41ea0c2..3d53ba138acd 100644
> > --- a/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus
> > +++ b/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus
> > @@ -1,5 +1,11 @@
> >  C MP+wmbonceonce+rmbonceonce
> >  
> > +(*
> > + * This litmus test demonstrates that smp_wmb() and smp_rmb() provide
> > + * sufficient ordering for the message-passing pattern.  However, it
> > + * is usually better to use smp_store_release() and smp_load_acquire().
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y)
> > diff --git a/tools/memory-model/litmus-tests/R+mbonceonces.litmus b/tools/memory-model/litmus-tests/R+mbonceonces.litmus
> > index e69b9e3e9436..4d64e547f1cd 100644
> > --- a/tools/memory-model/litmus-tests/R+mbonceonces.litmus
> > +++ b/tools/memory-model/litmus-tests/R+mbonceonces.litmus
> > @@ -1,5 +1,12 @@
> >  C R+mbonceonces
> >  
> > +(*
> > + * This is the fully ordered (via smp_mb()) version of one of the classic
> > + * counterintuitive litmus tests that illustrates the effects of store
> > + * propagation delays.  This test should be forbidden, but weaking either
> 
> s/weaking/weakening
> 
> (ispell suggests so, at least ...)

I agree with ispell, thank you!  ;-)

							Thanx, Paul

>   Andrea
> 
> 
> > + * of the barriers would cause the resulting test to be allowed.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y)
> > diff --git a/tools/memory-model/litmus-tests/R+poonceonces.litmus b/tools/memory-model/litmus-tests/R+poonceonces.litmus
> > index f7a12e00f82d..e75295b4e7c1 100644
> > --- a/tools/memory-model/litmus-tests/R+poonceonces.litmus
> > +++ b/tools/memory-model/litmus-tests/R+poonceonces.litmus
> > @@ -1,5 +1,11 @@
> >  C R+poonceonces
> >  
> > +(*
> > + * This is the unordered (via smp_mb()) version of one of the classic
> > + * counterintuitive litmus tests that illustrates the effects of store
> > + * propagation delays.  This test should be allowed.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y)
> > diff --git a/tools/memory-model/litmus-tests/S+poonceonces.litmus b/tools/memory-model/litmus-tests/S+poonceonces.litmus
> > index d0d541c8ec7d..7fe16920a228 100644
> > --- a/tools/memory-model/litmus-tests/S+poonceonces.litmus
> > +++ b/tools/memory-model/litmus-tests/S+poonceonces.litmus
> > @@ -1,5 +1,13 @@
> >  C S+poonceonces
> >  
> > +(*
> > + * Starting with a two-process release-acquire chain ordering P0()'s
> > + * first store against P1()'s final load, if the smp_store_release()
> > + * is replaced by WRITE_ONCE() and the smp_load_acquire() replaced by
> > + * READ_ONCE(), is ordering preserved.  The answer is "of course not!",
> > + * so this test should be allowed.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y)
> > diff --git a/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus
> > index 1d292d0d6603..f78ce120863b 100644
> > --- a/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus
> > +++ b/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus
> > @@ -1,5 +1,11 @@
> >  C S+wmbonceonce+poacquireonce
> >  
> > +(*
> > + * Can a smp_wmb(), instead of a release, and an acquire order a prior
> > + * store against a subsequent store?  The answer should be "yes", so
> > + * this test should be forbidden.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y)
> > diff --git a/tools/memory-model/litmus-tests/SB+mbonceonces.litmus b/tools/memory-model/litmus-tests/SB+mbonceonces.litmus
> > index b76caa5af1af..476542cd4a49 100644
> > --- a/tools/memory-model/litmus-tests/SB+mbonceonces.litmus
> > +++ b/tools/memory-model/litmus-tests/SB+mbonceonces.litmus
> > @@ -1,5 +1,12 @@
> >  C SB+mbonceonces
> >  
> > +(*
> > + * This litmus test demonstrates that full memory barriers suffice to
> > + * order the store-buffering pattern, where each process writes to the
> > + * variable that the preceding process read.  (Locking and RCU can also
> > + * suffice, but not much else.)
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y)
> > diff --git a/tools/memory-model/litmus-tests/SB+poonceonces.litmus b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
> > index c1797e03807e..40d519408ea6 100644
> > --- a/tools/memory-model/litmus-tests/SB+poonceonces.litmus
> > +++ b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
> > @@ -1,5 +1,11 @@
> >  C SB+poonceonces
> >  
> > +(*
> > + * This litmus test demonstrates that at least some ordering is required
> > + * to order the store-buffering pattern, where each process writes to the
> > + * variable that the preceding process read.  This test should be allowed.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y)
> > diff --git a/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
> > index f5e7c92f61cc..0780a67cf3bd 100644
> > --- a/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
> > +++ b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
> > @@ -1,5 +1,11 @@
> >  C WRC+poonceonces+Once
> >  
> > +(*
> > + * This litmus test is an extension of the message-passing pattern, where
> > + * the first write is moved to a separate process.  But because this test
> > + * has no ordering at all, it should be allowed.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x)
> > diff --git a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
> > index e3d0018025dd..070166d435e5 100644
> > --- a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
> > +++ b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
> > @@ -1,5 +1,11 @@
> >  C WRC+pooncerelease+rmbonceonce+Once
> >  
> > +(*
> > + * This litmus test is an extension of the message-passing pattern, where
> > + * the first write is moved to a separate process.  Because it features
> > + * a release and a read memory barrier, it should be forbidden.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x)
> > diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
> > index 9c2cb53e6ef0..4d0a25665655 100644
> > --- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
> > +++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
> > @@ -1,5 +1,12 @@
> >  C Z6.0+pooncelock+poonceLock+pombonce
> >  
> > +(*
> > + * This litmus test demonstrates how smp_mb__after_spinlock() may be
> > + * used to ensure that accesses in different critical sections for a
> > + * given lock running on different CPUs are nevertheless seen in order
> > + * by CPUs not holding that lock.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y, spinlock_t *mylock)
> > diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
> > index c9a1f1a49ae1..8c723892716f 100644
> > --- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
> > +++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
> > @@ -1,5 +1,11 @@
> >  C Z6.0+pooncelock+pooncelock+pombonce
> >  
> > +(*
> > + * This example demonstrates that a pair of accesses made by different
> > + * processes each while holding a given lock will not necessarily be
> > + * seen as ordered by a third process not holding that lock.
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y, spinlock_t *mylock)
> > diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
> > index 25409a033514..8b0b1b3ca348 100644
> > --- a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
> > +++ b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
> > @@ -1,5 +1,17 @@
> >  C Z6.0+pooncerelease+poacquirerelease+mbonceonce
> >  
> > +(*
> > + * This litmus test shows that a release-acquire chain, while sufficient
> > + * when there is but one non-reads-from (AKA non-rf) link, does not suffice
> > + * if there is more than one.  Of the three processes, only P1() reads from
> > + * P0's write, which means that there are two non-rf links: P1() to P2()
> > + * is a write-to-write link (AKA a "coherence" or just "co" link) and P2()
> > + * to P0() is a read-to-write link (AKA a "from-reads" or just "fr" link).
> > + * When there are two or more non-rf links, you typically will need one
> > + * full barrier for each non-rf link.  (Exceptions include some cases
> > + * involving locking.)
> > + *)
> > +
> >  {}
> >  
> >  P0(int *x, int *y)
> > 
> 
