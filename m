Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbfIQSHY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Sep 2019 14:07:24 -0400
Subject: Re: [PATCH v4 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
References: <20190906142541.34061-1-alex.kogan@oracle.com>
 <20190906142541.34061-5-alex.kogan@oracle.com>
From: Waiman Long <longman@redhat.com>
Message-ID: <506c7d1c-faef-d094-3baa-6aaaf9089c60@redhat.com>
Date: Tue, 17 Sep 2019 14:07:21 -0400
MIME-Version: 1.0
In-Reply-To: <20190906142541.34061-5-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190917180721.ICS2O5uycVOeTNJrDp9DIm88MWJu72msUH4MfDNOTZI@z>

On 9/6/19 10:25 AM, Alex Kogan wrote:
> Choose the next lock holder among spinning threads running on the same
> node with high probability rather than always. With small probability,
> hand the lock to the first thread in the secondary queue or, if that
> queue is empty, to the immediate successor of the current lock holder
> in the main queue.  Thus, assuming no failures while threads hold the
> lock, every thread would be able to acquire the lock after a bounded
> number of lock transitions, with high probability.
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  kernel/locking/qspinlock_cna.h | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
> index f983debf20bb..e86182e6163b 100644
> --- a/kernel/locking/qspinlock_cna.h
> +++ b/kernel/locking/qspinlock_cna.h
> @@ -4,6 +4,7 @@
>  #endif
>  
>  #include <linux/topology.h>
> +#include <linux/random.h>
>  
>  /*
>   * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
> @@ -50,6 +51,34 @@ struct cna_node {
>  	struct	cna_node *tail;    /* points to the secondary queue tail */
>  };
>  
> +/* Per-CPU pseudo-random number seed */
> +static DEFINE_PER_CPU(u32, seed);
> +
> +/*
> + * Controls the probability for intra-node lock hand-off. It can be
> + * tuned and depend, e.g., on the number of CPUs per node. For now,
> + * choose a value that provides reasonable long-term fairness without
> + * sacrificing performance compared to a version that does not have any
> + * fairness guarantees.
> + */
> +#define INTRA_NODE_HANDOFF_PROB_ARG (16)
> +
> +/*
> + * Return false with probability 1 / 2^@num_bits.
> + * Intuitively, the larger @num_bits the less likely false is to be returned.
> + * @num_bits must be a number between 0 and 31.
> + */
> +static bool probably(unsigned int num_bits)
> +{
> +	u32 s;
> +
> +	s = this_cpu_read(seed);
> +	s = next_pseudo_random32(s);
> +	this_cpu_write(seed, s);
> +
> +	return s & ((1 << num_bits) - 1);
> +}
> +
>  static void __init cna_init_nodes_per_cpu(unsigned int cpu)
>  {
>  	struct mcs_spinlock *base = per_cpu_ptr(&qnodes[0].mcs, cpu);
> @@ -202,9 +231,11 @@ static inline void cna_pass_lock(struct mcs_spinlock *node,
>  
>  	/*
>  	 * Try to find a successor running on the same NUMA node
> -	 * as the current lock holder.
> +	 * as the current lock holder. For long-term fairness,
> +	 * search for such a thread with high probability rather than always.
>  	 */
> -	new_next = cna_try_find_next(node, next);
> +	if (probably(INTRA_NODE_HANDOFF_PROB_ARG))
> +		new_next = cna_try_find_next(node, next);
>  
>  	if (new_next) {		          /* if such successor is found */
>  		next_holder = new_next;

Because the accounting is done per cpu, not per lock, there is no
guaranteed maximum of times for passing the lock to waiters in the same
node versus other nodes for a given lock. So lock starvation is still
theoretically possible. How about just keeping a count of how many times
a lock is passed to waiters of the same node in the CNA structure? So if
the count reaches a threshold, the lock will be passed to the one in the
secondary queue. 16 bits should be enough for node ID. That will leave
16 bits to store the count without increasing the size of the CNA structure.

Cheers,
Longman
