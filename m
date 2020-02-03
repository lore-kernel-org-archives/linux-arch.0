From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Mon, 3 Feb 2020 10:47:15 -0500
Message-ID: <15fa978d-bd41-3ecb-83d5-896187e11244@redhat.com>
References: <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <20200125111931.GW11457@worktop.programming.kicks-ass.net>
 <F32558D8-4ACB-483A-AB4C-F565003A02E7@oracle.com>
 <20200203134540.GA14879@hirez.programming.kicks-ass.net>
 <6d11b22b-2fb5-7dea-f88b-b32f1576a5e0@redhat.com>
 <20200203152807.GK14914@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33872 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728034AbgBCPr3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Feb 2020 10:47:29 -0500
In-Reply-To: <20200203152807.GK14914@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org, Hanjun Guo <guohanjun@huawei.com>, Jan Glauber <jglauber@marvell.com>, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com

On 2/3/20 10:28 AM, Peter Zijlstra wrote:
> On Mon, Feb 03, 2020 at 09:59:12AM -0500, Waiman Long wrote:
>> On 2/3/20 8:45 AM, Peter Zijlstra wrote:
>>> Presumably you have a workload where CNA is actually a win? That is,
>>> what inspired you to go down this road? Which actual kernel lock is so
>>> contended on NUMA machines that we need to do this?
>> Today, a 2-socket Rome server can have 128 cores and 256 threads. If we
>> scale up more, we could easily have more than 1000 threads in a system.
>> With that many logical cpus available, it is easy to envision some heavy
>> spinlock contention can happen fairly regularly. This patch can
>> alleviate the congestion and improve performance under that
>> circumstance. Of course, the specific locks that are contended will
>> depend on the workloads.
> Not the point. If there isn't an issue today, we don't have anything to
> fix.
>
> Furthermore, we've always adressed specific issues by looking at the
> locking granularity, first.

You are right in that. Unlike ticket spinlock where performance can drop
precipitately over a cliff when there is heavy contention, qspinlock
won't have this kind of performance drop. My suspicion is that slowdowns
caused by heavy spinlock contention in actual workloads are likely to be
more transient in nature and harder to pinpoint. These days, I seldom
get bug report that is related to heavy spinlock contention.

>
> So again, what specific lock inspired all these patches?
>
Maybe Alex has some data to share.

Cheers,
Longman
