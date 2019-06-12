Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:34972 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbfFLEmY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jun 2019 00:42:24 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <cc3eee8c-5212-7af5-c932-897ab8f3f8bf@huawei.com>
Date: Wed, 12 Jun 2019 00:38:29 -0400
Content-Transfer-Encoding: quoted-printable
Message-ID: <54241445-458C-4AE2-840B-6DFCCD410399@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <cc3eee8c-5212-7af5-c932-897ab8f3f8bf@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "liwei (GF)" <liwei391@huawei.com>
Cc: linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, Waiman Long <longman@redhat.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de, hpa@zytor.com, x86@kernel.org, dave.dice@oracle.com, Rahul Yadav <rahul.x.yadav@oracle.com>, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>
Message-ID: <20190612043829.alS7RpjoG2Hg2wihZKVqBd3NsHeNOWwCL77tcPC0zAI@z>

Hi, Wei.

> On Jun 11, 2019, at 12:22 AM, liwei (GF) <liwei391@huawei.com> wrote:
>=20
> Hi Alex,
>=20
> On 2019/3/29 23:20, Alex Kogan wrote:
>> In CNA, spinning threads are organized in two queues, a main queue =
for
>> threads running on the same node as the current lock holder, and a
>> secondary queue for threads running on other nodes. At the unlock =
time,
>> the lock holder scans the main queue looking for a thread running on
>> the same node. If found (call it thread T), all threads in the main =
queue
>> between the current lock holder and T are moved to the end of the
>> secondary queue, and the lock is passed to T. If such T is not found, =
the
>> lock is passed to the first node in the secondary queue. Finally, if =
the
>> secondary queue is empty, the lock is passed to the next thread in =
the
>> main queue. For more details, see =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__arxiv.org_abs_1810.=
05600&d=3DDwICbg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3=
F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=3DU7mfTbYj1r2Te2BBUUNbVrRPuTa_ujl=
pR4GZfUsrGTM&s=3DDw4O1EniF-nde4fp6RA9ISlSMOjWuqeR9OS1G0iauj0&e=3D.
>>=20
>> Note that this variant of CNA may introduce starvation by =
continuously
>> passing the lock to threads running on the same node. This issue
>> will be addressed later in the series.
>>=20
>> Enabling CNA is controlled via a new configuration option
>> (NUMA_AWARE_SPINLOCKS), which is enabled by default if NUMA is =
enabled.
>>=20
>> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
>> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> arch/x86/Kconfig                      |  14 +++
>> include/asm-generic/qspinlock_types.h |  13 +++
>> kernel/locking/mcs_spinlock.h         |  10 ++
>> kernel/locking/qspinlock.c            |  29 +++++-
>> kernel/locking/qspinlock_cna.h        | 173 =
++++++++++++++++++++++++++++++++++
>> 5 files changed, 236 insertions(+), 3 deletions(-)
>> create mode 100644 kernel/locking/qspinlock_cna.h
>>=20
> (SNIP)
>> +
>> +static __always_inline int get_node_index(struct mcs_spinlock *node)
>> +{
>> +	return decode_count(node->node_and_count++);
> When nesting level is > 4, it won't return a index >=3D 4 here and the =
numa node number
> is changed by mistake. It will go into a wrong way instead of the =
following branch.
>=20
>=20
> 	/*
> 	 * 4 nodes are allocated based on the assumption that there will
> 	 * not be nested NMIs taking spinlocks. That may not be true in
> 	 * some architectures even though the chance of needing more =
than
> 	 * 4 nodes will still be extremely unlikely. When that happens,
> 	 * we fall back to spinning on the lock directly without using
> 	 * any MCS node. This is not the most elegant solution, but is
> 	 * simple enough.
> 	 */
> 	if (unlikely(idx >=3D MAX_NODES)) {
> 		while (!queued_spin_trylock(lock))
> 			cpu_relax();
> 		goto release;
> 	}
Good point.
This patch does not handle count overflows gracefully.
It can be easily fixed by allocating more bits for the count =E2=80=94 =
we don=E2=80=99t really need 30 bits for #NUMA nodes.

However, I am working on a new revision of the patch, in which the cna =
node encapsulates the mcs node (following Peter=E2=80=99s suggestion and =
similarly to pv_node).
With that approach, this issue is gone.

Best regards,
=E2=80=94 Alex
