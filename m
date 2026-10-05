Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3192A4DF4D0
	for <linux-arch@vger.kernel.org>; Mon,  5 Oct 2026 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220579; cv=none; b=iTc8LJOa7/lkby9z+JOCA7APm/LT57iLfm3jCQZLpOtMzrRdLO44MuVRI07HLwRWvQYyqFwdrgfsV0ey6aHgelCVW312Iys6SDhQpyIn/OZZMq03mBWmPXe2txZ3W/XQiTWQz/Qoe35GAJBYFmH1Dt7Yr4OZKdObiOddIyG6OT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220579; c=relaxed/simple;
	bh=LfZ5/lSdai4qmcULNQ0sZLI2MsuRTJuBplORHvku1dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/gacXidXCSWL74ygirakwe9FjoefJTrDvLc3TKro2PEJbDheJ/L3zttCa8zEkaldUj3lX/Fr5JPRPuovCXvZy94Z8h5H8diz6ZxNDYpXAppSWfQf4IihVM4cT12m+mveV0zVOo/bgHifNkknQVVKoWpyrTqK0BDJsYOLi+d5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMLZlWzv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMLZlWzv"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a0a911e8d6so923872a91.1
        for <linux-arch@vger.kernel.org>; Mon, 05 Oct 2026 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791220577; x=1791825377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HaUov767om1ufidMBuv+Qa8IE9x5ePpDXkwVM9ozpyI=;
        b=RMLZlWzvh1M1EWyckgnhvGvZ9E0wFPeEVTGi4YR+wdR83c2j6EHlUoF32683uZQTFg
         BoJfkFyJyCjNk5+KIbmUAFIpVNOQ5C83QmLCUq9IwR4OFTEIiYccVNFQ2Nnm4+L+MSYY
         5VycpvXy/BjgaKtZF3aGqWvZNEmrhf3qW0qq5hBTzQcMwox3gBKj7QFPaqB4bi8RQYJC
         qIZffb9Ren7TkJWVdrtVFrsb86iJbSPhDWz2W7TpFj65tUXxSQ6R8Xmcbns5tBGDzjHL
         Nc+pOxDMgSmu+jLWxhD31GXozd9bk1j7SXWoBZG1FI54FGkpieMZTur9a3ROUDjMJQgP
         wNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791220577; x=1791825377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HaUov767om1ufidMBuv+Qa8IE9x5ePpDXkwVM9ozpyI=;
        b=DLcifqXRCi6RwaGs/cP2FV0JD862sHPiGIRrPuUL/t2mS56ZLeAFX/lInBSMUZSUmu
         pWnTziXk2wUSLETeYUAQTAvpyOUOJfq3jlSrANq3a3RDEybSgooK7xuBMPO348Gdk3Db
         anfIJ3oSVi+c9oBgNZHkgx2EAgUJ0MTU/YzZDkn8DncFe5aR4hWqwT6pbllNETafGVHT
         rkKQwCBVloP8vuiUV63tBDswY7WxfmG8GBvA2gygFXEhbv0Fe9Mb9yIrdL0uJ0NOep7r
         VNsX4Rxm+5FCh5iGngrMHm970P8DUorV2ZIaj9Vr5cmBx/EKd7l43FQ2SQEpBkd8Rvdl
         6Rkw==
X-Forwarded-Encrypted: i=1; AKwUvBy1ZxJnuqBm6+D6b6PazQw0g4YxQWN08+gRIVow62o1Ah9JJRtC9CpYgeieeIFADigNw203iDKE9NXs@vger.kernel.org
X-Gm-Message-State: AFq9FYIP7kpiovwNJIz/CPQA3kZO5zi2KoAMZhZv+b7k/o+xoUPY1YjY
	CKE//F1PBISWcIZZBjv6Vewqw4HhACPMJMTKFh3u9IlCG7lFhjROnm5z
X-Gm-Gg: AYBFou1i0nSDBYNQmEQo3zPd74NvFLIONkaQWorhH73riM57X6eNzSRgJ1YhjAWdbOf
	vwfweFJcJbQ2VmHdsWZFQBvTF84kn21pcGPr6JSecrgmU9iWvjiRWiV+979xyCSnvK2f9Xsxsd9
	GbXWui7BpdxQDwFE43CM7CZ2TUA9LcQrCGL5zX/ScW3XDgKki5ZvW7tIb5IgywAdfxcnPJbYGSJ
	/qKX2IXTnT1LeH3TVvc2c3N3einFvxL2AEzh1wbFL+F4OETpA/bdx5YCVoo5hIQQ1+E3weQrr9t
	aTb6FKhKib1rX/HWPkDuORP9Nkrlp4snTMth7hkIzOVwNBRnZFrDooYPo/6d6dfB+K2Z9Uz7L/4
	Q4tkfE/NtIOkB+PmruBvWfVMgxpM/lbOFft8aDWdakbEHyWTSuwQr033ci2bv+sHidq6wIe+hYl
	vhGDAVb1N/cqLT8mm3RHIskLYuFnY0OCDGLYMOPlXGDPpfruTd7QzxCsT0bWjR6l4+OJJauT7nj
	fgJhxmghRWCXvmpu61aFPFAroS2Cw==
X-Received: by 2002:a17:90b:4a48:b0:39e:4c81:6c5f with SMTP id 98e67ed59e1d1-3a7872b63bdmr7172810a91.26.1791220575398;
        Mon, 05 Oct 2026 10:16:15 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cafddesm406910a91.10.2026.10.05.10.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:16:14 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net,
	lianux.mm@gmail.com
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun@kernel.org,
	npiggin@gmail.com,
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
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC v3 02/15] hazptr: use Bloom filter for shared scan waiters
Date: Tue,  6 Oct 2026 01:15:16 +0800
Message-ID: <20261005171529.1378809-3-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005171529.1378809-1-kunwu.chan@gmail.com>
References: <20261005171529.1378809-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the per-waiter exact-match scan with a shared Bloom filter
built during the second drain pass: each observed non-wildcard
address sets three bits, so a waiter whose address hashes to an
unset bit can be completed without another slot walk.

A Bloom filter has no false negatives, so an address absent from
the final drain scan cannot be held by an observed slot; false
positives only delay completion to a later scan cycle.

The filter uses a one-page bitmap with three multiply-shift hash
functions.  It lives in the hazptr_scan_state and is only touched
by the scan kthread, so waiter state remains on the caller's stack
and no dynamic allocation is needed.

Suggested-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/hazptr.c | 93 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 83 insertions(+), 10 deletions(-)

diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index 9e274a691af5..900ba35de2cb 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/hazptr.h>
+#include <linux/bitops.h>
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
@@ -16,6 +17,7 @@
 #include <linux/kthread.h>
 #include <linux/swait.h>
 #include <linux/sched.h>
+#include <linux/bitmap.h>
 
 /*
  * The current hazard pointer wildcard. Flips between 1UL and 2UL to guarantee
@@ -213,6 +215,55 @@ void hazptr_scan_period(void *addr, void *scan_wildcard)
 	}
 }
 
+/* Number of hash functions for the Bloom filter. */
+#define HAZPTR_BLOOM_HASHES 3
+
+/* Number of bits in the Bloom filter bitmap: one page. */
+#define HAZPTR_BLOOM_NBITS (PAGE_SIZE * 8)
+
+struct hazptr_bloom {
+	unsigned long map[PAGE_SIZE / sizeof(unsigned long)];
+};
+
+/*
+ * Multiply @addr by a per-hash odd constant and use the high bits
+ * as the Bloom filter index.
+ */
+static unsigned long hazptr_bloom_hash(void *addr, unsigned int i)
+{
+	static const u64 mult[HAZPTR_BLOOM_HASHES] = {
+		0x9E3779B97F4A7C15ULL,
+		0xC2B2AE3D27D4EB4FULL,
+		0x165667B19E3779F9ULL,
+	};
+	u64 hash = (u64)(unsigned long)addr * mult[i];
+
+	return hash >> (64 - ilog2(HAZPTR_BLOOM_NBITS));
+}
+
+static void hazptr_bloom_reset(struct hazptr_bloom *bloom)
+{
+	bitmap_zero(bloom->map, HAZPTR_BLOOM_NBITS);
+}
+
+static void hazptr_bloom_add(struct hazptr_bloom *bloom, void *addr)
+{
+	unsigned int i;
+
+	for (i = 0; i < HAZPTR_BLOOM_HASHES; i++)
+		__set_bit(hazptr_bloom_hash(addr, i), bloom->map);
+}
+
+static bool hazptr_bloom_contains(const struct hazptr_bloom *bloom, void *addr)
+{
+	unsigned int i;
+
+	for (i = 0; i < HAZPTR_BLOOM_HASHES; i++)
+		if (!test_bit(hazptr_bloom_hash(addr, i), bloom->map))
+			return false;
+	return true;
+}
+
 struct hazptr_waiter {
 	struct list_head node;
 	void *addr;
@@ -226,17 +277,26 @@ struct hazptr_scan_state {
 	struct mutex lock;
 	struct list_head pending;
 	struct list_head scanning;	/* kthread only */
+	struct hazptr_bloom bloom;	/* kthread only */
 };
 static struct hazptr_scan_state hazptr_scan;
 
 /*
- * Check per-CPU slots before overflow-list slots to match the
- * acquisition ordering of promoted slots.
+ * Walk all slots and return true if @watch is present.  If @bloom
+ * is non-NULL, record observed non-wildcard addresses in it.
+ *
+ * Per-CPU slots are examined before overflow-list slots on each CPU
+ * to preserve the acquisition ordering required by the promote path:
+ * synchronize must observe the per-CPU slot release before the
+ * overflow-list entry can be missed.
  */
-static bool hazptr_value_present(void *val)
+static bool hazptr_scan_walk(void *watch, struct hazptr_bloom *bloom)
 {
 	int cpu;
 
+	if (bloom)
+		hazptr_bloom_reset(bloom);
+
 	for_each_possible_cpu(cpu) {
 		struct hazptr_percpu_slots *percpu_slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
 		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
@@ -244,10 +304,14 @@ static bool hazptr_value_present(void *val)
 
 		for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
 			struct hazptr_slot_item *item = &percpu_slots->items[idx];
+			void *v;
 
 			/* Pairs with smp_store_release in hazptr_release(). */
-			if (smp_load_acquire(&item->slot.addr) == val)
+			v = smp_load_acquire(&item->slot.addr);
+			if (v == watch)
 				return true;
+			if (bloom && v && !is_wildcard(v))
+				hazptr_bloom_add(bloom, v);
 		}
 		for (int i = 0; i < 2; i++) {
 			struct hazptr_overflow_list *list = &overflow_list_flip->array[i];
@@ -256,11 +320,16 @@ static bool hazptr_value_present(void *val)
 
 			raw_spin_lock_irqsave(&list->lock, flags);
 			hlist_for_each_entry(b, &list->head, overflow_node) {
+				void *v;
+
 				/* Pairs with smp_store_release in hazptr_release(). */
-				if (smp_load_acquire(&b->slot.addr) == val) {
+				v = smp_load_acquire(&b->slot.addr);
+				if (v == watch) {
 					raw_spin_unlock_irqrestore(&list->lock, flags);
 					return true;
 				}
+				if (bloom && v && !is_wildcard(v))
+					hazptr_bloom_add(bloom, v);
 			}
 			raw_spin_unlock_irqrestore(&list->lock, flags);
 		}
@@ -276,7 +345,7 @@ static bool hazptr_value_present(void *val)
  */
 static void hazptr_drain_wildcard(void *wc)
 {
-	while (hazptr_value_present(wc))
+	while (hazptr_scan_walk(wc, NULL))
 		cond_resched();
 }
 
@@ -309,12 +378,16 @@ static void hazptr_scan_do_cycle(void)
 	WRITE_ONCE(hazptr_wildcard, scan_wildcard);
 	old_wildcard = flip_wildcard(scan_wildcard);
 
-	/* Pass 2: drain the old wildcard. */
-	hazptr_drain_wildcard(old_wildcard);
+	/*
+	 * Pass 2: drain the old wildcard while collecting observed
+	 * addresses into the Bloom filter.
+	 */
+	while (hazptr_scan_walk(old_wildcard, &hazptr_scan.bloom))
+		cond_resched();
 
-	/* Complete waiters whose address is no longer held by any slot. */
+	/* Complete waiters whose address is not in the filter. */
 	list_for_each_entry_safe(w, n, &hazptr_scan.scanning, node) {
-		if (!hazptr_value_present(w->addr))
+		if (!hazptr_bloom_contains(&hazptr_scan.bloom, w->addr))
 			list_move(&w->node, &done);
 	}
 
-- 
2.43.0

