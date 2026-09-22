Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987BC4F93CB
	for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2026 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061019; cv=none; b=XuoProCd6PZQZf4rwggb3OrgjAtyBz0wQjPx3Ysj85XiKkdbc0QEHSkDdFPA8ejSvRsa9cn7zUe7W6wegaOxNi4PQykd9YldwqNC5SKywVH6m8Hd1g7VhmHeJhinXiRzLBJkhCkh3tXwHSGRNaCZounZSOCeVjhgBhI0Ep5PwfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061019; c=relaxed/simple;
	bh=72LNOQJjrtL3qWz6jvLkQ4Fallgw3xB29OlIJrXyRUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPH1v4u/ZxXUktdIoUbsCUs5/XZrLzqsoVWBgPkdDbu2MWTPByIvJVURP+F4yfzuVwKNKncD2+/RoD3mpeaUg4GCkAjpY1InGvzxXR0A5dLs1Pv4xv4cAnlRL24Ys16ufowsrw6wc5RBsY4NiWAzWpoMOybKOvHa9rbyuxXzew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfbmh/8b; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfbmh/8b"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398beb616f5so1607117a91.1
        for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2026 00:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790061017; x=1790665817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zci1WHdZ5lBidKxN/C/mCTiN5fZd/8DPxW3bn9MBBYQ=;
        b=rfbmh/8brNWO8si/SpVurmORLwjgrRwxYSeeShImvTFn2mP8VTCSfZbttojnSDTjR6
         sMAGLDJ1Gu6jRJsD/aef2nUOZFdhn2e7OzV1TVg0RDUJGWz/jT/5H4ZbowSOqaZjeQC0
         PFzAut1vTOdjScf8xdbpn1894TyQZvXGTKjaaWqd6OkpDz3fN891Q1C7i14AuAajcWAz
         WsoLaDB6P3qbmmLpqXQbFafIOFWVRjP5iiQ4YjBmku628VOJe5G477dX4QTA783n0SdO
         HwWqr/0vYQV4WvZuJ6kPEM2V3XF0RLrRZoVUm9Y3Ow4lKlhpWn9MMPaAhLN95wr/ZHoz
         noOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061017; x=1790665817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zci1WHdZ5lBidKxN/C/mCTiN5fZd/8DPxW3bn9MBBYQ=;
        b=dHnkYqNaCLVhLnHL11GQbLwyfQDrVgk7nrZSaeizwjQCgumTxHa3GC/b1xB1NCFFq0
         ClfMdp0Oak5TGW0zqpFxFk125okJvjFQsh/fHiK7kFuUDD0YbLXIGQc1hKALeHLWMUNW
         l5I9VIfMfTVJqnE4jmywba9pzAR0SyzM8f2cpi3By/bjXiw4fB5vC/I9/WKr5dbEEs1H
         sru0R2nngZs8xEExplFyJICqWwp9dxgPiIafa9H930iQtBNvbNOs+YDNSdvHrYMUv1dj
         5lekPG/ul8CIG73S3r3k8ydDsUkzn2NyYkvwhVkKJ6+mTjYbuaMqMA5tmIE7OeLAg1qd
         nBfg==
X-Forwarded-Encrypted: i=1; AKwUvBxzemCGfxk9VkJhUspMcBLiJG6Tvvrbl5LBa5YXoVMFWecb8d5auR4MOPsDfCSwXuwl74wDdqgDMfGe@vger.kernel.org
X-Gm-Message-State: AFuF++kFcMFr7/YaZDdGvr435/ah8d4X4sxGN66kmvDYliN+SZzRaP0k
	0EO0KeMCKf/fJEDMSvsKCbNqieAiT0rKS6FYlcT0RMCkfSc07VelOrbF
X-Gm-Gg: AYBFou1WJcB4rxdy8iGfVToXWW8NerqHH5tzaPaxDVK64liv3ikBO8M7TJE2+gJ2lJg
	WiG4+sUGTzMjopYNB81tJAFQjUgQYksqYUSE9XbepdHsF0opQmLjPz2RETQAzDzvw9xADwplJXI
	jmK9cB+uZmZn27fhPkQfAnl8hJwS7SHBpN51QtqlQXj+aKXoHNRQdFTi24aN1Dmv1NJdcLeuQuQ
	WrXfrjOw9PiJHhHA4P3u4nFNKKTHreljWpUl6FKFMAlm+qdmpMez/yCtJnXJ31VVjiYX36O/le0
	2XhSIwLo2EgOAN2qHc3TcKy6C5kZroNkAmwvech9NB7sG902yqQtani0/bSYXwrsLEb98EhDDNo
	zJaX8S7uGM+dQgHQqotk8Hth2WtQmnNu+WjPVSalhq92pFGJ54avSq1aJvtj6lNPjiou2d2rpGs
	DHHXEFBUwX+rkVn0i4SHRzhWQXtn8u8UvDRwixyYrcSwr0NX9Yh5KFN+0lXCcPsYAC4H/q+rzPy
	BYQPBwHL8WzCFVM4g==
X-Received: by 2002:a17:90b:1d46:b0:3a0:2900:f55e with SMTP id 98e67ed59e1d1-3a0736a923dmr127880a91.29.1790061016560;
        Tue, 22 Sep 2026 00:10:16 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a067409854sm3079414a91.7.2026.09.22.00.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:10:16 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun@kernel.org,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	paulmck@kernel.org,
	corbet@lwn.net,
	mingo@redhat.com,
	dave@stgolabs.net,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	urezki@gmail.com
Cc: akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	include@grrlz.net,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	lianux.mm@gmail.com
Subject: [RFC/WIP PATCH 1/4] hazptr: add shared-scan kthread
Date: Tue, 22 Sep 2026 15:09:47 +0800
Message-ID: <20260922070950.4173245-2-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922070950.4173245-1-kunwu.chan@gmail.com>
References: <20260922070950.4173245-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Batch concurrent hazptr_synchronize() callers into a shared scan
cycle, avoiding redundant scans of the per-CPU slots.

Queue waiters to a kthread and let each scan cycle make one pass
over all CPUs.  Each waiter tracks per-CPU progress for both
wildcard generations, allowing multiple waiters to share the same
scan.

Flip the wildcard before scanning.  New acquires then use the new
generation, so the old-generation mask makes forward progress even
under a steady stream of readers.  Waiters that remain blocked are
retried after a short delay.

Fall back to the existing direct two-phase scan if the scan kthread
is unavailable or waiter state cannot be allocated.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/hazptr.c | 274 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 274 insertions(+)

diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index d3d1050d92cf..ce553a61b119 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -12,6 +12,10 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/export.h>
+#include <linux/completion.h>
+#include <linux/kthread.h>
+#include <linux/slab.h>
+#include <linux/swait.h>
 
 /*
  * The current hazard pointer wildcard. Flips between 1UL and 2UL to guarantee
@@ -209,12 +213,251 @@ void hazptr_scan_period(void *addr, void *scan_wildcard)
 	}
 }
 
+/*
+ * Batch hazptr_synchronize() callers through a shared scan kthread.
+ */
+
+struct hazptr_waiter {
+	struct list_head node;
+	void *addr;
+	struct completion done;
+	/*
+	 * Per-wildcard-generation progress masks.  A CPU bit is
+	 * cleared when the scan observes neither @addr nor that
+	 * generation's wildcard on the CPU.
+	 */
+	unsigned long *cpu_mask;	/* 2 * BITS_TO_LONGS(nr_cpu_ids) */
+};
+
+/* Return waiter @w's progress mask for wildcard generation @gen. */
+static unsigned long *hazptr_waiter_mask(struct hazptr_waiter *w, int gen)
+{
+	return w->cpu_mask + gen * BITS_TO_LONGS(nr_cpu_ids);
+}
+
+struct hazptr_scan_state {
+	struct task_struct *kthread;
+	struct swait_queue_head wq;
+	bool wakeup;
+	struct mutex lock;
+	struct list_head pending;
+	struct list_head scanning;	/* kthread only */
+};
+static struct hazptr_scan_state hazptr_scan;
+
+/*
+ * Check a CPU's overflow lists.  A backup slot can hold a wildcard
+ * because __hazptr_acquire() writes the wildcard to any slot,
+ * including backup slots from hazptr_chain_backup_slot().
+ *
+ * @addr:     address the waiter is waiting on
+ * @old_wc:   wildcard value of the pre-flip generation
+ * @new_wc:   wildcard value of the post-flip generation
+ * @has_old:  set if any overflow slot holds @old_wc
+ * @has_new:  set if any overflow slot holds @new_wc
+ *
+ * Returns true if @addr is present.
+ */
+static bool hazptr_ovf_list_blocked(int cpu, void *addr,
+				    void *old_wc, void *new_wc,
+				    bool *has_old, bool *has_new)
+{
+	struct hazptr_overflow_list_flip *ovf = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
+	bool found_addr = false;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		struct hazptr_overflow_list *list = &ovf->array[i];
+		struct hazptr_backup_slot *b;
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&list->lock, flags);
+		hlist_for_each_entry(b, &list->head, overflow_node) {
+			/* Pairs with smp_store_release in hazptr_release(). */
+			void *val = smp_load_acquire(&b->slot.addr);
+
+			if (val == addr)
+				found_addr = true;
+			else if (val == old_wc)
+				*has_old = true;
+			else if (val == new_wc)
+				*has_new = true;
+		}
+		raw_spin_unlock_irqrestore(&list->lock, flags);
+	}
+	return found_addr;
+}
+
+/*
+ * Move pending waiters to ->scanning, flip the wildcard, then make
+ * one pass over all CPUs.  Clear per-waiter bits for CPUs that no
+ * longer hold the waiter address or the corresponding wildcard.
+ *
+ * After the flip, new acquires use the new wildcard.  The old
+ * generation therefore makes forward progress and is fully cleared
+ * after enough scan cycles.
+ */
+static void hazptr_scan_do_cycle(void)
+{
+	void *old_wc, *new_wc;
+	unsigned int old_idx, new_idx;
+	int cpu;
+	struct hazptr_waiter *w, *n;
+	LIST_HEAD(done);
+
+	mutex_lock(&hazptr_wildcard_lock);
+
+	mutex_lock(&hazptr_scan.lock);
+	list_splice_tail_init(&hazptr_scan.pending, &hazptr_scan.scanning);
+	mutex_unlock(&hazptr_scan.lock);
+
+	if (list_empty(&hazptr_scan.scanning)) {
+		mutex_unlock(&hazptr_wildcard_lock);
+		return;
+	}
+
+	old_wc = READ_ONCE(hazptr_wildcard);
+	new_wc = flip_wildcard(old_wc);
+	WRITE_ONCE(hazptr_wildcard, new_wc);
+	old_idx = (unsigned long)old_wc - 1;
+	new_idx = 1 - old_idx;
+
+	/*
+	 * One pass over all CPUs for the per-CPU slots, checking
+	 * overflow lists for the remaining waiters.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct hazptr_percpu_slots *slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
+		void *vals[NR_HAZPTR_PERCPU_SLOTS];
+		bool has_old = false, has_new = false;
+		unsigned int idx;
+
+		for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
+			/* Pairs with smp_store_release in hazptr_release(). */
+			vals[idx] = smp_load_acquire(&slots->items[idx].slot.addr);
+			if (vals[idx] == old_wc)
+				has_old = true;
+			else if (vals[idx] == new_wc)
+				has_new = true;
+		}
+
+		list_for_each_entry(w, &hazptr_scan.scanning, node) {
+			bool has_addr = false;
+
+			if (!test_bit(cpu, hazptr_waiter_mask(w, old_idx)) &&
+			    !test_bit(cpu, hazptr_waiter_mask(w, new_idx)))
+				continue;	/* Both bits already clear. */
+			for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
+				if (vals[idx] == w->addr) {
+					has_addr = true;
+					break;
+				}
+			}
+			if (!has_addr)
+				has_addr = hazptr_ovf_list_blocked(cpu, w->addr,
+					old_wc, new_wc, &has_old, &has_new);
+			if (has_addr)
+				continue;
+			if (!has_old)
+				__clear_bit(cpu, hazptr_waiter_mask(w, old_idx));
+			if (!has_new)
+				__clear_bit(cpu, hazptr_waiter_mask(w, new_idx));
+		}
+	}
+
+	mutex_unlock(&hazptr_wildcard_lock);
+
+	/* Complete waiters whose masks are both empty. */
+	list_for_each_entry_safe(w, n, &hazptr_scan.scanning, node) {
+		if (bitmap_empty(hazptr_waiter_mask(w, 0), nr_cpu_ids) &&
+		    bitmap_empty(hazptr_waiter_mask(w, 1), nr_cpu_ids))
+			list_move(&w->node, &done);
+	}
+
+	list_for_each_entry_safe(w, n, &done, node) {
+		list_del_init(&w->node);
+		complete(&w->done);
+	}
+}
+
+/*
+ * Shared scan kthread for hazptr_synchronize() waiters.
+ */
+static int hazptr_scan_kthread(void *unused)
+{
+	for (;;) {
+		bool idle;
+
+		swait_event_idle_exclusive(hazptr_scan.wq,
+					   READ_ONCE(hazptr_scan.wakeup));
+
+		hazptr_scan_do_cycle();
+
+		mutex_lock(&hazptr_scan.lock);
+		idle = list_empty(&hazptr_scan.pending) &&
+		      list_empty(&hazptr_scan.scanning);
+		if (idle)
+			WRITE_ONCE(hazptr_scan.wakeup, false);
+		mutex_unlock(&hazptr_scan.lock);
+
+		if (idle)
+			continue;
+		/* Waiters still blocked: retry after a polling delay. */
+		schedule_timeout_idle(1);
+	}
+	return 0;
+}
+
+/*
+ * Queue @addr for scan-thread processing, then sleep until the scan
+ * thread observes that @addr is no longer held by any hazard pointer.
+ * Returns false if the waiter masks cannot be allocated, in which
+ * case the caller falls back to the direct scan.
+ */
+static bool hazptr_synchronize_queued(void *addr)
+{
+	struct hazptr_waiter waiter = {
+		.addr = addr,
+	};
+	unsigned long *masks;
+	unsigned int mask_longs = BITS_TO_LONGS(nr_cpu_ids);
+
+	masks = kcalloc(2, mask_longs * sizeof(unsigned long), GFP_KERNEL);
+	if (!masks)
+		return false;
+	bitmap_fill(masks, nr_cpu_ids);
+	bitmap_fill(masks + mask_longs, nr_cpu_ids);
+	waiter.cpu_mask = masks;
+
+	init_completion(&waiter.done);
+	INIT_LIST_HEAD(&waiter.node);
+
+	/* Enqueue and wake the scan kthread. */
+	mutex_lock(&hazptr_scan.lock);
+	list_add_tail(&waiter.node, &hazptr_scan.pending);
+	if (!READ_ONCE(hazptr_scan.wakeup)) {
+		WRITE_ONCE(hazptr_scan.wakeup, true);
+		swake_up_one(&hazptr_scan.wq);
+	}
+	mutex_unlock(&hazptr_scan.lock);
+
+	/* Sleep until the scan thread completes this waiter. */
+	wait_for_completion(&waiter.done);
+	kfree(masks);
+	return true;
+}
+
 /*
  * hazptr_synchronize: Wait until @addr is released from all slots.
  *
  * Wait to observe that each slot contains a value that differs from
  * @addr before returning.
  * Should be called from preemptible context.
+ *
+ * If the scan kthread is running, the caller is queued and the scan
+ * thread performs the work, allowing multiple concurrent callers to
+ * share a single scan cycle.  Otherwise, the existing direct
+ * two-phase scan is used as a fallback.
  */
 void hazptr_synchronize(void *addr)
 {
@@ -235,6 +478,13 @@ void hazptr_synchronize(void *addr)
 	/* Memory ordering: Store A before Load B. */
 	smp_mb();
 
+	/* Use the scan thread if available. */
+	/* Pairs with smp_store_release in hazptr_scan_init(). */
+	if (smp_load_acquire(&hazptr_scan.kthread) &&
+	    hazptr_synchronize_queued(addr))
+		return;
+
+	/* Fallback: direct two-phase wildcard scan. */
 	guard(mutex)(&hazptr_wildcard_lock);
 	scan_wildcard = flip_wildcard(hazptr_wildcard);
 	hazptr_scan_period(addr, scan_wildcard);
@@ -282,3 +532,27 @@ void __init hazptr_init(void)
 		}
 	}
 }
+
+/*
+ * Initialize the scan kthread.  On failure falls back to the direct
+ * scan (busy-wait) path at synchronize time.
+ * core_initcall ensures the scheduler is ready before kthread_run.
+ */
+static int __init hazptr_scan_init(void)
+{
+	struct task_struct *t;
+
+	init_swait_queue_head(&hazptr_scan.wq);
+	mutex_init(&hazptr_scan.lock);
+	INIT_LIST_HEAD(&hazptr_scan.pending);
+	INIT_LIST_HEAD(&hazptr_scan.scanning);
+
+	t = kthread_run(hazptr_scan_kthread, NULL, "hazptr_scan");
+	if (!IS_ERR(t))
+		/* Pairs with smp_load_acquire in hazptr_synchronize(). */
+		smp_store_release(&hazptr_scan.kthread, t);
+	else
+		pr_warn("hazptr: scan thread failed, using direct scan\n");
+	return 0;
+}
+core_initcall(hazptr_scan_init);
-- 
2.43.0

