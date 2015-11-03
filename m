Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:38789 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964824AbbKCUXM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Nov 2015 15:23:12 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 11/28] lkl: basic kernel console support
Date: Tue,  3 Nov 2015 22:20:42 +0200
Message-ID: <1446582059-17355-12-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
Message-ID: <20151103202042.sZvANNaxge_VSa2I6Cf_1BTqSYUoiDfOTgLq8z_P1EI@z>

Write operations are deferred to the host print operation.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 arch/lkl/kernel/console.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 arch/lkl/kernel/console.c

diff --git a/arch/lkl/kernel/console.c b/arch/lkl/kernel/console.c
new file mode 100644
index 0000000..bd3a686
--- /dev/null
+++ b/arch/lkl/kernel/console.c
@@ -0,0 +1,41 @@
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <asm/host_ops.h>
+
+static void console_write(struct console *con, const char *str, unsigned len)
+{
+	if (lkl_ops->print)
+		lkl_ops->print(str, len);
+}
+
+#ifdef CONFIG_LKL_EARLY_CONSOLE
+static struct console lkl_boot_console = {
+	.name	= "lkl_boot_console",
+	.write	= console_write,
+	.flags	= CON_PRINTBUFFER | CON_BOOT,
+	.index	= -1,
+};
+
+int __init lkl_boot_console_init(void)
+{
+	register_console(&lkl_boot_console);
+	return 0;
+}
+early_initcall(lkl_boot_console_init);
+#endif
+
+static struct console lkl_console = {
+	.name	= "lkl_console",
+	.write	= console_write,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
+};
+
+int __init lkl_console_init(void)
+{
+	register_console(&lkl_console);
+	return 0;
+}
+core_initcall(lkl_console_init);
+
-- 
2.1.0

