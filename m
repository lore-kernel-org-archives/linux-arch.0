From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 11:56:54 -0700
Message-ID: <CA+55aFz=sfrQRHyoiy9L2SmRO5d3ZgoZpHh=6u2aHQsvbN1OHw@mail.gmail.com>
References: <8079.1507628146@warthog.procyon.org.uk> <26455.1507724399@warthog.procyon.org.uk>
 <6309.1507735045@warthog.procyon.org.uk> <20171011155948.GE3521@linux.vnet.ibm.com>
 <20171011161220.zqkdhynxerrcmvdd@hirez.programming.kicks-ass.net>
 <20171011162412.o6lmjiag7spwabge@hirez.programming.kicks-ass.net>
 <20171011164748.GK3521@linux.vnet.ibm.com> <20171011165405.xd4xfa2x3dcz4e57@hirez.programming.kicks-ass.net>
 <20171011170631.GN3521@linux.vnet.ibm.com> <20171011171137.bb2evetsnk2qtdhc@hirez.programming.kicks-ass.net>
 <20171011173423.GO3521@linux.vnet.ibm.com> <CACT4Y+aMzyBeRpXR2DGY=AASxYUGT4N+-MWW4ykLFxCpY0pFAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACT4Y+aMzyBeRpXR2DGY=AASxYUGT4N+-MWW4ykLFxCpY0pFAg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 11, 2017 at 11:43 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> A long thread and I lost track somewhat, but, yes, from KTSAN (data
> race detector) point of view we will need a way to understand when
> things are ordered due to data and control dependencies
> (i.e.effectively acquire but only wrt the dependent stuff).
> There is a logic level and physical level, it's perfectly fine if on
> physical level all these _DEP/_CTRL variants are no-op (the same as
> READ_ONCE, at least on todays archs with todays compilers). But on
> logical level they represent a well defined, meaningful thing.

No, they do not.

Do you believe in fairies and Santa Claus?

Because quite frankly, the likelihood of either of those being true is
_way_ higher than the likelihood of any normal human ever getting
those things right.

So asking a programmer to annotate whether two memory accesses have a
data dependency or a control dependency is completely inappropriate.
You won't get people understanding it to begin with, much less then
figure out subtle things like whether a control dependency is an
actual branch, or might be turned into a data dependency through
select, or whatever.

We've had really smart people who wrote core code that couldn't get it
right, and that weren't sure if a control dependency was really
guaranteed or not.

That is *exactly* the kinds of thing that _automation_ should handle.
Not some human. Figure the data/control dependencies out from the
code, not from some logical level.

I saw the contortions that the ISO C people tried to go through just
to describe control and data dependencies. It was awful.  It should
have never been described on that kind of level to begin with, when it
would have been much easier to just describe it to compiler people as
"this is a consume relationship". The same rules apply here. Don't
make it about some high-level thing and humans annontating things.
Make it about the actual generated code.

                Linus
