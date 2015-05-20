From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [c++std-parallel-1614] Re: Compilers and RCU readers: Once more
 unto the breach!
Date: Wed, 20 May 2015 05:02:29 -0700
Message-ID: <20150520120229.GG6776@linux.vnet.ibm.com>
References: <20150520005510.GA23559@linux.vnet.ibm.com>
 <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
 <20150520023402.GC6776@linux.vnet.ibm.com>
 <555C38F2.7060402@gmx.net>
 <CAFiYyc2csMmcEJLRaoSExLkWGUw=zyL9L6i4VaNDyJ6H+rROYQ@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:46080 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbbETMCe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 May 2015 08:02:34 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 20 May 2015 06:02:34 -0600
Content-Disposition: inline
In-Reply-To: <CAFiYyc2csMmcEJLRaoSExLkWGUw=zyL9L6i4VaNDyJ6H+rROYQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Biener <richard.guenther@gmail.com>
Cc: Jens Maurer <Jens.Maurer@gmx.net>, c++std-parallel@accu.org, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, michaelw@ca.ibm.com

On Wed, May 20, 2015 at 11:03:00AM +0200, Richard Biener wrote:
> On Wed, May 20, 2015 at 9:34 AM, Jens Maurer <Jens.Maurer@gmx.net> wrote:
> > On 05/20/2015 04:34 AM, Paul E. McKenney wrote:
> >> On Tue, May 19, 2015 at 06:57:02PM -0700, Linus Torvalds wrote:
> >
> >>>  - the "you can add/subtract integral values" still opens you up to
> >>> language lawyers claiming "(char *)ptr - (intptr_t)ptr" preserving the
> >>> dependency, which it clearly doesn't. But language-lawyering it does,
> >>> since all those operations (cast to pointer, cast to integer,
> >>> subtracting an integer) claim to be dependency-preserving operations.
> >
> > [...]
> >
> >> There are some stranger examples, such as "(char *)ptr - ((intptr_t)ptr)/7",
> >> but in that case, if the resulting pointer happens by chance to reference
> >> valid memory, I believe a dependency would still be carried.
> > [...]
> >
> > From a language lawyer standpoint, pointer arithmetic is only valid
> > within an array.  These examples seem to go beyond the bounds of the
> > array and therefore have undefined behavior.
> >
> > C++ standard section 5.7 paragraph 4
> > "If both the pointer operand and the result point to elements of the
> > same array object, or one past the last element of the array object,
> > the evaluation shall not produce an overflow; otherwise, the behavior
> > is undefined."
> >
> > C99 and C11
> > identical phrasing in 6.5.6 paragraph 8
> 
> Of course you can try to circumvent that by doing
> (char*)((intptr_t)ptr - (intptr_t)ptr + (intptr_t)ptr)
> (see https://gcc.gnu.org/bugzilla/show_bug.cgi?id=65752 for extra fun).
> 
> Which (IMHO) gets you into the standard language that only makes conversion of
> the exact same integer back to a pointer well-defined(?)

I am feeling good about leaving the restriction and calling out
the two paragraphs in a footnote, then.  ;-)

							Thanx, Paul
