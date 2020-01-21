From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Tue, 21 Jan 2020 14:29:49 +0100
Message-ID: <20200121132949.GL14914@hirez.programming.kicks-ass.net>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191230194042.67789-5-alex.kogan@oracle.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux-arch@vger.kernel.org, guohanjun@huawei.com, arnd@arndb.de, dave.dice@oracle.com, jglauber@marvell.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, steven.sistare@oracle.com, linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, longman@redhat.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 30, 2019 at 02:40:41PM -0500, Alex Kogan wrote:

> +/*
> + * Controls the threshold for the number of intra-node lock hand-offs before
> + * the NUMA-aware variant of spinlock is forced to be passed to a thread on
> + * another NUMA node. By default, the chosen value provides reasonable
> + * long-term fairness without sacrificing performance compared to a lock
> + * that does not have any fairness guarantees. The default setting can
> + * be changed with the "numa_spinlock_threshold" boot option.
> + */
> +int intra_node_handoff_threshold __ro_after_init = 1 << 16;

There is a distinct lack of quantitative data to back up that
'reasonable' claim there.

Where is the table of inter-node latencies observed for the various
values tested, and on what criteria is this number deemed reasonable?

To me, 64k lock hold times seems like a giant number, entirely outside
of reasonable.

> +
>  static void __init cna_init_nodes_per_cpu(unsigned int cpu)
>  {
>  	struct mcs_spinlock *base = per_cpu_ptr(&qnodes[0].mcs, cpu);
> @@ -97,6 +109,11 @@ static int __init cna_init_nodes(void)
>  }
>  early_initcall(cna_init_nodes);
>  
> +static __always_inline void cna_init_node(struct mcs_spinlock *node)
> +{
> +	((struct cna_node *)node)->intra_count = 0;
> +}
> +
>  /* this function is called only when the primary queue is empty */
>  static inline bool cna_try_change_tail(struct qspinlock *lock, u32 val,
>  				       struct mcs_spinlock *node)
> @@ -233,7 +250,9 @@ __always_inline u32 cna_pre_scan(struct qspinlock *lock,
>  {
>  	struct cna_node *cn = (struct cna_node *)node;
>  
> -	cn->pre_scan_result = cna_scan_main_queue(node, node);
> +	cn->pre_scan_result =
> +		cn->intra_count == intra_node_handoff_threshold ?
> +			FLUSH_SECONDARY_QUEUE : cna_scan_main_queue(node, node);

Because:

	if (cn->intra_count < intra_node_handoff_threshold)
		cn->pre_scan_result = cna_scan_main_queue(node, node);
	else
		cn->pre_scan_result = FLUSH_SECONDARY_QUEUE;

was too readable?
