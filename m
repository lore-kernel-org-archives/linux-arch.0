From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v9 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Thu, 23 Jan 2020 09:15:55 -0500
Message-ID: <d751a8ef-aae8-ca70-6a28-79dd8bee2324@redhat.com>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200115035920.54451-4-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28007 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726780AbgAWOQG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 09:16:06 -0500
In-Reply-To: <20200115035920.54451-4-alex.kogan@oracle.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com

On 1/14/20 10:59 PM, Alex Kogan wrote:
> +static int __init cna_init_nodes(void)
> +{
> +	unsigned int cpu;
> +
> +	/*
> +	 * this will break on 32bit architectures, so we restrict
> +	 * the use of CNA to 64bit only (see arch/x86/Kconfig)
> +	 */
> +	BUILD_BUG_ON(sizeof(struct cna_node) > sizeof(struct qnode));
> +	/* we store an ecoded tail word in the node's @locked field */
> +	BUILD_BUG_ON(sizeof(u32) > sizeof(unsigned int));
> +
> +	for_each_possible_cpu(cpu)
> +		cna_init_nodes_per_cpu(cpu);
> +
> +	return 0;
> +}
> +early_initcall(cna_init_nodes);
> +

I just realized that you shouldn't call cna_init_nodes as an
early_initcall. Instead,

> +/*
> + * Switch to the NUMA-friendly slow path for spinlocks when we have
> + * multiple NUMA nodes in native environment, unless the user has
> + * overridden this default behavior by setting the numa_spinlock flag.
> + */
> +void __init cna_configure_spin_lock_slowpath(void)
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

call it when it is sure that CNA spinlock is going to be used. At this
point, the system is still in UP mode and the slowpath will not be called.

Cheers,
Longman
