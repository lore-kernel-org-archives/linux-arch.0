Return-Path: <SRS0=GP1c=3Q=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:33634 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbgA0QCr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jan 2020 11:02:47 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <CAC4j=Y--5UQR7Oc5n+sxAwLxd_PKi0Eb-7aiZjDTUW0FTJy8Tw@mail.gmail.com>
Date: Mon, 27 Jan 2020 11:01:33 -0500
Content-Transfer-Encoding: quoted-printable
Message-ID: <25401561-CD1F-4FDC-AED5-256EBE56B9F6@oracle.com>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
 <4F71A184-42C0-4865-9AAA-79A636743C25@oracle.com>
 <CAC4j=Y_SMHe4WNpaaS0kK1JYfnufM+AAiwwUMBx27L8U6bD8Yg@mail.gmail.com>
 <CAC4j=Y--5UQR7Oc5n+sxAwLxd_PKi0Eb-7aiZjDTUW0FTJy8Tw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lihao Liang <lihaoliang@google.com>
Cc: linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, dave.dice@oracle.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, Will Deacon <will@kernel.org>
Message-ID: <20200127160133.4EZEcQLrdQdf6v0yPQNNUzRuuMef1HVJzLjlfAdw16g@z>

Hi, Lihao.

>>>=20
>>>> This is particularly relevant
>>>> in high contention situations when new threads keep arriving on the =
same
>>>> socket as the lock holder.
>>> In this case, the lock will stay on the same NUMA node/socket for
>>> 2^numa_spinlock_threshold times, which is the worst case scenario if =
we
>>> consider the long-term fairness. And if we have multiple nodes, it =
will take
>>> up to 2^numa_spinlock_threshold X (nr_nodes - 1) + nr_cpus_per_node
>>> lock transitions until any given thread will acquire the lock
>>> (assuming 2^numa_spinlock_threshold > nr_cpus_per_node).
>>>=20
>>=20
>> You're right that the latest version of the patch handles long-term =
fairness
>> deterministically.
>>=20
>> As I understand it, the n-th thread in the main queue is guaranteed =
to
>> acquire the lock after N lock handovers, where N is bounded by
>>=20
>> n - 1 + 2^numa_spinlock_threshold * (nr_nodes - 1)
>>=20
>> I'm not sure what role the variable nr_cpus_per_node plays in your =
analysis.
>>=20
>> Do I miss anything?
>>=20
>=20
> If I understand correctly, there are two phases in the algorithm:
>=20
> MCS phase: when the secondary queue is empty, as explained in your =
emails,
> the algorithm hands the lock to threads in the main queue in an FIFO =
order.
> When probably(SHUFFLE_REDUCTION_PROB_ARG) returns false (with default
> probability 1%), if the algorithm finds the first thread running on =
the same
> socket as the lock holder in cna_scan_main_queue(), it enters the =
following
> CNA phase
Yep. When probably() returns false, we scan the main queue. If as the =
result of
this scan the secondary queue becomes not empty, we enter what you call
the CNA phase.

> .
>=20
> CNA phase: when the secondary queue is not empty, the algorithm keeps
> handing the lock to threads in the main queue that run on the same =
socket as
> the lock holder. When 2^numa_spinlock_threshold is reached, it splices
> the secondary queue to the front of the main queue. And we are back to =
the
> MCS phase above.
Correct.

> For the n-th thread T in the main queue, the MCS phase handles threads =
that
> arrived in the main queue before T. In high contention situations, the =
CNA
> phase handles two kinds of threads:
>=20
> 1. Threads ahead of T that run on the same socket as the lock holder =
when
> a transition from the MCS to CNA phase was made. Assume there are m =
such
> threads.
>=20
> 2. Threads that keep arriving on the same socket as the lock holder. =
There
> are at most 2^numa_spinlock_threshold of them.
>=20
> Then the number of lock handovers in the CNA phase is max(m,
> 2^numa_spinlock_threshold). So the total number of lock handovers =
before T
> acquires the lock is at most
>=20
> n - 1 + 2^numa_spinlock_threshold * (nr_nodes - 1)
>=20
> Please let me know if I misunderstand anything.
I think you got it right (modulo nr_cpus_per_node instead of n, as =
mentioned in=20
my other response).

Regards,
=E2=80=94 Alex=
