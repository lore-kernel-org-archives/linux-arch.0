From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Thu, 23 Jan 2020 16:29:18 +0100
Message-ID: <20200123152918.GD14879@hirez.programming.kicks-ass.net>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200115035920.54451-4-alex.kogan@oracle.com>
 <d751a8ef-aae8-ca70-6a28-79dd8bee2324@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <d751a8ef-aae8-ca70-6a28-79dd8bee2324@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org, guohanjun@huawei.com, arnd@arndb.de, dave.dice@oracle.com, jglauber@marvell.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, Alex Kogan <alex.kogan@oracle.com>, steven.sistare@oracle.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 23, 2020 at 09:15:55AM -0500, Waiman Long wrote:
> On 1/14/20 10:59 PM, Alex Kogan wrote:
> > +static int __init cna_init_nodes(void)
> > +{
> > +	unsigned int cpu;
> > +
> > +	/*
> > +	 * this will break on 32bit architectures, so we restrict
> > +	 * the use of CNA to 64bit only (see arch/x86/Kconfig)
> > +	 */
> > +	BUILD_BUG_ON(sizeof(struct cna_node) > sizeof(struct qnode));
> > +	/* we store an ecoded tail word in the node's @locked field */
> > +	BUILD_BUG_ON(sizeof(u32) > sizeof(unsigned int));
> > +
> > +	for_each_possible_cpu(cpu)
> > +		cna_init_nodes_per_cpu(cpu);
> > +
> > +	return 0;
> > +}
> > +early_initcall(cna_init_nodes);
> > +
> 
> I just realized that you shouldn't call cna_init_nodes as an
> early_initcall. Instead,
> 
> > +/*
> > + * Switch to the NUMA-friendly slow path for spinlocks when we have
> > + * multiple NUMA nodes in native environment, unless the user has
> > + * overridden this default behavior by setting the numa_spinlock flag.
> > + */
> > +void __init cna_configure_spin_lock_slowpath(void)
> > +{
> > +	if ((numa_spinlock_flag == 1) ||
> > +	    (numa_spinlock_flag == 0 && nr_node_ids > 1 &&
> > +		    pv_ops.lock.queued_spin_lock_slowpath ==
> > +			native_queued_spin_lock_slowpath)) {
> > +		pv_ops.lock.queued_spin_lock_slowpath =
> > +		    __cna_queued_spin_lock_slowpath;
> > +
> > +		pr_info("Enabling CNA spinlock\n");
> > +	}
> > +}
> 
> call it when it is sure that CNA spinlock is going to be used. At this
> point, the system is still in UP mode and the slowpath will not be called.

Indeed, let me go fix that!
