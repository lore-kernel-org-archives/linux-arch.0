From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
Date: Tue, 07 Jul 2020 15:57:06 +1000
Message-ID: <1594101082.hfq9x5yact.astroid@bobo.none>
References: <20200706043540.1563616-1-npiggin@gmail.com>
        <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgGGF5M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2020 01:57:12 -0400
In-Reply-To: <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, Waiman Long <longman@redhat.com>
Cc: Anton Blanchard <anton@ozlabs.org>, Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>

Excerpts from Waiman Long's message of July 7, 2020 4:39 am:
> On 7/6/20 12:35 AM, Nicholas Piggin wrote:
>> v3 is updated to use __pv_queued_spin_unlock, noticed by Waiman (thank y=
ou).
>>
>> Thanks,
>> Nick
>>
>> Nicholas Piggin (6):
>>    powerpc/powernv: must include hvcall.h to get PAPR defines
>>    powerpc/pseries: move some PAPR paravirt functions to their own file
>>    powerpc: move spinlock implementation to simple_spinlock
>>    powerpc/64s: implement queued spinlocks and rwlocks
>>    powerpc/pseries: implement paravirt qspinlocks for SPLPAR
>>    powerpc/qspinlock: optimised atomic_try_cmpxchg_lock that adds the
>>      lock hint
>>
>>   arch/powerpc/Kconfig                          |  13 +
>>   arch/powerpc/include/asm/Kbuild               |   2 +
>>   arch/powerpc/include/asm/atomic.h             |  28 ++
>>   arch/powerpc/include/asm/paravirt.h           |  89 +++++
>>   arch/powerpc/include/asm/qspinlock.h          |  91 ++++++
>>   arch/powerpc/include/asm/qspinlock_paravirt.h |   7 +
>>   arch/powerpc/include/asm/simple_spinlock.h    | 292 +++++++++++++++++
>>   .../include/asm/simple_spinlock_types.h       |  21 ++
>>   arch/powerpc/include/asm/spinlock.h           | 308 +-----------------
>>   arch/powerpc/include/asm/spinlock_types.h     |  17 +-
>>   arch/powerpc/lib/Makefile                     |   3 +
>>   arch/powerpc/lib/locks.c                      |  12 +-
>>   arch/powerpc/platforms/powernv/pci-ioda-tce.c |   1 +
>>   arch/powerpc/platforms/pseries/Kconfig        |   5 +
>>   arch/powerpc/platforms/pseries/setup.c        |   6 +-
>>   include/asm-generic/qspinlock.h               |   4 +
>>   16 files changed, 577 insertions(+), 322 deletions(-)
>>   create mode 100644 arch/powerpc/include/asm/paravirt.h
>>   create mode 100644 arch/powerpc/include/asm/qspinlock.h
>>   create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
>>   create mode 100644 arch/powerpc/include/asm/simple_spinlock.h
>>   create mode 100644 arch/powerpc/include/asm/simple_spinlock_types.h
>>
> This patch looks OK to me.

Thanks for reviewing and testing.

> I had run some microbenchmark on powerpc system with or w/o the patch.
>=20
> On a 2-socket 160-thread SMT4 POWER9 system (not virtualized):
>=20
> 5.8.0-rc4
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Running locktest with spinlock [runtime =3D 10s, load =3D 1]
> Threads =3D 160, Min/Mean/Max =3D 77,665/90,153/106,895
> Threads =3D 160, Total Rate =3D 1,441,759 op/s; Percpu Rate =3D 9,011 op/=
s
>=20
> Running locktest with rwlock [runtime =3D 10s, r% =3D 50%, load =3D 1]
> Threads =3D 160, Min/Mean/Max =3D 47,879/53,807/63,689
> Threads =3D 160, Total Rate =3D 860,192 op/s; Percpu Rate =3D 5,376 op/s
>=20
> Running locktest with spinlock [runtime =3D 10s, load =3D 1]
> Threads =3D 80, Min/Mean/Max =3D 242,907/319,514/463,161
> Threads =3D 80, Total Rate =3D 2,555 kop/s; Percpu Rate =3D 32 kop/s
>=20
> Running locktest with rwlock [runtime =3D 10s, r% =3D 50%, load =3D 1]
> Threads =3D 80, Min/Mean/Max =3D 146,161/187,474/259,270
> Threads =3D 80, Total Rate =3D 1,498 kop/s; Percpu Rate =3D 19 kop/s
>=20
> Running locktest with spinlock [runtime =3D 10s, load =3D 1]
> Threads =3D 40, Min/Mean/Max =3D 646,639/1,000,817/1,455,205
> Threads =3D 40, Total Rate =3D 4,001 kop/s; Percpu Rate =3D 100 kop/s
>=20
> Running locktest with rwlock [runtime =3D 10s, r% =3D 50%, load =3D 1]
> Threads =3D 40, Min/Mean/Max =3D 402,165/597,132/814,555
> Threads =3D 40, Total Rate =3D 2,388 kop/s; Percpu Rate =3D 60 kop/s
>=20
> 5.8.0-rc4-qlock+
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Running locktest with spinlock [runtime =3D 10s, load =3D 1]
> Threads =3D 160, Min/Mean/Max =3D 123,835/124,580/124,587
> Threads =3D 160, Total Rate =3D 1,992 kop/s; Percpu Rate =3D 12 kop/s
>=20
> Running locktest with rwlock [runtime =3D 10s, r% =3D 50%, load =3D 1]
> Threads =3D 160, Min/Mean/Max =3D 254,210/264,714/276,784
> Threads =3D 160, Total Rate =3D 4,231 kop/s; Percpu Rate =3D 26 kop/s
>=20
> Running locktest with spinlock [runtime =3D 10s, load =3D 1]
> Threads =3D 80, Min/Mean/Max =3D 599,715/603,397/603,450
> Threads =3D 80, Total Rate =3D 4,825 kop/s; Percpu Rate =3D 60 kop/s
>=20
> Running locktest with rwlock [runtime =3D 10s, r% =3D 50%, load =3D 1]
> Threads =3D 80, Min/Mean/Max =3D 492,687/525,224/567,456
> Threads =3D 80, Total Rate =3D 4,199 kop/s; Percpu Rate =3D 52 kop/s
>=20
> Running locktest with spinlock [runtime =3D 10s, load =3D 1]
> Threads =3D 40, Min/Mean/Max =3D 1,325,623/1,325,628/1,325,636
> Threads =3D 40, Total Rate =3D 5,299 kop/s; Percpu Rate =3D 132 kop/s
>=20
> Running locktest with rwlock [runtime =3D 10s, r% =3D 50%, load =3D 1]
> Threads =3D 40, Min/Mean/Max =3D 1,249,731/1,292,977/1,342,815
> Threads =3D 40, Total Rate =3D 5,168 kop/s; Percpu Rate =3D 129 kop/s
>=20
> On systems on large number of cpus, qspinlock lock is faster and more fai=
r.
>=20
> With some tuning, we may be able to squeeze out more performance.

Yes, powerpc could certainly get more performance out of the slow
paths, and then there are a few parameters to tune.

We don't have a good alternate patching for function calls yet, but
that would be something to do for native vs pv.

And then there seem to be one or two tunable parameters we could
experiment with.

The paravirt locks may need a bit more tuning. Some simple testing
under KVM shows we might be a bit slower in some cases. Whether this
is fairness or something else I'm not sure. The current simple pv
spinlock code can do a directed yield to the lock holder CPU, whereas=20
the pv qspl here just does a general yield. I think we might actually
be able to change that to also support directed yield. Though I'm
not sure if this is actually the cause of the slowdown yet.

Thanks,
Nick
