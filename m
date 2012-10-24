From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/3] xtensa: switch to generic kernel_execve()
Date: Wed, 24 Oct 2012 05:48:36 +0400
Message-ID: <1351043317-21631-3-git-send-email-jcmvbkbc@gmail.com>
References: <1351043317-21631-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61817 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694Ab2JXBtk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Oct 2012 21:49:40 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so765207lbo.19
        for <linux-arch@vger.kernel.org>; Tue, 23 Oct 2012 18:49:39 -0700 (PDT)
In-Reply-To: <1351043317-21631-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Marc Gauthier <marc@tensilica.com>, Al Viro <viro@zeniv.linux.org.uk>, Max Filippov <jcmvbkbc@gmail.com>

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig        |    1 +
 arch/xtensa/kernel/entry.S |   18 +-----------------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 9525b70..0d1f36a 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -14,6 +14,7 @@ config XTENSA
 	select MODULES_USE_ELF_RELA
 	select GENERIC_PCI_IOMAP
 	select GENERIC_KERNEL_THREAD
+	select GENERIC_KERNEL_EXECVE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	help
 	  Xtensa processors are 32-bit RISC machines designed by Tensilica
diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index d4ec138..90bfc1d 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -1833,22 +1833,6 @@ ENTRY(system_call)
 
 
 /*
- * Do a system call from kernel instead of calling sys_execve, so we end up
- * with proper pt_regs.
- *
- * int kernel_execve(const char *fname, char *const argv[], charg *const envp[])
- * a2                        a2               a3                  a4
- */
-
-ENTRY(kernel_execve)
-	entry	a1, 16
-	mov	a6, a2			# arg0 is in a6
-	movi	a2, __NR_execve
-	syscall
-
-	retw
-
-/*
  * Task switch.
  *
  * struct task*  _switch_to (struct task* prev, struct task* next)
@@ -1940,6 +1924,6 @@ ENTRY(ret_from_kernel_thread)
 	call4	schedule_tail
 	mov	a6, a3
 	callx4	a2
-	call4	do_exit
+	j	common_exception_return
 
 ENDPROC(ret_from_kernel_thread)
-- 
1.7.7.6
