Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:60823 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeIYX2s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Sep 2018 19:28:48 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 25 Sep 2018 19:19:04 +0200
Message-ID: <20180925171906.19683-4-ebiederm@xmission.com>
In-Reply-To: <87h8idv6nw.fsf@xmission.com>
References: <87h8idv6nw.fsf@xmission.com>
Subject: [REVIEW][PATCH 4/6] signal: Introduce copy_siginfo_from_user and use it's return value
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, linux-arch@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180925171904.uRVzyEE7XshTJkmxd963wHx0I3ZJT_Mxn-PjpkWRtRU@z>

In preparation for using a smaller version of siginfo in the kernel
introduce copy_siginfo_from_user and use it when siginfo is copied from
userspace.

Make the pattern for using copy_siginfo_from_user and
copy_siginfo_from_user32 to capture the return value and return that
value on error.

This is a necessary prerequisite for using a smaller siginfo
in the kernel than the kernel exports to userspace.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/signal.h |  1 +
 kernel/ptrace.c        | 12 +++++-------
 kernel/signal.c        | 25 ++++++++++++++++---------
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index 3d4cd5db30a9..de94c159bfb0 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -22,6 +22,7 @@ static inline void clear_siginfo(struct siginfo *info)
 }
 
 int copy_siginfo_to_user(struct siginfo __user *to, const struct siginfo *from);
+int copy_siginfo_from_user(struct siginfo *to, const struct siginfo __user *from);
 
 enum siginfo_layout {
 	SIL_KILL,
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 45f77a1b9c97..a807ff5cc1a9 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -919,9 +919,8 @@ int ptrace_request(struct task_struct *child, long request,
 		break;
 
 	case PTRACE_SETSIGINFO:
-		if (copy_from_user(&siginfo, datavp, sizeof siginfo))
-			ret = -EFAULT;
-		else
+		ret = copy_siginfo_from_user(&siginfo, datavp);
+		if (!ret)
 			ret = ptrace_setsiginfo(child, &siginfo);
 		break;
 
@@ -1215,10 +1214,9 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
 		break;
 
 	case PTRACE_SETSIGINFO:
-		if (copy_siginfo_from_user32(
-			    &siginfo, (struct compat_siginfo __user *) datap))
-			ret = -EFAULT;
-		else
+		ret = copy_siginfo_from_user32(
+			&siginfo, (struct compat_siginfo __user *) datap);
+		if (!ret)
 			ret = ptrace_setsiginfo(child, &siginfo);
 		break;
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
diff --git a/kernel/signal.c b/kernel/signal.c
index debb485a76db..c0e289e62d77 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2896,6 +2896,13 @@ int copy_siginfo_to_user(siginfo_t __user *to, const siginfo_t *from)
 	return 0;
 }
 
+int copy_siginfo_from_user(siginfo_t *to, const siginfo_t __user *from)
+{
+	if (copy_from_user(to, from, sizeof(struct siginfo)))
+		return -EFAULT;
+	return 0;
+}
+
 #ifdef CONFIG_COMPAT
 int copy_siginfo_to_user32(struct compat_siginfo __user *to,
 			   const struct siginfo *from)
@@ -3323,8 +3330,9 @@ SYSCALL_DEFINE3(rt_sigqueueinfo, pid_t, pid, int, sig,
 		siginfo_t __user *, uinfo)
 {
 	siginfo_t info;
-	if (copy_from_user(&info, uinfo, sizeof(siginfo_t)))
-		return -EFAULT;
+	int ret = copy_siginfo_from_user(&info, uinfo);
+	if (unlikely(ret))
+		return ret;
 	return do_rt_sigqueueinfo(pid, sig, &info);
 }
 
@@ -3365,10 +3373,9 @@ SYSCALL_DEFINE4(rt_tgsigqueueinfo, pid_t, tgid, pid_t, pid, int, sig,
 		siginfo_t __user *, uinfo)
 {
 	siginfo_t info;
-
-	if (copy_from_user(&info, uinfo, sizeof(siginfo_t)))
-		return -EFAULT;
-
+	int ret = copy_siginfo_from_user(&info, uinfo);
+	if (unlikely(ret))
+		return ret;
 	return do_rt_tgsigqueueinfo(tgid, pid, sig, &info);
 }
 
@@ -3380,9 +3387,9 @@ COMPAT_SYSCALL_DEFINE4(rt_tgsigqueueinfo,
 			struct compat_siginfo __user *, uinfo)
 {
 	siginfo_t info;
-
-	if (copy_siginfo_from_user32(&info, uinfo))
-		return -EFAULT;
+	int ret = copy_siginfo_from_user32(&info, uinfo);
+	if (unlikely(ret))
+		return ret;
 	return do_rt_tgsigqueueinfo(tgid, pid, sig, &info);
 }
 #endif
-- 
2.17.1
