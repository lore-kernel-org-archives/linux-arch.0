Return-Path: <SRS0=XOKs=3M=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:34794 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgAWP3y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 10:29:54 -0500
Date: Thu, 23 Jan 2020 16:29:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20200123152918.GD14879@hirez.programming.kicks-ass.net>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200115035920.54451-4-alex.kogan@oracle.com>
 <d751a8ef-aae8-ca70-6a28-79dd8bee2324@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d751a8ef-aae8-ca70-6a28-79dd8bee2324@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com
Message-ID: <20200123152918.xJLugrLfwuja7PT2cqtANSsrWg4HkqGyjbAeaprO1rQ@z>

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
