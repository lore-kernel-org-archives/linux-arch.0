Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:46396 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfBEDpd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Feb 2019 22:45:33 -0500
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance
 into CNA
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190131100009.GB31534@hirez.programming.kicks-ass.net>
Date: Mon, 4 Feb 2019 22:35:09 -0500
Content-Transfer-Encoding: quoted-printable
Message-ID: <10672939-5C35-4DEF-AFDE-99E85E0F9C46@oracle.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-4-alex.kogan@oracle.com>
 <20190131100009.GB31534@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20190205033509.91PMxpizv8zX-jPQdTDeN7BKvwch-CBlLFKt2W9Bn0A@z>


> On Jan 31, 2019, at 5:00 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Wed, Jan 30, 2019 at 10:01:35PM -0500, Alex Kogan wrote:
>> Choose the next lock holder among spinning threads running on the =
same
>> socket with high probability rather than always. With small =
probability,
>> hand the lock to the first thread in the secondary queue or, if that
>> queue is empty, to the immediate successor of the current lock holder
>> in the main queue.  Thus, assuming no failures while threads hold the
>> lock, every thread would be able to acquire the lock after a bounded
>> number of lock transitions, with high probability.
>>=20
>> Note that we could make the inter-socket transition deterministic,
>> by sticking a counter of intra-socket transitions in the head node
>> of the secondary queue. At the handoff time, we could increment
>> the counter and check if it is below a threshold. This adds another
>> field to queue nodes and nearly-certain local cache miss to read and
>> update this counter during the handoff. While still beating stock,
>> this variant adds certain overhead over the probabilistic variant.
>=20
> (also heavily suffers from the socket =3D=3D node confusion)
>=20
> How would you suggest RT 'tunes' this?
>=20
> RT relies on FIFO fairness of the basic spinlock primitives; you just
> completely wrecked that.

This is true that CNA trades some fairness for shorter lock handover =
latency, much like any other NUMA-aware lock.

Can you explain, however, what exactly breaks here?
It seems that even today, qspinlock does not support RT_PREEMPT, given =
that it uses per-CPU queue nodes.

Thank you,
=E2=80=94 Alex
