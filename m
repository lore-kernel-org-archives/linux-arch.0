Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35455 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeINNwj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Sep 2018 09:52:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id 7-v6so4068759pgf.2
        for <linux-arch@vger.kernel.org>; Fri, 14 Sep 2018 01:39:12 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 1/3] mips: Add __NR_syscalls macro in uapi/asm/unistd.h
Date: Fri, 14 Sep 2018 14:08:32 +0530
Message-ID: <1536914314-5026-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>, linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20180914083832.cZa7s-HlqDXcX3oBTU5RCqHJ3byqF4urbWivTYWIP3U@z>

NR_syscalls macro holds the number of system call exist in MIPS
architecture. This macro is currently not a part of uapi/asm/unistd.h
file. The purpose of this macro is We have to change the value of
NR_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which will generate
a uapi header based on syscall.tbl file. The syscall.tbl file contains
the number of system call information. So we have two option to update
NR_syscalls value.

1. Update NR_syscalls in uapi/asm/unistd.h manually by counting the
   no.of system calls. No need to update NR_syscalls until we either
   add a new system call or delete an existing system call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update NR_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. While __NR_syscalls
isn't strictly part of the uapi, having it as part of the generated
header to simplifies the implementation.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/include/uapi/asm/unistd.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index f25dd1d..f8bab34 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -390,17 +390,17 @@
 #define __NR_statx			(__NR_Linux + 366)
 #define __NR_rseq			(__NR_Linux + 367)
 #define __NR_io_pgetevents		(__NR_Linux + 368)
-
+#define __NR_syscalls                   368
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		368
+#define __NR_Linux_syscalls             __NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		368
+#define __NR_O32_Linux_syscalls         __NR_syscalls
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -737,16 +737,17 @@
 #define __NR_statx			(__NR_Linux + 326)
 #define __NR_rseq			(__NR_Linux + 327)
 #define __NR_io_pgetevents		(__NR_Linux + 328)
+#define __NR_syscalls                   328
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		328
+#define __NR_Linux_syscalls		__NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		328
+#define __NR_64_Linux_syscalls		__NR_syscalls
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1087,15 +1088,16 @@
 #define __NR_statx			(__NR_Linux + 330)
 #define __NR_rseq			(__NR_Linux + 331)
 #define __NR_io_pgetevents		(__NR_Linux + 332)
+#define __NR_syscalls                   332
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		332
+#define __NR_Linux_syscalls		__NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		332
+#define __NR_N32_Linux_syscalls		__NR_syscalls
 
 #endif /* _UAPI_ASM_UNISTD_H */
-- 
1.9.1
