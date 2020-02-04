From: Alex Kogan <alex.kogan@oracle.com>
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Tue, 4 Feb 2020 12:53:46 -0500
Message-ID: <B98581F8-DE4B-4DF6-B435-112993605E8E@oracle.com>
References: <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <20200125111931.GW11457@worktop.programming.kicks-ass.net>
 <F32558D8-4ACB-483A-AB4C-F565003A02E7@oracle.com>
 <20200203134540.GA14879@hirez.programming.kicks-ass.net>
 <6d11b22b-2fb5-7dea-f88b-b32f1576a5e0@redhat.com>
 <20200203152807.GK14914@hirez.programming.kicks-ass.net>
 <15fa978d-bd41-3ecb-83d5-896187e11244@redhat.com>
 <83762715-F68C-42DF-9B41-C4C48DF6762F@oracle.com>
 <20200204172758.GF14879@hirez.programming.kicks-ass.net>
 <e26b3afa-80d6-71bf-39c8-0fa4b875cbb2@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:46590 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgBDRyr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2020 12:54:47 -0500
In-Reply-To: <e26b3afa-80d6-71bf-39c8-0fa4b875cbb2@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org, Hanjun Guo <guohanjun@huawei.com>, Jan Glauber <jglauber@marvell.com>, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com



> On Feb 4, 2020, at 12:39 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> On 2/4/20 12:27 PM, Peter Zijlstra wrote:
>> On Tue, Feb 04, 2020 at 11:54:02AM -0500, Alex Kogan wrote:
>>>> On Feb 3, 2020, at 10:47 AM, Waiman Long <longman@redhat.com> =
wrote:
>>>>=20
>>>> On 2/3/20 10:28 AM, Peter Zijlstra wrote:
>>>>> On Mon, Feb 03, 2020 at 09:59:12AM -0500, Waiman Long wrote:
>>>>>> On 2/3/20 8:45 AM, Peter Zijlstra wrote:
>>>>>>> Presumably you have a workload where CNA is actually a win? That =
is,
>>>>>>> what inspired you to go down this road? Which actual kernel lock =
is so
>>>>>>> contended on NUMA machines that we need to do this?
>>> There are quite a few actually. files_struct.file_lock, =
file_lock_context.flc_lock
>>> and lockref.lock are some concrete examples that get very hot in =
will-it-scale
>>> benchmarks.=20
>> Right, that's all a variant of banging on the same resources across
>> nodes. I'm not sure there's anything fundamental we can fix there.
Not much, except gain that 2x from a better lock.

>>=20
>>> And then there are spinlocks in __futex_data.queues,=20
>>> which get hot when applications have contended (pthread) locks =E2=80=94=
=20
>>> LevelDB is an example.
>> A numa aware rework of futexes has been on the todo list for years :/
> Now, we are going to get that for free with this patchset:-)
Exactly!!

>>=20
>>> Our initial motivation was based on an observation that kernel =
qspinlock is not=20
>>> NUMA-aware. So what, you may ask. Much like people realized in the =
past that
>>> global spinning is bad for performance, and they switched from =
ticket lock to
>>> locks with local spinning (e.g., MCS), I think everyone would agree =
these days that
>>> bouncing a lock (and cache lines in general) across numa nodes is =
similarly bad.
>>> And as CNA demonstrates, we are easily leaving 2-3x speedups on the =
table by
>>> doing just that with the current qspinlock.
>> Actual benchmarks with performance numbers are required. It helps
>> motivate the patches as well as gives reviewers clues on how to
>> reproduce / inspect the claims made.
>>=20
> I think the cover-letter does have some benchmark results listed.
To clarify on that, I _used to include benchmark results in the cover =
letter=20
for previous revisions. I stopped doing that as the changes between =
revisions
were rather minor =E2=80=94 maybe that is the missing part? If so, my =
apologies, I can
certainly publish them again.

The point is that we have numbers for actual benchmarks, plus the kernel =
build
robot has sent quite a few reports on positive improvements in the =
performance
of AIM7 and other benchmarks due to CNA (plus ARM folks noticed =
improvement
in their benchmarks, although I think those were mostly microbenchmarks.=20=

Yet, it is evident that the improvements are cross-platform.)

Regards,
=E2=80=94 Alex=
