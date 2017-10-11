From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 21:59:41 +0200
Message-ID: <CACT4Y+YLiCu=+ofR32+eFW+suPGKnnF5KfMo+ywfitZccS+JTw@mail.gmail.com>
References: <8079.1507628146@warthog.procyon.org.uk> <26455.1507724399@warthog.procyon.org.uk>
 <6309.1507735045@warthog.procyon.org.uk> <20171011155948.GE3521@linux.vnet.ibm.com>
 <20171011161220.zqkdhynxerrcmvdd@hirez.programming.kicks-ass.net>
 <20171011162412.o6lmjiag7spwabge@hirez.programming.kicks-ass.net>
 <20171011164748.GK3521@linux.vnet.ibm.com> <20171011165405.xd4xfa2x3dcz4e57@hirez.programming.kicks-ass.net>
 <20171011170631.GN3521@linux.vnet.ibm.com> <20171011171137.bb2evetsnk2qtdhc@hirez.programming.kicks-ass.net>
 <20171011173423.GO3521@linux.vnet.ibm.com> <CACT4Y+aMzyBeRpXR2DGY=AASxYUGT4N+-MWW4ykLFxCpY0pFAg@mail.gmail.com>
 <CA+55aFz=sfrQRHyoiy9L2SmRO5d3ZgoZpHh=6u2aHQsvbN1OHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:43729 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752534AbdJKUAD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Oct 2017 16:00:03 -0400
Received: by mail-io0-f169.google.com with SMTP id f202so3085521ioe.0
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 13:00:03 -0700 (PDT)
In-Reply-To: <CA+55aFz=sfrQRHyoiy9L2SmRO5d3ZgoZpHh=6u2aHQsvbN1OHw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>

On Wed, Oct 11, 2017 at 8:56 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Oct 11, 2017 at 11:43 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> A long thread and I lost track somewhat, but, yes, from KTSAN (data
>> race detector) point of view we will need a way to understand when
>> things are ordered due to data and control dependencies
>> (i.e.effectively acquire but only wrt the dependent stuff).
>> There is a logic level and physical level, it's perfectly fine if on
>> physical level all these _DEP/_CTRL variants are no-op (the same as
>> READ_ONCE, at least on todays archs with todays compilers). But on
>> logical level they represent a well defined, meaningful thing.
>
> No, they do not.
>
> Do you believe in fairies and Santa Claus?
>
> Because quite frankly, the likelihood of either of those being true is
> _way_ higher than the likelihood of any normal human ever getting
> those things right.
>
> So asking a programmer to annotate whether two memory accesses have a
> data dependency or a control dependency is completely inappropriate.
> You won't get people understanding it to begin with, much less then
> figure out subtle things like whether a control dependency is an
> actual branch, or might be turned into a data dependency through
> select, or whatever.
>
> We've had really smart people who wrote core code that couldn't get it
> right, and that weren't sure if a control dependency was really
> guaranteed or not.
>
> That is *exactly* the kinds of thing that _automation_ should handle.
> Not some human. Figure the data/control dependencies out from the
> code, not from some logical level.
>
> I saw the contortions that the ISO C people tried to go through just
> to describe control and data dependencies. It was awful.  It should
> have never been described on that kind of level to begin with, when it
> would have been much easier to just describe it to compiler people as
> "this is a consume relationship". The same rules apply here. Don't
> make it about some high-level thing and humans annontating things.
> Make it about the actual generated code.


First of all, I am not asking for a big overhaul and nothing changes
wrt codegen (i.e. the code works the same way it used to work).
If/when it is done, it will be guided by the race detector. It is
similar to enabling a new compiler warning and cleaning up the code
base incrementally. Compiler warnings don't affect code behavior, and
one doesn't need to proactively guess where they will fire (a compiler
warnings points you to the line what compiler does not like).

Second, we would very much like to just analyze the code as is. And in
fact we gone to great lengths teaching it about standalone memory
barriers (rmb/wmb), per-cpu variables, seqlocks, rcu, etc (none of
that we had in user-space). But this is just where we need help
(basically the same problem you mentioned with ISO C, it's effectively
not defineable/analyzable by compiler).

As far as I remember we added just few of READ_ONCE_CTRL (<5) to get
the prototype running. So it's not that we are talking about
hundreds/thousands of them. And again the tool will point to the
places it does not like. So I am just asking for a practical tradeoff:
few annotations in exchange for hundreds/thousands of bugs killed.

I did not want to revive this discussion right now, we already had it
and decided that we need a clear story for READ_ONCE_CTRL first. Our
plan is to revive the tool, find more real bugs and show what are the
actual code changes required for the tool. Hope we can get to some
compromise.
