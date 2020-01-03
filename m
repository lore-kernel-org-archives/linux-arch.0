From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v8 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Fri, 3 Jan 2020 17:14:55 -0500
Message-ID: <fcba7eee-b98f-5381-ea33-6fd94a9e66a6@redhat.com>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-4-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191230194042.67789-4-alex.kogan@oracle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com
List-Id: linux-arch.vger.kernel.org

On 12/30/19 2:40 PM, Alex Kogan wrote:
> +/*
> + * cna_scan_main_queue - scan the main waiting queue looking for the first
> + * thread running on the same NUMA node as the lock holder. If found (call it
> + * thread T), move all threads in the main queue between the lock holder and
> + * T to the end of the secondary queue and return 0
> + * (=SUCCESSOR_FROM_SAME_NUMA_NODE_FOUND); otherwise, return the encoded
Are you talking about LOCAL_WAITER_FOUND?
> + * pointer of the last scanned node in the primary queue (so a subsequent scan
> + * can be resumed from that node).
> + *
> + * Schematically, this may look like the following (nn stands for numa_node and
> + * et stands for encoded_tail).
> + *
> + *   when cna_scan_main_queue() is called (the secondary queue is empty):
> + *
> + *  A+------------+   B+--------+   C+--------+   T+--------+
> + *   |mcs:next    | -> |mcs:next| -> |mcs:next| -> |mcs:next| -> NULL
> + *   |mcs:locked=1|    |cna:nn=0|    |cna:nn=2|    |cna:nn=1|
> + *   |cna:nn=1    |    +--------+    +--------+    +--------+
> + *   +----------- +
> + *
> + *   when cna_scan_main_queue() returns (the secondary queue contains B and C):
> + *
> + *  A+----------------+    T+--------+
> + *   |mcs:next        | ->  |mcs:next| -> NULL
> + *   |mcs:locked=C.et | -+  |cna:nn=1|
> + *   |cna:nn=1        |  |  +--------+
> + *   +--------------- +  +-----+
> + *                             \/
> + *          B+--------+   C+--------+
> + *           |mcs:next| -> |mcs:next| -+
> + *           |cna:nn=0|    |cna:nn=2|  |
> + *           +--------+    +--------+  |
> + *               ^                     |
> + *               +---------------------+
> + *
> + * The worst case complexity of the scan is O(n), where n is the number
> + * of current waiters. However, the amortized complexity is close to O(1),
> + * as the immediate successor is likely to be running on the same node once
> + * threads from other nodes are moved to the secondary queue.
> + *
> + * @node      : Pointer to the MCS node of the lock holder
> + * @pred_start: Pointer to the MCS node of the waiter whose successor should be
> + *              the first node in the scan
> + * Return     : LOCAL_WAITER_FOUND or encoded tail of the last scanned waiter
> + */
> +static u32 cna_scan_main_queue(struct mcs_spinlock *node,
> +			       struct mcs_spinlock *pred_start)
> +{
> +	struct cna_node *cn = (struct cna_node *)node;
> +	struct cna_node *cni = (struct cna_node *)READ_ONCE(pred_start->next);
> +	struct cna_node *last;
> +	int my_numa_node = cn->numa_node;
> +
> +	/* find any next waiter on 'our' NUMA node */
> +	for (last = cn;
> +	     cni && cni->numa_node != my_numa_node;
> +	     last = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
> +		;
> +
> +	/* if found, splice any skipped waiters onto the secondary queue */
> +	if (cni) {
> +		if (last != cn)	/* did we skip any waiters? */
> +			cna_splice_tail(node, node->next,
> +					(struct mcs_spinlock *)last);
> +		return LOCAL_WAITER_FOUND;
> +	}
> +
> +	return last->encoded_tail;
> +}
> +
>
> +/*
> + * Switch to the NUMA-friendly slow path for spinlocks when we have
> + * multiple NUMA nodes in native environment, unless the user has
> + * overridden this default behavior by setting the numa_spinlock flag.
> + */
> +void cna_configure_spin_lock_slowpath(void)
Nit: There should be a __init.
> +{
> +	if ((numa_spinlock_flag == 1) ||
> +	    (numa_spinlock_flag == 0 && nr_node_ids > 1 &&
> +		    pv_ops.lock.queued_spin_lock_slowpath ==
> +			native_queued_spin_lock_slowpath)) {
> +		pv_ops.lock.queued_spin_lock_slowpath =
> +		    __cna_queued_spin_lock_slowpath;
> +
> +		pr_info("Enabling CNA spinlock\n");
> +	}
> +}

Other than these two minor nits, the rests looks good to me.

Cheers,
Longman
