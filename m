Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38499 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeGPKvl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Jul 2018 06:51:41 -0400
Received: by mail-pl0-f66.google.com with SMTP id b1-v6so15056955pls.5
        for <linux-arch@vger.kernel.org>; Mon, 16 Jul 2018 03:24:56 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 4/6] alpha: Replace NR_SYSCALLS macro from asm/unistd.h
Date: Mon, 16 Jul 2018 15:53:56 +0530
Message-ID: <1531736638-15294-5-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-alpha@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, Firoz Khan <firoz.khan@linaro.org>
Message-ID: <20180716102356.BJIXfsG23wQ9Es2kRZF8a0_qhAri2ZHTRwyczvEiREM@z>

Replace NR_SYSCALLS from asm/unistd.h and keep equivalent macro
__NR_syscalls in uapi/asm/unistd.h and this will make a unified
implementation across all the architecture and we can use a system
call generation script to generate __NR_syscalls.

While __NR_syscalls isn't strictly part of the uapi, having it as
part of the generated header to simplifies the implementation.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/alpha/include/asm/unistd.h      | 2 --
 arch/alpha/include/uapi/asm/unistd.h | 2 ++
 arch/alpha/kernel/entry.S            | 4 ++--
 arch/alpha/kernel/systbls.S          | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index 1d19087..92c3f2e 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -4,8 +4,6 @@
 
 #include <uapi/asm/unistd.h>
 
-#define NR_SYSCALLS			523
-
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
index 3bb6ac1..5d4b51e 100644
--- a/arch/alpha/include/uapi/asm/unistd.h
+++ b/arch/alpha/include/uapi/asm/unistd.h
@@ -481,4 +481,6 @@
 #define __NR_pwritev2			521
 #define __NR_statx			522
 
+#define __NR_syscalls                   523
+
 #endif /* _UAPI_ALPHA_UNISTD_H */
diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index c64806a..8f0d706 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -454,7 +454,7 @@ entSys:
 	SAVE_ALL
 	lda	$8, 0x3fff
 	bic	$sp, $8, $8
-	lda	$4, NR_SYSCALLS($31)
+	lda	$4, __NR_syscalls($31)
 	stq	$16, SP_OFF+24($sp)
 	lda	$5, sys_call_table
 	lda	$27, sys_ni_syscall
@@ -585,7 +585,7 @@ strace:
 	ldq	$21, 88($sp)
 
 	/* get the system call pointer.. */
-	lda	$1, NR_SYSCALLS($31)
+	lda	$1, __NR_syscalls($31)
 	lda	$2, sys_call_table
 	lda	$27, alpha_ni_syscall
 	cmpult	$0, $1, $1
diff --git a/arch/alpha/kernel/systbls.S b/arch/alpha/kernel/systbls.S
index 7ef6925..de79de3 100644
--- a/arch/alpha/kernel/systbls.S
+++ b/arch/alpha/kernel/systbls.S
@@ -544,6 +544,6 @@ sys_call_table:
 	.type sys_call_table, @object
 
 /* Remember to update everything, kids.  */
-.ifne (. - sys_call_table) - (NR_SYSCALLS * 8)
+.ifne (. - sys_call_table) - (__NR_syscalls * 8)
 .err
 .endif
-- 
2.7.4
