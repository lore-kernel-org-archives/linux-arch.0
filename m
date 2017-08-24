From: Hoeun Ryu <hoeun.ryu@gmail.com>
Subject: [RFC 3/3] sched: depend on 64BIT_ATOMIC_ACCESS to determine if to use min_vruntime_copy
Date: Thu, 24 Aug 2017 14:42:57 +0900
Message-ID: <1503553377-3646-4-git-send-email-hoeun.ryu@gmail.com>
References: <1503553377-3646-1-git-send-email-hoeun.ryu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503553377-3646-1-git-send-email-hoeun.ryu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, Ingo Molnar <mingo@kernel.org>, Michal Marek <mmarek@suse.com>, Laura Abbott <labbott@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, mic@digikod.net, Russell King <linux@armlinux.org.uk>, Vladimir Murzin <vladimir.murzin@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jonathan Austin <jonathan.austin@arm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hoeun.ryu@gmail.com, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

 'min_vruntime_copy' is copied when 'min_vruntime' is updated for cfq_rq
and used to check if updating 'min_vruntime' is completed on reader side.
 Because 'min_vruntime' variable is 64bit, we need a mimic of seqlock to
check if the variable is not being updated on 32bit machines.

 On 64BIT_ATOMIC_ACCESS enabled machines, 64bit accesses are atomic even
though the machines are 32bit, so we can directly access 'min_vruntime'
on the architectures.

 Depend on CONFIG_64BIT_ATOMIC_ACCESS instead of CONFIG_64BIT to determine
whether 'min_vruntime_copy' variable is used for synchronization or not.
And align 'min_vruntime' by 8 if 64BIT_ATOMIC_ALIGNED_ACCESS is true
because 64BIT_ATOMIC_ALIGNED_ACCESS enabled system can access the variable
atomically only when it' aligned.

Signed-off-by: Hoeun Ryu <hoeun.ryu@gmail.com>
---
 kernel/sched/fair.c  | 6 +++---
 kernel/sched/sched.h | 6 +++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c95880e..840658f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -536,7 +536,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 
 	/* ensure we never gain time by being placed backwards. */
 	cfs_rq->min_vruntime = max_vruntime(cfs_rq->min_vruntime, vruntime);
-#ifndef CONFIG_64BIT
+#ifndef CONFIG_64BIT_ATOMIC_ACCESS
 	smp_wmb();
 	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
 #endif
@@ -5975,7 +5975,7 @@ static void migrate_task_rq_fair(struct task_struct *p)
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 		u64 min_vruntime;
 
-#ifndef CONFIG_64BIT
+#ifndef CONFIG_64BIT_ATOMIC_ACCESS
 		u64 min_vruntime_copy;
 
 		do {
@@ -9173,7 +9173,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT;
 	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
-#ifndef CONFIG_64BIT
+#ifndef CONFIG_64BIT_ATOMIC_ACCESS
 	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
 #endif
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index eeef1a3..870010b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -421,8 +421,12 @@ struct cfs_rq {
 	unsigned int nr_running, h_nr_running;
 
 	u64 exec_clock;
+#ifndef CONFIG_64BIT_ATOMIC_ALIGNED_ACCESS
 	u64 min_vruntime;
-#ifndef CONFIG_64BIT
+#else
+	u64 min_vruntime __attribute__((aligned(sizeof(u64))));
+#endif
+#ifndef CONFIG_64BIT_ATOMIC_ACCESS
 	u64 min_vruntime_copy;
 #endif
 
-- 
2.7.4
