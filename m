From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 09/17] xtensa: call check_s32c1i after trap_init
Date: Thu, 17 Oct 2013 02:42:20 +0400
Message-ID: <1381963348-29448-10-git-send-email-jcmvbkbc@gmail.com>
References: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:51330 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761403Ab3JPWnA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 18:43:00 -0400
Received: by mail-la0-f48.google.com with SMTP id er20so1112882lab.21
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 15:42:58 -0700 (PDT)
In-Reply-To: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Otherwise exceptions may occur prior to exception handling mechanism
initialization, resulting in silently dead system.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/setup.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 946fb8d..00904b6 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -378,7 +378,8 @@ static inline int probed_compare_swap(int *v, int cmp, int set)
 
 /* Handle probed exception */
 
-void __init do_probed_exception(struct pt_regs *regs, unsigned long exccause)
+static void __init do_probed_exception(struct pt_regs *regs,
+		unsigned long exccause)
 {
 	if (regs->pc == rcw_probe_pc) {	/* exception on s32c1i ? */
 		regs->pc += 3;		/* skip the s32c1i instruction */
@@ -390,7 +391,7 @@ void __init do_probed_exception(struct pt_regs *regs, unsigned long exccause)
 
 /* Simple test of S32C1I (soc bringup assist) */
 
-void __init check_s32c1i(void)
+static int __init check_s32c1i(void)
 {
 	int n, cause1, cause2;
 	void *handbus, *handdata, *handaddr; /* temporarily saved handlers */
@@ -445,24 +446,21 @@ void __init check_s32c1i(void)
 	trap_set_handler(EXCCAUSE_LOAD_STORE_ERROR, handbus);
 	trap_set_handler(EXCCAUSE_LOAD_STORE_DATA_ERROR, handdata);
 	trap_set_handler(EXCCAUSE_LOAD_STORE_ADDR_ERROR, handaddr);
+	return 0;
 }
 
 #else /* XCHAL_HAVE_S32C1I */
 
 /* This condition should not occur with a commercially deployed processor.
    Display reminder for early engr test or demo chips / FPGA bitstreams */
-void __init check_s32c1i(void)
+static int __init check_s32c1i(void)
 {
 	pr_warn("Processor configuration lacks atomic compare-and-swap support!\n");
+	return 0;
 }
 
 #endif /* XCHAL_HAVE_S32C1I */
-#else /* CONFIG_S32C1I_SELFTEST */
-
-void __init check_s32c1i(void)
-{
-}
-
+early_initcall(check_s32c1i);
 #endif /* CONFIG_S32C1I_SELFTEST */
 
 
@@ -471,8 +469,6 @@ void __init setup_arch(char **cmdline_p)
 	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 
-	check_s32c1i();
-
 	/* Reserve some memory regions */
 
 #ifdef CONFIG_BLK_DEV_INITRD
-- 
1.8.1.4
