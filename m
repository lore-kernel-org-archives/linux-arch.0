Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:19094 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729880AbfDBJIm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Apr 2019 05:08:42 -0400
Message-ID: <a3ba0b0f56ffedb380be0a7856dcbe9382112bfb.1554195798.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554195798.git.christophe.leroy@c-s.fr>
References: <cover.1554195798.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 5/9] powerpc: convert to generic builtin command line
Date: Tue,  2 Apr 2019 09:08:39 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Message-ID: <20190402090839.ULUa66C6ZTv5DMEB891kOycc3rx6kBZwUCH6PcJywx0@z>

This updates the powerpc code to use the new cmdline building function.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/prom_init.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index d4889ba04ddd..08f3db25b2f1 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -30,6 +30,7 @@
 #include <linux/delay.h>
 #include <linux/initrd.h>
 #include <linux/bitops.h>
+#include <linux/cmdline.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
 #include <asm/page.h>
@@ -155,7 +156,7 @@ static struct prom_t __prombss prom;
 static unsigned long __prombss prom_entry;
 
 static char __prombss of_stdout_device[256];
-static char __prombss prom_scratch[256];
+static char __prombss prom_scratch[COMMAND_LINE_SIZE];
 
 static unsigned long __prombss dt_header_start;
 static unsigned long __prombss dt_struct_start, dt_struct_end;
@@ -627,18 +628,14 @@ static unsigned long prom_memparse(const char *ptr, const char **retptr)
 static void __init early_cmdline_parse(void)
 {
 	const char *opt;
+	int l = 0;
 
-	char *p;
-	int l __maybe_unused = 0;
-
-	prom_cmd_line[0] = 0;
-	p = prom_cmd_line;
 	if ((long)prom.chosen > 0)
-		l = prom_getprop(prom.chosen, "bootargs", p, COMMAND_LINE_SIZE-1);
-#ifdef CONFIG_CMDLINE
-	if (l <= 0 || p[0] == '\0' || IS_ENABLED(CONFIG_CMDLINE_EXTEND)) /* dbl check */
-		strlcat(prom_cmd_line, CONFIG_CMDLINE, sizeof(prom_cmd_line));
-#endif /* CONFIG_CMDLINE */
+		l = prom_getprop(prom.chosen, "bootargs", prom_scratch,
+				 COMMAND_LINE_SIZE - 1);
+
+	cmdline_build(prom_cmd_line, l > 0 ? prom_scratch : NULL, sizeof(prom_scratch));
+
 	prom_printf("command line: %s\n", prom_cmd_line);
 
 #ifdef CONFIG_PPC64
-- 
2.13.3
