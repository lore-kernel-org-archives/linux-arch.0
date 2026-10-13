Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9284E324D
	for <linux-arch@vger.kernel.org>; Tue, 13 Oct 2026 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791890807; cv=none; b=K6jD84TEYGlh1HH744V2nyqO4tpqDIPu3R/Jw+KU6r2+0sNAJJChjLquCuk2HsZtVwrarLA/OBeV/PEnoP+LeAE6V/bQVVsUP5M9odAPROOKwAu+/22cay2dwlWTvYK2E23WfyLS1YXOOQlutMrlqbAbvsXrLJ4Yd8VDhGmRK3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791890807; c=relaxed/simple;
	bh=43MfgRVkS8bABD7YWWTEsSbgUzVfokl3iBTVws5w9NQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cPnn1rRRGacNDMaVrB4jn9wqURPqcYHKhIuY2tsfft9hB/CgYf/NsTS8NqBb6sFbo1o6RhsNuBCcoJl9qvhXCk8l7KtwD/QK/VgPBYG+DTdHoPNaHs4bSbTQDbzzmjDsdoD7PVGito3k+PaWTxTMqltCOe57rROFBAiEkkLtftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHUUokQ4; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHUUokQ4"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48b05d75172so1229256f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 13 Oct 2026 04:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791890804; x=1792495604; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E9eNlM0Mc79ItY4RDXm3QhjiEEdEB8QJC9bUPo2+qkA=;
        b=dHUUokQ4uNt0hmmfdqJuEEO/uCEn/VOIAUCWYz5EykWwi//AHO9iq/oLFf4eLHFJZ7
         Cd1x2ZCPw/5hKy6DYlAra/3Pqklv4hciiNQCnTJ8tx1UsxMgCwRsJcC89wnKi8PSXhUC
         5Oa0NlnmgxlpeBb4Kq3aY/2Bz8YimwiDYzanMTpaZVcsYyL2IjVLp7kUDDlpZU/gcG7d
         lMJyvY9+CwTOjx/TmZqre/MRzZnGxc/aAhuJHpO6DG6PzARbk8/I0FHHf5x2qPaoNA+s
         rhvLPkqTl509irJKVOwjhBTCNoWIvhEPq3i9HpniompkbNLaIRfI/wSZi7pKiuJvJKPy
         fPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791890804; x=1792495604;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=E9eNlM0Mc79ItY4RDXm3QhjiEEdEB8QJC9bUPo2+qkA=;
        b=PwI+vvZeNDSKqgaiid0QiO3EPnm5h+jW5GO7gZBUcXh7cassRDnDdwsOCU4kQ7tf7b
         VF/d5Sm1psIMYXteRDrH0lc41ZCByiuCBn+OGSwe5ecJQNWEtLY9KrGbStSUYeeOltpz
         uIzueaeadAJzlpOdrbT+8Bg0ZXI9y0dLeOaowa66zbJ5UWkY4JnilfGfDiwvWv4pukn/
         2XhQS8V2M5S7CKyIOeyznw+UqN42itjOxqkOHbeuUZLOXoYNigIAbKlUaoGEGSY4s7VR
         lgR7zTXGV3K6RrnvpPxAqjNKpAaj2VK7MSB+t318qtZfK7e2jKqo8ow9bsIfaJBomlgO
         oHcA==
X-Forwarded-Encrypted: i=1; AKwUvBzvDZyX8iz7pX6V/iyclwUDMLgP7t7isDT23j0pltkPYJca/YiYYKMgJHxs/2A8CAlvCbJ/MBOd7bzX@vger.kernel.org
X-Gm-Message-State: AFq9FYI4wVP6aG0dOwMBSsN/4xrI7W+mxn7z33xoATjWU5BgLi6F0oUv
	peua3mRLHmWllzijmI1Mt1dYnF2MfWq6+TUB0+b8SSMSmaZSwBH+Umr9
X-Gm-Gg: AYBFou1bloOtbtpQStf4pXfAzLcnc091mYZ2UmF6Ta5PCn0AMBvflvk1SEPe9ZM0F0x
	Z7CpiP17/aT/gxjGbCzVD301rE6zkAw9rQ1WUpSndiu4lE69zjcgxP/TMZGKFuq55sw3AimZhfB
	0Wo6pJcqGwk4x86ESo1lDr9YZLjDNm/19gLB1P73ulcLBfkGWgmdEsk6DasNF899P76TWnwpJQ2
	yJ3M+v5a+H4PLVhM0kKNpGjbj48THkWDUbAsft2A58rnQhhmUywjJS9mVy4LNXWbUW2cWGZeTGE
	G1haSRn3LWDLH6cd3kdIHpLcHxwZakjB5zS/Phcj9nFGl3oHqJVoQEQo8LG1gm54YhzWGslXUny
	+wmvwbAqyJoXocH0jaIbQ9btAdQYF09auTDqxpDk7PqeRAIFJdBm2cHRwBkEoHP6pAQ8aT7S0Ok
	6Ict35L9ngNt1SC2CS41sKwthDmeZpB5/Ov9krpcCq2VsbmeFRQFlJXpX6sCq+d01Wgw==
X-Received: by 2002:a05:6000:4310:b0:48a:f1fb:e165 with SMTP id ffacd0b85a97d-48dbaae39e0mr22461931f8f.21.1791890803352;
        Tue, 13 Oct 2026 04:26:43 -0700 (PDT)
Received: from M2403003457HW ([119.13.72.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaabb8sm5166403f8f.15.2026.10.13.04.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:26:42 -0700 (PDT)
From: Kai Ma <justksqsf@gmail.com>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: paulmck@kernel.org,  corbet@lwn.net,  mingo@redhat.com,
  frederic@kernel.org,  neeraj.upadhyay@kernel.org,  josh@joshtriplett.org,
  urezki@gmail.com,  dave@stgolabs.net,  lianux.mm@gmail.com,
  stern@rowland.harvard.edu,  parri.andrea@gmail.com,  will@kernel.org,
  peterz@infradead.org,  boqun@kernel.org,  npiggin@gmail.com,
  dhowells@redhat.com,  j.alglave@ucl.ac.uk,  luc.maranget@inria.fr,
  akiyks@gmail.com,  dlustig@nvidia.com,  joelagnelf@nvidia.com,
  skhan@linuxfoundation.org,  rdunlap@infradead.org,  longman@redhat.com,
  rostedt@goodmis.org,  mathieu.desnoyers@efficios.com,
  jiangshanlai@gmail.com,  qiang.zhang@linux.dev,  brads@mainlining.org,
  linux-kernel@vger.kernel.org,  linux-arch@vger.kernel.org,
  lkmm@lists.linux.dev,  linux-doc@vger.kernel.org,  rcu@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v3 03/15] hazptr: scan all per-CPU slots before
 overflow lists
In-Reply-To: <20261005171529.1378809-4-kunwu.chan@gmail.com>
References: <20261005171529.1378809-1-kunwu.chan@gmail.com>
	<20261005171529.1378809-4-kunwu.chan@gmail.com>
Date: Tue, 13 Oct 2026 13:26:38 +0200
Message-ID: <875wz57sep.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kunwu Chan <kunwu.chan@gmail.com> writes:

> Boqun Feng pointed out that a promote racing a scan can cause the
> scan to miss a hazard pointer: hazptr_promote_to_backup_slot()
> chains the backup slot into an overflow list before clearing the
> per-CPU slot, so the scan must observe the old location before the
> new one.  The scan currently visits each CPU's overflow lists right
> after that CPU's per-CPU slots, so a promote that moves a hazard
> pointer from a per-CPU slot of a later-scanned CPU into an overflow
> list of an earlier-scanned CPU can be missed.
>
> The direct two-phase scan has a related race because the overflow
> list selection follows the wildcard phase: a promote racing the
> wildcard flip can move a backup slot to the list not covered by the
> second phase.
>
> Fix this by scanning all per-CPU slots before any overflow-list
> slot, in both the shared-scan walk and the direct fallback scan.
> Give the overflow lists a flip phase of their own, independent of
> the wildcard, so each list is scanned while it is the non-live one:
> new backup slots are chained to the other list, preserving forward
> progress.
>
> The same race was also addressed by Mathieu Desnoyers.

Hello,

I tested the previous faulting patch with a standalone reproducer.  It
admits the following interleaving, resulting in Too-short grace period.

Initially, hazptr_wildcard is 1.  Below, p is a pointer to the protected
object, and slot is the reader's per-CPU slot.

Mutator                                Reader
-------                                ------

                                       /* hazptr_acquire() */
                                       void *addr;
                                       WRITE_ONCE(slot->addr,
                                           READ_ONCE(hazptr_wildcard));
                                       ...
                                       addr = READ_ONCE(*addr_p);
                                       /* addr == p */

void *old = p;
smp_store_release(&p, NULL);
hazptr_synchronize(old);
  ...
  scan_wildcard =
      flip_wildcard(hazptr_wildcard);
  /* scan_wildcard == 2 */

  /* First pass: Load B */
  smp_cond_load_acquire(
      &item->slot.addr,
      VAL != addr &&
      VAL != scan_wildcard);
  /* Sees wildcard 1, so proceeds. */

                                       /* Store C */
                                       WRITE_ONCE(slot->addr, addr);

  /* scans list 1. */
  hazptr_synchronize_overflow_list(
      &overflow_list_flip->array[scan_idx],
      addr);
  ...

  WRITE_ONCE(hazptr_wildcard,
             scan_wildcard);
  /* hazptr_wildcard == 2 */

                                       hazptr_detach(&ctx);
                                         ...
                                         /* hazptr_chain_backup_slot() */
                                         unsigned int list_idx =
                                             (unsigned long)
                                             READ_ONCE(hazptr_wildcard) - 1;
                                         /* list_idx == 1 */
                                         ...
                                         /* Protection moves to the
                                          * backup slot in list 1.
                                          * The per-CPU slot is cleared. */

  hazptr_scan_period(
      addr, flip_wildcard(scan_wildcard));
  /* Second pass sees the cleared
   * per-CPU slot and scans list 0,
   * missing the backup slot in list 1. */

  /* Returns while the reader
   * still holds the hazard pointer. */

The critical orderings extracted from this failure are:
1. [Load B] -> [Store C]
2. [WRITE_ONCE(hazptr_wildcard, scan_wildcard)]
     -> [unsigned int list_idx = (unsigned long) READ_ONCE(hazptr_wildcard) - 1]

Kunwu's patch (hazptr: scan all per-CPU slots before overflow lists)
addresses the second ordering.  The overflow-list phase is now flipped
only after both per-CPU scan passes.

I also tested the patched version and it did not reproduce the previous
failure.

> Fixes: 0b8114b25f17 ("hazptr: Implement two-phase wildcard scan")
> Reported-by: Boqun Feng <boqun@kernel.org>
> Link: https://lore.kernel.org/all/20260925195958.4766-1-mathieu.desnoyers@efficios.com/
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> ---
>  kernel/hazptr.c | 88 +++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 64 insertions(+), 24 deletions(-)
>
> diff --git a/kernel/hazptr.c b/kernel/hazptr.c
> index 900ba35de2cb..799784f698ed 100644
> --- a/kernel/hazptr.c
> +++ b/kernel/hazptr.c
> @@ -23,13 +23,20 @@
>   * The current hazard pointer wildcard. Flips between 1UL and 2UL to guarantee
>   * hazptr_synchronize forward progress even with a steady stream of readers.
>   * This wildcard value is used by acquire to temporarily tag the per-CPU slots.
> - * This also affects the overflow list selection: the current list used by
> - * readers is array[(unsigned long) hazptr_wildcard - 1].
>   */
> -static DEFINE_MUTEX(hazptr_wildcard_lock);	/* Protect the wildcard flip. */
> +static DEFINE_MUTEX(hazptr_phase_lock);
> +/* Protect the wildcard and overflow-list phase flips. */
>  void *hazptr_wildcard = (void *) 1UL;
>  EXPORT_SYMBOL_GPL(hazptr_wildcard);
>  
> +/*
> + * The current overflow list phase. Independent from the wildcard so that the
> + * overflow list scan can be placed after the per-CPU slot scan while still
> + * scanning the non-live list: the current list used by readers is
> + * array[hazptr_overflow_list_phase].
> + */
> +static unsigned int hazptr_overflow_list_phase;
> +
>  struct hazptr_overflow_list {
>  	raw_spinlock_t lock;		/* Lock protecting overflow list and list generation. */
>  	struct hlist_head head;		/* Overflow list head. */
> @@ -59,6 +66,12 @@ void *flip_wildcard(void *wildcard)
>  	return ((unsigned long) wildcard == 1UL) ? (void *) 2UL : (void *) 1UL;
>  }
>  
> +static
> +unsigned int flip_list_phase(unsigned int phase)
> +{
> +	return 1 - phase;
> +}
> +
>  static
>  bool is_wildcard(void *addr)
>  {
> @@ -184,15 +197,12 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
>  }
>  
>  static
> -void hazptr_scan_period(void *addr, void *scan_wildcard)
> +void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
>  {
> -	unsigned int scan_idx = (unsigned long) scan_wildcard - 1;
>  	int cpu;
>  
>  	/* Scan all CPUs slots. */
>  	for_each_possible_cpu(cpu) {
> -		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
> -
>  		/*
>  		 * Scan CPU slots.
>  		 * Forward progress against recurring wildcards is guaranteed
> @@ -205,12 +215,22 @@ void hazptr_scan_period(void *addr, void *scan_wildcard)
>  		 * to acquire that same hazard pointer value.
>  		 */
>  		hazptr_synchronize_cpu_slots(cpu, addr, scan_wildcard);
> +	}
> +}
> +
> +static
> +void hazptr_scan_overflow_list_period(void *addr, unsigned int scan_idx)
> +{
> +	int cpu;
> +
> +	/*
> +	 * Scan backup slots in percpu overflow lists.
> +	 * Forward progress is guaranteed by scanning one list
> +	 * while new elements are added into the other list.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
>  
> -		/*
> -		 * Scan backup slots in percpu overflow lists.
> -		 * Forward progress is guaranteed by scanning one list
> -		 * while new elements are added into the other list.
> -		 */
>  		hazptr_synchronize_overflow_list(&overflow_list_flip->array[scan_idx], addr);
>  	}
>  }
> @@ -285,10 +305,13 @@ static struct hazptr_scan_state hazptr_scan;
>   * Walk all slots and return true if @watch is present.  If @bloom
>   * is non-NULL, record observed non-wildcard addresses in it.
>   *
> - * Per-CPU slots are examined before overflow-list slots on each CPU
> - * to preserve the acquisition ordering required by the promote path:
> - * synchronize must observe the per-CPU slot release before the
> - * overflow-list entry can be missed.
> + * All per-CPU slots are examined before any overflow-list slot: a
> + * promote (hazptr_detach() or a context switch) moves a hazard
> + * pointer from a per-CPU slot to an overflow list by chaining the
> + * backup slot before clearing the per-CPU slot, see
> + * hazptr_promote_to_backup_slot().  Therefore the scan must observe
> + * the old location before the new location for every slot/list
> + * pair, including pairs on different CPUs.
>   */
>  static bool hazptr_scan_walk(void *watch, struct hazptr_bloom *bloom)
>  {
> @@ -297,9 +320,9 @@ static bool hazptr_scan_walk(void *watch, struct hazptr_bloom *bloom)
>  	if (bloom)
>  		hazptr_bloom_reset(bloom);
>  
> +	/* Scan all per-CPU slots before any overflow-list slot. */
>  	for_each_possible_cpu(cpu) {
>  		struct hazptr_percpu_slots *percpu_slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
> -		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
>  		unsigned int idx;
>  
>  		for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
> @@ -313,6 +336,10 @@ static bool hazptr_scan_walk(void *watch, struct hazptr_bloom *bloom)
>  			if (bloom && v && !is_wildcard(v))
>  				hazptr_bloom_add(bloom, v);
>  		}
> +	}
> +	for_each_possible_cpu(cpu) {
> +		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
> +
>  		for (int i = 0; i < 2; i++) {
>  			struct hazptr_overflow_list *list = &overflow_list_flip->array[i];
>  			struct hazptr_backup_slot *b;
> @@ -359,14 +386,14 @@ static void hazptr_scan_do_cycle(void)
>  	struct hazptr_waiter *w, *n;
>  	LIST_HEAD(done);
>  
> -	mutex_lock(&hazptr_wildcard_lock);
> +	mutex_lock(&hazptr_phase_lock);
>  
>  	mutex_lock(&hazptr_scan.lock);
>  	list_splice_tail_init(&hazptr_scan.pending, &hazptr_scan.scanning);
>  	mutex_unlock(&hazptr_scan.lock);
>  
>  	if (list_empty(&hazptr_scan.scanning)) {
> -		mutex_unlock(&hazptr_wildcard_lock);
> +		mutex_unlock(&hazptr_phase_lock);
>  		return;
>  	}
>  
> @@ -391,7 +418,7 @@ static void hazptr_scan_do_cycle(void)
>  			list_move(&w->node, &done);
>  	}
>  
> -	mutex_unlock(&hazptr_wildcard_lock);
> +	mutex_unlock(&hazptr_phase_lock);
>  
>  	list_for_each_entry_safe(w, n, &done, node) {
>  		list_del_init(&w->node);
> @@ -463,6 +490,7 @@ static void hazptr_synchronize_queued(void *addr)
>  void hazptr_synchronize(void *addr)
>  {
>  	void *scan_wildcard;
> +	unsigned int scan_list_phase;
>  
>  	/*
>  	 * Busy-wait should only be done from preemptible context.
> @@ -486,18 +514,30 @@ void hazptr_synchronize(void *addr)
>  	}
>  
>  	/* Fallback: use the direct scan path. */
> -	guard(mutex)(&hazptr_wildcard_lock);
> +	guard(mutex)(&hazptr_phase_lock);
>  	scan_wildcard = flip_wildcard(hazptr_wildcard);
> -	hazptr_scan_period(addr, scan_wildcard);
> +	/* Scan per-CPU slots. */
> +	hazptr_scan_cpu_slots_period(addr, scan_wildcard);
>  	WRITE_ONCE(hazptr_wildcard, scan_wildcard);	/* Flip the current wildcard. */
> -	hazptr_scan_period(addr, flip_wildcard(scan_wildcard));
> +	hazptr_scan_cpu_slots_period(addr, flip_wildcard(scan_wildcard));
> +
> +	/*
> +	 * Scan overflow lists *after* scanning all per-CPU slots, see
> +	 * hazptr_promote_to_backup_slot().  Flip the overflow list phase
> +	 * between the two lists so that each list is scanned while it is
> +	 * the non-live one.
> +	 */
> +	scan_list_phase = flip_list_phase(hazptr_overflow_list_phase);
> +	hazptr_scan_overflow_list_period(addr, scan_list_phase);
> +	WRITE_ONCE(hazptr_overflow_list_phase, scan_list_phase);
> +	hazptr_scan_overflow_list_period(addr, flip_list_phase(scan_list_phase));
>  }
>  EXPORT_SYMBOL_GPL(hazptr_synchronize);
>  
>  struct hazptr_slot *hazptr_chain_backup_slot(struct hazptr_ctx *ctx)
>  {
>  	struct hazptr_overflow_list_flip *overflow_list_flip = this_cpu_ptr(&percpu_overflow_list_flip);
> -	unsigned int list_idx = (unsigned long) READ_ONCE(hazptr_wildcard) - 1;
> +	unsigned int list_idx = READ_ONCE(hazptr_overflow_list_phase);
>  	struct hazptr_overflow_list *overflow_list = &overflow_list_flip->array[list_idx];
>  	struct hazptr_slot *slot = &ctx->backup_slot.slot;

-- 
Kai Ma
