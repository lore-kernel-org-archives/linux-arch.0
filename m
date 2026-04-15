Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FD03DC4CB;
	Wed, 15 Apr 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776271658; cv=none; b=Tx/1p+uyRfns0URVSVGJf2fF8yjoBTixv8IPY6FPaXHawpE5lQu3wBETckEbAwxEruhL+vy/7mI1+WuNq1p1dCBcIBu+V+P7WgM6xq1m1wnKnlWZRVomMN63Fmz4iBZ1WcgVY22YPa9JOmg/ywdi8JPzWuSD516rdbKPkTayvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776271658; c=relaxed/simple;
	bh=GB7hnr8gL/xUh7qfRJVFwiyTl7Bd6wNCVU9HRjw9TO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqgqCZJBVGzj9sSlIq6g3hz98jUPVlFc8vELhLwF/RMudvLSg5zm+zKrBdQY0CIdvIRPggnqm5RJ21Myt5F0BtXwhg09Q/rlJ/B6kpAlaDM+K/d5ARiWuzu++MQg7SgCVtjr6OVl3pGN5CMMRlRbU7jwUikUCcjs6eNZYkJZ068=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fwn9J4N2czJ46DW;
	Thu, 16 Apr 2026 00:46:44 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 0334640570;
	Thu, 16 Apr 2026 00:47:28 +0800 (CST)
Received: from localhost.localdomain (10.123.66.205) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 19:47:27 +0300
From: Fedorov Nikita <fedorov.nikita@h-partners.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Ajay
 Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
	<alexey.makhalov@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>, Arnd
 Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng
	<boqun@kernel.org>, Waiman Long <longman@redhat.com>, Darren Hart
	<dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	<andrealmeid@igalia.com>, Andrew Morton <akpm@linux-foundation.org>, David
 Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost
	<matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim
	<rakie.kim@sk.com>, <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple
	<apopple@nvidia.com>, Anatoly Stepanov <stepanov.anatoly@huawei.com>
CC: Nikita Fedorov <fedorov.nikita@h-partners.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <guohanjun@huawei.com>, <wangkefeng.wang@huawei.com>,
	<weiyongjun1@huawei.com>, <yusongping@huawei.com>, <leijitang@huawei.com>,
	<artem.kuzin@huawei.com>, <kang.sun@huawei.com>, <chenjieping3@huawei.com>
Subject: [RFC PATCH v3 1/7] kernel: add hq-spinlock types
Date: Thu, 16 Apr 2026 00:44:53 +0800
Message-ID: <20260415164459.2904963-2-fedorov.nikita@h-partners.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415164459.2904963-1-fedorov.nikita@h-partners.com>
References: <20260415164459.2904963-1-fedorov.nikita@h-partners.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Introduce the type definitions used by Hierarchical Queued spinlocks.

Add the HQ-specific types definitions and extend qspinlock so
that a lock can be marked as using the HQ slowpath
while preserving the existing qspinlock layout

Co-developed-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
Signed-off-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
Co-developed-by: Nikita Fedorov <fedorov.nikita@h-partners.com>
Signed-off-by: Nikita Fedorov <fedorov.nikita@h-partners.com>
---
 include/asm-generic/qspinlock_types.h |  44 ++++++++--
 kernel/locking/hqlock_types.h         | 118 ++++++++++++++++++++++++++
 2 files changed, 157 insertions(+), 5 deletions(-)
 create mode 100644 kernel/locking/hqlock_types.h

diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index 2fd1fb89ec..a97387ae48 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -43,11 +43,6 @@ typedef struct qspinlock {
 	};
 } arch_spinlock_t;
 
-/*
- * Initializier
- */
-#define	__ARCH_SPIN_LOCK_UNLOCKED	{ { .val = ATOMIC_INIT(0) } }
-
 /*
  * Bitfields in the atomic value:
  *
@@ -76,6 +71,26 @@ typedef struct qspinlock {
 #else
 #define _Q_PENDING_BITS		1
 #endif
+
+#ifdef CONFIG_HQSPINLOCKS
+/* For locks with HQ-mode we always use single pending bit */
+#define _Q_PENDING_HQLOCK_BITS	 1
+#define _Q_PENDING_HQLOCK_OFFSET (_Q_LOCKED_OFFSET + _Q_LOCKED_BITS)
+#define _Q_PENDING_HQLOCK_MASK		_Q_SET_MASK(PENDING_HQLOCK)
+
+#define _Q_LOCKTYPE_OFFSET	(_Q_PENDING_HQLOCK_OFFSET + _Q_PENDING_HQLOCK_BITS)
+#define _Q_LOCKTYPE_BITS	1
+#define _Q_LOCKTYPE_MASK	_Q_SET_MASK(LOCKTYPE)
+#define _Q_LOCKTYPE_HQ			(1U << _Q_LOCKTYPE_OFFSET)
+
+#define _Q_LOCK_MODE_OFFSET	(_Q_LOCKTYPE_OFFSET + _Q_LOCKTYPE_BITS)
+#define _Q_LOCK_MODE_BITS	2
+#define _Q_LOCK_MODE_MASK	_Q_SET_MASK(LOCK_MODE)
+#define _Q_LOCK_MODE_QSPINLOCK_VAL	(1U << _Q_LOCK_MODE_OFFSET)
+
+#define _Q_LOCK_TYPE_MODE_MASK	(_Q_LOCKTYPE_MASK | _Q_LOCK_MODE_MASK)
+#endif //CONFIG_HQSPINLOCKS
+
 #define _Q_PENDING_MASK		_Q_SET_MASK(PENDING)
 
 #define _Q_TAIL_IDX_OFFSET	(_Q_PENDING_OFFSET + _Q_PENDING_BITS)
@@ -92,4 +107,23 @@ typedef struct qspinlock {
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
+#ifdef CONFIG_HQSPINLOCKS
+#define _Q_LOCK_INVALID_TAIL	(_Q_TAIL_IDX_MASK)
+
+#define _Q_SERVICE_MASK		(_Q_LOCKTYPE_MASK | _Q_LOCK_MODE_QSPINLOCK_VAL | _Q_LOCK_INVALID_TAIL)
+#else // CONFIG_HQSPINLOCKS
+#define _Q_SERVICE_MASK		0
+#endif
+
+/*
+ * Initializier
+ */
+#define	__ARCH_SPIN_LOCK_UNLOCKED		{ { .val = ATOMIC_INIT(0) } }
+
+#ifdef CONFIG_HQSPINLOCKS
+#define	__ARCH_SPIN_LOCK_UNLOCKED_HQ	{ { .val = ATOMIC_INIT(_Q_LOCKTYPE_HQ | _Q_LOCK_MODE_QSPINLOCK_VAL) } }
+#else
+#define	__ARCH_SPIN_LOCK_UNLOCKED_HQ	{ { .val = ATOMIC_INIT(0) } }
+#endif
+
 #endif /* __ASM_GENERIC_QSPINLOCK_TYPES_H */
diff --git a/kernel/locking/hqlock_types.h b/kernel/locking/hqlock_types.h
new file mode 100644
index 0000000000..32d06f2755
--- /dev/null
+++ b/kernel/locking/hqlock_types.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _GEN_HQ_SPINLOCK_SLOWPATH
+#error "Do not include this file!"
+#endif
+
+#define IRQ_NODE (MAX_NUMNODES + 1)
+#define Q_NEW_NODE_QUEUE 1
+#define LOCK_ID_BITS		(12)
+
+#define LOCK_ID_MAX			(1 << LOCK_ID_BITS)
+#define LOCK_ID_NONE		(LOCK_ID_MAX + 1)
+
+#define _QUEUE_TAIL_MASK (((1ULL << 32) - 1) << 0)
+#define _QUEUE_SEQ_COUNTER_MASK (((1ULL << 32) - 1) << 32)
+
+/*
+ * Output code for handoff-logic:
+ *
+ * ==  0 (HQLOCK_HANDOFF_LOCAL) - has local nodes to handoff
+ *  >  0 - has remote node to handoff, id is visible
+ * == -1 (HQLOCK_HANDOFF_REMOTE_HEAD) - has remote node to handoff,
+ *         id isn't visible yet, will be in the *lock_meta->head_node*
+ */
+enum {
+	HQLOCK_HANDOFF_LOCAL = 0,
+	HQLOCK_HANDOFF_REMOTE_HEAD = -1
+};
+
+typedef enum {
+	LOCK_NO_MODE = 0,
+	LOCK_MODE_QSPINLOCK = 1,
+	LOCK_MODE_HQLOCK = 2,
+} hqlock_mode_t;
+
+struct numa_qnode {
+	struct mcs_spinlock mcs;
+
+	u16 lock_id;
+	u16 wrong_fallback_tail;
+	u16 general_handoffs;
+
+	u16 numa_node;
+};
+
+struct numa_queue {
+	struct numa_qnode *head;
+	union {
+		u64 seq_counter_tail;
+		struct {
+			u32 tail;
+			u32 seq_counter;
+		};
+	};
+
+	u16 next_node;
+	u16 prev_node;
+
+	u16 handoffs_not_head;
+} ____cacheline_aligned;
+
+/**
+ * Lock metadata
+ * "allocated"/"freed" on demand.
+ *
+ * Used to dynamically bind numa_queue to a lock,
+ * maintain FIFO-order for the NUMA-queues.
+ *
+ * seq_counter is needed to distinguish metadata usage
+ * by different locks, preventing local contenders
+ * from queueing in the wrong per-NUMA queue
+ *
+ * @see set_bucket
+ * @see numa_xchg_tail
+ */
+struct lock_metadata {
+	atomic_t seq_counter;
+	struct qspinlock *lock_ptr;
+
+	/* NUMA-queues of contenders ae kept in FIFO order */
+	union {
+		u32 nodes_tail;
+		struct {
+			u16 tail_node;
+			u16 head_node;
+		};
+	};
+};
+
+static inline int decode_lock_mode(u32 lock_val)
+{
+	return (lock_val & _Q_LOCK_MODE_MASK) >> _Q_LOCK_MODE_OFFSET;
+}
+
+static inline u32 encode_lock_mode(u16 lock_id)
+{
+	if (lock_id == LOCK_ID_NONE)
+		return LOCK_MODE_QSPINLOCK << _Q_LOCK_MODE_OFFSET;
+
+	return LOCK_MODE_HQLOCK << _Q_LOCK_MODE_OFFSET;
+}
+
+static inline u64 encode_tc(u32 tail, u32 counter)
+{
+	u64 __tail = (u64)tail;
+	u64 __counter = (u64)counter;
+
+	return __tail | (__counter << 32);
+}
+
+static inline u32 decode_tc_tail(u64 tail_counter)
+{
+	return (u32)(tail_counter & _QUEUE_TAIL_MASK);
+}
+
+static inline u32 decode_tc_counter(u64 tail_counter)
+{
+	return (u32)((tail_counter & _QUEUE_SEQ_COUNTER_MASK) >> 32);
+}
-- 
2.34.1

