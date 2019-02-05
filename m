Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:58298 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfBEVII (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Feb 2019 16:08:08 -0500
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance
 into CNA
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190205092256.GN17528@hirez.programming.kicks-ass.net>
Date: Tue, 5 Feb 2019 16:07:37 -0500
Content-Transfer-Encoding: quoted-printable
Message-ID: <4A727687-51F9-4FD0-9608-CDBAD6A6EF07@oracle.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-4-alex.kogan@oracle.com>
 <20190131100009.GB31534@hirez.programming.kicks-ass.net>
 <10672939-5C35-4DEF-AFDE-99E85E0F9C46@oracle.com>
 <20190205092256.GN17528@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com, Rahul Yadav <rahul.x.yadav@oracle.com>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20190205210737.I-RS1yk4ou7Zd_B1AD7bLQzh2PiHG0lcBocJ-nC8onk@z>

[ Resending after correcting an issue with the included URL and =
correcting a typo=20
in Waiman=E2=80=99s name =E2=80=94 sorry about that! ]

> On Feb 5, 2019, at 4:22 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Mon, Feb 04, 2019 at 10:35:09PM -0500, Alex Kogan wrote:
>>=20
>>> On Jan 31, 2019, at 5:00 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>>=20
>>> On Wed, Jan 30, 2019 at 10:01:35PM -0500, Alex Kogan wrote:
>>>> Choose the next lock holder among spinning threads running on the =
same
>>>> socket with high probability rather than always. With small =
probability,
>>>> hand the lock to the first thread in the secondary queue or, if =
that
>>>> queue is empty, to the immediate successor of the current lock =
holder
>>>> in the main queue.  Thus, assuming no failures while threads hold =
the
>>>> lock, every thread would be able to acquire the lock after a =
bounded
>>>> number of lock transitions, with high probability.
>>>>=20
>>>> Note that we could make the inter-socket transition deterministic,
>>>> by sticking a counter of intra-socket transitions in the head node
>>>> of the secondary queue. At the handoff time, we could increment
>>>> the counter and check if it is below a threshold. This adds another
>>>> field to queue nodes and nearly-certain local cache miss to read =
and
>>>> update this counter during the handoff. While still beating stock,
>>>> this variant adds certain overhead over the probabilistic variant.
>>>=20
>>> (also heavily suffers from the socket =3D=3D node confusion)
>>>=20
>>> How would you suggest RT 'tunes' this?
>>>=20
>>> RT relies on FIFO fairness of the basic spinlock primitives; you =
just
>>> completely wrecked that.
>>=20
>> This is true that CNA trades some fairness for shorter lock handover
>> latency, much like any other NUMA-aware lock.
>>=20
>> Can you explain, however, what exactly breaks here?
>=20
> Timeliness guarantees. FIFO-fair has well defined time behaviour; you
> know exactly how long you get to wait before you acquire the lock,
> namely however many waiters are in front of you multiplied by the =
worst
> case wait time.
Got it =E2=80=94 thanks for the clarification!

>=20
> Doing time analysis on a randomized algorithm isn't my idea of fun.
>=20
>> It seems that even today, qspinlock does not support RT_PREEMPT, =
given
>> that it uses per-CPU queue nodes.
>=20
> It does work with RT, commit:
>=20
>  7aa54be29765 ("locking/qspinlock, x86: Provide liveness guarantee")
>=20
> it a direct result of RT observing funnies with it. I've no idea why =
you
> think it would not work.
Just trying to get to the bottom of it =E2=80=94 as of today, qspinlock =
explicitly assumes
no preemption while waiting for the lock.

Here is what Waiman had to say about that in =
https://lwn.net/Articles/561775:

"The idea behind this spinlock implementation is the fact that spinlocks
are acquired with preemption disabled. In other words, the process
will not be migrated to another CPU while it is trying to get a
spinlock.=E2=80=9D

This was back in 2013, but the code still uses per-CPU queue nodes,
and AFAICT, preemption will break things up.

So what you are saying is that RT would be fine assuming no preemption =
in
the spinlock as long as it provides FIFO? Or there is some future code =
patch=20
that will take care of the =E2=80=9Cno preemption=E2=80=9D assumption =
(but still assume FIFO)?

Thanks,
=E2=80=94 Alex=
