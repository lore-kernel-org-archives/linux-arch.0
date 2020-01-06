Return-Path: <SRS0=948I=23=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:34458 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgAFPE1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jan 2020 10:04:27 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v8 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <fcba7eee-b98f-5381-ea33-6fd94a9e66a6@redhat.com>
Date: Mon, 6 Jan 2020 10:02:26 -0500
Content-Transfer-Encoding: quoted-printable
Message-ID: <1E203DB5-E35B-48AA-90DC-286FE479BB91@oracle.com>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-4-alex.kogan@oracle.com>
 <fcba7eee-b98f-5381-ea33-6fd94a9e66a6@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com
Message-ID: <20200106150226.wN80ln0Z7D16iu_jFSG8ouI3mtsQbEGCyxiTVIojoj4@z>



> On Jan 3, 2020, at 5:14 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> On 12/30/19 2:40 PM, Alex Kogan wrote:
>> +/*
>> + * cna_scan_main_queue - scan the main waiting queue looking for the =
first
>> + * thread running on the same NUMA node as the lock holder. If found =
(call it
>> + * thread T), move all threads in the main queue between the lock =
holder and
>> + * T to the end of the secondary queue and return 0
>> + * (=3DSUCCESSOR_FROM_SAME_NUMA_NODE_FOUND); otherwise, return the =
encoded
> Are you talking about LOCAL_WAITER_FOUND?
Ahh, yes =E2=80=94 good catch!

>> + * pointer of the last scanned node in the primary queue (so a =
subsequent scan
>> + * can be resumed from that node).
>> + *
>> + * Schematically, this may look like the following (nn stands for =
numa_node and
>> + * et stands for encoded_tail).
>> + *
>> + *   when cna_scan_main_queue() is called (the secondary queue is =
empty):
>> + *
>> + *  A+------------+   B+--------+   C+--------+   T+--------+
>> + *   |mcs:next    | -> |mcs:next| -> |mcs:next| -> |mcs:next| -> =
NULL
>> + *   |mcs:locked=3D1|    |cna:nn=3D0|    |cna:nn=3D2|    |cna:nn=3D1|
>> + *   |cna:nn=3D1    |    +--------+    +--------+    +--------+
>> + *   +----------- +
>> + *
>> + *   when cna_scan_main_queue() returns (the secondary queue =
contains B and C):
>> + *
>> + *  A+----------------+    T+--------+
>> + *   |mcs:next        | ->  |mcs:next| -> NULL
>> + *   |mcs:locked=3DC.et | -+  |cna:nn=3D1|
>> + *   |cna:nn=3D1        |  |  +--------+
>> + *   +--------------- +  +-----+
>> + *                             \/
>> + *          B+--------+   C+--------+
>> + *           |mcs:next| -> |mcs:next| -+
>> + *           |cna:nn=3D0|    |cna:nn=3D2|  |
>> + *           +--------+    +--------+  |
>> + *               ^                     |
>> + *               +---------------------+
>> + *
>> + * The worst case complexity of the scan is O(n), where n is the =
number
>> + * of current waiters. However, the amortized complexity is close to =
O(1),
>> + * as the immediate successor is likely to be running on the same =
node once
>> + * threads from other nodes are moved to the secondary queue.
>> + *
>> + * @node      : Pointer to the MCS node of the lock holder
>> + * @pred_start: Pointer to the MCS node of the waiter whose =
successor should be
>> + *              the first node in the scan
>> + * Return     : LOCAL_WAITER_FOUND or encoded tail of the last =
scanned waiter
>> + */
>> +static u32 cna_scan_main_queue(struct mcs_spinlock *node,
>> +			       struct mcs_spinlock *pred_start)
>> +{
>> +	struct cna_node *cn =3D (struct cna_node *)node;
>> +	struct cna_node *cni =3D (struct cna_node =
*)READ_ONCE(pred_start->next);
>> +	struct cna_node *last;
>> +	int my_numa_node =3D cn->numa_node;
>> +
>> +	/* find any next waiter on 'our' NUMA node */
>> +	for (last =3D cn;
>> +	     cni && cni->numa_node !=3D my_numa_node;
>> +	     last =3D cni, cni =3D (struct cna_node =
*)READ_ONCE(cni->mcs.next))
>> +		;
>> +
>> +	/* if found, splice any skipped waiters onto the secondary queue =
*/
>> +	if (cni) {
>> +		if (last !=3D cn)	/* did we skip any waiters? */
>> +			cna_splice_tail(node, node->next,
>> +					(struct mcs_spinlock *)last);
>> +		return LOCAL_WAITER_FOUND;
>> +	}
>> +
>> +	return last->encoded_tail;
>> +}
>> +
>>=20
>> +/*
>> + * Switch to the NUMA-friendly slow path for spinlocks when we have
>> + * multiple NUMA nodes in native environment, unless the user has
>> + * overridden this default behavior by setting the numa_spinlock =
flag.
>> + */
>> +void cna_configure_spin_lock_slowpath(void)
> Nit: There should be a __init.
True. I will fix that.

>> +{
>> +	if ((numa_spinlock_flag =3D=3D 1) ||
>> +	    (numa_spinlock_flag =3D=3D 0 && nr_node_ids > 1 &&
>> +		    pv_ops.lock.queued_spin_lock_slowpath =3D=3D
>> +			native_queued_spin_lock_slowpath)) {
>> +		pv_ops.lock.queued_spin_lock_slowpath =3D
>> +		    __cna_queued_spin_lock_slowpath;
>> +
>> +		pr_info("Enabling CNA spinlock\n");
>> +	}
>> +}
>=20
> Other than these two minor nits, the rests looks good to me.
Great. I will revise and resubmit.

Best regards,
=E2=80=94 Alex=
