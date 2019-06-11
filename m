Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:6934 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbfFKEW3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jun 2019 00:22:29 -0400
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
From: "liwei (GF)" <liwei391@huawei.com>
Message-ID: <cc3eee8c-5212-7af5-c932-897ab8f3f8bf@huawei.com>
Date: Tue, 11 Jun 2019 12:22:05 +0800
MIME-Version: 1.0
In-Reply-To: <20190329152006.110370-4-alex.kogan@oracle.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Cc: dave.dice@oracle.com, rahul.x.yadav@oracle.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com
Message-ID: <20190611042205.G8VOD93EWQ2VVRrOU6rUg1M3TxPganL49HQQ2T88fVk@z>

Hi Alex,

On 2019/3/29 23:20, Alex Kogan wrote:
> In CNA, spinning threads are organized in two queues, a main queue for
> threads running on the same node as the current lock holder, and a
> secondary queue for threads running on other nodes. At the unlock time,
> the lock holder scans the main queue looking for a thread running on
> the same node. If found (call it thread T), all threads in the main queue
> between the current lock holder and T are moved to the end of the
> secondary queue, and the lock is passed to T. If such T is not found, the
> lock is passed to the first node in the secondary queue. Finally, if the
> secondary queue is empty, the lock is passed to the next thread in the
> main queue. For more details, see https://arxiv.org/abs/1810.05600.
> 
> Note that this variant of CNA may introduce starvation by continuously
> passing the lock to threads running on the same node. This issue
> will be addressed later in the series.
> 
> Enabling CNA is controlled via a new configuration option
> (NUMA_AWARE_SPINLOCKS), which is enabled by default if NUMA is enabled.
> 
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  arch/x86/Kconfig                      |  14 +++
>  include/asm-generic/qspinlock_types.h |  13 +++
>  kernel/locking/mcs_spinlock.h         |  10 ++
>  kernel/locking/qspinlock.c            |  29 +++++-
>  kernel/locking/qspinlock_cna.h        | 173 ++++++++++++++++++++++++++++++++++
>  5 files changed, 236 insertions(+), 3 deletions(-)
>  create mode 100644 kernel/locking/qspinlock_cna.h
> 
(SNIP)
> +
> +static __always_inline int get_node_index(struct mcs_spinlock *node)
> +{
> +	return decode_count(node->node_and_count++);
When nesting level is > 4, it won't return a index >= 4 here and the numa node number
is changed by mistake. It will go into a wrong way instead of the following branch.


	/*
	 * 4 nodes are allocated based on the assumption that there will
	 * not be nested NMIs taking spinlocks. That may not be true in
	 * some architectures even though the chance of needing more than
	 * 4 nodes will still be extremely unlikely. When that happens,
	 * we fall back to spinning on the lock directly without using
	 * any MCS node. This is not the most elegant solution, but is
	 * simple enough.
	 */
	if (unlikely(idx >= MAX_NODES)) {
		while (!queued_spin_trylock(lock))
			cpu_relax();
		goto release;
	}

> +}
> +
> +static __always_inline void release_mcs_node(struct mcs_spinlock *node)
> +{
> +	__this_cpu_dec(node->node_and_count);
> +}
> +
> +static __always_inline void cna_init_node(struct mcs_spinlock *node, int cpuid,
> +					  u32 tail)
> +{

Thanks,
Wei
