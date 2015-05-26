From: Torvald Riegel <triegel@redhat.com>
Subject: Re: [c++std-parallel-1641] Re: Compilers and RCU readers: Once more unto the breach!
Date: Tue, 26 May 2015 19:37:23 +0200
Message-ID: <1432661843.26239.29.camel@triegel.csb>
References: <20150520005510.GA23559@linux.vnet.ibm.com>	 <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>	 <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com>	 <20150520024148.GD6776@linux.vnet.ibm.com> <20150520114745.GC11498@arm.com>	 <20150520121522.GH6776@linux.vnet.ibm.com> <20150520154617.GE11498@arm.com>	 <20150520181606.GT6776@linux.vnet.ibm.com> <20150521192422.GC19204@arm.com>	 <20150521200212.GW6776@linux.vnet.ibm.com>	 <CA+55aFxse3wTkfLMdotb+FO+_6EN32sseC0gpBaSnJ2KmbNUhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <gcc-return-187471-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
In-Reply-To: <CA+55aFxse3wTkfLMdotb+FO+_6EN32sseC0gpBaSnJ2KmbNUhQ@mail.gmail.com>
To: c++std-parallel@accu.org
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "michaelw@ca.ibm.com" <michaelw@ca.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 2015-05-21 at 13:42 -0700, Linus Torvalds wrote:
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

It must not speculative volatile accesses.  It could speculate
non-volatiles even if those are atomic and observable by other threads
but that would require further work/checks on all potential observers of
those (ie, to still satisfy as-if).  Thus, compilers are unlikely to do
such speculation, I'd say.

The as-if rule (ie, equality of observable behavior (ie, volatiles, ...)
to the abstract machine) makes all this clear.

> Also, I do think that the whole "consume" read should be explained
> better to compiler writers. Right now the language (including very
> much in the "restricted dependency" model) is described in very
> abstract terms. Yet those abstract terms are actually very subtle and
> complex, and very opaque to a compiler writer.

I believe the issues around the existing specification of mo_consume
where pointed out by compiler folks.  It's a complex problem, and I'm
all for more explanations, but I did get the impression that the
compiler writers in ISO C++ Study Group 1 do have a good understanding
of the problem.

> I personally think the whole "abstract machine" model of the C
> language is a mistake. It would be much better to talk about things in
> terms of actual code generation and actual issues. Make all the
> problems much more concrete, with actual examples of how memory
> ordering matters on different architectures.

As someone working for a toolchain team, I don't see how the
abstract-machine-based specification is a problem at all, nor have I
seen compiler writers struggling with it.  It does give precise rules
for code generation.

The level of abstraction is a good thing for most programs because for
those, the primary concern is that the observable behavior and end
result is computed -- it's secondary and QoI how that happens.  In
contrast, if you specify on the level of code generation, you'd have to
foresee how code generation might look in the future, including predict
future optimizations and all that.  That doesn't look future-proof to
me.

I do realize that this may be less than ideal for cases when one would
want to use a C compiler more like a convenient assembler.  But that
case isn't the 99%, I believe.
