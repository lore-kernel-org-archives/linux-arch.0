From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 20:43:48 +0200
Message-ID: <CACT4Y+aMzyBeRpXR2DGY=AASxYUGT4N+-MWW4ykLFxCpY0pFAg@mail.gmail.com>
References: <8079.1507628146@warthog.procyon.org.uk> <26455.1507724399@warthog.procyon.org.uk>
 <6309.1507735045@warthog.procyon.org.uk> <20171011155948.GE3521@linux.vnet.ibm.com>
 <20171011161220.zqkdhynxerrcmvdd@hirez.programming.kicks-ass.net>
 <20171011162412.o6lmjiag7spwabge@hirez.programming.kicks-ass.net>
 <20171011164748.GK3521@linux.vnet.ibm.com> <20171011165405.xd4xfa2x3dcz4e57@hirez.programming.kicks-ass.net>
 <20171011170631.GN3521@linux.vnet.ibm.com> <20171011171137.bb2evetsnk2qtdhc@hirez.programming.kicks-ass.net>
 <20171011173423.GO3521@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:54069 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbdJKSoK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Oct 2017 14:44:10 -0400
Received: by mail-io0-f180.google.com with SMTP id 189so2811396iow.10
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 11:44:10 -0700 (PDT)
In-Reply-To: <20171011173423.GO3521@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>

On Wed, Oct 11, 2017 at 7:34 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Wed, Oct 11, 2017 at 07:11:37PM +0200, Peter Zijlstra wrote:
>> On Wed, Oct 11, 2017 at 10:06:31AM -0700, Paul E. McKenney wrote:
>>
>> > This, you mean?
>> >
>> > data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
>>
>> Yep, that one. Although in my tree it now appears to look like:
>>
>>         data = rcu_dereference_sched(*per_cpu_ptr(&cpufreq_update_util_data,
>>                                                   cpu_of(rq)));
>
> So in the non-RCU case, we could simply replace rcu_dereference_sched()
> with ACCESS_ONCE(), right?  Thus no need to change the per-CPU
> primitives.  Especially given that most uses of per-CPU variables
> don't even need protection from load/store tearing, let alone
> protection from Alpha.



A long thread and I lost track somewhat, but, yes, from KTSAN (data
race detector) point of view we will need a way to understand when
things are ordered due to data and control dependencies
(i.e.effectively acquire but only wrt the dependent stuff).
There is a logic level and physical level, it's perfectly fine if on
physical level all these _DEP/_CTRL variants are no-op (the same as
READ_ONCE, at least on todays archs with todays compilers). But on
logical level they represent a well defined, meaningful thing. Say,
when you proof-read code for correctness, the fact that there is a
dependency can be important and crucial. But tools can's always figure
that out, and even if they can it's still useful to distinguish
between normal dependencies (that are all over the place) and the ones
that are important for correctness. It also makes code more explicit,
rather then relying on some tricky implicit guarantees. Say, like
__user annotations which we could wipe out from codegen point of view.
