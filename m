From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 002/109] kernel: use kernel_wait4() instead of sys_wait4()
Date: Thu, 29 Mar 2018 13:22:39 +0200
Message-ID: <20180329112426.23043-3-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "Luis R . Rodriguez" <mcgrof@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

All call sites of sys_wait4() set *rusage to NULL. Therefore, there is
no need for the copy_to_user() handling of *rusage, and we can use
kernel_wait4() directly.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 kernel/exit.c          | 2 +-
 kernel/pid_namespace.c | 6 +++---
 kernel/umh.c           | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 995453d9fb55..c3c7ac560114 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1691,7 +1691,7 @@ SYSCALL_DEFINE4(wait4, pid_t, upid, int __user *, stat_addr,
  */
 SYSCALL_DEFINE3(waitpid, pid_t, pid, int __user *, stat_addr, int, options)
 {
-	return sys_wait4(pid, stat_addr, options, NULL);
+	return kernel_wait4(pid, stat_addr, options, NULL);
 }
 
 #endif
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 0b53eef7d34b..93b57f026688 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -242,16 +242,16 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 
 	/*
 	 * Reap the EXIT_ZOMBIE children we had before we ignored SIGCHLD.
-	 * sys_wait4() will also block until our children traced from the
+	 * kernel_wait4() will also block until our children traced from the
 	 * parent namespace are detached and become EXIT_DEAD.
 	 */
 	do {
 		clear_thread_flag(TIF_SIGPENDING);
-		rc = sys_wait4(-1, NULL, __WALL, NULL);
+		rc = kernel_wait4(-1, NULL, __WALL, NULL);
 	} while (rc != -ECHILD);
 
 	/*
-	 * sys_wait4() above can't reap the EXIT_DEAD children but we do not
+	 * kernel_wait4() above can't reap the EXIT_DEAD children but we do not
 	 * really care, we could reparent them to the global init. We could
 	 * exit and reap ->child_reaper even if it is not the last thread in
 	 * this pid_ns, free_pid(pid_allocated == 0) calls proc_cleanup_work(),
diff --git a/kernel/umh.c b/kernel/umh.c
index 18e5fa4b0e71..f76b3ff876cf 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -118,7 +118,7 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
 {
 	pid_t pid;
 
-	/* If SIGCLD is ignored sys_wait4 won't populate the status. */
+	/* If SIGCLD is ignored kernel_wait4 won't populate the status. */
 	kernel_sigaction(SIGCHLD, SIG_DFL);
 	pid = kernel_thread(call_usermodehelper_exec_async, sub_info, SIGCHLD);
 	if (pid < 0) {
@@ -135,7 +135,7 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
 		 *
 		 * Thus the __user pointer cast is valid here.
 		 */
-		sys_wait4(pid, (int __user *)&ret, 0, NULL);
+		kernel_wait4(pid, (int __user *)&ret, 0, NULL);
 
 		/*
 		 * If ret is 0, either call_usermodehelper_exec_async failed and
-- 
2.16.3
