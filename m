From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Date: Sun, 4 Feb 2018 23:19:03 -0800
Message-ID: <20180205071903.GV3617@linux.vnet.ibm.com>
References: <20180204101700.GA25520@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802041119590.16222-100000@netrider.rowland.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751938AbeBEHTA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Feb 2018 02:19:00 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w157FhcF071724
        for <linux-arch@vger.kernel.org>; Mon, 5 Feb 2018 02:18:59 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fxepxq941-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 05 Feb 2018 02:18:59 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 5 Feb 2018 02:18:58 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802041119590.16222-100000@netrider.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Feb 04, 2018 at 11:37:59AM -0500, Alan Stern wrote:
> On Sun, 4 Feb 2018, Paul E. McKenney wrote:
> 
> > --- a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
> > +++ b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
> > @@ -1,5 +1,11 @@
> >  C CoRW+poonceonce+Once
> >  
> > +(*
> > + * Test of read-write coherence, that is, whether or not a read from a
> > + * given variable followed by a write to that same variable are ordered.
> 
> The syntax of this sentence is a little tortured.  Suggestion:
> 
> 	... whether or not a read from a given variable and a later
> 	write to that same variable are ordered.
> 
> > + * This should be ordered, that is, this test should be forbidden.
> 
> s/This/They/

Good catches, both changed as suggested.

> > --- a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
> > +++ b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
> > @@ -1,5 +1,11 @@
> >  C CoWR+poonceonce+Once
> >  
> > +(*
> > + * Test of write-read coherence, that is, whether or not a write to a
> > + * given variable followed by a read from that same variable are ordered.
> 
> Same syntax issue as above.

Analogous fixed applied!

> > --- a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
> > +++ b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
> > @@ -1,5 +1,13 @@
> >  C ISA2+poonceonces
> >  
> > +(*
> > + * Given a release-acquire chain ordering the first process's store
> > + * against the last process's load, is ordering preserved if all of the
> > + * smp_store_release() invocations be replaced by WRITE_ONCE() and all
> 
> s/be/are/
> 
> > + * of the smp_load_acquire() invocations be replaced by READ_ONCE()?
> 
> s/be/are/

Good eyes, fixed!

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
> 
> s/are to/are enough to/

Ditto!

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
> s/relaasing/releasing/
> 
> > + * given lock), a CPU is not only guaranteed to see the accesses that other
> > + * CPOs made while previously holding that lock, it are also guaranteed
> 
> s/CPO/CPU/
> s/are/is/

Andrea beat you to the first two of these three, but fixed.  ;-)

> > + * to see all prior accesses by those other CPUs.
> 
> Doesn't say whether the test should be allowed.  This is true of several
> other litmus tests too.

Added the "Forbidden".

You know, I should use the machine-generated syntax that my scripts
recognize, shouldn't I?  Doing that as well.

> > --- a/tools/memory-model/litmus-tests/MP+porevlocks.litmus
> > +++ b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
> > @@ -1,5 +1,14 @@
> >  C MP+porevlocks
> >  
> > +(*
> > + * This litmus test demonstrates how lock acquisitions and releases can
> > + * stand in for smp_load_acquire() and smp_store_release(), respectively.
> > + * In other words, when holding a given lock (or indeed after relaasing a
> 
> s/relaasing/releasing
> 
> > + * given lock), a CPU is not only guaranteed to see the accesses that other
> > + * CPOs made while previously holding that lock, it are also guaranteed
> 
> s/CPO/CPU/
> s/are/is/

Fixed!

> > --- a/tools/memory-model/litmus-tests/R+poonceonces.litmus
> > +++ b/tools/memory-model/litmus-tests/R+poonceonces.litmus
> > @@ -1,5 +1,11 @@
> >  C R+poonceonces
> >  
> > +(*
> > + * This is the unordered (via smp_mb()) version of one of the classic
> 
> Does "unordered (via smp_mb())" mean that the test uses smp_mb() to
> "unorder" the accesses, or does it mean that the test doesn't use smp_mb()
> to order the accesses?

That is a bit ambiguous...  Though I would be interested in seeing a
litmus test that really did use smp_mb() to unorder the accesses!

How about the following?

	* Result: Sometimes
	*
	* This is the unordered (thus lacking smp_mb()) version of one of the 
	* classic counterintuitive litmus tests that illustrates the effects of
	* store propagation delays.

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
> 
> s/./?/

Good eyes, fixed!

> > --- a/tools/memory-model/litmus-tests/SB+mbonceonces.litmus
> > +++ b/tools/memory-model/litmus-tests/SB+mbonceonces.litmus
> > @@ -1,5 +1,12 @@
> >  C SB+mbonceonces
> >  
> > +(*
> > + * This litmus test demonstrates that full memory barriers suffice to
> > + * order the store-buffering pattern, where each process writes to the
> > + * variable that the preceding process read.  (Locking and RCU can also
> 
> s/read/reads/

Ditto!

> > --- a/tools/memory-model/litmus-tests/SB+poonceonces.litmus
> > +++ b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
> > @@ -1,5 +1,11 @@
> >  C SB+poonceonces
> >  
> > +(*
> > + * This litmus test demonstrates that at least some ordering is required
> > + * to order the store-buffering pattern, where each process writes to the
> > + * variable that the preceding process read.  This test should be allowed.
> 
> s/read/reads/

And ditto again!  (Hey, at least I was consistent!  If you didn't know
better, you might even think that I was using copy-and-paste.)

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
> 
> Note that the outcome of this test will be changed by one of the
> patches in our "pending" list.

I decided to anticipate that change and marked it "Result: Never".  ;-)

							Thanx, Paul
