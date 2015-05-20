From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Tue, 19 May 2015 19:41:48 -0700
Message-ID: <20150520024148.GD6776@linux.vnet.ibm.com>
References: <20150520005510.GA23559@linux.vnet.ibm.com>
 <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
 <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:34337 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbbETCly (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 May 2015 22:41:54 -0400
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 19 May 2015 20:41:54 -0600
Content-Disposition: inline
In-Reply-To: <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, c++std-parallel@accu.org, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, michaelw@ca.ibm.com

On Tue, May 19, 2015 at 07:10:12PM -0700, Linus Torvalds wrote:
> On Tue, May 19, 2015 at 6:57 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >  - the "you can add/subtract integral values" still opens you up to
> > language lawyers claiming "(char *)ptr - (intptr_t)ptr" preserving the
> > dependency, which it clearly doesn't. But language-lawyering it does,
> > since all those operations (cast to pointer, cast to integer,
> > subtracting an integer) claim to be dependency-preserving operations.
> >
> > So I think you want to limit the logical operators to things that
> > don't mask off too many bits, and you should probably limit the
> > add/subtract operations some way (maybe specify that the integer value
> > you add/subtract cannot be related to the pointer).
> 
> Actually, "not related" doesn't work. For some buddy allocator thing,
> you very much might want some of the bits to be related.

Good point, you could do the buddy-allocator computations with add
and subtract instead of exclusive OR.

> So I think you're better off just saying that operations designed to
> drop significant bits break the dependency chain, and give things like
> "& 1" and "(char *)ptr-(uintptr_t)ptr" as examples of such.
> 
> Making that just an extension of your existing "& 0" language would
> seem to be natural.

Works for me!  I added the following bullet to the list of things
that break dependencies:

	If a pointer is part of a dependency chain, and if the values
	added to or subtracted from that pointer cancel the pointer
	value so as to allow the compiler to precisely determine the
	resulting value, then the resulting value will not be part of
	any dependency chain.  For example, if p is part of a dependency
	chain, then ((char *)p-(uintptr_t)p)+65536 will not be.

Seem reasonable?

> Humans will understand, and compiler writers won't care. They will
> either depend on hardware semantics anyway (and argue that your
> language is tight enough that they don't need to do anything special)
> or they will turn the consume into an acquire (on platforms that have
> too weak hardware).

Agreed.  Plus Core Working Group will hammer out the exact wording,
should this approach meet their approval.

							Thanx, Paul
