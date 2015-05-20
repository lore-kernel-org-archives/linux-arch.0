From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Wed, 20 May 2015 08:12:00 -0700
Message-ID: <20150520151200.GS6776@linux.vnet.ibm.com>
References: <20150520005510.GA23559@linux.vnet.ibm.com>
 <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
 <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com>
 <20150520024148.GD6776@linux.vnet.ibm.com>
 <20150520114745.GC11498@arm.com>
 <31547.1432127917@warthog.procyon.org.uk>
 <31805.1432129025@warthog.procyon.org.uk>
 <555C8FBE.4020505@arm.com>
 <20150520140343.GO6776@linux.vnet.ibm.com>
 <555C9714.6020001@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:41844 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbbETPSd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 May 2015 11:18:33 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 20 May 2015 09:18:33 -0600
Content-Disposition: inline
In-Reply-To: <555C9714.6020001@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Cc: David Howells <dhowells@redhat.com>, Will Deacon <Will.Deacon@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "c++std-parallel@accu.org" <c++std-parallel@accu.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "michaelw@ca.ibm.com" <michaelw@ca.ibm.com>

On Wed, May 20, 2015 at 03:15:48PM +0100, Ramana Radhakrishnan wrote:
> 
> 
> On 20/05/15 15:03, Paul E. McKenney wrote:
> >On Wed, May 20, 2015 at 02:44:30PM +0100, Ramana Radhakrishnan wrote:
> >>
> >>
> >>On 20/05/15 14:37, David Howells wrote:
> >>>Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> >>>
> >>>>I was thinking of "y" as a simple variable, but if it is something more
> >>>>complex, then the compiler could do this, right?
> >>>>
> >>>>	char *x;
> >>>>
> >>>>	y;
> >>>>	x = z;
> >>>
> >>>Yeah.  I presume it has to maintain the ordering, though.
> >>
> >>The scheduler for e.g. is free to reorder if it can prove there is
> >>no dependence (or indeed side-effects for y) between insns produced
> >>for y and `x = z'.
> >
> >So for example, if y is independent of z, the compiler can do the
> >following:
> >
> >	char *x;
> >
> >	x = z;
> >	y;
> >
> >But the dependency ordering is still maintained from z to x, so this
> >is not a problem.
> 
> 
> Well, reads if any of x (assuming x was initialized elsewhere) would
> need to happen before x got assigned to z.

Agreed, there needs to be a memory_order_consume load up there somewhere.
(AKA rcu_dereference().)

> I understood the original "maintain the ordering" as between the
> statements `x = z' and `y'.

Ah, I was assuming between x and z.  David, what was your intent?  ;-)

> >Or am I missing something subtle here?
> 
> No, it sounds like we are on the same page here.

Whew!  ;-)

							Thanx, Paul
