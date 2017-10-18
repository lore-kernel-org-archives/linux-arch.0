From: Krzysztof Opasiak <k.opasiak@samsung.com>
Subject: [PATCH 3/4][PoC][RFC] Connect rlimit-events with process life cycle
Date: Wed, 18 Oct 2017 22:32:29 +0200
Message-ID: <20171018203230.29871-4-k.opasiak@samsung.com>
References: <20171018203230.29871-1-k.opasiak@samsung.com>
        <CGME20171018203337epcas2p22bc3a5ac063486c9c7906fe6e88277bb@epcas2p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20171018203230.29871-1-k.opasiak@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, k.lewandowsk@samsung.com, l.stelmach@samsung.com, p.szewczyk@samsung.com, b.zolnierkie@samsung.com, andrzej.p@samsung.com, kopasiak90@gmail.com, Krzysztof Opasiak <k.opasiak@samsung.com>
List-Id: linux-arch.vger.kernel.org

Add rlimit-events call to process lifecycle to ensure that
we get notified whenever process dies (to cleanup our watch
levels) or forks (to implement watch levels inheritance).

Signed-off-by: Krzysztof Opasiak <k.opasiak@samsung.com>
---
 kernel/exit.c |  4 ++++
 kernel/fork.c | 16 +++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 516acdb0e0ec..c7e435ac4428 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -62,6 +62,7 @@
 #include <linux/kcov.h>
 #include <linux/random.h>
 #include <linux/rcuwait.h>
+#include <linux/rlimit_noti.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -858,6 +859,9 @@ void __noreturn do_exit(long code)
 	if (group_dead)
 		tty_audit_exit();
 	audit_free(tsk);
+#ifdef CONFIG_RLIMIT_NOTIFICATION
+	rlimit_noti_task_exit(tsk);
+#endif
 
 	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
diff --git a/kernel/fork.c b/kernel/fork.c
index a98336d154b6..3d102b116688 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -98,6 +98,8 @@
 
 #include <trace/events/sched.h>
 
+#include <linux/rlimit_noti.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/task.h>
 
@@ -1395,9 +1397,21 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 #endif
 
 	task_lock(current->group_leader);
-	memcpy(sig->rlim, current->signal->rlim, sizeof sig->rlim);
+	memcpy(sig->rlim, current->signal->rlim, sizeof(sig->rlim));
 	task_unlock(current->group_leader);
 
+#ifdef CONFIG_RLIMIT_NOTIFICATION
+	{
+		int ret;
+
+		ret = rlimit_noti_task_fork(current->group_leader, tsk);
+		if (ret) {
+			kmem_cache_free(signal_cachep, sig);
+			return ret;
+		}
+	}
+#endif
+
 	posix_cpu_timers_init_group(sig);
 
 	tty_audit_fork(sig);
-- 
2.9.3
