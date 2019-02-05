From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Tue, 5 Feb 2019 16:12:05 -0500
Message-ID: <9ba407a6-8f16-876e-549a-d82176d2234e@redhat.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-4-alex.kogan@oracle.com>
 <20190131100009.GB31534@hirez.programming.kicks-ass.net>
 <10672939-5C35-4DEF-AFDE-99E85E0F9C46@oracle.com>
 <20190205092256.GN17528@hirez.programming.kicks-ass.net>
 <4A727687-51F9-4FD0-9608-CDBAD6A6EF07@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4A727687-51F9-4FD0-9608-CDBAD6A6EF07@oracle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Kogan <alex.kogan@oracle.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com, Rahul Yadav <rahul.x.yadav@oracle.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On 02/05/2019 04:07 PM, Alex Kogan wrote:
>> Doing time analysis on a randomized algorithm isn't my idea of fun.
>>
>>> It seems that even today, qspinlock does not support RT_PREEMPT, given
>>> that it uses per-CPU queue nodes.
>> It does work with RT, commit:
>>
>>  7aa54be29765 ("locking/qspinlock, x86: Provide liveness guarantee")
>>
>> it a direct result of RT observing funnies with it. I've no idea why you
>> think it would not work.
> Just trying to get to the bottom of it — as of today, qspinlock explicitly assumes
> no preemption while waiting for the lock.
>
> Here is what Waiman had to say about that in https://lwn.net/Articles/561775:
>
> "The idea behind this spinlock implementation is the fact that spinlocks
> are acquired with preemption disabled. In other words, the process
> will not be migrated to another CPU while it is trying to get a
> spinlock.”
>
> This was back in 2013, but the code still uses per-CPU queue nodes,
> and AFAICT, preemption will break things up.
>
> So what you are saying is that RT would be fine assuming no preemption in
> the spinlock as long as it provides FIFO? Or there is some future code patch 
> that will take care of the “no preemption” assumption (but still assume FIFO)?
>
> Thanks,
> — Alex

Some of the critical sections protected by spinlocks may have execution
times that are much longer than desired. That is why they are converted
to rt-mutex in the RT kernel. There is another class of spinlocks called
raw spinlocks. They are the same as regular spinlocks in non RT-kernel,
but remain spinlocks with no preemption allowed in RT-kernel as sleeping
locks can't be used in atomic context. This is where the replacement of
the current qspinlock code by your NUMA-aware qspinlock may screw up the
timing guarantee that can be provided by the RT-kernel.

Cheers,
Longman
