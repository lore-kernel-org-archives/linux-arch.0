From: Krzysztof Opasiak <k.opasiak@samsung.com>
Subject: [PATCH 1/4][PoC][RFC] sched: Allow to get() and put() signal struct
Date: Wed, 18 Oct 2017 22:32:27 +0200
Message-ID: <20171018203230.29871-2-k.opasiak@samsung.com>
References: <20171018203230.29871-1-k.opasiak@samsung.com>
        <CGME20171018203328epcas2p4bdcc3650d1c0f0add143488792243932@epcas2p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20171018203230.29871-1-k.opasiak@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, k.lewandowsk@samsung.com, l.stelmach@samsung.com, p.szewczyk@samsung.com, b.zolnierkie@samsung.com, andrzej.p@samsung.com, kopasiak90@gmail.com, Krzysztof Opasiak <k.opasiak@samsung.com>
List-Id: linux-arch.vger.kernel.org

Allow to get() and put() signal struct from different
parts of kernel core, not only from signal.c.

Signed-off-by: Krzysztof Opasiak <k.opasiak@samsung.com>
---
 include/linux/sched/signal.h | 13 +++++++++++++
 kernel/fork.c                |  9 ++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index c06d63b3a583..05cef037fbf2 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -609,4 +609,17 @@ static inline unsigned long rlimit_max(unsigned int limit)
 	return task_rlimit_max(current, limit);
 }
 
+void free_signal_struct(struct signal_struct *sig);
+
+static inline void put_signal_struct(struct signal_struct *sig)
+{
+	if (atomic_dec_and_test(&sig->sigcnt))
+		free_signal_struct(sig);
+}
+
+static inline void get_signal_struct(struct signal_struct *sig)
+{
+	atomic_inc(&sig->sigcnt);
+}
+
 #endif /* _LINUX_SCHED_SIGNAL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index e53770d2bf95..a98336d154b6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -390,7 +390,7 @@ void free_task(struct task_struct *tsk)
 }
 EXPORT_SYMBOL(free_task);
 
-static inline void free_signal_struct(struct signal_struct *sig)
+void free_signal_struct(struct signal_struct *sig)
 {
 	taskstats_tgid_free(sig);
 	sched_autogroup_exit(sig);
@@ -402,12 +402,7 @@ static inline void free_signal_struct(struct signal_struct *sig)
 		mmdrop_async(sig->oom_mm);
 	kmem_cache_free(signal_cachep, sig);
 }
-
-static inline void put_signal_struct(struct signal_struct *sig)
-{
-	if (atomic_dec_and_test(&sig->sigcnt))
-		free_signal_struct(sig);
-}
+EXPORT_SYMBOL_GPL(free_signal_struct);
 
 void __put_task_struct(struct task_struct *tsk)
 {
-- 
2.9.3
