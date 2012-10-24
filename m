From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 3/3] xtensa: switch to generic sys_execve()
Date: Wed, 24 Oct 2012 05:48:37 +0400
Message-ID: <1351043317-21631-4-git-send-email-jcmvbkbc@gmail.com>
References: <1351043317-21631-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61817 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab2JXBty (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Oct 2012 21:49:54 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so765207lbo.19
        for <linux-arch@vger.kernel.org>; Tue, 23 Oct 2012 18:49:53 -0700 (PDT)
In-Reply-To: <1351043317-21631-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Marc Gauthier <marc@tensilica.com>, Al Viro <viro@zeniv.linux.org.uk>, Max Filippov <jcmvbkbc@gmail.com>

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
index 9ef1c31..e83e966 100644
--- a/arch/xtensa/include/asm/unistd.h
+++ b/arch/xtensa/include/asm/unistd.h
@@ -8,6 +8,7 @@
  * Copyright (C) 2001 - 2005 Tensilica Inc.
  */
 
+#define __ARCH_WANT_SYS_EXECVE
 #include <uapi/asm/unistd.h>
 
 
diff --git a/arch/xtensa/include/uapi/asm/unistd.h b/arch/xtensa/include/uapi/asm/unistd.h
index ac37eb4..c5d736f 100644
--- a/arch/xtensa/include/uapi/asm/unistd.h
+++ b/arch/xtensa/include/uapi/asm/unistd.h
@@ -269,7 +269,7 @@ __SYSCALL(115, sys_sendmmsg, 4)
 #define __NR_clone 				116
 __SYSCALL(116, xtensa_clone, 5)
 #define __NR_execve 				117
-__SYSCALL(117, xtensa_execve, 3)
+__SYSCALL(117, sys_execve, 3)
 #define __NR_exit 				118
 __SYSCALL(118, sys_exit, 1)
 #define __NR_exit_group 			119
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index fd538bb..58e50ff 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -350,28 +350,3 @@ long xtensa_clone(unsigned long clone_flags, unsigned long newsp,
                 newsp = regs->areg[1];
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
