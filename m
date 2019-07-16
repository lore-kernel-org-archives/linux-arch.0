From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Tue, 16 Jul 2019 17:59:00 +0200
Message-ID: <20190716155900.GS3419@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-5-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190715192536.104548-5-alex.kogan@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 15, 2019 at 03:25:35PM -0400, Alex Kogan wrote:

> @@ -36,6 +37,33 @@ struct cna_node {
>  
>  #define CNA_NODE(ptr) ((struct cna_node *)(ptr))
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
> +#define INTRA_NODE_HANDOFF_PROB_ARG 0x10000
> +
> +/*
> + * Return false with probability 1 / @range.
> + * @range must be a power of 2.
> + */
> +static bool probably(unsigned int range)
> +{
> +	u32 s;
> +
> +	s = this_cpu_read(seed);
> +	s = next_pseudo_random32(s);
> +	this_cpu_write(seed, s);
> +
> +	return s & (range - 1);

This is fragile, better to take a number of bits as argument.

> +}
> +
>  static void cna_init_node(struct mcs_spinlock *node)
>  {
>  	struct cna_node *cn = CNA_NODE(node);
> @@ -140,7 +168,13 @@ static inline void cna_pass_mcs_lock(struct mcs_spinlock *node,
>  	u64 *var = &next->locked;
>  	u64 val = 1;
>  
> -	succ = find_successor(node);
> +	/*
> +	 * Try to pass the lock to a thread running on the same node.
> +	 * For long-term fairness, search for such a thread with high
> +	 * probability rather than always.
> +	 */
> +	if (probably(INTRA_NODE_HANDOFF_PROB_ARG))
> +		succ = find_successor(node);
>  
>  	if (succ) {
>  		var = &succ->mcs.locked;

And this is where that tertiary condition comes from.. I think.
