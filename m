From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 10/17] xtensa: move init_mmu declaration to mmu_context.h
Date: Thu, 17 Oct 2013 02:42:21 +0400
Message-ID: <1381963348-29448-11-git-send-email-jcmvbkbc@gmail.com>
References: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:52902 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758828Ab3JPWnB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 18:43:01 -0400
Received: by mail-lb0-f182.google.com with SMTP id p9so1193402lbv.41
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 15:43:00 -0700 (PDT)
In-Reply-To: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Secondary CPUs need this declaration to initialize their MMUs.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/mmu_context.h | 6 ++++++
 arch/xtensa/kernel/setup.c            | 7 +------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/include/asm/mmu_context.h b/arch/xtensa/include/asm/mmu_context.h
index d43525a..86292c2 100644
--- a/arch/xtensa/include/asm/mmu_context.h
+++ b/arch/xtensa/include/asm/mmu_context.h
@@ -49,6 +49,12 @@ extern unsigned long asid_cache;
 #define ASID_MASK	((1 << XCHAL_MMU_ASID_BITS) - 1)
 #define ASID_INSERT(x)	(0x03020001 | (((x) & ASID_MASK) << 8))
 
+#ifdef CONFIG_MMU
+void init_mmu(void);
+#else
+static inline void init_mmu(void) { }
+#endif
+
 static inline void set_rasid_register (unsigned long val)
 {
 	__asm__ __volatile__ (" wsr %0, rasid\n\t"
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 00904b6..84b26ee 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -40,6 +40,7 @@
 #endif
 
 #include <asm/bootparam.h>
+#include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/timex.h>
@@ -88,12 +89,6 @@ static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
 
 sysmem_info_t __initdata sysmem;
 
-#ifdef CONFIG_MMU
-extern void init_mmu(void);
-#else
-static inline void init_mmu(void) { }
-#endif
-
 extern int mem_reserve(unsigned long, unsigned long, int);
 extern void bootmem_init(void);
 extern void zones_init(void);
-- 
1.8.1.4
