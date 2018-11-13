From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v3 1/5] alpha: move __IGNORE* entries to non uapi header
Date: Tue, 13 Nov 2018 15:01:49 +0530
Message-ID: <1542101513-22010-2-git-send-email-firoz.khan@linaro.org>
References: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
List-Id: linux-arch.vger.kernel.org

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
index 9ff37aa..4f0ceb3 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -19,4 +19,25 @@
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
