Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44063 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbeKAWrT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2018 18:47:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so7296926plq.11
        for <linux-arch@vger.kernel.org>; Thu, 01 Nov 2018 06:44:17 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v2 1/5] alpha: move __IGNORE* entries to non uapi header
Date: Thu,  1 Nov 2018 19:13:33 +0530
Message-ID: <1541079817-3431-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1541079817-3431-1-git-send-email-firoz.khan@linaro.org>
References: <1541079817-3431-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20181101134333.PIJVAYKTT6DOJWxhe4slVUKHURyQLucQ7WFI8DA7f_Q@z>

All the __IGNORE* entries are resides in the uapi header
file move to non uapi header asm/unistd.h as it is not
used by any user space applications.

It is correct to keep __IGNORE* entry in non uapi header
asm/unistd.h while uapi/asm/unistd.h must hold information
only useful for user space applications.

One of the patch in this patch series will generate uapi
header file. The information which directly used by the
user space application must be present in uapi file.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/alpha/include/asm/unistd.h      | 21 +++++++++++++++++++++
 arch/alpha/include/uapi/asm/unistd.h | 21 ---------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index d6e29a1..cbd04d3 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -17,4 +17,25 @@
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
 
+/*
+ * Ignore legacy syscalls that we don't use.
+ */
+#define __IGNORE_alarm
+#define __IGNORE_creat
+#define __IGNORE_getegid
+#define __IGNORE_geteuid
+#define __IGNORE_getgid
+#define __IGNORE_getpid
+#define __IGNORE_getppid
+#define __IGNORE_getuid
+#define __IGNORE_pause
+#define __IGNORE_time
+#define __IGNORE_utime
+#define __IGNORE_umount2
+
+/* Alpha doesn't have protection keys. */
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+
 #endif /* _ALPHA_UNISTD_H */
diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
index e153ca6..47c65f1 100644
--- a/arch/alpha/include/uapi/asm/unistd.h
+++ b/arch/alpha/include/uapi/asm/unistd.h
@@ -241,22 +241,6 @@
 #define __NR_osf_fdatasync	261	/* not implemented */
 
 /*
- * Ignore legacy syscalls that we don't use.
- */
-#define __IGNORE_alarm
-#define __IGNORE_creat
-#define __IGNORE_getegid
-#define __IGNORE_geteuid
-#define __IGNORE_getgid
-#define __IGNORE_getpid
-#define __IGNORE_getppid
-#define __IGNORE_getuid
-#define __IGNORE_pause
-#define __IGNORE_time
-#define __IGNORE_utime
-#define __IGNORE_umount2
-
-/*
  * Linux-specific system calls begin at 300
  */
 #define __NR_bdflush		300
@@ -481,9 +465,4 @@
 #define __NR_pwritev2			521
 #define __NR_statx			522
 
-/* Alpha doesn't have protection keys. */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
-
 #endif /* _UAPI_ALPHA_UNISTD_H */
-- 
1.9.1
