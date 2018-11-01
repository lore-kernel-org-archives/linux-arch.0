Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44005 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbeKAW4t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2018 18:56:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id n10-v6so9054726pgv.10
        for <linux-arch@vger.kernel.org>; Thu, 01 Nov 2018 06:53:45 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v2 1/4] sparc: move __IGNORE* entries to non uapi header
Date: Thu,  1 Nov 2018 19:23:08 +0530
Message-ID: <1541080391-3890-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1541080391-3890-1-git-send-email-firoz.khan@linaro.org>
References: <1541080391-3890-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20181101135308.-zViVdreQ5ejh8qQ6bffL1vMG_sIP-m1-s1qsFzEBb8@z>

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
 arch/sparc/include/asm/unistd.h      | 16 ++++++++++++++++
 arch/sparc/include/uapi/asm/unistd.h | 16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index b2a6a95..6dfd752 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -45,4 +45,20 @@
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #endif
 
+#ifdef __32bit_syscall_numbers__
+/* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
+ * it never had the plain ones and there is no value to adding those
+ * old versions into the syscall table.
+ */
+#define __IGNORE_setresuid
+#define __IGNORE_getresuid
+#define __IGNORE_setresgid
+#define __IGNORE_getresgid
+#endif
+
+/* Sparc doesn't have protection keys. */
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+
 #endif /* _SPARC_UNISTD_H */
diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index 09acf0d..6e59037 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -433,20 +433,4 @@
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
 
-#ifdef __32bit_syscall_numbers__
-/* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
- * it never had the plain ones and there is no value to adding those
- * old versions into the syscall table.
- */
-#define __IGNORE_setresuid
-#define __IGNORE_getresuid
-#define __IGNORE_setresgid
-#define __IGNORE_getresgid
-#endif
-
-/* Sparc doesn't have protection keys. */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
-
 #endif /* _UAPI_SPARC_UNISTD_H */
-- 
1.9.1
