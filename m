Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751194AbeFBOnB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Jun 2018 10:43:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w52Eca9e010875
        for <linux-arch@vger.kernel.org>; Sat, 2 Jun 2018 10:43:00 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jbqcu1b20-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sat, 02 Jun 2018 10:43:00 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 2 Jun 2018 10:42:59 -0400
Date: Sat, 2 Jun 2018 07:44:40 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180530231441.GO7063@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1805311008460.1607-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1805311008460.1607-100000@iolanthe.rowland.org>
Message-ID: <20180602144440.GI3593@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>, Roman Pen <roman.penyaev@profitbricks.com>
Message-ID: <20180602144440.X_97KcVUyhVpVZUlMxVoVAzcakKXyV5vBdxDOR_pOhg@z>

On Thu, May 31, 2018 at 10:27:33AM -0400, Alan Stern wrote:
> On Wed, 30 May 2018, Paul E. McKenney wrote:
> 
> > On Wed, May 30, 2018 at 05:01:01PM -0500, Linus Torvalds wrote:
> > > On Wed, May 30, 2018 at 2:08 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > Indeed.  The very first line Linus quoted in his first reply to me
> > > > (elided above) was:
> > > >
> > > >         Putting this into herd would be extremely difficult, if not impossible,
> > > >         because it involves analyzing code that was not executed.
> > > >
> > > > It should be clear from this that I was talking about herd.  Not gcc or
> > > > real hardware.
> > > 
> > > So what does herd actually work on? The source code or the executable,
> > > or a trace?
> > 
> > The source code, that is, the source code of the litmus test.
> > There are definitions for the various Linux operations, partly within
> > the herd tool and partly in the linux.def file in tools/memory-model.
> > The problem we are having is nailing down control dependencies and
> > compiler optimizations.  The bit about limiting control dependencies
> > through the end of "if" statement itself works well in a great many cases,
> > but this clearly is not one of them.
> > 
> > > I found the herd paper, but I'm on the road helping my daughter in
> > > college move, and I don't have the background to skim the paper
> > > quickly and come up with the obvious answer, so I'l just ask.
> > 
> > It is not a short learning curve.
> > 
> > > Because I really think that from our memory model standpoint, we
> > > really do have the rule that
> > > 
> > >    load -> cond -> store
> > > 
> > > is ordered - even if the store address and store data is in no way
> > > dependent on the load. The only thing that matters is that there's a
> > > conditional that is dependent on the load in between the load and the
> > > store.
> 
> This is true for all the architectures supported by the Linux kernel.  
> However, in the future it might not always hold.  I can imagine that
> CPU designers would want to include an optimization that checks a
> conditional branch to see if it skips over only the following
> instruction (and the following instruction can't affect the flow of
> control); in that situation, they might decide there doesn't need to be
> a control dependency to future stores.  Such an optimization would not
> violate the C11 memory model.
> 
> Of course, this is purely theoretical.  And if anybody does decide to
> try doing that, the memory-model people might scream at them so hard
> they change their minds.  :-)
> 
> ...
> 
> > > But I don't know what level 'herd' works on. If it doesn't see
> > > compiler barriers (eg our own "barrier()" macro that literally is just
> > > that), only sees the generated code, then it really has no other
> > > information than what he compiler _happened_ to do - it doesn't know
> > > if the compiler did the store after the conditional because it *had*
> > > to do so, or whether it was just a random instruction scheduling
> > > decision.
> > 
> > The 'herd' tool works on litmus-test source, and has almost no idea of
> > what compilers get up to.  In this particular case, it would be better
> > off being even more ignorant of what compilers get up to.  ;-)
> 
> In more detail, herd analyzes the source code and constructs a set of
> all possible candidate executions.  herd then checks each execution to
> see if it violates the rules of the memory model as expressed in the
> .bell and .cat files.  If any of the non-violating executions satisfies
> the litmus test's final "exists" condition, herd reports that the test
> is allowed.
> 
> The point here is that when herd checks any one particular execution, 
> it pays attention _only_ to the statements which are part of that 
> execution.  Statements belonging to an untaken "if" branch are ignored 
> completely.  That's why I think it would be difficult to make herd do 
> exactly what we want in this case.

One crude but effective workaround is to replicate the code following the
"if" statement into both legs of the "if" statement.  This has the effect
of extending the control dependency to cover all of the code that used to
follow the "if" statement, leveraging herd's current limited knowledge of
compiler optimization.  This workaround would of course be hopeless for
general Linux-kernel code, but should be at least semi-acceptable for the
very small snippets of code that can be accommodated within litmus tests.

Please see the litmus test shown below, which uses this workaround,
allowing the smp_store_release() to be downgraded to WRITE_ONCE().

Given this workaround, crude though it might be, I believe that we can
take a more measured approach to identifying a longer-term solution.

Thoughts?

							Thanx, Paul
					
			
	
------------------------------------------------------------------------

C C-RomanPenyaev-list-rcu-rr-WA

(*
 * The same as C-RomanPenyaev-list-rcu-rr.litmus, but working around herd's
 * having just the wrong level of understanding of compiler optimizations
 * for that particular litmus test.  The trick is to replicate the code
 * following the "if" statement into both legs of that "if" statement.
 *)

{
	int *z=1; (* List: v->w->x->y->z. Noncircular, but long enough. *)
	int *y=z;
	int *x=y;
	int *w=x;
	int *v=w; (* List head is v. *)
	int *c=w; (* Cache, emulating ppcpu_con. *)
}

P0(int *c, int *v, int *w, int *x, int *y)
{
	rcu_assign_pointer(*w, y); /* Remove x from list. */
	synchronize_rcu();
	r1 = READ_ONCE(*c);
	if (r1 == x) {
		WRITE_ONCE(*c, 0); /* Invalidate cache. */
		synchronize_rcu();
		WRITE_ONCE(*x, 0);  /* Emulate kfree(x). */
	} else {
		WRITE_ONCE(*x, 0);  /* Emulate kfree(x). */
	}
}

P1(int *c, int *v)
{
	rcu_read_lock();
	r1 = READ_ONCE(*c); /* Pick up cache. */
	if (r1 == 0) {
		r1 = READ_ONCE(*v); /* Cache empty, start from head. */
	}
	r2 = rcu_dereference(*r1); /* Advance to next element. */
	smp_store_release(c, r2); /* Update cache. */
	rcu_read_unlock();

	/* And repeat. */
	rcu_read_lock();
	r3 = READ_ONCE(*c);
	if (r3 == 0) {
		r3 = READ_ONCE(*v);
	}
	r4 = rcu_dereference(*r3);
	smp_store_release(c, r4);
	rcu_read_unlock();
}

locations [0:r1; 1:r1; 1:r3; c; v; w; x; y]
exists (1:r1=0 \/ 1:r2=0 \/ 1:r3=0 \/ 1:r4=0) (* Better not be freed!!! *)
