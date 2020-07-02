From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 13/21] um: nommu: basic console support
Date: Thu,  2 Jul 2020 23:07:07 +0900
Message-ID: <f7c7b19dcaef76f2c803df022fead27bba89fea0.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbgGBOJ1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:09:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E25C08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:09:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w2so12721043pgg.10
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:09:27 -0700 (PDT)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>

This commit also disables stdio-console of UM if !CONFIG_MMU to avoid
conflicts between multiple consoles.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/drivers/Makefile                  |  8 ++++-
 arch/um/nommu/include/uapi/asm/host_ops.h |  3 ++
 arch/um/nommu/um/console.c                | 42 +++++++++++++++++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/nommu/um/console.c

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index ae96c83e312d..694da4aa550d 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -37,7 +37,13 @@ $(obj)/vde.o: $(obj)/vde_kern.o $(obj)/vde_user.o
 # When the above is fixed, don't forget to add this too!
 #targets += $(obj)/pcap.o
 
-obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
+ifdef CONFIG_MMU
+obj-y := stdio_console.o
+else
+obj-y :=
+endif
+obj-y += fd.o chan_kern.o chan_user.o line.o
+
 obj-$(CONFIG_SSL) += ssl.o
 obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
 
diff --git a/arch/um/nommu/include/uapi/asm/host_ops.h b/arch/um/nommu/include/uapi/asm/host_ops.h
index 6ee9489fc47e..133877c857a1 100644
--- a/arch/um/nommu/include/uapi/asm/host_ops.h
+++ b/arch/um/nommu/include/uapi/asm/host_ops.h
@@ -15,6 +15,7 @@ struct lkl_jmp_buf {
  *
  * These operations must be provided by a host library or by the application
  * itself.
+ * @print - optional operation that receives console messages
  *
  * @sem_alloc - allocate a host semaphore an initialize it to count
  * @sem_free - free a host semaphore
@@ -63,6 +64,8 @@ struct lkl_jmp_buf {
  *
  */
 struct lkl_host_operations {
+	void (*print)(const char *str, int len);
+
 	struct lkl_sem *(*sem_alloc)(int count);
 	void (*sem_free)(struct lkl_sem *sem);
 	void (*sem_up)(struct lkl_sem *sem);
diff --git a/arch/um/nommu/um/console.c b/arch/um/nommu/um/console.c
new file mode 100644
index 000000000000..e3194f7bb0dd
--- /dev/null
+++ b/arch/um/nommu/um/console.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
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
2.21.0 (Apple Git-122.2)
