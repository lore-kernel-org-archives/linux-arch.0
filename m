Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811460;
	b=vU9W1ll3RYGDCdx8GdpW6ZruCv1sM+DcHvkx5uAKfZeqVdSvJFPbS+0BEib3fSbS7rpm
	 MVq0m1Jm18w2LQ+h+2zOmhRevVfdR4vPuK8RAgHIM6LvEkci2PB0zmYvkL13Buu4NWXqe
	 kD7rF/J2ZK9ksDFf9yVEwnP8Bhd/CEb1ehyYz8sC12NxKlu6r5kuZVGZX/QxluSHIdOBW
	 b5jygd32bev8YjSaPFsRfRMD1FGEi31ZKX6nkkM+UCFHuh5o/E2rnMvSs6RAuJGkN4E0D
	 ugYuRMmM89ayez0As/AueBEU6/ByQ5s0KaI3biWSNmWBmsdFUBPejeJoVfi8BVXDC+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SOeq7G4y4ma0p9IJnHs+BlzRjxe0BhRxp82Dix1vOx8=;
	b=jSKijTMunpOs3s5UVQWVgN/zG0y+Nda6M2lhGN79bjh3dx4t8uOY0zCmycekkqnYcDaZ
	 dvk1XUuSLPsb7+EpLusfwLiCz+OuqArD4hiBsmHsjB/hKAfCoQlBFq7CNb9L26zjHpW6i
	 yP/FTLicxohKUZysduHH10NV/Y/f6hVLDnF0KSFIo4cgF7ciCah3zgQHEaP9sTfB/cT6X
	 sYG3ByKvfxUm/3PwId5L+6zl/aav0atac2IWus9evR+TaIIn3LSIyiNw/chkxcEbsNqFZ
	 U7oxqn7/429P78t47MWYrAcG3wX8pc89hoztqlbwfBXOQvNV6eorGnr7Afz7Ec+ZUJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eNGdeOdJ;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA4606A337
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ABA4606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eNGdeOdJ
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35b2c599f43so1899531eec.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811459; x=1794416259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SOeq7G4y4ma0p9IJnHs+BlzRjxe0BhRxp82Dix1vOx8=;
        b=eNGdeOdJpnu18FUYHbtEYd9XslXM7vnKZ3T9KRrZq+Y7UtGL/Hrp9HVryybuKTdD8d
         TGVTOmgwZwFkpLknmlNOYkP7mP6W+8tmajSQHLUXVbCsaOsjAwQofVaJiSwQiQxUiSkb
         y9xqT4w4oN5Owdx+qyKDJxT9C9kJUEPSKBmt0GiN9BTP1Z8ezvlF/b04RtiuboJ64I+I
         uTLZBwueAMnwJcExIi28F3kOQmAxbjSbn3xJh27uV4/3Um9o/c6k3kc26GkkIxTXtl5T
         4ME6hkttpWSuPsKY9+uAszQkFOs6/PrYvSfXmZPJfkE6U1thqDGsfMEF+BnVXYvPXBz8
         qawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811459; x=1794416259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SOeq7G4y4ma0p9IJnHs+BlzRjxe0BhRxp82Dix1vOx8=;
        b=ohGrRUvRN2sErYEXED20BF10SUT7S6K2S4tIAPuupj18du11LEQ+vFleCqlTSeEiSg
         fH0LpZ7N07cf1EPhkBTuqNQW1/1GK3g3cMZMSLjp25Xi5TZuFrMeIotT0PrmvtjEpSax
         16vD2/E5mZvhrys2T4zIeTsOw0X1SforLCnHPaPbOoD5VqLAFBdm6/vmehxQwt86D+Vh
         TOo4xIsCfsROaVZNmTsbr85u7TvUQ7K6yzBt0DrWw2UQ4/YjYgmp3GMM3Gd3CQkBd607
         bwoIZwJ8cGfQsLD9E0g4aMhq3U7lwF0acqPZNHKzpjOKuXL9+kXmmeHo8XUYriALpqT0
         rwSA==
X-Forwarded-Encrypted: i=1; AKwUvBzOmdawksaAa+xW7w4/C8J2DwsQ4YGQYcX6jPB2gNoztPVbf7/qTv3swFKyP9F5+V//zqjIHm4pYN/j@vger.kernel.org
X-Gm-Message-State: APuU4Z9hXxWzYejsQ+zDdljDop9XnxBWYlEu7A2V+4ODOiehjGvkmj+J
	KTqBBSQ6eqRaPsltcx6Y7h2L7jhDuPcFcHXwoRpUomKQgOErMNjMgmpt
X-Gm-Gg: AYBFou0ghRtw0LkhkFqz34RcybRi2W1b4oxuq8IixordIgNPZp7NfmwsSpfSmpvSmfk
	a06aEhutRXVYtyafgTkWdMlmY2JfwkXwTsCUjh5pbc3J6pH6mjKatyTGFd+04e6VGrarV4AFsfE
	ASlQOakZ5Mh94HSoD0YOUH3glo5Ys42a1NATyCqP1kq8D33tdapCjcuk1tSYmZ/vejeDte+Dt9j
	8yL8KAN9pG15cyVRL2KRn5/4beWc7OUzfRrdbveT2ilcm9EEaqLf7K1Ojdtj2aXo9o8hSvnPjuW
	dd79lMj/hmBaswbQsxPGL8R9huR5g/yDQ+x2nw5pey4JpKf/rZIymVYLAmfx63BkVJFlTRI4BC1
	G/LRDRuMMuq59IwU2VfwmwF6vKK67qm7O/OiSAJer1JT75R5iDvsIUvrdAhcdE7GHpFua2NOjEv
	wFDohOY7JEZpqZocTEvHCAB6BG/zhRf30hoBz6ckpYZ+347nfyMGHFgdxZ2tqaHU6sm66geULQL
	xUwbXNYQeW67y4+RJR3hck+MSvhQO6Z7Y3meBkfvi3pgF5N4pbQjXNxo2zm+ukncpuOJJYu5Nvt
	nlAFSB82PcK1K38BCBywo7kczEgwiCLvKUQxTFxz
X-Received: by 2002:a05:693c:6092:b0:369:1084:8ee3 with SMTP id 5a478bee46e88-36a423e52c8mr29328732eec.23.1793811457983;
        Wed, 04 Nov 2026 08:57:37 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:57:36 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	boqun@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 15/28] hazptr: Add reader-assisted drain for stalled waiters
Date: Thu,  5 Nov 2026 00:54:33 +0800
Message-ID: <20261104165504.2430480-16-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104165504.2430480-1-kunwu.chan@gmail.com>
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a waiter remains blocked on a sticky address for 100+ scan
cycles, engage a drain: snapshot which per-CPU and overflow-list
slots hold the address, then wait for those holders to release.

Per-CPU slots are tracked via a bitmap mapping (cpu, idx) to the
stable per-CPU slot_item.  Overflow-list slots (struct
hazptr_backup_slot) lack stable identity, so each one is marked
with the current drain generation (drain_gen) at engage; the
reader cooperates on release by checking its own slot's drain_gen,
clearing it, and decrementing backup_outstanding.

The unchain path and the engage both hold the overflow-list lock
during their marker operations, serializing the reader's marker
consumption with the engage's marker writes and preventing the
stranded-marker race.

A cmpxchg() ensures only one of the release hook, the resnapshot
recovery path, or the unchain path consumes each marker.

The outstanding count is maintained incrementally (atomic_inc
during the engage walk, atomic_dec on consumption) so a
concurrent unchain cannot be overwritten by a final atomic_set.

A fairness cap (HAZPTR_DRAIN_MAX_CYCLES) bounds consecutive drain
cycles for a single address: on expiry the drain disengages and
the waiter's re-engage counter resets.

Each disengage logs its reason (complete, fairness-cap, or
orphaned) for test observability.

Wildcards never appear in per-CPU slots: the try_acquire fast
path publishes the actual address directly; only the slow path's
backup slot goes through a wildcard transient.

Suggested-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/linux/hazptr.h                        |  17 +
 kernel/hazptr.c                               | 468 +++++++++++++++++-
 kernel/rcu/Kconfig.debug                      |  12 +
 .../selftests/rcutorture/bin/hazptr.sh        |  22 +-
 4 files changed, 513 insertions(+), 6 deletions(-)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index ebf804315a26..018e9309e3ea 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -39,12 +39,22 @@ struct hazptr_slot {
 };
 
 struct hazptr_overflow_list;
+struct hazptr_ctx;
+
+#ifdef CONFIG_HAZPTR_DRAIN_ASSIST
+DECLARE_STATIC_KEY_FALSE(hazptr_drain_key);
+void hazptr_drain_release(void *addr, struct hazptr_slot *slot,
+			   struct hazptr_ctx *ctx);
+#endif
 
 struct hazptr_backup_slot {
 	struct hlist_node overflow_node;
 	struct hazptr_slot slot;
 	/* Overflow list where the backup slot is added. */
 	struct hazptr_overflow_list *overflow_list;
+#ifdef CONFIG_HAZPTR_DRAIN_ASSIST
+	unsigned long drain_gen;
+#endif
 };
 
 struct hazptr_ctx {
@@ -72,6 +82,9 @@ struct hazptr_slot_item {
 	unsigned long acquire_caller;
 	unsigned long acquire_jiffies;
 #endif
+#ifdef CONFIG_HAZPTR_DRAIN_ASSIST
+	unsigned long drain_gen;
+#endif
 };
 
 struct hazptr_percpu_slots {
@@ -352,6 +365,10 @@ void hazptr_release(struct hazptr_ctx *ctx, void *addr)
 	hazptr_release_debug(ctx, addr);
 	slot = ctx->slot;
 	smp_store_release(&slot->addr, NULL);
+#ifdef CONFIG_HAZPTR_DRAIN_ASSIST
+	if (static_branch_unlikely(&hazptr_drain_key))
+		hazptr_drain_release(addr, slot, ctx);
+#endif
 	if (unlikely(hazptr_slot_is_backup(ctx, slot)))
 		hazptr_unchain_backup_slot(ctx);
 }
diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index 8de194c07eea..7d4273a44183 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -323,6 +323,9 @@ static bool hazptr_bloom_contains(const struct hazptr_bloom *bloom, void *addr)
  * match.
  *
  * A wildcard in an overflow-list slot means a slow-path acquire is in
+ * flight.  Wildcards never appear in per-CPU slots: the try_acquire
+ * fast path publishes the actual address directly, and only the
+ * slow path's backup slot goes through a wildcard transient.
  * flight: that slot may resolve to any address (including @watch or a
  * Bloom-collected one) after the walk.  To keep the single-pass
  * completion decision safe, the caller must observe wildcards and
@@ -402,6 +405,9 @@ struct hazptr_waiter {
 	int pid;
 	unsigned long caller;
 #endif
+#ifdef CONFIG_HAZPTR_DRAIN_ASSIST
+	unsigned int drain_cycles;
+#endif
 };
 
 struct hazptr_scan_state {
@@ -417,6 +423,346 @@ static struct hazptr_scan_state hazptr_scan;
 
 /* Sysfs counters, cf. RCU's rcu_stall_count. */
 static atomic_t hazptr_stall_count = ATOMIC_INIT(0);
+static atomic_t hazptr_drain_count = ATOMIC_INIT(0);
+
+#ifdef CONFIG_HAZPTR_DRAIN_ASSIST
+
+/*
+ * Drain-assist: internal forward-progress mechanism for sticky addresses.
+ *
+ * When a waiter is blocked for too many scan cycles, the kthread
+ * snapshots which per-CPU slots hold the waited-for address and
+ * tracks their release via a per-slot bitmap.  A remove-only
+ * re-snapshot (periodic re-walk that only clears bits, never sets
+ * new ones) recovers lost notifications.
+ *
+ * Completion requires: bitmap empty (all per-CPU snapshot holders
+ * released) AND all marked backup slots released (tracked via a
+ * per-slot drain_gen marker and a backup_outstanding count).
+ * Per-CPU slots are bitmap-tracked; backup slots are
+ * generation-marked.
+ *
+ * The release path carries a static_branch-guarded check:
+ * near-zero overhead when no drain is active.
+ */
+
+#define HAZPTR_DRAIN_BITS	(NR_CPUS * NR_HAZPTR_PERCPU_SLOTS)
+
+/*
+ * Backup-slot tracking: overflow-list holders lack stable
+ * (cpu, idx) identity.  Instead of storing dangling pointers,
+ * each backup slot carries a drain_gen marker set by engage
+ * and cleared by the release path (a synchronous hook called from
+ * hazptr_release() while the reader's ctx is still valid).
+ * The completion check waits for backup_outstanding to reach
+ * zero, plus the per-CPU bitmap to become empty.
+ */
+
+struct hazptr_drain_state {
+	void *addr;		/* NULL = inactive; written by kthread, read by release hook */
+	DECLARE_BITMAP(map, HAZPTR_DRAIN_BITS);
+	unsigned long generation;
+	atomic_t backup_outstanding;
+	unsigned int cycle_count;	/* cycles since engage, for fairness */
+};
+
+/*
+ * Cap on consecutive drain cycles for a single address.  When reached,
+ * the drain disengages and the current waiter's re-engage counter is
+ * reset, giving other stalled waiters a chance to engage.  This
+ * prevents one continuously-re-published address from starving
+ * waiters on other addresses.
+ */
+#define HAZPTR_DRAIN_MAX_CYCLES	1000
+
+static struct hazptr_drain_state hazptr_drain;
+DEFINE_STATIC_KEY_FALSE(hazptr_drain_key);
+EXPORT_SYMBOL_GPL(hazptr_drain_key);
+
+/*
+ * Engage: record the address, snapshot which per-CPU slots hold it,
+ * and enable the release-path check.  Defers (returns false) if any
+ * slot (per-CPU or overflow-list) holds a wildcard value: an
+ * in-flight acquire could resolve to the target address after the
+ * snapshot, missing the bitmap.
+ */
+/*
+ * Clear backup-slot markers for the given generation, under the
+ * overflow-list locks.  Used by the wildcard-defer and orphaned-
+ * disengage paths, where the drain is being abandoned before or
+ * after formal publication.  Does not decrement backup_outstanding:
+ * the defer path runs before the count is established, and the
+ * orphan path runs after the drain is no longer consulted.
+ */
+static void hazptr_drain_clear_markers(unsigned long gen)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct hazptr_overflow_list_flip *overflow_list_flip =
+			per_cpu_ptr(&percpu_overflow_list_flip, cpu);
+
+		for (int i = 0; i < 2; i++) {
+			struct hazptr_overflow_list *list =
+				&overflow_list_flip->array[i];
+			struct hazptr_backup_slot *b;
+			unsigned long flags;
+
+			raw_spin_lock_irqsave(&list->lock, flags);
+			hlist_for_each_entry(b, &list->head, overflow_node) {
+				if (READ_ONCE(b->drain_gen) == gen)
+					WRITE_ONCE(b->drain_gen, 0);
+			}
+			raw_spin_unlock_irqrestore(&list->lock, flags);
+		}
+	}
+}
+static bool hazptr_drain_engage(void *addr)
+{
+	int cpu;
+	unsigned int idx;
+	bool wildcard_present = false;
+
+	bitmap_zero(hazptr_drain.map, HAZPTR_DRAIN_BITS);
+	hazptr_drain.generation++;
+	hazptr_drain.cycle_count = 0;
+	atomic_set(&hazptr_drain.backup_outstanding, 0);
+
+	for_each_possible_cpu(cpu) {
+		struct hazptr_percpu_slots *percpu_slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
+		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
+
+		for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
+			struct hazptr_slot_item *item = &percpu_slots->items[idx];
+			void *v = smp_load_acquire(&item->slot.addr);
+
+			if (is_wildcard(v))
+				wildcard_present = true;
+			if (v == addr)
+				set_bit(cpu * NR_HAZPTR_PERCPU_SLOTS + idx,
+					hazptr_drain.map);
+		}
+		for (int i = 0; i < 2; i++) {
+			struct hazptr_overflow_list *list = &overflow_list_flip->array[i];
+			struct hazptr_backup_slot *b;
+			unsigned long flags;
+
+			raw_spin_lock_irqsave(&list->lock, flags);
+			hlist_for_each_entry(b, &list->head, overflow_node) {
+				void *v = smp_load_acquire(&b->slot.addr);
+
+				if (is_wildcard(v)) {
+					wildcard_present = true;
+					continue;
+				}
+				if (v != addr)
+					continue;
+
+				/*
+				 * Mark this backup slot with the current
+				 * drain generation and increment the
+				 * outstanding count immediately.  The
+				 * count is maintained incrementally so
+				 * that a concurrent unchain (which
+				 * consumes the marker and decrements)
+				 * cannot be overwritten by a final
+				 * atomic_set.
+				 */
+				WRITE_ONCE(b->drain_gen,
+					   hazptr_drain.generation);
+				atomic_inc(&hazptr_drain.backup_outstanding);
+			}
+			raw_spin_unlock_irqrestore(&list->lock, flags);
+		}
+	}
+
+	/*
+	 * Defer if any in-flight acquire holds a wildcard.
+	 */
+	if (wildcard_present) {
+		/*
+		 * Clear any markers set before the wildcard was found:
+		 * they belong to an abandoned round.  The count was
+		 * already incremented for these markers; reset it
+		 * because clear_markers does not decrement.
+		 */
+		hazptr_drain_clear_markers(hazptr_drain.generation);
+		bitmap_zero(hazptr_drain.map, HAZPTR_DRAIN_BITS);
+		atomic_set(&hazptr_drain.backup_outstanding, 0);
+		return false;
+	}
+
+	WRITE_ONCE(hazptr_drain.addr, addr);
+	smp_mb(); /* addr publish before static_branch enable */
+
+	static_branch_inc(&hazptr_drain_key);
+	pr_info("hazptr: drain engaged for %p (gen %lu, outstanding %d)\n",
+		addr, hazptr_drain.generation,
+		atomic_read(&hazptr_drain.backup_outstanding));
+	return true;
+}
+
+/*
+ * Release notification: the release path calls this when it clears
+ * a slot that was holding the drain address.
+ *
+ * Context: preemption disabled (hazptr_release always runs under
+ * guard(preempt)).  cpu = this CPU; idx = slot index (0..3).
+ */
+static void hazptr_drain_notify(int cpu, int idx)
+{
+	int bit = cpu * NR_HAZPTR_PERCPU_SLOTS + idx;
+
+	if (bit >= HAZPTR_DRAIN_BITS)
+		return;
+	if (test_and_clear_bit(bit, hazptr_drain.map) &&
+	    bitmap_empty(hazptr_drain.map, HAZPTR_DRAIN_BITS))
+		swake_up_one(&hazptr_scan.wq);
+}
+
+/*
+ * Re-snapshot: remove-only re-walk.  Clear bits for slots that no
+ * longer hold the drain address; never set new bits.  Also recovers
+ * backup-slot releases that occurred during the engage walk (before
+ * the drain address was published): if a backup slot's drain_gen
+ * marker still matches the current generation but the slot no longer
+ * holds the target address, the reader has already released it;
+ * clear the marker and decrement backup_outstanding.
+ * Called periodically while draining.
+ */
+static void hazptr_drain_resnapshot(void)
+{
+	int cpu;
+	unsigned int idx;
+
+	for_each_possible_cpu(cpu) {
+		struct hazptr_percpu_slots *percpu_slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
+
+		for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
+			int bit = cpu * NR_HAZPTR_PERCPU_SLOTS + idx;
+			struct hazptr_slot_item *item = &percpu_slots->items[idx];
+
+			if (test_bit(bit, hazptr_drain.map) &&
+			    smp_load_acquire(&item->slot.addr) != hazptr_drain.addr)
+				clear_bit(bit, hazptr_drain.map);
+		}
+		for (int i = 0; i < 2; i++) {
+			struct hazptr_overflow_list *list =
+				&per_cpu_ptr(&percpu_overflow_list_flip, cpu)->array[i];
+			struct hazptr_backup_slot *b;
+			unsigned long flags;
+
+			raw_spin_lock_irqsave(&list->lock, flags);
+			hlist_for_each_entry(b, &list->head, overflow_node) {
+				if (READ_ONCE(b->drain_gen) !=
+				    hazptr_drain.generation)
+					continue;
+				/*
+				 * Still holds the drain address: the reader
+				 * has not released yet, so the marker is
+				 * legitimately active.  Skip.
+				 */
+				if (smp_load_acquire(&b->slot.addr) ==
+				    hazptr_drain.addr)
+					continue;
+				/*
+				 * The slot no longer holds the address:
+				 * the reader released during the engage
+				 * walk, before the drain address was
+				 * published.  The release hook could not
+				 * have seen the address, so recover here.
+				 * Atomically claim the marker so that the
+				 * release hook and this recovery path
+				 * cannot both decrement for the same slot.
+				 */
+				if (cmpxchg(&b->drain_gen,
+					    hazptr_drain.generation, 0) ==
+				    hazptr_drain.generation)
+					atomic_dec(&hazptr_drain.backup_outstanding);
+			}
+			raw_spin_unlock_irqrestore(&list->lock, flags);
+		}
+	}
+}
+
+
+/*
+ * Disengage: clear the address, disable the release hook, and
+ * clear any backup-slot markers still marked for this generation.
+ */
+static void hazptr_drain_disengage(const char *reason)
+{
+	unsigned long gen = hazptr_drain.generation;
+
+	WRITE_ONCE(hazptr_drain.addr, NULL);
+	smp_mb(); /* addr-NULL visible before static_branch off */
+	static_branch_dec(&hazptr_drain_key);
+	pr_info("hazptr: drain disengaged (%s, gen %lu, outstanding %d)\n",
+		reason, gen, atomic_read(&hazptr_drain.backup_outstanding));
+	/*
+	 * Clear markers for the abandoned generation.  The static key
+	 * is off, so no new release hook can enter; an in-flight hook
+	 * that already passed the addr check may still consume a
+	 * marker and decrement backup_outstanding, leaving the count
+	 * stale.  The count is only meaningful within a generation's
+	 * lifetime and is reset on the next engage, so no adjustment
+	 * is needed here.
+	 */
+	hazptr_drain_clear_markers(gen);
+}
+
+/*
+ * hazptr_drain_release - release-path hook under static_branch.
+ *
+ * Called from hazptr_release() *after* smp_store_release(&slot->addr, NULL)
+ * has committed.  For per-CPU slots, clears the bitmap bit.  For
+ * backup (overflow-list) slots, cooperates via the slot's drain_gen
+ * marker: the engage set it, and here we clear it and decrement
+ * backup_outstanding.
+ *
+ * The slot type is identified via hazptr_slot_is_backup(ctx, slot).
+ */
+void hazptr_drain_release(void *addr, struct hazptr_slot *slot,
+			   struct hazptr_ctx *ctx)
+{
+	struct hazptr_percpu_slots *base;
+	struct hazptr_slot_item *item;
+	int cpu;
+
+	if (smp_load_acquire(&hazptr_drain.addr) != addr)
+		return;
+
+	cpu = smp_processor_id();
+
+	/* Backup slot: cooperate via drain_gen marker. */
+	if (hazptr_slot_is_backup(ctx, slot)) {
+		/*
+		 * Atomically claim the marker: only one of the release
+		 * hook or the resnapshot recovery path may consume it,
+		 * so only the cmpxchg() winner decrements.
+		 */
+		if (cmpxchg(&ctx->backup_slot.drain_gen,
+			    hazptr_drain.generation, 0) ==
+		    hazptr_drain.generation)
+			atomic_dec(&hazptr_drain.backup_outstanding);
+		return;
+	}
+
+	/*
+	 * Per-CPU slot: derive the bit index from the slot's position.
+	 * Safe because hazptr_release() runs under guard(preempt) and
+	 * the per-CPU slot was acquired on the same CPU, so the slot
+	 * item is in this CPU's items[] array.
+	 */
+	base = per_cpu_ptr(&hazptr_percpu_slots, cpu);
+	item = container_of(slot, struct hazptr_slot_item, slot);
+	if (item >= base->items &&
+	    item < base->items + NR_HAZPTR_PERCPU_SLOTS)
+		hazptr_drain_notify(cpu, item - base->items);
+}
+EXPORT_SYMBOL_GPL(hazptr_drain_release);
+
+#endif /* CONFIG_HAZPTR_DRAIN_ASSIST */
 
 /*
  * Queue @addr for the shared scan.  The waiter lives on the
@@ -438,6 +784,9 @@ static void hazptr_synchronize_queued(void *addr, unsigned long caller)
 	waiter.pid = task_pid_nr(current);
 	waiter.caller = caller;
 #endif
+#ifdef CONFIG_HAZPTR_DRAIN_ASSIST
+	waiter.drain_cycles = 0;
+#endif
 
 	/* Enqueue and wake the scan kthread. */
 	mutex_lock(&hazptr_scan.lock);
@@ -509,6 +858,90 @@ static void hazptr_scan_do_cycle(void)
 	list_for_each_entry_safe(w, n, &hazptr_scan.scanning, node)
 		hazptr_waiter_stall_check(w);
 #endif
+#ifdef CONFIG_HAZPTR_DRAIN_ASSIST
+	/*
+	 * Drain-assist: for still-blocked waiters, advance the cycle
+	 * counter and engage or manage a sticky-address drain.
+	 *
+	 * When a waiter has been blocked for 100+ scan cycles, the
+	 * kthread snapshots which slots hold the address (engage)
+	 * and tracks their release via a per-slot bitmap.
+	 *
+	 * When all tracked holders have released (the per-CPU bitmap
+	 * is empty and no backup slots remain marked for the current
+	 * generation), disengage the drain.  The next
+	 * scan cycle's Bloom walk then verifies the address is
+	 * truly absent before completing the waiter, avoiding a race
+	 * with post-engage readers.
+	 */
+	list_for_each_entry_safe(w, n, &hazptr_scan.scanning, node) {
+		w->drain_cycles++;
+
+		/* Engage when a waiter has been stuck long enough. */
+		if (!hazptr_drain.addr && w->drain_cycles > 100) {
+			hazptr_drain_engage(w->addr);
+			if (hazptr_drain.addr == w->addr)
+				atomic_inc(&hazptr_drain_count);
+		}
+
+		/* If draining for this address, check progress. */
+		if (hazptr_drain.addr == w->addr) {
+			/* Periodic remove-only re-snapshot. */
+			if (!(w->drain_cycles & 63))
+				hazptr_drain_resnapshot();
+
+			{
+				/*
+				 * All tracked holders have released.
+				 * Disengage and let the next cycle's
+				 * Bloom walk verify the address is
+				 * truly absent before completing the
+				 * waiter.
+				 */
+				if (bitmap_empty(hazptr_drain.map,
+						 HAZPTR_DRAIN_BITS) &&
+				    !atomic_read(&hazptr_drain.backup_outstanding)) {
+					hazptr_drain_disengage("complete");
+					hazptr_drain.cycle_count = 0;
+				}
+			}
+
+			/*
+			 * Fairness: cap consecutive drain cycles for a
+			 * single address.  On expiry, disengage and reset
+			 * this waiter's re-engage counter so the next
+			 * stalled waiter (if any) gets the next turn
+			 * instead of the same address immediately
+			 * re-engaging.
+			 */
+			if (++hazptr_drain.cycle_count >
+			    HAZPTR_DRAIN_MAX_CYCLES) {
+				hazptr_drain_disengage("fairness-cap");
+				hazptr_drain.cycle_count = 0;
+				w->drain_cycles = 0;
+			}
+			break;	/* one drain target at a time */
+		}
+	}
+
+	/*
+	 * Disengage orphaned drain: if the drain address no longer
+	 * has a matching waiter in ->scanning (the Bloom path may
+	 * have completed it this cycle), clean up.
+	 */
+	if (hazptr_drain.addr) {
+		bool orphaned = true;
+
+		list_for_each_entry(w, &hazptr_scan.scanning, node) {
+			if (w->addr == hazptr_drain.addr) {
+				orphaned = false;
+				break;
+			}
+		}
+		if (orphaned)
+			hazptr_drain_disengage("orphaned");
+	}
+#endif
 }
 
 
@@ -684,7 +1117,6 @@ static void hazptr_waiter_stall_check(struct hazptr_waiter *w)
 	unsigned long now = jiffies;
 	unsigned long timeout = msecs_to_jiffies(CONFIG_HAZPTR_STALL_TIMEOUT);
 	unsigned long deadline;
-
 	w->cycles++;
 	deadline = w->reports ? w->last_report + 2 * timeout
 			      : w->enqueue_jiffies + timeout;
@@ -799,6 +1231,30 @@ void hazptr_unchain_backup_slot(struct hazptr_ctx *ctx)
 	struct hazptr_overflow_list *overflow_list = ctx->backup_slot.overflow_list;
 
 	guard(raw_spinlock_irqsave)(&overflow_list->lock);
+#ifdef CONFIG_HAZPTR_DRAIN_ASSIST
+	unsigned long gen;
+
+	/*
+	 * Consume any pending drain marker under the list lock,
+	 * before removing the slot from the overflow list.  The
+	 * engage sets markers while holding this same lock, so
+	 * checking under the lock guarantees that if the engage
+	 * marks this slot, we see the marker before the slot is
+	 * unchained.  Without the lock, the unchain could check
+	 * drain_gen before the engage sets it, then block on the
+	 * lock while the engage sets the marker and increments
+	 * the count, and finally remove the slot without ever
+	 * consuming the orphaned marker.
+	 *
+	 * The cmpxchg ensures only one of the release hook, the
+	 * resnapshot, or this path decrements backup_outstanding.
+	 */
+	gen = READ_ONCE(ctx->backup_slot.drain_gen);
+	if (gen) {
+		if (cmpxchg(&ctx->backup_slot.drain_gen, gen, 0) == gen)
+			atomic_dec(&hazptr_drain.backup_outstanding);
+	}
+#endif
 	overflow_list->gen++;
 	hlist_del(&ctx->backup_slot.overflow_node);
 }
@@ -825,12 +1281,22 @@ static ssize_t hazptr_stall_count_show(struct kobject *kobj,
 {
 	return sysfs_emit(page, "%d\n", atomic_read(&hazptr_stall_count));
 }
+static ssize_t hazptr_drain_count_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					char *page)
+{
+	return sysfs_emit(page, "%d\n", atomic_read(&hazptr_drain_count));
+}
+
+static struct kobj_attribute hazptr_drain_count_attr =
+	__ATTR_RO(hazptr_drain_count);
 
 static struct kobj_attribute hazptr_stall_count_attr =
 	__ATTR_RO(hazptr_stall_count);
 
 static struct attribute *hazptr_sysfs_attrs[] = {
 	&hazptr_stall_count_attr.attr,
+	&hazptr_drain_count_attr.attr,
 	NULL,
 };
 
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index b64ae06f3298..b500e96ea1c1 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -291,4 +291,16 @@ config HAZPTR_STALL_TIMEOUT
 	help
 	  Waiter stall timeout in milliseconds, defaulting to RCU's 21s.
 
+config HAZPTR_DRAIN_ASSIST
+	bool "Hazard-pointer sticky-address drain assist"
+	default y
+	help
+	  Internal forward-progress mechanism for hazptr_synchronize()
+	  waiters whose target address is continuously re-published
+	  by new readers.  When a waiter has been blocked for many
+	  scan cycles, the scan kthread snapshots which slots hold
+	  the address and tracks their release via per-slot tracking.
+
+	  If unsure, say Y.
+
 endmenu # "RCU Debugging"
diff --git a/tools/testing/selftests/rcutorture/bin/hazptr.sh b/tools/testing/selftests/rcutorture/bin/hazptr.sh
index 4e30ea51d9fc..d12735ddfefc 100755
--- a/tools/testing/selftests/rcutorture/bin/hazptr.sh
+++ b/tools/testing/selftests/rcutorture/bin/hazptr.sh
@@ -229,8 +229,19 @@ then
 		if ! grep -q "hazptr: waiter stall" "$console"
 		then
 			echo "HOTADDR note: no stall splats observed (record as not-reproduced, investigate interleaving)" > "$resdir/kvm.sh.note"
+		elif ! grep -q "drain engaged" "$console"
+		then
+			echo "HOTADDR note: drain-assist did not engage (Bloom completion may have handled it)" > "$resdir/kvm.sh.note"
+		elif ! grep -q "drain disengaged (complete" "$console"
+		then
+			if grep -q "drain disengaged (fairness-cap" "$console"
+			then
+				echo "HOTADDR: drain hit fairness cap without completing" > "$resdir/kvm.sh.err"
+			else
+				echo "HOTADDR note: drain engaged but did not disengage normally" > "$resdir/kvm.sh.note"
+			fi
 		else
-			echo "HOTADDR: starvation reproduced, stall detector confirmed, drain verified"
+			echo "HOTADDR: starvation reproduced, stall detector confirmed, drain engaged"
 		fi
 	else
 		nerrs=$((nerrs+1))
@@ -239,10 +250,11 @@ else
 	nerrs=$((nerrs+1))
 fi
 
-# LONGHOLD: legitimate long-lived references.  The stall detector must
-# fire (observation), the holder must release, and the waiter must drain
-# normally afterwards: diagnostics without interruption, module verdict
-# stays SUCCESS.
+# LONGHOLD: legitimate long-lived references.  The holder must release,
+# and the waiter must drain normally afterwards.  The stall detector
+# may or may not fire (the 8-second hold may not exceed the 21-second
+# timeout depending on when the waiter started relative to the hold);
+# this is observation data only, not a correctness requirement.
 
 echo "--- hazptr LONGHOLD (legitimate long-held reference) ---"
 if run_kvm longhold LONGHOLD "$cpus" "" "60s"
-- 
2.43.0

