Return-Path: <SRS0=+omB=25=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43190 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725838AbgAHFKF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jan 2020 00:10:05 -0500
From: Shijith Thotton <sthotton@marvell.com>
Subject: Re: [PATCH v8 0/5] Add NUMA-awareness to qspinlock
Date: Wed, 8 Jan 2020 05:09:05 +0000
Message-ID: <20200108050847.GA12944@dc5-eodlnx05.marvell.com>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
In-Reply-To: <20191230194042.67789-1-alex.kogan@oracle.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73759E6B28304F49959E310699290855@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>, "will.deacon@arm.com" <will.deacon@arm.com>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "arnd@arndb.de" <arnd@arndb.de>, "longman@redhat.com" <longman@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "guohanjun@huawei.com" <guohanjun@huawei.com>, "steven.sistare@oracle.com" <steven.sistare@oracle.com>, "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>, "dave.dice@oracle.com" <dave.dice@oracle.com>
Message-ID: <20200108050905.Cyp-sVKXIh8fuUPYBhIPexWJoRvPZvU0HuMfOicNCmc@z>

Hi Will,

On Mon, Dec 30, 2019 at 02:40:37PM -0500, Alex Kogan wrote:
> Minor changes from v7 based on feedback from Longman:
> -----------------------------------------------------
>=20
> - Move __init functions from alternative.c to qspinlock_cna.h
>=20
> - Introduce enum for return values from cna_pre_scan(), for better
> readability.
>=20
> - Add/revise a few comments to improve readability.
>=20
>=20
> Summary
> -------
>=20
> Lock throughput can be increased by handing a lock to a waiter on the
> same NUMA node as the lock holder, provided care is taken to avoid
> starvation of waiters on other NUMA nodes. This patch introduces CNA
> (compact NUMA-aware lock) as the slow path for qspinlock. It is
> enabled through a configuration option (NUMA_AWARE_SPINLOCKS).
>=20
> CNA is a NUMA-aware version of the MCS lock. Spinning threads are
> organized in two queues, a main queue for threads running on the same
> node as the current lock holder, and a secondary queue for threads
> running on other nodes. Threads store the ID of the node on which
> they are running in their queue nodes. After acquiring the MCS lock and
> before acquiring the spinlock, the lock holder scans the main queue
> looking for a thread running on the same node (pre-scan). If found (call
> it thread T), all threads in the main queue between the current lock
> holder and T are moved to the end of the secondary queue.  If such T
> is not found, we make another scan of the main queue after acquiring=20
> the spinlock when unlocking the MCS lock (post-scan), starting at the
> node where pre-scan stopped. If both scans fail to find such T, the
> MCS lock is passed to the first thread in the secondary queue. If the
> secondary queue is empty, the MCS lock is passed to the next thread in th=
e
> main queue. To avoid starvation of threads in the secondary queue, those
> threads are moved back to the head of the main queue after a certain
> number of intra-node lock hand-offs.
>=20
> More details are available at https://urldefense.proofpoint.com/v2/url?u=
=3Dhttps-3A__arxiv.org_abs_1810.05600&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ=
&r=3DG9w4KsPaQLACBfGCL35PtiRH996yqJDxAZwrWegU2qQ&m=3DAoOLTQlgNjtdBvY_yWd6Vi=
BXrVM6o2wqXOdFA4B_F2A&s=3DyUjG9gfi3BtLKDEjgki86h52GVXMvDQ6ZClMvoIG034&e=3D =
.
>=20
> The series applies on top of v5.5.0-rc2, commit ea200dec51.
> Performance numbers are available in previous revisions
> of the series.
>=20
> Further comments are welcome and appreciated.
>=20
> Alex Kogan (5):
>   locking/qspinlock: Rename mcs lock/unlock macros and make them more
>     generic
>   locking/qspinlock: Refactor the qspinlock slow path
>   locking/qspinlock: Introduce CNA into the slow path of qspinlock
>   locking/qspinlock: Introduce starvation avoidance into CNA
>   locking/qspinlock: Introduce the shuffle reduction optimization into
>     CNA
>=20
>  .../admin-guide/kernel-parameters.txt         |  18 +
>  arch/arm/include/asm/mcs_spinlock.h           |   6 +-
>  arch/x86/Kconfig                              |  20 +
>  arch/x86/include/asm/qspinlock.h              |   4 +
>  arch/x86/kernel/alternative.c                 |   4 +
>  include/asm-generic/mcs_spinlock.h            |   4 +-
>  kernel/locking/mcs_spinlock.h                 |  20 +-
>  kernel/locking/qspinlock.c                    |  82 +++-
>  kernel/locking/qspinlock_cna.h                | 400 ++++++++++++++++++
>  kernel/locking/qspinlock_paravirt.h           |   2 +-
>  10 files changed, 537 insertions(+), 23 deletions(-)
>  create mode 100644 kernel/locking/qspinlock_cna.h
>=20
> --=20
> 2.21.0 (Apple Git-122.2)
>

Tried out queued spinlock slowpath improvements on arm64 (ThunderX2) by
hardwiring CNA APIs to queued_spin_lock_slowpath() and numbers are pretty
good with the CNA changes.

Speed-up on v5.5-rc4 kernel:

will-it-scale/open1_threads:
#thr    speed-up
1        1.00
2        0.97
4        0.98
8        1.02
16       0.95
32       1.63
64       1.70
128      2.09
224      2.16

will-it-scale/lock2_threads:
#thr    speed-up
1        0.98
2        0.99
4        0.90  =20
8        0.98
16       0.99
32       1.52
64       2.31
128      2.25  =20
224      2.04  =20

#thr - number of threads
speed-up - number with CNA patch / number with stock kernel

Please share your thoughts on best way to enable this series on arm64.

Thanks,
Shijith
