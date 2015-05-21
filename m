From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Thu, 21 May 2015 15:02:32 -0700
Message-ID: <20150521220232.GZ6776@linux.vnet.ibm.com>
References: <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
 <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com>
 <20150520024148.GD6776@linux.vnet.ibm.com>
 <20150520114745.GC11498@arm.com>
 <20150520121522.GH6776@linux.vnet.ibm.com>
 <20150520154617.GE11498@arm.com>
 <20150520181606.GT6776@linux.vnet.ibm.com>
 <20150521192422.GC19204@arm.com>
 <20150521200212.GW6776@linux.vnet.ibm.com>
 <CA+55aFxse3wTkfLMdotb+FO+_6EN32sseC0gpBaSnJ2KmbNUhQ@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:45246 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbbEUWCk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 May 2015 18:02:40 -0400
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 21 May 2015 16:02:39 -0600
Content-Disposition: inline
In-Reply-To: <CA+55aFxse3wTkfLMdotb+FO+_6EN32sseC0gpBaSnJ2KmbNUhQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "c++std-parallel@accu.org" <c++std-parallel@accu.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "michaelw@ca.ibm.com" <michaelw@ca.ibm.com>

On Thu, May 21, 2015 at 01:42:11PM -0700, Linus Torvalds wrote:
> On Thu, May 21, 2015 at 1:02 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >
> > The compiler can (and does) speculate non-atomic non-volatile writes
> > in some cases, but I do not believe that it is permitted to speculate
> > either volatile or atomic writes.
> 
> I do *not* believe that a compiler is ever allowed to speculate *any*
> writes - volatile or not - unless the compiler can prove that the end
> result is either single-threaded, or the write in question is
> guaranteed to only be visible in that thread (ie local stack variable
> etc).
> 
> Quite frankly, I'd be much happier if the C standard just said so outright.

So would I.  ;-)

The usual example is the following, where x is non-volatile and
non-atomic:

	if (a)
		x = 42;
	else
		x = 7;

The current rules allow this to be transformed as follows:

	x = 7;
	if (a)
		x = 42;

So the variable x takes on the value 7 momentarily when it otherwise
would not have.

At least C11 now prohibits "drive-by" speculative writes, where the
compiler writes a larger size and then fixes things up afterwards.

> Also, I do think that the whole "consume" read should be explained
> better to compiler writers. Right now the language (including very
> much in the "restricted dependency" model) is described in very
> abstract terms. Yet those abstract terms are actually very subtle and
> complex, and very opaque to a compiler writer.
> 
> If I was a compiler writer, I'd absolutely detest that definition.
> It's very far removed from my problem space as a compiler writer, and
> nothing in the language *explains* the odd and subtle abstract rules.
> It smells ad-hoc to me.
> 
> Now, I actually understand the point of those odd and abstract rules,
> but to a compiler writer that doesn't understand the background, the
> whole section reads as "this is really painful for me to track all
> those dependencies and what kills them".
> 
> So I would very much suggest that there would be language that
> *explains* this. Basically, tell the compiler writer:
> 
>  (a) the "official" rules are completely pointless, and make sense
> only because the standard is written for some random "abstract
> machine" that doesn't actually exist.
> 
>  (b) in *real life*, the whole and only point of the rules is to make
> sure that the compiler doesn't turn a data depenency into a control
> dependency, which on ARM and POWERPC does not honor causal memory
> ordering
> 
>  (c) on x86, since *all* memory accesses are causal, all the magical
> dependency rules are just pointless anyway, and what it really means
> is that you cannot re-order accesses with value speculation.
> 
>  (c) the *actual* relevant rule for a compiler writer is very simple:
> the compiler must not do value speculation on a "consume" load, and
> the abstract machine rules are written so that any other sane
> optimization is legal.
> 
>  (d) if the compiler writer really thinks they want to do value
> speculation, they have to turn the "consume" load into an "acquire"
> load. And you have to do that anyway on architectures like alpha that
> aren't causal even for data dependencies.

I am certainly more than willing to add this sort of wording to
the document.

> I personally think the whole "abstract machine" model of the C
> language is a mistake. It would be much better to talk about things in
> terms of actual code generation and actual issues. Make all the
> problems much more concrete, with actual examples of how memory
> ordering matters on different architectures.
> 
> 99% of all the problems with the whole "consume" memory ordering comes
> not from anything relevant to a compiler writer. All of it comes from
> trying to "define" the issue in the wrong terms.

I certainly cannot deny that there seems to be significant confusion
in the discussion thus far.

							Thanx, Paul
