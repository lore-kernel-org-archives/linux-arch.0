From: Krzysztof Opasiak <k.opasiak@samsung.com>
Subject: [RFC PATCH v2 3/4] Connect rlimit-events with process life cycle
Date: Thu, 14 Dec 2017 23:00:11 +0100
Message-ID: <20171214220012.10103-4-k.opasiak@samsung.com>
References: <20171214220012.10103-1-k.opasiak@samsung.com>
        <CGME20171214220046epcas2p476226b86cbf0f6dc94666912bfd1cfbb@epcas2p4.samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <20171214220012.10103-1-k.opasiak@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, k.lewandowsk@samsung.com, l.stelmach@samsung.com, p.szewczyk@samsung.com, Krzysztof Opasiak <k.opasiak@samsung.com>
List-Id: linux-arch.vger.kernel.org

Add rlimit-events call to process lifecycle to ensure that
we get notified whenever process dies (to cleanup our watch
levels) or forks (to implement watch levels inheritance).

Signed-off-by: Krzysztof Opasiak <k.opasiak@samsung.com>
---
 kernel/exit.c |  3 +++
 kernel/fork.c | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index f6cad39f35df..d3b9e1b854a3 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -62,6 +62,7 @@
 #include <linux/random.h>
 #include <linux/rcuwait.h>
 #include <linux/compat.h>
+#include <linux/rlimit_noti.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -846,6 +847,8 @@ void __noreturn do_exit(long code)
 		tty_audit_exit();
 	audit_free(tsk);
 
+	rlimit_noti_task_exit(tsk);
+
 	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index e54684b63c08..77bbac0bdfe9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -100,6 +100,8 @@
 
 #include <trace/events/sched.h>
 
+#include <linux/rlimit_noti.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/task.h>
 
@@ -1389,6 +1391,7 @@ static inline void posix_cpu_timers_init_group(struct signal_struct *sig) { }
 static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 {
 	struct signal_struct *sig;
+	int ret;
 
 	if (clone_flags & CLONE_THREAD)
 		return 0;
@@ -1419,9 +1422,15 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 #endif
 
 	task_lock(current->group_leader);
-	memcpy(sig->rlim, current->signal->rlim, sizeof sig->rlim);
+	memcpy(sig->rlim, current->signal->rlim, sizeof(sig->rlim));
 	task_unlock(current->group_leader);
 
+	ret = rlimit_noti_task_fork(current->group_leader, tsk);
+	if (ret) {
+		kmem_cache_free(signal_cachep, sig);
+		return ret;
+	}
+
 	posix_cpu_timers_init_group(sig);
 
 	tty_audit_fork(sig);
-- 
2.9.3
