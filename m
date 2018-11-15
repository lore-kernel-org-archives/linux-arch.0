Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43197 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbeKOQVe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Nov 2018 11:21:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id g59-v6so8967565plb.10
        for <linux-arch@vger.kernel.org>; Wed, 14 Nov 2018 22:15:06 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v2 3/5] mips: remove syscall table entries
Date: Thu, 15 Nov 2018 11:44:19 +0530
Message-ID: <1542262461-29024-4-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20181115061419.gEr5lV-GJgCf8JKQiuktuw8jN6nIL7lvAh0_Wbot104@z>

The config flag - CONFIG_MIPS_MT_FPAFF uses to check whether which
syscall entries need to be used in scall32-o32.S file.

One of the patch in this patch series will generate syscall table
file. But CONFIG_MIPS_MT_FPAFF flag will add more complexity in the
script to generate the syscall table file.

In order to come up with a common implementation across all archit-
ecture, we need to remove mipsmt_sys_sched_setaffinity and mipsmt-
_sys_sched_getaffinity from the table and define it in other way.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/kernel/scall32-o32.S | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index a9b895f..4eee437 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -208,6 +208,18 @@ einval: li	v0, -ENOSYS
 	jr	ra
 	END(sys_syscall)
 
+#ifdef CONFIG_MIPS_MT_FPAFF
+	/*
+	 * For FPU affinity scheduling on MIPS MT processors, we need to
+	 * intercept sys_sched_xxxaffinity() calls until we get a proper hook
+	 * in kernel/sched/core.c.  Considered only temporary we only support
+	 * these hooks for the 32-bit kernel - there is no MIPS64 MT processor
+	 * atm.
+	 */
+#define mipsmt_sys_sched_setaffinity sys_sched_setaffinity
+#define mipsmt_sys_sched_getaffinity sys_sched_getaffinity
+#endif /* CONFIG_MIPS_MT_FPAFF */
+
 	.align	2
 	.type	sys_call_table, @object
 EXPORT(sys_call_table)
@@ -450,20 +462,8 @@ EXPORT(sys_call_table)
 	PTR	sys_tkill
 	PTR	sys_sendfile64
 	PTR	sys_futex
-#ifdef CONFIG_MIPS_MT_FPAFF
-	/*
-	 * For FPU affinity scheduling on MIPS MT processors, we need to
-	 * intercept sys_sched_xxxaffinity() calls until we get a proper hook
-	 * in kernel/sched/core.c.  Considered only temporary we only support
-	 * these hooks for the 32-bit kernel - there is no MIPS64 MT processor
-	 * atm.
-	 */
-	PTR	mipsmt_sys_sched_setaffinity
-	PTR	mipsmt_sys_sched_getaffinity
-#else
 	PTR	sys_sched_setaffinity
 	PTR	sys_sched_getaffinity		/* 4240 */
-#endif /* CONFIG_MIPS_MT_FPAFF */
 	PTR	sys_io_setup
 	PTR	sys_io_destroy
 	PTR	sys_io_getevents
-- 
1.9.1
