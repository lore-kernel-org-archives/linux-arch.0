Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38053 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeK2TtF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Nov 2018 14:49:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so675666pfi.5
        for <linux-arch@vger.kernel.org>; Thu, 29 Nov 2018 00:44:28 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v3 2/6] mips: remove unused macros
Date: Thu, 29 Nov 2018 14:13:32 +0530
Message-ID: <1543481016-18500-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20181129084332.dO_BQOwUNt4I53OFcnuC50azqLYgNJk-6QZKjNtaa1g@z>

Remove NR_syscalls from asm/unistd.h as there is no
users to use NR_syscalls macro in mips kernel.

MAX_SYSCALL_NO can also remove as there is commit
2957c9e61ee9 ("[MIPS] IRIX: Goodbye and thanks for
all the fish"), eight years ago.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/include/asm/unistd.h | 8 --------
 arch/mips/kernel/scall32-o32.S | 3 ---
 2 files changed, 11 deletions(-)

diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index c68b8ae..d7ee846 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -14,14 +14,6 @@
 
 #include <uapi/asm/unistd.h>
 
-#ifdef CONFIG_MIPS32_N32
-#define NR_syscalls  (__NR_N32_Linux + __NR_N32_Linux_syscalls)
-#elif defined(CONFIG_64BIT)
-#define NR_syscalls  (__NR_64_Linux + __NR_64_Linux_syscalls)
-#else
-#define NR_syscalls  (__NR_O32_Linux + __NR_O32_Linux_syscalls)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #define __ARCH_WANT_NEW_STAT
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 91d3c8c..fea6edb 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -22,9 +22,6 @@
 #include <asm/war.h>
 #include <asm/asm-offsets.h>
 
-/* Highest syscall used of any syscall flavour */
-#define MAX_SYSCALL_NO	__NR_O32_Linux + __NR_O32_Linux_syscalls
-
 	.align	5
 NESTED(handle_sys, PT_SIZE, sp)
 	.set	noat
-- 
1.9.1
