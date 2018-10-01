Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34620 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbeJATV3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Oct 2018 15:21:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so9154995pfi.1
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 05:43:50 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v2 1/3] microblaze: replace __NR_syscalls macro from asm/unistd.h
Date: Mon,  1 Oct 2018 18:13:02 +0530
Message-ID: <1538397784-4214-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1538397784-4214-1-git-send-email-firoz.khan@linaro.org>
References: <1538397784-4214-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <monstr@monstr.eu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20181001124302.3UcwwP3QE5QkI3CkfxAK9GsZcmO9_fekmWH636sNmQI@z>

__NR_syscalls macro holds the number of system call exist in this
architecture. This macro is currently the part of asm/unistd.h file.
We have change the value of __NR_syscalls, if we add or delete a
system call.

One of the patch in this patch series has a script which will
generate a uapi header based on syscall.tbl file. The syscall.tbl
file contains the number of system call information. So we have
two option to update __NR_syscalls value.

1. Update __NR_syscalls in asm/unistd.h manually by counting the
   no.of system calls. No need to update __NR_syscalls until
   we either add a new system call or delete an existing system
   call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update __NR_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I moved the
__NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. While
__NR_syscalls isn't strictly part of the uapi, having it as part
of the generated header to simplifies the implementation. We also
need to enclose this macro with #ifdef __KERNEL__ to avoid side
effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/microblaze/include/asm/unistd.h      | 2 --
 arch/microblaze/include/uapi/asm/unistd.h | 4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/include/asm/unistd.h b/arch/microblaze/include/asm/unistd.h
index a62d094..e19550f 100644
--- a/arch/microblaze/include/asm/unistd.h
+++ b/arch/microblaze/include/asm/unistd.h
@@ -38,6 +38,4 @@
 
 #endif /* __ASSEMBLY__ */
 
-#define __NR_syscalls         401
-
 #endif /* _ASM_MICROBLAZE_UNISTD_H */
diff --git a/arch/microblaze/include/uapi/asm/unistd.h b/arch/microblaze/include/uapi/asm/unistd.h
index 7a9f16a..ed9c6f5 100644
--- a/arch/microblaze/include/uapi/asm/unistd.h
+++ b/arch/microblaze/include/uapi/asm/unistd.h
@@ -418,4 +418,8 @@
 #define __NR_io_pgetevents	399
 #define __NR_rseq		400
 
+#ifdef __KERNEL__
+#define __NR_syscalls         401
+#endif
+
 #endif /* _UAPI_ASM_MICROBLAZE_UNISTD_H */
-- 
1.9.1
