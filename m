From: Will Deacon <will.deacon@arm.com>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Wed, 20 May 2015 12:47:45 +0100
Message-ID: <20150520114745.GC11498@arm.com>
References: <20150520005510.GA23559@linux.vnet.ibm.com>
 <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
 <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com>
 <20150520024148.GD6776@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37855 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbbETLru (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 May 2015 07:47:50 -0400
Content-Disposition: inline
In-Reply-To: <20150520024148.GD6776@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "c++std-parallel@accu.org" <c++std-parallel@accu.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "michaelw@ca.ibm.com" <michaelw@ca.ibm.com>

Hi Paul,

On Wed, May 20, 2015 at 03:41:48AM +0100, Paul E. McKenney wrote:
> On Tue, May 19, 2015 at 07:10:12PM -0700, Linus Torvalds wrote:
> > On Tue, May 19, 2015 at 6:57 PM, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > So I think you're better off just saying that operations designed to
> > drop significant bits break the dependency chain, and give things like
> > "& 1" and "(char *)ptr-(uintptr_t)ptr" as examples of such.
> > 
> > Making that just an extension of your existing "& 0" language would
> > seem to be natural.
> 
> Works for me!  I added the following bullet to the list of things
> that break dependencies:
> 
> 	If a pointer is part of a dependency chain, and if the values
> 	added to or subtracted from that pointer cancel the pointer
> 	value so as to allow the compiler to precisely determine the
> 	resulting value, then the resulting value will not be part of
> 	any dependency chain.  For example, if p is part of a dependency
> 	chain, then ((char *)p-(uintptr_t)p)+65536 will not be.
> 
> Seem reasonable?

Whilst I understand what you're saying (the ARM architecture makes these
sorts of distinctions when calling out dependency-based ordering), it
feels like we're dangerously close to defining the difference between a
true and a false dependency. If we want to do this in the context of the
C language specification, you run into issues because you need to evaluate
the program in order to determine data values in order to determine the
nature of the dependency.

You tackle this above by saying "to allow the compiler to precisely
determine the resulting value", but I can't see how that can be cleanly
fitted into something like the C language specification. Even if it can,
then we'd need to reword the "?:" treatment that you currently have:

  "If a pointer is part of a dependency chain, and that pointer appears
   in the entry of a ?: expression selected by the condition, then the
   chain extends to the result."

which I think requires the state of the condition to be known statically
if we only want to extend the chain from the selected expression. In the
general case, wouldn't a compiler have to assume that the chain is
extended from both?

Additionally, what about the following code?

  char *x = y ? z : z;

Does that extend a dependency chain from z to x? If so, I can imagine a
CPU breaking that in practice.

> > Humans will understand, and compiler writers won't care. They will
> > either depend on hardware semantics anyway (and argue that your
> > language is tight enough that they don't need to do anything special)
> > or they will turn the consume into an acquire (on platforms that have
> > too weak hardware).
> 
> Agreed.  Plus Core Working Group will hammer out the exact wording,
> should this approach meet their approval.

For the avoidance of doubt, I'm completely behind any attempts to tackle
this problem, but I anticipate an uphill struggle getting this text into
the C standard. Is your intention to change the carries-a-dependency
relation to encompass this change?

Cheers,

Will
