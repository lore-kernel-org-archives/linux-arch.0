From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/9] drivers: of: use cmdline building function
Date: Tue,  2 Apr 2019 09:08:37 +0000 (UTC)
Message-ID: <a65e145d464451885f8d2570f7fca1e433155c13.1554195798.git.christophe.leroy@c-s.fr>
References: <cover.1554195798.git.christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1554195798.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This patch uses the new cmdline building function to
concatenate the of provided cmdline with built-in parts
based on compile-time options.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/of/fdt.c        | 23 ++++-------------------
 include/linux/cmdline.h |  2 +-
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4734223ab702..c6d941785b37 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -24,6 +24,7 @@
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
+#include <linux/cmdline.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -1090,26 +1091,10 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 
 	/* Retrieve command line */
 	p = of_get_flat_dt_prop(node, "bootargs", &l);
-	if (p != NULL && l > 0)
-		strlcpy(data, p, min((int)l, COMMAND_LINE_SIZE));
+	if (l <= 0)
+		p = NULL;
 
-	/*
-	 * CONFIG_CMDLINE is meant to be a default in case nothing else
-	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
-	 * is set in which case we override whatever was found earlier.
-	 */
-#ifdef CONFIG_CMDLINE
-#if defined(CONFIG_CMDLINE_EXTEND)
-	strlcat(data, " ", COMMAND_LINE_SIZE);
-	strlcat(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#elif defined(CONFIG_CMDLINE_FORCE)
-	strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#else
-	/* No arguments from boot loader, use kernel's  cmdl*/
-	if (!((char *)data)[0])
-		strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#endif
-#endif /* CONFIG_CMDLINE */
+	cmdline_build(data, p, COMMAND_LINE_SIZE);
 
 	pr_debug("Command line is: %s\n", (char*)data);
 
diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
index 8610ddf813ff..afcc00d7628d 100644
--- a/include/linux/cmdline.h
+++ b/include/linux/cmdline.h
@@ -10,7 +10,7 @@
  * @src: The starting string or NULL if there isn't one. Must not equal dest.
  * @length: the length of dest buffer.
  */
-static __always_inline void cmdline_build(char *dest, char *src, size_t length)
+static __always_inline void cmdline_build(char *dest, const char *src, size_t length)
 {
 	if (length <= 0)
 		return;
-- 
2.13.3
