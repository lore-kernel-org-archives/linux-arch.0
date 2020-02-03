Return-Path: <SRS0=zisY=3X=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51082 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726884AbgBCO7Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Feb 2020 09:59:24 -0500
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
References: <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <20200125111931.GW11457@worktop.programming.kicks-ass.net>
 <F32558D8-4ACB-483A-AB4C-F565003A02E7@oracle.com>
 <20200203134540.GA14879@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Message-ID: <6d11b22b-2fb5-7dea-f88b-b32f1576a5e0@redhat.com>
Date: Mon, 3 Feb 2020 09:59:12 -0500
MIME-Version: 1.0
In-Reply-To: <20200203134540.GA14879@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org, Hanjun Guo <guohanjun@huawei.com>, Jan Glauber <jglauber@marvell.com>, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com
Message-ID: <20200203145912.z0tVsDGsuOtnY5yFzWOX9rsyUEfgrjC88EXfQcXNCRk@z>

On 2/3/20 8:45 AM, Peter Zijlstra wrote:
> On Thu, Jan 30, 2020 at 05:05:28PM -0500, Alex Kogan wrote:
>>> On Jan 25, 2020, at 6:19 AM, Peter Zijlstra <peterz@infradead.org> wr=
ote:
>>>
>>> On Fri, Jan 24, 2020 at 01:19:05PM -0500, Alex Kogan wrote:
>>>
>>>> Is there a lightweight way to identify such a =E2=80=9Cprioritized=E2=
=80=9D thread?
>>> No; people might for instance care about tail latencies between their
>>> identically spec'ed worker tasks.
>> I would argue that those users need to tune/reduce the intra-node hand=
off
>> threshold for their needs. Or disable CNA altogether.
> I really don't like boot time arguments (or tunables in generic) for a
> machine to work as it should.
>
> The default really should 'just work'.
That will be the ideal case. In reality, it usually takes a while for
the code to mature enough to do some kind of self tuning. In the mean
time, having some configuration options available allows us to have more
time to figure what the best configuration options to be.
>> In general, Peter, seems like you are not on board with the way Longma=
n
>> suggested to handle prioritized threads. Am I right?
> Right.
>
> Presumably you have a workload where CNA is actually a win? That is,
> what inspired you to go down this road? Which actual kernel lock is so
> contended on NUMA machines that we need to do this?

Today, a 2-socket Rome server can have 128 cores and 256 threads. If we
scale up more, we could easily have more than 1000 threads in a system.
With that many logical cpus available, it is easy to envision some heavy
spinlock contention can happen fairly regularly. This patch can
alleviate the congestion and improve performance under that
circumstance. Of course, the specific locks that are contended will
depend on the workloads.

Cheers,
Longman
