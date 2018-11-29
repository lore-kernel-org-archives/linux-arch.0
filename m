Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35992 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeK2Pbz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Nov 2018 10:31:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so384000pfc.3
        for <linux-arch@vger.kernel.org>; Wed, 28 Nov 2018 20:27:56 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v3 1/4] powerpc: add __NR_syscalls along with NR_syscalls
Date: Thu, 29 Nov 2018 09:56:48 +0530
Message-ID: <1543465611-17122-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1543465611-17122-1-git-send-email-firoz.khan@linaro.org>
References: <1543465611-17122-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Ram Pai <linuxram@us.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Breno Leitao <leitao@debian.org>, Boqun Feng <boqun.feng@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20181129042648._onlz4pIZtGgWRQ8gCAgDiT2ADxqlWtK1p9e9LAFRhM@z>

NR_syscalls macro holds the number of system call exist
in powerpc architecture. We have to change the value of
NR_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the number of system call
information. So we have two option to update NR_syscalls
value.

1. Update NR_syscalls in asm/unistd.h manually by count-
   ing the no.of system calls. No need to update NR_sys-
   calls until we either add a new system call or delete
   existing system call.

2. We can keep this feature in above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update NR_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
added the __NR_syscalls macro in uapi/asm/unistd.h along
with NR_syscalls asm/unistd.h. The macro __NR_syscalls
also added for making the name convention same across all
architecture. While __NR_syscalls isn't strictly part of
the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/powerpc/include/asm/unistd.h      | 3 +--
 arch/powerpc/include/uapi/asm/unistd.h | 5 ++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index b0de85b..a3c35e6 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -11,8 +11,7 @@
 
 #include <uapi/asm/unistd.h>
 
-
-#define NR_syscalls		389
+#define NR_syscalls	__NR_syscalls
 
 #define __NR__exit __NR_exit
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 985534d..7195868 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -10,7 +10,6 @@
 #ifndef _UAPI_ASM_POWERPC_UNISTD_H_
 #define _UAPI_ASM_POWERPC_UNISTD_H_
 
-
 #define __NR_restart_syscall	  0
 #define __NR_exit		  1
 #define __NR_fork		  2
@@ -401,4 +400,8 @@
 #define __NR_rseq		387
 #define __NR_io_pgetevents	388
 
+#ifdef __KERNEL__
+#define __NR_syscalls		389
+#endif
+
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
1.9.1
