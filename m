From: Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/4] locking/qspinlock: Handle > 4 slowpath nesting levels
Date: Tue, 22 Jan 2019 22:49:08 -0500
Message-ID: <1548215351-18896-2-git-send-email-longman@redhat.com>
References: <1548215351-18896-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548215351-18896-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>, James Morse <james.morse@arm.com>, SRINIVAS <srinivas.eeda@oracle.com>, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

Four queue nodes per cpu are allocated to enable up to 4 nesting levels
using the per-cpu nodes. Nested NMIs are possible in some architectures.
Still it is very unlikely that we will ever hit more than 4 nested
levels with contention in the slowpath.

When that rare condition happens, however, it is likely that the system
will hang or crash shortly after that. It is not good and we need to
handle this exception case.

This is done by spinning directly on the lock using repeated trylock.
This alternative code path should only be used when there is nested
NMIs. Assuming that the locks used by those NMI handlers will not be
heavily contended, a simple TAS locking should work out.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 8a8c3c2..0875053 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -412,6 +412,21 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
 
+	/*
+	 * 4 nodes are allocated based on the assumption that there will
+	 * not be nested NMIs taking spinlocks. That may not be true in
+	 * some architectures even though the chance of needing more than
+	 * 4 nodes will still be extremely unlikely. When that happens,
+	 * we fall back to spinning on the lock directly without using
+	 * any MCS node. This is not the most elegant solution, but is
+	 * simple enough.
+	 */
+	if (unlikely(idx >= MAX_NODES)) {
+		while (!queued_spin_trylock(lock))
+			cpu_relax();
+		goto release;
+	}
+
 	node = grab_mcs_node(node, idx);
 
 	/*
-- 
1.8.3.1
