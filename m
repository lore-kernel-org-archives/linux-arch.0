Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5864241A90B;
	Tue, 22 Sep 2026 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065709; cv=none; b=UqAKWQEvGIUgH6BlyEO/oaS5pQQbpf1bIqChmve68dVSrSn10A/KZIqwj2ucLbq6x+k2jWZ8FevINxioVZqnHnnUmuMnbyxNkW7TqUMoh7E/wypDPHa0AgTO7bCL+fzkMSN7ckmVoUSECmXH4SqYzrz6C6DHhAc9Y+RhXski5YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065709; c=relaxed/simple;
	bh=ESCK5KvZWFJ/oAOUPofQdFgVGnvKhsNdZIR/ndVTtv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0xbnpJ0WdlFHNfMH+yxI2TwPcr8DmxqyJECiM2mo5WalA/QSRWM1yBPmz9iZlymY/r5fjxeOZ1eUB9MAx3tq+ygSwf0VDBpKRE7xVnoW0xkW8WmG8wTLHOZfG3y5222skI/NElTOKhA5s6JG3ginHpJyhavKHRU7yVCj3NbV6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2Q71rue; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2Q71rue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A1E1F000FF;
	Tue, 22 Sep 2026 08:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790065708;
	bh=VkmPg61FiN9Xz1SlzPL2ssBRgPtSlOLIACv5olyx/rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D2Q71rueC45lfwVRazVvwEwobm4xMVKPuzxsn7+Vhc253m2QX8toPDrJONZfMiHXb
	 G+aZ0JQdybtb+cseMjAuiuUfve/nuoJcsTkCB5/1NJcew7jIB5QxehC354V05y3BcY
	 xCYQR5NzVNiLNSQOHiY0eYpzWPE22ImEZlb++XD4WAnE+B611oM4gu8SA+bST4Nhv8
	 cdU3CO0vI/kUtIPjy1Y+K5+4kWAQ8WS/wAo1g19LPuNpLelbH0o9U34bziTlkgw9QS
	 ZbegI8Am35OHyZULFAYUGlFPzoSw0xPe/yG7gNNHNu8eOlUpialv3cvjt03kYgN7dr
	 OmnUD8LflZeqA==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 36B05F40066;
	Tue, 22 Sep 2026 04:28:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 22 Sep 2026 04:28:26 -0400
X-ME-Sender: <xms:KjyyavBAtxx0S7EMYys24_Q27Won9NIjUFATi9IBcQVNDT6jkxvu-w>
    <xme:KjyyaofcK7lRb3h-bnSI-AkDCPpt54UxO3EfHoFCOdfjflaMf1WztQCmeBBKwnOjE
    sBUeLcYGYijdm6t_QBWewUXapdVFFppuOsxEx02PQLG6TKBps818T0>
X-ME-Received: <xmr:Kjyyauz6Q7a-BqUZ_Yh68XFuiM8X5aC109tej4jVPzJzKFlZw_GEi5sMUJ-FItPVdya4qgBmigc478jyeaBZSpIBOLB6xV1nZvt2VPpEYGq5EtptuKWwX16G>
X-ME-Proxy-Cause: dmFkZTGQ4uUrDEXwf3C7PVrBLcIs38XJYKDUf/eHC5CcL7qCyZEQZTQc7EmiwbQXMikcVs
    0kwNj+AkKR2dq3OSokVIGEpJ4cQWFWX7ZAodLUB1MV0dMGmmpZM8OZnuTt5tIgNIPk1olb
    wlqIAtbiox1nfXJbx0VdWD3YTvEeJYlKhUViQzmayt0gpt02inVCzVd/OxL0e+0qmn1aD4
    tEzi2pCI0+jQFy/RZUuQTbzwGZMA0TW5zr6qWiBsecRvd2ErwEuKXG5eSJplxXEBFSI8dC
    AnX10O91yf+TYX3NZmw7JCtF6LA8Rzu71kBGfhrMDSvUqOr5lc1Uq5aXghmuRDL/ASUnDT
    n1yRy60YQQatCcH8t+/oSdigbf7Ka9PC+IVUI1BzjUpOfKEmOI/OZ+2kkkc62iAZel+Nl7
    XjF00zGMLOSFbCV1OcAbRIAY0MFFxcHXyJpzrIFNBGG8T+p+n3nQB1JJ8mQwEzD95i5W0/
    k4s3SN/QCD39/UWTFf3y95ugbZYpiVh5hrzsr7zjDGUo6l4sns9U2CZpxkQxGG+vOix5cB
    BiqNus6cqKQV7xEpGvod/F1fnJilG8vJhFjSUmnE89YNpApysioAOroOBwHFjqjlPVbqiQ
    wAhwxilzpaam5xczZus+p+J9Bcb5H3s5Ed4bUp2z4N5/I+RBrB+3rzhWAZUA
X-ME-Proxy: <xmx:Kjyyau9hoscJV4tazHLYRBbmr21re4iflc--guYkKztmRBLo4dAJvQ>
    <xmx:KjyyagnVYtF1hHs5OGoj_mhHUv9TKPwY60Yilte1WRDN0ZeBUBhbEA>
    <xmx:KjyyaooHhy8ef5Kiw_-MzoGsDbgxOD171yC8x7edn22kp67f6GtHqQ>
    <xmx:Kjyyak965b_vGE7KqCoRHYg0UcB0F6taRQGjzwG7YvO8rQ0sQJhGjg>
    <xmx:KjyyajOD-BQ1OOoOguSiY44EBEn50X86SZLbuFXgaErpTxmcYsczafA9>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 04:28:25 -0400 (EDT)
Date: Tue, 22 Sep 2026 10:28:24 +0200
From: Boqun Feng <boqun@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
	corbet@lwn.net, mingo@redhat.com, dave@stgolabs.net,
	josh@joshtriplett.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, urezki@gmail.com, akiyks@gmail.com,
	dlustig@nvidia.com, joelagnelf@nvidia.com,
	skhan@linuxfoundation.org, rdunlap@infradead.org,
	longman@redhat.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, include@grrlz.net,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, linux-doc@vger.kernel.org,
	rcu@vger.kernel.org, lianux.mm@gmail.com
Subject: Re: [RFC/WIP PATCH 1/4] hazptr: add shared-scan kthread
Message-ID: <arI8KNUjYNFBwKf8@MacBook-0RXW5>
References: <20260922070950.4173245-1-kunwu.chan@gmail.com>
 <20260922070950.4173245-2-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922070950.4173245-2-kunwu.chan@gmail.com>

On Tue, Sep 22, 2026 at 03:09:47PM +0800, Kunwu Chan wrote:
> Batch concurrent hazptr_synchronize() callers into a shared scan
> cycle, avoiding redundant scans of the per-CPU slots.
> 
> Queue waiters to a kthread and let each scan cycle make one pass
> over all CPUs.  Each waiter tracks per-CPU progress for both
> wildcard generations, allowing multiple waiters to share the same
> scan.
> 
> Flip the wildcard before scanning.  New acquires then use the new
> generation, so the old-generation mask makes forward progress even
> under a steady stream of readers.  Waiters that remain blocked are
> retried after a short delay.
> 
> Fall back to the existing direct two-phase scan if the scan kthread
> is unavailable or waiter state cannot be allocated.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> ---
>  kernel/hazptr.c | 274 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 274 insertions(+)
> 
> diff --git a/kernel/hazptr.c b/kernel/hazptr.c
> index d3d1050d92cf..ce553a61b119 100644
> --- a/kernel/hazptr.c
> +++ b/kernel/hazptr.c
> @@ -12,6 +12,10 @@
>  #include <linux/mutex.h>
>  #include <linux/list.h>
>  #include <linux/export.h>
> +#include <linux/completion.h>
> +#include <linux/kthread.h>
> +#include <linux/slab.h>
> +#include <linux/swait.h>
>  
>  /*
>   * The current hazard pointer wildcard. Flips between 1UL and 2UL to guarantee
> @@ -209,12 +213,251 @@ void hazptr_scan_period(void *addr, void *scan_wildcard)
>  	}
>  }
>  
> +/*
> + * Batch hazptr_synchronize() callers through a shared scan kthread.
> + */
> +
> +struct hazptr_waiter {
> +	struct list_head node;
> +	void *addr;
> +	struct completion done;
> +	/*
> +	 * Per-wildcard-generation progress masks.  A CPU bit is
> +	 * cleared when the scan observes neither @addr nor that
> +	 * generation's wildcard on the CPU.
> +	 */
> +	unsigned long *cpu_mask;	/* 2 * BITS_TO_LONGS(nr_cpu_ids) */

This would requires allocation during hazptr_synchronize() and I would
like to avoid that (it's going to introduce a "allocating memory to free
memory" case).

Mathieu brought up a useful data structure for the scan: A Bloom filter:

	https://en.wikipedia.org/wiki/Bloom_filter

, which is basically a bitmap set + k hash functions. Let's say we have
a struct bloom_filter (you can still with a page as the bitmap and k=3)
and put it in hazptr_scan_state. Then the scan would become:

	bloom_filter_clear(); // <- reset the bloom filer.

	for_each_possible_cpu()
          hlist_for_each_entry(b, &list->head, overflow_node) {
	    bloom_filter_set(*b->slot.addr);
	    // ^ add the hazptr_acquire() adress into the bloom filter
	  }
	
	list_for_each_entry(w, &hazptr_scan.scanning, node) {
	  if (!bloom_filter_contains(w->addr)) {
	    list_move(&w->node, &done);
	  }
	}

Of course, there are some additional handling or optimizaiton we can do
with the per-CPU slot and wildcard, but this is the idea. It also makes 
a potential call_hazptr() work.

Willing to give it a try?

Regards,
Boqun

> +};
> +
> +/* Return waiter @w's progress mask for wildcard generation @gen. */
> +static unsigned long *hazptr_waiter_mask(struct hazptr_waiter *w, int gen)
> +{
> +	return w->cpu_mask + gen * BITS_TO_LONGS(nr_cpu_ids);
> +}
> +
> +struct hazptr_scan_state {
> +	struct task_struct *kthread;
> +	struct swait_queue_head wq;
> +	bool wakeup;
> +	struct mutex lock;
> +	struct list_head pending;
> +	struct list_head scanning;	/* kthread only */
> +};
> +static struct hazptr_scan_state hazptr_scan;
> +
> +/*
> + * Check a CPU's overflow lists.  A backup slot can hold a wildcard
> + * because __hazptr_acquire() writes the wildcard to any slot,
> + * including backup slots from hazptr_chain_backup_slot().
> + *
> + * @addr:     address the waiter is waiting on
> + * @old_wc:   wildcard value of the pre-flip generation
> + * @new_wc:   wildcard value of the post-flip generation
> + * @has_old:  set if any overflow slot holds @old_wc
> + * @has_new:  set if any overflow slot holds @new_wc
> + *
> + * Returns true if @addr is present.
> + */
> +static bool hazptr_ovf_list_blocked(int cpu, void *addr,
> +				    void *old_wc, void *new_wc,
> +				    bool *has_old, bool *has_new)
> +{
> +	struct hazptr_overflow_list_flip *ovf = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
> +	bool found_addr = false;
> +	int i;
> +
> +	for (i = 0; i < 2; i++) {
> +		struct hazptr_overflow_list *list = &ovf->array[i];
> +		struct hazptr_backup_slot *b;
> +		unsigned long flags;
> +
> +		raw_spin_lock_irqsave(&list->lock, flags);
> +		hlist_for_each_entry(b, &list->head, overflow_node) {
> +			/* Pairs with smp_store_release in hazptr_release(). */
> +			void *val = smp_load_acquire(&b->slot.addr);
> +
> +			if (val == addr)
> +				found_addr = true;
> +			else if (val == old_wc)
> +				*has_old = true;
> +			else if (val == new_wc)
> +				*has_new = true;
> +		}
> +		raw_spin_unlock_irqrestore(&list->lock, flags);
> +	}
> +	return found_addr;
> +}
> +
> +/*
> + * Move pending waiters to ->scanning, flip the wildcard, then make
> + * one pass over all CPUs.  Clear per-waiter bits for CPUs that no
> + * longer hold the waiter address or the corresponding wildcard.
> + *
> + * After the flip, new acquires use the new wildcard.  The old
> + * generation therefore makes forward progress and is fully cleared
> + * after enough scan cycles.
> + */
> +static void hazptr_scan_do_cycle(void)
> +{
> +	void *old_wc, *new_wc;
> +	unsigned int old_idx, new_idx;
> +	int cpu;
> +	struct hazptr_waiter *w, *n;
> +	LIST_HEAD(done);
> +
> +	mutex_lock(&hazptr_wildcard_lock);
> +
> +	mutex_lock(&hazptr_scan.lock);
> +	list_splice_tail_init(&hazptr_scan.pending, &hazptr_scan.scanning);
> +	mutex_unlock(&hazptr_scan.lock);
> +
> +	if (list_empty(&hazptr_scan.scanning)) {
> +		mutex_unlock(&hazptr_wildcard_lock);
> +		return;
> +	}
> +
> +	old_wc = READ_ONCE(hazptr_wildcard);
> +	new_wc = flip_wildcard(old_wc);
> +	WRITE_ONCE(hazptr_wildcard, new_wc);
> +	old_idx = (unsigned long)old_wc - 1;
> +	new_idx = 1 - old_idx;
> +
> +	/*
> +	 * One pass over all CPUs for the per-CPU slots, checking
> +	 * overflow lists for the remaining waiters.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct hazptr_percpu_slots *slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
> +		void *vals[NR_HAZPTR_PERCPU_SLOTS];
> +		bool has_old = false, has_new = false;
> +		unsigned int idx;
> +
> +		for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
> +			/* Pairs with smp_store_release in hazptr_release(). */
> +			vals[idx] = smp_load_acquire(&slots->items[idx].slot.addr);
> +			if (vals[idx] == old_wc)
> +				has_old = true;
> +			else if (vals[idx] == new_wc)
> +				has_new = true;
> +		}
> +
> +		list_for_each_entry(w, &hazptr_scan.scanning, node) {
> +			bool has_addr = false;
> +
> +			if (!test_bit(cpu, hazptr_waiter_mask(w, old_idx)) &&
> +			    !test_bit(cpu, hazptr_waiter_mask(w, new_idx)))
> +				continue;	/* Both bits already clear. */
> +			for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
> +				if (vals[idx] == w->addr) {
> +					has_addr = true;
> +					break;
> +				}
> +			}
> +			if (!has_addr)
> +				has_addr = hazptr_ovf_list_blocked(cpu, w->addr,
> +					old_wc, new_wc, &has_old, &has_new);
> +			if (has_addr)
> +				continue;
> +			if (!has_old)
> +				__clear_bit(cpu, hazptr_waiter_mask(w, old_idx));
> +			if (!has_new)
> +				__clear_bit(cpu, hazptr_waiter_mask(w, new_idx));
> +		}
> +	}
> +
> +	mutex_unlock(&hazptr_wildcard_lock);
> +
> +	/* Complete waiters whose masks are both empty. */
> +	list_for_each_entry_safe(w, n, &hazptr_scan.scanning, node) {
> +		if (bitmap_empty(hazptr_waiter_mask(w, 0), nr_cpu_ids) &&
> +		    bitmap_empty(hazptr_waiter_mask(w, 1), nr_cpu_ids))
> +			list_move(&w->node, &done);
> +	}
> +
> +	list_for_each_entry_safe(w, n, &done, node) {
> +		list_del_init(&w->node);
> +		complete(&w->done);
> +	}
> +}
> +
> +/*
> + * Shared scan kthread for hazptr_synchronize() waiters.
> + */
> +static int hazptr_scan_kthread(void *unused)
> +{
> +	for (;;) {
> +		bool idle;
> +
> +		swait_event_idle_exclusive(hazptr_scan.wq,
> +					   READ_ONCE(hazptr_scan.wakeup));
> +
> +		hazptr_scan_do_cycle();
> +
> +		mutex_lock(&hazptr_scan.lock);
> +		idle = list_empty(&hazptr_scan.pending) &&
> +		      list_empty(&hazptr_scan.scanning);
> +		if (idle)
> +			WRITE_ONCE(hazptr_scan.wakeup, false);
> +		mutex_unlock(&hazptr_scan.lock);
> +
> +		if (idle)
> +			continue;
> +		/* Waiters still blocked: retry after a polling delay. */
> +		schedule_timeout_idle(1);
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Queue @addr for scan-thread processing, then sleep until the scan
> + * thread observes that @addr is no longer held by any hazard pointer.
> + * Returns false if the waiter masks cannot be allocated, in which
> + * case the caller falls back to the direct scan.
> + */
> +static bool hazptr_synchronize_queued(void *addr)
> +{
> +	struct hazptr_waiter waiter = {
> +		.addr = addr,
> +	};
> +	unsigned long *masks;
> +	unsigned int mask_longs = BITS_TO_LONGS(nr_cpu_ids);
> +
> +	masks = kcalloc(2, mask_longs * sizeof(unsigned long), GFP_KERNEL);
> +	if (!masks)
> +		return false;
> +	bitmap_fill(masks, nr_cpu_ids);
> +	bitmap_fill(masks + mask_longs, nr_cpu_ids);
> +	waiter.cpu_mask = masks;
> +
> +	init_completion(&waiter.done);
> +	INIT_LIST_HEAD(&waiter.node);
> +
> +	/* Enqueue and wake the scan kthread. */
> +	mutex_lock(&hazptr_scan.lock);
> +	list_add_tail(&waiter.node, &hazptr_scan.pending);
> +	if (!READ_ONCE(hazptr_scan.wakeup)) {
> +		WRITE_ONCE(hazptr_scan.wakeup, true);
> +		swake_up_one(&hazptr_scan.wq);
> +	}
> +	mutex_unlock(&hazptr_scan.lock);
> +
> +	/* Sleep until the scan thread completes this waiter. */
> +	wait_for_completion(&waiter.done);
> +	kfree(masks);
> +	return true;
> +}
> +
>  /*
>   * hazptr_synchronize: Wait until @addr is released from all slots.
>   *
>   * Wait to observe that each slot contains a value that differs from
>   * @addr before returning.
>   * Should be called from preemptible context.
> + *
> + * If the scan kthread is running, the caller is queued and the scan
> + * thread performs the work, allowing multiple concurrent callers to
> + * share a single scan cycle.  Otherwise, the existing direct
> + * two-phase scan is used as a fallback.
>   */
>  void hazptr_synchronize(void *addr)
>  {
> @@ -235,6 +478,13 @@ void hazptr_synchronize(void *addr)
>  	/* Memory ordering: Store A before Load B. */
>  	smp_mb();
>  
> +	/* Use the scan thread if available. */
> +	/* Pairs with smp_store_release in hazptr_scan_init(). */
> +	if (smp_load_acquire(&hazptr_scan.kthread) &&
> +	    hazptr_synchronize_queued(addr))
> +		return;
> +
> +	/* Fallback: direct two-phase wildcard scan. */
>  	guard(mutex)(&hazptr_wildcard_lock);
>  	scan_wildcard = flip_wildcard(hazptr_wildcard);
>  	hazptr_scan_period(addr, scan_wildcard);
> @@ -282,3 +532,27 @@ void __init hazptr_init(void)
>  		}
>  	}
>  }
> +
> +/*
> + * Initialize the scan kthread.  On failure falls back to the direct
> + * scan (busy-wait) path at synchronize time.
> + * core_initcall ensures the scheduler is ready before kthread_run.
> + */
> +static int __init hazptr_scan_init(void)
> +{
> +	struct task_struct *t;
> +
> +	init_swait_queue_head(&hazptr_scan.wq);
> +	mutex_init(&hazptr_scan.lock);
> +	INIT_LIST_HEAD(&hazptr_scan.pending);
> +	INIT_LIST_HEAD(&hazptr_scan.scanning);
> +
> +	t = kthread_run(hazptr_scan_kthread, NULL, "hazptr_scan");
> +	if (!IS_ERR(t))
> +		/* Pairs with smp_load_acquire in hazptr_synchronize(). */
> +		smp_store_release(&hazptr_scan.kthread, t);
> +	else
> +		pr_warn("hazptr: scan thread failed, using direct scan\n");
> +	return 0;
> +}
> +core_initcall(hazptr_scan_init);
> -- 
> 2.43.0
> 
