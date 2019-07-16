Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:60952 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPOyD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 10:54:03 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v3 2/5] locking/qspinlock: Refactor the qspinlock slow
 path
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190716102034.GN3419@hirez.programming.kicks-ass.net>
Date: Tue, 16 Jul 2019 10:53:02 -0400
Content-Transfer-Encoding: quoted-printable
Message-ID: <9D5B6F33-6003-4CCA-BBE5-998B5A679B9C@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-3-alex.kogan@oracle.com>
 <20190716102034.GN3419@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190716145302.JaM3tN4xz9Vu8rTmAaWiTuN12FNTCnpmEDqs66nAFc8@z>

On Jul 16, 2019, at 6:20 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Mon, Jul 15, 2019 at 03:25:33PM -0400, Alex Kogan wrote:
>=20
>> +/*
>> + * set_locked_empty_mcs - Try to set the spinlock value to =
_Q_LOCKED_VAL,
>> + * and by doing that unlock the MCS lock when its waiting queue is =
empty
>> + * @lock: Pointer to queued spinlock structure
>> + * @val: Current value of the lock
>> + * @node: Pointer to the MCS node of the lock holder
>> + *
>> + * *,*,* -> 0,0,1
>> + */
>> +static __always_inline bool __set_locked_empty_mcs(struct qspinlock =
*lock,
>> +						   u32 val,
>> +						   struct mcs_spinlock =
*node)
>> +{
>> +	return atomic_try_cmpxchg_relaxed(&lock->val, &val, =
_Q_LOCKED_VAL);
>> +}
>=20
> That name is nonsense. It should be something like:
>=20
> static __always_inline bool __try_clear_tail(=E2=80=A6)

We already have set_locked(), so I was trying to convey the fact that we =
are
doing the same here, but only when the MCS chain is empty.

I can use __try_clear_tail() instead.

>=20
>=20
>> +/*
>> + * pass_mcs_lock - pass the MCS lock to the next waiter
>> + * @node: Pointer to the MCS node of the lock holder
>> + * @next: Pointer to the MCS node of the first waiter in the MCS =
queue
>> + */
>> +static __always_inline void __pass_mcs_lock(struct mcs_spinlock =
*node,
>> +					    struct mcs_spinlock *next)
>> +{
>> +	arch_mcs_spin_unlock_contended(&next->locked, 1);
>> +}
>=20
> I'm not entirely happy with that name either; but it's not horrible =
like
> the other one. Why not mcs_spin_unlock_contended() ?

Sure, I can use mcs_spin_unlock_contended() instead.

Thanks,
=E2=80=94 Alex
