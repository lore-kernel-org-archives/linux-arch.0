Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753734AbeE3XNE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 May 2018 19:13:04 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4UN4xuI102875
        for <linux-arch@vger.kernel.org>; Wed, 30 May 2018 19:13:04 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ja5ad87xj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 30 May 2018 19:13:04 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 30 May 2018 19:13:03 -0400
Date: Wed, 30 May 2018 16:14:41 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180530183826.GI7063@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
 <CA+55aFxXgECHW+Pekiuvt1htsDfML2ximrLrmr99xewGYpmEng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxXgECHW+Pekiuvt1htsDfML2ximrLrmr99xewGYpmEng@mail.gmail.com>
Message-ID: <20180530231441.GO7063@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>, Roman Pen <roman.penyaev@profitbricks.com>
Message-ID: <20180530231441.soS7MO-1mqFHMzQWLX00gu8TclRjErskVdO03W1wGv4@z>

On Wed, May 30, 2018 at 05:01:01PM -0500, Linus Torvalds wrote:
> On Wed, May 30, 2018 at 2:08 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > Indeed.  The very first line Linus quoted in his first reply to me
> > (elided above) was:
> >
> >         Putting this into herd would be extremely difficult, if not impossible,
> >         because it involves analyzing code that was not executed.
> >
> > It should be clear from this that I was talking about herd.  Not gcc or
> > real hardware.
> 
> So what does herd actually work on? The source code or the executable,
> or a trace?

The source code, that is, the source code of the litmus test.
There are definitions for the various Linux operations, partly within
the herd tool and partly in the linux.def file in tools/memory-model.
The problem we are having is nailing down control dependencies and
compiler optimizations.  The bit about limiting control dependencies
through the end of "if" statement itself works well in a great many cases,
but this clearly is not one of them.

> I found the herd paper, but I'm on the road helping my daughter in
> college move, and I don't have the background to skim the paper
> quickly and come up with the obvious answer, so I'l just ask.

It is not a short learning curve.

> Because I really think that from our memory model standpoint, we
> really do have the rule that
> 
>    load -> cond -> store
> 
> is ordered - even if the store address and store data is in no way
> dependent on the load. The only thing that matters is that there's a
> conditional that is dependent on the load in between the load and the
> store.
> 
> Note that this is *independent* of how you get to the store. It
> doesn't matter  if it's a fallthrough conditional jump or  a taken
> conditional jump, or whether  there is a joining.
> 
> The only thing that *does* matter is whether the conditional can be
> turned into a "select" statement. If the conditional can be turned
> into a data dependency, then the ordering goes away. That is why it
> was relevant whether "C" contained a barrier or not (it doesn't even
> have to be a *memory* barrier, it just has to be a barrier for code
> generation).

Another situation is something like this:

	r1 = READ_ONCE(x);
	if (r1)
		r2 = r1 * 3 - 1;
	else
		r2 = 42;
	WRITE_ONCE(y, 5);
	do_something(r2);

Because there are no compiler barriers or volatile accesses in either
the "then" clause or the "else" clause, the compiler is within its
rights to do this:

	r1 = READ_ONCE(x);
	WRITE_ONCE(y, 5);
	if (r1)
		r2 = r1 * 3 - 1;
	else
		r2 = 42;
	do_something(r2);

Then weakly ordered CPUs can reorder the READ_ONCE() and WRITE_ONCE().
The compiler of course cannot because they are both volatile accesses.

> Note that the "C doesn't even have to have a memory barrier" is
> important, because the orderin from load->cond->store doesn't actually
> have anything to do with any memory ordering imposed by C, it's much
> more fundamental than that.

If there were volatiles or compiler barriers in the "then" or "else"
clauses, or if the store itself was there (and there weren't identical
stores in both), then agreed, the compiler cannot do much, nor can
the hardware.

> > Preserving the order of volatile accesses isn't sufficient.  The
> > compiler is still allowed to translate
> >
> >         r1 = READ_ONCE(x);
> >         if (r1) {
> >                 ...
> >         }
> >         WRITE_ONCE(y, r2);
> >
> > into something resembling
> >
> >         r1 = READ_ONCE(x);
> >         WRITE_ONCE(y, r2);
> >         if (r1) {
> >                 ...
> >         }
> 
> Correct.
> 
> What matter is that the code in C (now called "..." above ;^) has a
> build-time barrier that means that the compiler cannot do that.
> 
> That barrier can be pretty much anything. The important part is
> literally that there's a guarantee that the write cannot  be migrated
> below the conditional.
> 
> But I don't know what level 'herd' works on. If it doesn't see
> compiler barriers (eg our own "barrier()" macro that literally is just
> that), only sees the generated code, then it really has no other
> information than what he compiler _happened_ to do - it doesn't know
> if the compiler did the store after the conditional because it *had*
> to do so, or whether it was just a random instruction scheduling
> decision.

The 'herd' tool works on litmus-test source, and has almost no idea of
what compilers get up to.  In this particular case, it would be better
off being even more ignorant of what compilers get up to.  ;-)

							Thanx, Paul
