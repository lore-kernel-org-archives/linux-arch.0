Return-Path: <SRS0=HZcf=3N=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20845 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387621AbgAXSvo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 13:51:44 -0500
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
From: Waiman Long <longman@redhat.com>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
 <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <45660873-731a-a810-8c57-1a5a19d266b4@redhat.com>
Message-ID: <b26837a9-d0cd-4413-95ec-1deaca184324@redhat.com>
Date: Fri, 24 Jan 2020 13:51:34 -0500
MIME-Version: 1.0
In-Reply-To: <45660873-731a-a810-8c57-1a5a19d266b4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org, Hanjun Guo <guohanjun@huawei.com>, Jan Glauber <jglauber@marvell.com>, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com
Message-ID: <20200124185134.tlbKEVqcRVPb7ZJJpgSmd-RbXt97biNUCLHI7od2_u8@z>

On 1/24/20 1:40 PM, Waiman Long wrote:
> On 1/24/20 1:19 PM, Alex Kogan wrote:
>>
>>
>>> On Jan 24, 2020, at 11:46 AM, Waiman Long <longman@redhat.com
>>> <mailto:longman@redhat.com>> wrote:
>>>
>>> On 1/24/20 11:29 AM, Alex Kogan wrote:
>>>>
>>>>
>>>>> On Jan 24, 2020, at 10:19 AM, Waiman Long <longman@redhat.com
>>>>> <mailto:longman@redhat.com>> wrote:
>>>>>
>>>>> On 1/24/20 9:42 AM, Waiman Long wrote:
>>>>>> On 1/24/20 2:52 AM, Peter Zijlstra wrote:
>>>>>>> On Thu, Jan 23, 2020 at 04:33:54PM -0500, Alex Kogan wrote:
>>>>>>>> Let me put this question to you. What do you think the number
>>>>>>>> should be?
>>>>>>> I think it would be very good to keep the inter-node latency
>>>>>>> below 1ms.
>>>>>> It is hard to guarantee that given that lock hold times can vary
>>>>>> quite a
>>>>>> lot depending on the workload. What we can control is just how man=
y
>>>>>> later lock waiters can jump ahead before a given waiter.
>>>> I totally agree. I do not think you can guarantee that latency even
>>>> today.
>>>> With the existing spinlock, you join the queue and wait for as long
>>>> as it takes
>>>> for each and every thread in front of you to execute its critical
>>>> section.
>>>>
>>>>>>> But to realize that we need data on the lock hold times.
>>>>>>> Specifically
>>>>>>> for the heavily contended locks that make CNA worth it in the fir=
st
>>>>>>> place.
>>>>>>>
>>>>>>> I don't see that data, so I don't see how we can argue about
>>>>>>> this let
>>>>>>> alone call something reasonable.
>>>>>>>
>>>>>> In essence, CNA lock is for improving throughput on NUMA machines
>>>>>> at the
>>>>>> expense of increasing worst case latency. If low latency is
>>>>>> important,
>>>>>> it should be disabled. If CONFIG_PREEMPT_RT is on,
>>>>>> CONFIG_NUMA_AWARE_SPINLOCKS should be off.
>>>>>
>>>>> Actually, what we are worrying about is the additional latency
>>>>> that can
>>>>> be added to important tasks or execution contexts that are waiting
>>>>> for a
>>>>> lock. Maybe we can make CNA lock behaves somewhat like qrwlock is t=
hat
>>>>> requests from interrupt context are giving priority. We could add a
>>>>> priority flag in the CNA node. If the flag is set, we will never
>>>>> put it
>>>>> into the secondary queue. In fact, we can transfer control next to =
it
>>>>> even if it is not on the same node. We may also set the priority
>>>>> flag if
>>>>> it is a RT task that is trying to acquire the lock.
>>>> I think this is possible, and in fact, we have been thinking along
>>>> those lines
>>>> about ways to better support RT tasks with CNA. However, this will
>>>> _probably
>>>> require changes to API and will _certainly complicate the code
>>>> quite a bit.
>>>
>>> What you need to do is to modify cna_init_node() to check the
>>> current locking context and set the priority flag accordingly.
>>>
>> Is there a lightweight way to identify such a =E2=80=9Cprioritized=E2=80=
=9D thread?
>
> You can use the in_task() macro in include/linux/preempt.h. This is
> just a percpu preempt_count read and test. If in_task() is false, it
> is in a {soft|hard}irq or nmi context. If it is true, you can check
> the rt_task() macro to see if it is an RT task. That will access to
> the current task structure. So it may cost a little bit more if you
> want to handle the RT task the same way.
>
We may not need to do that for softIRQ context. If that is the case, you
can use in_irq() which checks for hardirq and nmi only. Peter, what is
your thought on that?

Cheers,
Longman
