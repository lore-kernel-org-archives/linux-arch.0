Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:42434 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932537AbaDKK0Q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Apr 2014 06:26:16 -0400
Received: by mail-ee0-f54.google.com with SMTP id d49so4030631eek.27
        for <linux-arch@vger.kernel.org>; Fri, 11 Apr 2014 03:26:15 -0700 (PDT)
From: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 06/15] m68k: add renameat2 syscall
Date: Fri, 11 Apr 2014 12:25:42 +0200
Message-ID: <1397211951-20549-7-git-send-email-miklos@szeredi.hu>
In-Reply-To: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20140411102542.LVNLAi-lrxCK_nNAgpDNI2-57X6aWYww1lNx4dGFDo4@z>

From: Miklos Szeredi <mszeredi@suse.cz>

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/unistd.h      | 2 +-
 arch/m68k/include/uapi/asm/unistd.h | 1 +
 arch/m68k/kernel/syscalltable.S     | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/unistd.h b/arch/m68k/include/asm/unistd.h
index 9d38b73989eb..33afa56ad47a 100644
--- a/arch/m68k/include/asm/unistd.h
+++ b/arch/m68k/include/asm/unistd.h
@@ -4,7 +4,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define NR_syscalls		351
+#define NR_syscalls		352
 
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_OLD_STAT
diff --git a/arch/m68k/include/uapi/asm/unistd.h b/arch/m68k/include/uapi/asm/unistd.h
index b932dd470041..9cd82fbc7817 100644
--- a/arch/m68k/include/uapi/asm/unistd.h
+++ b/arch/m68k/include/uapi/asm/unistd.h
@@ -356,5 +356,6 @@
 #define __NR_finit_module	348
 #define __NR_sched_setattr	349
 #define __NR_sched_getattr	350
+#define __NR_renameat2		351
 
 #endif /* _UAPI_ASM_M68K_UNISTD_H_ */
diff --git a/arch/m68k/kernel/syscalltable.S b/arch/m68k/kernel/syscalltable.S
index b6223dc41d82..b63bb8845c4c 100644
--- a/arch/m68k/kernel/syscalltable.S
+++ b/arch/m68k/kernel/syscalltable.S
@@ -371,4 +371,5 @@ ENTRY(sys_call_table)
 	.long sys_finit_module
 	.long sys_sched_setattr
 	.long sys_sched_getattr		/* 350 */
+	.long sys_sched_renameat2
 
-- 
1.8.1.4

