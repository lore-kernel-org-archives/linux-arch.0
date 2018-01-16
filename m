From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 21/22] signal: Remove the code to clear siginfo before calling copy_siginfo_from_user32
Date: Mon, 15 Jan 2018 18:40:08 -0600
Message-ID: <20180116004009.31036-21-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

The new unified copy_siginfo_from_user32 takes care of this.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 1 -
 kernel/signal.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 84b1367935e4..ec4365da9be8 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1226,7 +1226,6 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
 		break;
 
 	case PTRACE_SETSIGINFO:
-		memset(&siginfo, 0, sizeof siginfo);
 		if (copy_siginfo_from_user32(
 			    &siginfo, (struct compat_siginfo __user *) datap))
 			ret = -EFAULT;
diff --git a/kernel/signal.c b/kernel/signal.c
index 5211b1b57163..bebe44265b8b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3155,7 +3155,7 @@ COMPAT_SYSCALL_DEFINE3(rt_sigqueueinfo,
 			int, sig,
 			struct compat_siginfo __user *, uinfo)
 {
-	siginfo_t info = {};
+	siginfo_t info;
 	int ret = copy_siginfo_from_user32(&info, uinfo);
 	if (unlikely(ret))
 		return ret;
@@ -3199,7 +3199,7 @@ COMPAT_SYSCALL_DEFINE4(rt_tgsigqueueinfo,
 			int, sig,
 			struct compat_siginfo __user *, uinfo)
 {
-	siginfo_t info = {};
+	siginfo_t info;
 
 	if (copy_siginfo_from_user32(&info, uinfo))
 		return -EFAULT;
-- 
2.14.1
