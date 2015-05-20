From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Tue, 19 May 2015 19:34:03 -0700
Message-ID: <20150520023402.GC6776@linux.vnet.ibm.com>
References: <20150520005510.GA23559@linux.vnet.ibm.com>
 <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:38058 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbbETCeH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 May 2015 22:34:07 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 19 May 2015 20:34:07 -0600
Content-Disposition: inline
In-Reply-To: <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, c++std-parallel@accu.org, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, michaelw@ca.ibm.com

On Tue, May 19, 2015 at 06:57:02PM -0700, Linus Torvalds wrote:
> On Tue, May 19, 2015 at 5:55 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >
> >         http://www.rdrop.com/users/paulmck/RCU/consume.2015.05.18a.pdf
> 
> >From a very quick read-through, the restricted dependency chain in 7.9
> seems to be reasonable, and essentially covers "thats' what hardware
> gives us anyway", making compiler writers happy.
> 
> I would clarify the language somewhat:
> 
>  - it says that the result of a cast of a pointer is a dependency. You
> need to make an exception for casting to bool, methinks (because
> that's effectively just a test-against-NULL, which you later describe
> as terminating the dependency).
> 
>    Maybe get rid of the "any type", and just limit it to casts to
> types of size intptr_t, ie ones that don't drop significant bits. All
> the other rules talk about [u]intptr_t anyway.

Excellent point!  I now say:

	If a pointer is part of a dependency chain, then casting it
	(either explicitly or implicitly) to any pointer-sized type
	extends the chain to the result.

If this approach works out, the people in the Core Working Group will
come up with alternative language-lawyer-proof wording, but this informal
version will hopefully do for the moment.

>  - you clarify that the trivial "& 0" and "| ~0" kill the dependency
> chain, but if you really want to be a stickler, you might want to
> extend it to a few more cases. Things like "& 1" (to extract a tag
> from the lot bit of a tagged pointer) should likely also drop the
> dependency, since a compiler would commonly end up using the end
> result as a conditional even if the code was written to then use
> casting etc to look like a dereference.

Ah, how about the following?

	If a value of type intptr_t or uintptr_t is part of a dependency
	chain, and if that value is one of the operands to an & or |
	infix operator whose result has too few or too many bits set,
	then the resulting value will not be part of any dependency
	chain.	For example, on a 64-bit system, if p is part of a
	dependency chain, then (p & 0x7) provides just the tag bits,
	and normally cannot even be legally dereferenced.  Similarly,
	(p | ~0) normally cannot be legally dereferenced.

>  - the "you can add/subtract integral values" still opens you up to
> language lawyers claiming "(char *)ptr - (intptr_t)ptr" preserving the
> dependency, which it clearly doesn't. But language-lawyering it does,
> since all those operations (cast to pointer, cast to integer,
> subtracting an integer) claim to be dependency-preserving operations.

My thought was that the result of "(char *)ptr - (intptr_t)ptr" is a
NULL pointer in most environments, and dereferencing a NULL pointer
is undefined behavior.  So it becomes irrelevant whether or not the
NULL pointer carries a dependency.

There are some stranger examples, such as "(char *)ptr - ((intptr_t)ptr)/7",
but in that case, if the resulting pointer happens by chance to reference 
valid memory, I believe a dependency would still be carried.  Of course,
if you are producing code like that, I am guessing that dependencies are
the very least of your concerns.

However, I will give this some more thought.

> So I think you want to limit the logical operators to things that
> don't mask off too many bits, and you should probably limit the
> add/subtract operations some way (maybe specify that the integer value
> you add/subtract cannot be related to the pointer). But I think
> limiting it to mostly pointer ops (and a _few_ integer operations to
> do offsets and remove tag bits) is otherwise a good approach.

Glad you mostly like it!  ;-)

						Thanx, Paul
