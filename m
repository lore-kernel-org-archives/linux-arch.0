From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 4/4] xtensa: switch to generic sys_execve()
Date: Mon, 29 Oct 2012 18:56:21 +0400
Message-ID: <1351522581-30516-5-git-send-email-jcmvbkbc@gmail.com>
References: <1351522581-30516-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59288 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254Ab2J2O5L (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2012 10:57:11 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so3112446lbo.19
        for <linux-arch@vger.kernel.org>; Mon, 29 Oct 2012 07:57:10 -0700 (PDT)
In-Reply-To: <1351522581-30516-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>, Max Filippov <jcmvbkbc@gmail.com>

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/syscall.h     |    2 +-
 arch/xtensa/include/asm/unistd.h      |    1 +
 arch/xtensa/include/uapi/asm/unistd.h |    2 +-
 arch/xtensa/kernel/process.c          |   25 -------------------------
 4 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/arch/xtensa/include/asm/syscall.h b/arch/xtensa/include/asm/syscall.h
index c1dacca..124aeee 100644
--- a/arch/xtensa/include/asm/syscall.h
+++ b/arch/xtensa/include/asm/syscall.h
@@ -10,7 +10,7 @@
 
 struct pt_regs;
 struct sigaction;
-asmlinkage long xtensa_execve(char*, char**, char**, struct pt_regs*);
+asmlinkage long sys_execve(char*, char**, char**, struct pt_regs*);
 asmlinkage long xtensa_clone(unsigned long, unsigned long, struct pt_regs*);
 asmlinkage long xtensa_ptrace(long, long, long, long);
 asmlinkage long xtensa_sigreturn(struct pt_regs*);
diff --git a/arch/xtensa/include/asm/unistd.h b/arch/xtensa/include/asm/unistd.h
index d9fa52d..f4e6eaa 100644
--- a/arch/xtensa/include/asm/unistd.h
+++ b/arch/xtensa/include/asm/unistd.h
@@ -1,6 +1,7 @@
 #ifndef _XTENSA_UNISTD_H
 #define _XTENSA_UNISTD_H
 
+#define __ARCH_WANT_SYS_EXECVE
 #include <uapi/asm/unistd.h>
 
 /*
diff --git a/arch/xtensa/include/uapi/asm/unistd.h b/arch/xtensa/include/uapi/asm/unistd.h
index 1fd157f..9f36d0e 100644
--- a/arch/xtensa/include/uapi/asm/unistd.h
+++ b/arch/xtensa/include/uapi/asm/unistd.h
@@ -262,7 +262,7 @@ __SYSCALL(115, sys_sendmmsg, 4)
 #define __NR_clone 				116
 __SYSCALL(116, xtensa_clone, 5)
 #define __NR_execve 				117
-__SYSCALL(117, xtensa_execve, 3)
+__SYSCALL(117, sys_execve, 3)
 #define __NR_exit 				118
 __SYSCALL(118, sys_exit, 1)
 #define __NR_exit_group 			119
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index be52fe4..09ae7bf 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -373,28 +373,3 @@ long xtensa_clone(unsigned long clone_flags, unsigned long newsp,
 {
         return do_fork(clone_flags, newsp, regs, 0, parent_tid, child_tid);
 }
-
-/*
- * xtensa_execve() executes a new program.
- */
-
-asmlinkage
-long xtensa_execve(const char __user *name,
-		   const char __user *const __user *argv,
-                   const char __user *const __user *envp,
-                   long a3, long a4, long a5,
-                   struct pt_regs *regs)
-{
-	long error;
-	struct filename *filename;
-
-	filename = getname(name);
-	error = PTR_ERR(filename);
-	if (IS_ERR(filename))
-		goto out;
-	error = do_execve(filename->name, argv, envp, regs);
-	putname(filename);
-out:
-	return error;
-}
-
-- 
1.7.7.6
