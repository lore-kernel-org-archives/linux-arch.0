From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 2/7] sched: Add NEED_RESCHED to the preempt_count
Date: Wed, 11 Sep 2013 09:35:08 -0700
Message-ID: <CALCETrUECkOZkxao0d1467rEFcSF3jzddNo1awshE4uK-wsWGQ@mail.gmail.com>
References: <20130910130811.507933095@infradead.org> <20130910132011.116593485@infradead.org>
 <522FCE9D.4010707@amacapital.net> <20130911082530.GN31370@twins.programming.kicks-ass.net>
 <20130911110635.GT26785@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130911110635.GT26785@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andi Kleen <ak@linux.intel.com>, Peter Anvin <hpa@zytor.com>, Mike Galbraith <bitbucket@online.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Len Brown <lenb@kernel.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 11, 2013 at 4:06 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Sep 11, 2013 at 10:25:30AM +0200, Peter Zijlstra wrote:
>> On Tue, Sep 10, 2013 at 06:59:57PM -0700, Andy Lutomirski wrote:
>
>> > It looks like the intel_idle code can get confused if TIF_NEED_RESCHED
>> > is set but the preempt resched bit is not -- the need_resched call
>> > between monitor and mwait won't notice TIF_NEED_RESCHED.
>> >
>> > Is this condition possible?
>>
>> Ah indeed, I'll have to go find all idle loops out there it seems. Now
>> if only they were easy to spot :/
>>
>> I was hoping the generic idle thing was good enough, apparently not
>> quite. Thanks for spotting that.
>
> OK, and the reason I didn't notice is that the entire TS_POLLING thing
> is completely wrecked so we'll get the interrupt anyway.
>

I bet that this improves cross-cpu wakeup latency, too -- the old code
would presumably wake up the cpu and then immediately interrupt it.

It might be nice to rename one or both of need_resched and
test_need_resched, though -- the difference is somewhat inscrutable.

--Andy
