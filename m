From: Krzysztof Opasiak <k.opasiak@samsung.com>
Subject: [RFC PATCH v2 1/4] sched: Allow to get() and put() signal struct
Date: Thu, 14 Dec 2017 23:00:09 +0100
Message-ID: <20171214220012.10103-2-k.opasiak@samsung.com>
References: <20171214220012.10103-1-k.opasiak@samsung.com>
        <CGME20171214220038epcas2p1542bea506839523d0c657907665c6036@epcas2p1.samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <20171214220012.10103-1-k.opasiak@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, k.lewandowsk@samsung.com, l.stelmach@samsung.com, p.szewczyk@samsung.com, Krzysztof Opasiak <k.opasiak@samsung.com>
List-Id: linux-arch.vger.kernel.org

Allow to get() and put() signal struct from different
parts of kernel core, not only from signal.c.

This is useful when you place inside signal struct additional
resources that has to be accessed after process dies.

Signed-off-by: Krzysztof Opasiak <k.opasiak@samsung.com>
---
 include/linux/sched/signal.h | 13 +++++++++++++
 kernel/fork.c                |  9 ++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0aa4548fb492..78c0c337c130 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -610,4 +610,17 @@ static inline unsigned long rlimit_max(unsigned int limit)
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
index 07cc743698d3..e54684b63c08 100644
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
