From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Thu, 21 May 2015 13:42:11 -0700
Message-ID: <CA+55aFxse3wTkfLMdotb+FO+_6EN32sseC0gpBaSnJ2KmbNUhQ@mail.gmail.com>
References: <20150520005510.GA23559@linux.vnet.ibm.com>
	<CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
	<CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com>
	<20150520024148.GD6776@linux.vnet.ibm.com>
	<20150520114745.GC11498@arm.com>
	<20150520121522.GH6776@linux.vnet.ibm.com>
	<20150520154617.GE11498@arm.com>
	<20150520181606.GT6776@linux.vnet.ibm.com>
	<20150521192422.GC19204@arm.com>
	<20150521200212.GW6776@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150521200212.GW6776@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "c++std-parallel@accu.org" <c++std-parallel@accu.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "michaelw@ca.ibm.com" <michaelw@ca.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, May 21, 2015 at 1:02 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> The compiler can (and does) speculate non-atomic non-volatile writes
> in some cases, but I do not believe that it is permitted to speculate
> either volatile or atomic writes.

I do *not* believe that a compiler is ever allowed to speculate *any*
writes - volatile or not - unless the compiler can prove that the end
result is either single-threaded, or the write in question is
guaranteed to only be visible in that thread (ie local stack variable
etc).

Quite frankly, I'd be much happier if the C standard just said so outright.

Also, I do think that the whole "consume" read should be explained
better to compiler writers. Right now the language (including very
much in the "restricted dependency" model) is described in very
abstract terms. Yet those abstract terms are actually very subtle and
complex, and very opaque to a compiler writer.

If I was a compiler writer, I'd absolutely detest that definition.
It's very far removed from my problem space as a compiler writer, and
nothing in the language *explains* the odd and subtle abstract rules.
It smells ad-hoc to me.

Now, I actually understand the point of those odd and abstract rules,
but to a compiler writer that doesn't understand the background, the
whole section reads as "this is really painful for me to track all
those dependencies and what kills them".

So I would very much suggest that there would be language that
*explains* this. Basically, tell the compiler writer:

 (a) the "official" rules are completely pointless, and make sense
only because the standard is written for some random "abstract
machine" that doesn't actually exist.

 (b) in *real life*, the whole and only point of the rules is to make
sure that the compiler doesn't turn a data depenency into a control
dependency, which on ARM and POWERPC does not honor causal memory
ordering

 (c) on x86, since *all* memory accesses are causal, all the magical
dependency rules are just pointless anyway, and what it really means
is that you cannot re-order accesses with value speculation.

 (c) the *actual* relevant rule for a compiler writer is very simple:
the compiler must not do value speculation on a "consume" load, and
the abstract machine rules are written so that any other sane
optimization is legal.

 (d) if the compiler writer really thinks they want to do value
speculation, they have to turn the "consume" load into an "acquire"
load. And you have to do that anyway on architectures like alpha that
aren't causal even for data dependencies.

I personally think the whole "abstract machine" model of the C
language is a mistake. It would be much better to talk about things in
terms of actual code generation and actual issues. Make all the
problems much more concrete, with actual examples of how memory
ordering matters on different architectures.

99% of all the problems with the whole "consume" memory ordering comes
not from anything relevant to a compiler writer. All of it comes from
trying to "define" the issue in the wrong terms.

                     Linus
