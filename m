Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40509 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731737AbeKMT3x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Nov 2018 14:29:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22-v6so270570pls.7
        for <linux-arch@vger.kernel.org>; Tue, 13 Nov 2018 01:32:39 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v3 3/5] alpha: add __NR_syscalls along with NR_SYSCALLS
Date: Tue, 13 Nov 2018 15:01:51 +0530
Message-ID: <1542101513-22010-4-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
References: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20181113093151.H1uM7lI5Lm6bWuC8HJo8n5hmK3qhPmBuS5m5pj0qe2Y@z>

NR_SYSCALLS macro holds the number of system call exist
in alpha architecture. We have to change the value of NR-
_SYSCALLS, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the total number of system
calls information. So we have two option to update NR_SY-
CALLS value.

1. Update NR_SYSCALLS in asm/unistd.h manually by count-
   ing the no.of system calls. No need to update NR_SYS-
   CALLS until we either add a new system call or delete
   existing system call.

2. We can keep this feature it above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update NR_SYSCALLS in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
added the __NR_syscalls macro in uapi/asm/unistd.h along
with NR_SYSCALLS asm/unistd.h. The macro __NR_syscalls
also added for making the name convention same across all
architecture. While __NR_syscalls isn't strictly part of
the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/alpha/include/asm/unistd.h      | 2 +-
 arch/alpha/include/uapi/asm/unistd.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index 4f0ceb3..21b706a 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -4,7 +4,7 @@
 
 #include <uapi/asm/unistd.h>
 
-#define NR_SYSCALLS			523
+#define NR_SYSCALLS	__NR_syscalls
 
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
index 47c65f1..ab40aa6 100644
--- a/arch/alpha/include/uapi/asm/unistd.h
+++ b/arch/alpha/include/uapi/asm/unistd.h
@@ -465,4 +465,8 @@
 #define __NR_pwritev2			521
 #define __NR_statx			522
 
+#ifdef __KERNEL__
+#define __NR_syscalls			523
+#endif
+
 #endif /* _UAPI_ALPHA_UNISTD_H */
-- 
1.9.1
