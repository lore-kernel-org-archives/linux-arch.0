Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:53807 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbfFGVng (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 17:43:36 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
Date: Fri, 07 Jun 2019 16:43:21 -0500
In-Reply-To: <87k1dxaxcl.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Fri, 07 Jun 2019 16:39:54 -0500")
Message-ID: <87wohx9ime.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [RFC PATCH 4/5] signal: Remove saved_sigmask
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de, axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, omar.kilani@gmail.com, tglx@linutronix.de, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, David Laight <David.Laight@ACULAB.COM>, linux-arch@vger.kernel.org
Message-ID: <20190607214321.OOLJzdUUfPcLQNCjCAsfISPN7BoX9fvkPFyZ3q6B1nc@z>


We have real_sigmask that serves the same purpose and is always kept
uptodate.  Remove a field from the task structure and a conditional
from the signal delivery code by removing this field.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched.h        |  2 --
 include/linux/sched/signal.h |  9 +++------
 kernel/ptrace.c              | 12 ++----------
 kernel/signal.c              |  2 --
 4 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 11837410690f..520efbd355be 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -864,8 +864,6 @@ struct task_struct {
 	struct sighand_struct		*sighand;
 	sigset_t			blocked;
 	sigset_t			real_blocked;
-	/* Restored if set_restore_sigmask() was used: */
-	sigset_t			saved_sigmask;
 	struct sigpending		pending;
 	unsigned long			sas_ss_sp;
 	size_t				sas_ss_size;
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 97f6a6a35a81..78678de45278 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -407,7 +407,7 @@ void task_join_group_stop(struct task_struct *task);
  */
 
 /**
- * set_restore_sigmask() - make sure saved_sigmask processing gets done
+ * set_restore_sigmask() - make sure real_sigmask processing gets done
  *
  * This sets TIF_RESTORE_SIGMASK and ensures that the arch signal code
  * will run before returning to user mode, to process the flag.  For
@@ -479,7 +479,7 @@ static inline bool test_and_clear_restore_sigmask(void)
 static inline void restore_saved_sigmask(void)
 {
 	if (test_and_clear_restore_sigmask())
-		__set_current_blocked(&current->saved_sigmask);
+		__set_current_blocked(&current->real_blocked);
 }
 
 extern int set_user_sigmask(const sigset_t __user *umask, size_t sigsetsize);
@@ -494,10 +494,7 @@ static inline void restore_saved_sigmask_unless(bool interrupted)
 
 static inline sigset_t *sigmask_to_save(void)
 {
-	sigset_t *res = &current->blocked;
-	if (unlikely(test_restore_sigmask()))
-		res = &current->saved_sigmask;
-	return res;
+	return &current->real_blocked;
 }
 
 static inline int kill_cad_pid(int sig, int priv)
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 6507d700d70f..5ed6126e1cc5 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -925,26 +925,18 @@ int ptrace_request(struct task_struct *child, long request,
 			ret = ptrace_setsiginfo(child, &siginfo);
 		break;
 
-	case PTRACE_GETSIGMASK: {
-		sigset_t *mask;
-
+	case PTRACE_GETSIGMASK:
 		if (addr != sizeof(sigset_t)) {
 			ret = -EINVAL;
 			break;
 		}
 
-		if (test_tsk_restore_sigmask(child))
-			mask = &child->saved_sigmask;
-		else
-			mask = &child->blocked;
-
-		if (copy_to_user(datavp, mask, sizeof(sigset_t)))
+		if (copy_to_user(datavp, &child->real_blocked, sizeof(sigset_t)))
 			ret = -EFAULT;
 		else
 			ret = 0;
 
 		break;
-	}
 
 	case PTRACE_SETSIGMASK: {
 		sigset_t new_set;
diff --git a/kernel/signal.c b/kernel/signal.c
index fcd84f4a93c9..c37d4f209699 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2941,8 +2941,6 @@ EXPORT_SYMBOL(sigprocmask);
 static int set_sigmask(sigset_t *newset)
 {
 	set_restore_sigmask();
-	current->saved_sigmask = current->blocked;
-
 	sigdelsetmask(newset, sigmask(SIGKILL) | sigmask(SIGSTOP));
 	__set_current_blocked(newset);
 
-- 
2.21.0.dirty
