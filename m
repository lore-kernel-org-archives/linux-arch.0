Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:50529 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756722AbaDKK0M (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Apr 2014 06:26:12 -0400
Received: by mail-ee0-f41.google.com with SMTP id t10so4013672eei.28
        for <linux-arch@vger.kernel.org>; Fri, 11 Apr 2014 03:26:11 -0700 (PDT)
From: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 03/15] arm: add renameat2 syscall
Date: Fri, 11 Apr 2014 12:25:39 +0200
Message-ID: <1397211951-20549-4-git-send-email-miklos@szeredi.hu>
In-Reply-To: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@suse.cz>, Russell King <linux@arm.linux.org.uk>
Message-ID: <20140411102539.uNru82ACY_rMFM4I6q4kA5kaF7Bbnc_ZO6-SqQK4OnY@z>

From: Miklos Szeredi <mszeredi@suse.cz>

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/include/asm/unistd.h      | 2 +-
 arch/arm/include/uapi/asm/unistd.h | 1 +
 arch/arm/kernel/calls.S            | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index c4cd2060cac2..fbda7a3e5abe 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -15,7 +15,7 @@
 
 #include <uapi/asm/unistd.h>
 
-#define __NR_syscalls  (382)
+#define __NR_syscalls  (383)
 #define __ARM_NR_cmpxchg		(__ARM_NR_BASE+0x00fff0)
 
 #define __ARCH_WANT_STAT64
diff --git a/arch/arm/include/uapi/asm/unistd.h b/arch/arm/include/uapi/asm/unistd.h
index fb5584d0cc05..ba94446c72d9 100644
--- a/arch/arm/include/uapi/asm/unistd.h
+++ b/arch/arm/include/uapi/asm/unistd.h
@@ -408,6 +408,7 @@
 #define __NR_finit_module		(__NR_SYSCALL_BASE+379)
 #define __NR_sched_setattr		(__NR_SYSCALL_BASE+380)
 #define __NR_sched_getattr		(__NR_SYSCALL_BASE+381)
+#define __NR_renameat2			(__NR_SYSCALL_BASE+382)
 
 /*
  * This may need to be greater than __NR_last_syscall+1 in order to
diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
index 166e945de832..8f51bdcdacbb 100644
--- a/arch/arm/kernel/calls.S
+++ b/arch/arm/kernel/calls.S
@@ -391,6 +391,7 @@
 		CALL(sys_finit_module)
 /* 380 */	CALL(sys_sched_setattr)
 		CALL(sys_sched_getattr)
+		CALL(sys_renameat2)
 #ifndef syscalls_counted
 .equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
 #define syscalls_counted
-- 
1.8.1.4

