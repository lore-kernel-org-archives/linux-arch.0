From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Fri, 24 Jan 2020 10:19:14 -0500
Message-ID: <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
 <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org, Hanjun Guo <guohanjun@huawei.com>, Jan Glauber <jglauber@marvell.com>, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com
List-Id: linux-arch.vger.kernel.org

On 1/24/20 9:42 AM, Waiman Long wrote:
> On 1/24/20 2:52 AM, Peter Zijlstra wrote:
>> On Thu, Jan 23, 2020 at 04:33:54PM -0500, Alex Kogan wrote:
>>> Let me put this question to you. What do you think the number should be?
>> I think it would be very good to keep the inter-node latency below 1ms.
> It is hard to guarantee that given that lock hold times can vary quite a
> lot depending on the workload. What we can control is just how many
> later lock waiters can jump ahead before a given waiter.
>> But to realize that we need data on the lock hold times. Specifically
>> for the heavily contended locks that make CNA worth it in the first
>> place.
>>
>> I don't see that data, so I don't see how we can argue about this let
>> alone call something reasonable.
>>
> In essence, CNA lock is for improving throughput on NUMA machines at the
> expense of increasing worst case latency. If low latency is important,
> it should be disabled. If CONFIG_PREEMPT_RT is on,
> CONFIG_NUMA_AWARE_SPINLOCKS should be off.

Actually, what we are worrying about is the additional latency that can
be added to important tasks or execution contexts that are waiting for a
lock. Maybe we can make CNA lock behaves somewhat like qrwlock is that
requests from interrupt context are giving priority. We could add a
priority flag in the CNA node. If the flag is set, we will never put it
into the secondary queue. In fact, we can transfer control next to it
even if it is not on the same node. We may also set the priority flag if
it is a RT task that is trying to acquire the lock.

In this way, we can guarantee that important tasks or contexts will not
suffer a delay in acquiring the lock. Those less important tasks,
however, may need to wait a bit longer before they can get the lock.

What do you guys think about that?

Regards,
Longman
