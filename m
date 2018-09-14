Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33383 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeINNkw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Sep 2018 09:40:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id b30-v6so3882486pla.0
        for <linux-arch@vger.kernel.org>; Fri, 14 Sep 2018 01:27:30 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 2/4] parisc: Replace __NR_Linux_syscalls macro with __NR_syscalls
Date: Fri, 14 Sep 2018 13:56:41 +0530
Message-ID: <1536913603-4584-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536913603-4584-1-git-send-email-firoz.khan@linaro.org>
References: <1536913603-4584-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thibaut Varene <T-Bone@parisc-linux.org>, linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20180914082641.jf-iXO_jKSJp1Ll1Mj-Qq9jJBicJrIXUc7JbuVfvO2E@z>

__NR_Linux_syscalls macro holds the number of system call exist in
PARISC architecture. This macro is currently the part of uapi/asm/
unistd.h file. We have to change the value of __NR_Linux_syscalls,
if we add or delete a system call.

One of the patch in this patch series has a script which will generate
a uapi header based on syscall.tbl file. The syscall.tbl file contains
the number of system call information. So we have two option to update
__NR_Linux_syscalls value.

1. Update __NR_Linux_syscalls in uapi/asm/unistd.h manually by counting
   the no.of system calls. No need to update NR_syscalls until we
   either add a new system call or delete an existing system call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update __NR_Linux_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I moved the
__NR_Linux_syscalls macro from uapi/asm/unistd.h to asm/unistd.h. The
macro name also changed form __NR_Linux_syscalls to __NR_syscalls for
making the name convention same across all architecture. While __NR_
syscalls isn't strictly part of the uapi, having it as part of the
generated header to simplifies the implementation.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/include/asm/unistd.h      | 2 ++
 arch/parisc/include/uapi/asm/unistd.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index fc71edf..71417c1 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -8,6 +8,8 @@
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
 
+#define __NR_Linux_syscalls __NR_syscalls
+
 #ifndef ASM_LINE_SEP
 # define ASM_LINE_SEP ;
 #endif
diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
index bb52e12..7532817 100644
--- a/arch/parisc/include/uapi/asm/unistd.h
+++ b/arch/parisc/include/uapi/asm/unistd.h
@@ -366,7 +366,7 @@
 #define __NR_statx		(__NR_Linux + 349)
 #define __NR_io_pgetevents	(__NR_Linux + 350)
 
-#define __NR_Linux_syscalls	(__NR_io_pgetevents + 1)
+#define __NR_syscalls           (__NR_Linux + 351)
 
 #define LINUX_GATEWAY_ADDR      0x100
 
-- 
1.9.1
