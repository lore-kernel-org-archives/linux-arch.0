Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0342D0C92
	for <linux-arch@vger.kernel.org>; Fri,  2 Oct 2026 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960968; cv=none; b=i6zTp2zPToCYN4PgYDQsm4+StJuQgHebczJx8bI4HIhYe4WPc2dV6fLrqmGzIS3TOROaylhX2nFJBnMifOSHdUGiGBRzxoOZPkmVOjuySGpdc0r2KU/+6nXAt1OCLelUbslxRTD4h9q4eIZ9Ju4SEg4m46SbR8AA0/2B62Vxh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960968; c=relaxed/simple;
	bh=LfZ5/lSdai4qmcULNQ0sZLI2MsuRTJuBplORHvku1dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAEgGd4pMIl0xlU/nA7rSvIF4ul3K31MMlRxmnBheyC8djPgP+AxPUk4YUN30kx8LoMy6He4rfPhQXUxHixZQAedsU1gDb4RmeIuzwTGZJl8KEn0U9b2zlrJ04zlrojmsakS+8xHyelVKUfMTq+5BUMKolGRMtRLHJsMKQqU0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfBdQ45u; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfBdQ45u"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so155932a91.0
        for <linux-arch@vger.kernel.org>; Fri, 02 Oct 2026 10:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790960963; x=1791565763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HaUov767om1ufidMBuv+Qa8IE9x5ePpDXkwVM9ozpyI=;
        b=RfBdQ45uKdBTEN7/xQSrOBMYxBG36N/OP6r3it7YygnJ2OTWhBTMcj0XtsFU/4mGOo
         ItfVsYh5SA33n5K9J5ADOUeK8A61j8e4W8fPbxSqnGMt5/2LxASxAMoT3xnvL0dqqIbK
         I9Oh0dcf/xn+SGRW4ErS71MdzroXPaI6tc1fNLQYqRpS+F0/UjcH5G8oTxrZHK2Qe+ll
         52NwnUVecNIy2hK9QJ792gAeG6yQOsbkjhuk2ZxyaC+osdiDxj0aB32NXW58EnmaW5rU
         HRC/X57ceppDMKmjCe02sRRz1gvua2twyyp9xynR0SHnN9SZmQ0cROsDktFc9qE2XDkq
         sI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790960963; x=1791565763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HaUov767om1ufidMBuv+Qa8IE9x5ePpDXkwVM9ozpyI=;
        b=lvTdWkc9/PvlVTLrFnCynmIms5BNKse8nTvDEYMJTOfJ/zetPpQYzeASR/hSARTzKX
         4JF6z1plwmZibUo5/BfgptM8u+B4OvpUuH0KebgAiXrg9RN3UjMF9T1+e2DJx2LYpEt+
         NsctX26sVVbURpm8LX0u5fdNRu2iVYhnUSv23w6iChBx88ZAYDurP2Gfv2PHrYP+GWIX
         kw3cpSq+VPj6eTAYOfu3Wr7MypSAb4HYp/HBp/uX0oS3XwUDyyv614zsFsquRPC+r8Ob
         Oy5fNUNJEV+zBTMpy1KDukHbchc9lywB1VeJauAmcBfZJZuFVdb7ADpWiuNAyI3x48kD
         jx4Q==
X-Forwarded-Encrypted: i=1; AKwUvBznieF1KnH89+qFz55i5P8gge5dRsafIYr9P2u2RK/k6oul/E35yayZk6dF04P+eSgmQdVL6qNEN8lY@vger.kernel.org
X-Gm-Message-State: AFq9FYJgzzZPk5JW0HSdldLbUmj+mmXlcv0ddL4iDfEryEnNXy2F5USC
	YeKurZ7yGWzpDr8gsL2pIvrDkgNsvyYsfA/1E7XHV7vyRyIOCBk5xQR9
X-Gm-Gg: AYBFou2Spuv/bXJ/N0AkJDZR2j3jx2ObMksCxZiNCbI+naFXTxb262YLJsIEP2JpUgb
	0g8dDm94Bq1t3kjFnumweaYYTAOiKyWCH7DV7PgO41tHdw1cOyD1U9hq/YiYLqQ2QwUSAk0ZG3e
	yDSRv11e6u6/GX6D9HS2EIsTqbPztVw2rcKfbX0RX2fuiKHnApgDegJJPk0T8jR2AOtXM7UA+3Z
	eyv3xiX8PsUb9BNpQZSXLXFj7oJdVLrD5ZLIiUStLbXte1jv0uKTlQSFm73xY1THCrByDHX7vgc
	gWi07sRcyPWNXGrgnw/ACHpXTKhEKH7xpePhnznzCj9cpGgOqdU7tYKpw0boWthD1QkVPI1Vux/
	mL/1SqqHbS8Bn/ICwQW/UIr2IeZapPG9qVya+lEdEgY8RsNiC+btD3arqBzuS3qISMTeiWFoVED
	pSOtVAv94b531uYxjev6b367HvzJtTxGJy60hTbpjkcTJ3lC+wP61yNh78x6I4baQZdmPWbFmt2
	XyKcj+ZEyXqO6fnDQ==
X-Received: by 2002:a17:90a:dfc5:b0:3a1:8b70:d46b with SMTP id 98e67ed59e1d1-3a6ce80d87amr2504431a91.42.1790960962547;
        Fri, 02 Oct 2026 10:09:22 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7024d0f5fsm1597719a91.0.2026.10.02.10.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:09:22 -0700 (PDT)
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
Subject: [PATCH RFC v2 02/15] hazptr: use Bloom filter for shared scan waiters
Date: Sat,  3 Oct 2026 01:08:34 +0800
Message-ID: <20261002170847.3653663-3-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002170847.3653663-1-kunwu.chan@gmail.com>
References: <20261002170847.3653663-1-kunwu.chan@gmail.com>
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

