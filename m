Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37945 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbeHIIA0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Aug 2018 04:00:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so2282549pfh.5
        for <linux-arch@vger.kernel.org>; Wed, 08 Aug 2018 22:37:22 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 1/3] sh: Rename NR_syscalls macro to __NR_syscalls
Date: Thu,  9 Aug 2018 11:06:43 +0530
Message-ID: <1533793005-4525-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1533793005-4525-1-git-send-email-firoz.khan@linaro.org>
References: <1533793005-4525-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20180809053643.eCuDpvUohWZgVG5GsGYV2spueDVwbWgq9n7qLAMZdkg@z>

NR_syscalls macro holds the number of system call exist in SH arch-
itecture. One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file. The syscall.tbl
file contains the total number of system call information, which will
be used to update NR_syscalls.

The macro name also changed form NR_syscalls to __NR_syscalls for
making the name convention same across all architecture. While
__NR_syscalls isn't strictly part of the uapi, having it as part of
the generated header to simplifies the implementation.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/sh/include/asm/ftrace.h         | 2 +-
 arch/sh/include/uapi/asm/unistd_32.h | 2 +-
 arch/sh/include/uapi/asm/unistd_64.h | 2 +-
 arch/sh/kernel/cpu/sh5/entry.S       | 2 +-
 arch/sh/kernel/entry-common.S        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/include/asm/ftrace.h b/arch/sh/include/asm/ftrace.h
index b1c1dc0..968a9bb 100644
--- a/arch/sh/include/asm/ftrace.h
+++ b/arch/sh/include/asm/ftrace.h
@@ -5,7 +5,7 @@
 #ifdef CONFIG_FUNCTION_TRACER
 
 #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
-#define FTRACE_SYSCALL_MAX	NR_syscalls
+#define FTRACE_SYSCALL_MAX	__NR_syscalls
 
 #ifndef __ASSEMBLY__
 extern void mcount(void);
diff --git a/arch/sh/include/uapi/asm/unistd_32.h b/arch/sh/include/uapi/asm/unistd_32.h
index 58f04cf..2c4f087 100644
--- a/arch/sh/include/uapi/asm/unistd_32.h
+++ b/arch/sh/include/uapi/asm/unistd_32.h
@@ -396,6 +396,6 @@
 #define __NR_preadv2		381
 #define __NR_pwritev2		382
 
-#define NR_syscalls 383
+#define __NR_syscalls 383
 
 #endif /* __ASM_SH_UNISTD_32_H */
diff --git a/arch/sh/include/uapi/asm/unistd_64.h b/arch/sh/include/uapi/asm/unistd_64.h
index 6f809a5..9e6e8cb 100644
--- a/arch/sh/include/uapi/asm/unistd_64.h
+++ b/arch/sh/include/uapi/asm/unistd_64.h
@@ -416,6 +416,6 @@
 #define __NR_preadv2		392
 #define __NR_pwritev2		393
 
-#define NR_syscalls 394
+#define __NR_syscalls 394
 
 #endif /* __ASM_SH_UNISTD_64_H */
diff --git a/arch/sh/kernel/cpu/sh5/entry.S b/arch/sh/kernel/cpu/sh5/entry.S
index 0c8d037..d2ff022 100644
--- a/arch/sh/kernel/cpu/sh5/entry.S
+++ b/arch/sh/kernel/cpu/sh5/entry.S
@@ -1192,7 +1192,7 @@ system_call:
 	STI()
 
 	pta	syscall_allowed, tr0
-	movi	NR_syscalls - 1, r4	/* Last valid */
+	movi	__NR_syscalls - 1, r4	/* Last valid */
 	bgeu/l	r4, r5, tr0
 
 syscall_bad:
diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
index 28cc612..80ea3c4 100644
--- a/arch/sh/kernel/entry-common.S
+++ b/arch/sh/kernel/entry-common.S
@@ -396,7 +396,7 @@ syscall_exit:
 #if !defined(CONFIG_CPU_SH2)
 1:	.long	TRA
 #endif
-2:	.long	NR_syscalls
+2:	.long	__NR_syscalls
 3:	.long	sys_call_table
 7:	.long	do_syscall_trace_enter
 8:	.long	do_syscall_trace_leave
-- 
1.9.1
