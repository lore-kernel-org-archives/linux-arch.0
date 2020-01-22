Return-Path: <SRS0=lDRc=3L=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:49500 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVTau (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jan 2020 14:30:50 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
Date: Wed, 22 Jan 2020 14:29:36 -0500
Content-Transfer-Encoding: quoted-printable
Message-ID: <4F71A184-42C0-4865-9AAA-79A636743C25@oracle.com>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lihao Liang <lihaoliang@google.com>
Cc: linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, dave.dice@oracle.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, Will Deacon <will@kernel.org>
Message-ID: <20200122192936.bzb7EiMnT-XpBRyiTAOtvyn0msj_VjVvifL6wprSRr0@z>

Hi, Lihao.

> On Jan 22, 2020, at 6:45 AM, Lihao Liang <lihaoliang@google.com> =
wrote:
>=20
> Hi Alex,
>=20
> On Wed, Jan 22, 2020 at 10:28 AM Alex Kogan <alex.kogan@oracle.com> =
wrote:
>>=20
>> Summary
>> -------
>>=20
>> Lock throughput can be increased by handing a lock to a waiter on the
>> same NUMA node as the lock holder, provided care is taken to avoid
>> starvation of waiters on other NUMA nodes. This patch introduces CNA
>> (compact NUMA-aware lock) as the slow path for qspinlock. It is
>> enabled through a configuration option (NUMA_AWARE_SPINLOCKS).
>>=20
>=20
> Thanks for your patches. The experimental results look promising!
>=20
> I understand that the new CNA qspinlock uses randomization to achieve
> long-term fairness, and provides the numa_spinlock_threshold parameter
> for users to tune.
This has been the case in the first versions of the series, but is not =
true anymore.
That is, the long-term fairness is achieved deterministically (and you =
are correct=20
that it is done through the numa_spinlock_threshold parameter).

> As Linux runs extremely diverse workloads, it is not
> clear how randomization affects its fairness, and how users with
> different requirements are supposed to tune this parameter.
>=20
> To this end, Will and I consider it beneficial to be able to answer =
the
> following question:
>=20
> With different values of numa_spinlock_threshold and
> SHUFFLE_REDUCTION_PROB_ARG, how long do threads running on different
> sockets have to wait to acquire the lock?
The SHUFFLE_REDUCTION_PROB_ARG parameter is intended for performance
optimization only, and *does not* affect the long-term fairness (or, at =
the=20
very least, does not make it any worse). As Longman correctly pointed =
out in=20
his response to this email, the shuffle reduction optimization is =
relevant only
when the secondary queue is empty. In that case, CNA hands-off the lock
exactly as MCS does, i.e., in the FIFO order. Note that when the =
secondary
queue is not empty, we do not call probably().

> This is particularly relevant
> in high contention situations when new threads keep arriving on the =
same
> socket as the lock holder.
In this case, the lock will stay on the same NUMA node/socket for=20
2^numa_spinlock_threshold times, which is the worst case scenario if we=20=

consider the long-term fairness. And if we have multiple nodes, it will =
take=20
up to 2^numa_spinlock_threshold X (nr_nodes - 1) + nr_cpus_per_node
lock transitions until any given thread will acquire the lock
(assuming 2^numa_spinlock_threshold > nr_cpus_per_node).

Hopefully, it addresses your concern. Let me know if you have any =
further=20
questions.

Best regards,
=E2=80=94 Alex
