From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v3 10/26] um lkl: basic kernel console support
Date: Wed,  5 Feb 2020 16:30:19 +0900
Message-ID: <f38b9e100b963bdc88d296287a290728d2ece94e.1580882335.git.thehajime@gmail.com>
References: <cover.1580882335.git.thehajime@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43289 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgBEHbG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 02:31:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id p11so505068plq.10
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 23:31:05 -0800 (PST)
In-Reply-To: <cover.1580882335.git.thehajime@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

Write operations are deferred to the host print operation.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/lkl/include/uapi/asm/host_ops.h |  4 +++
 arch/um/lkl/kernel/console.c            | 42 +++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/um/lkl/kernel/console.c

diff --git a/arch/um/lkl/include/uapi/asm/host_ops.h b/arch/um/lkl/include/uapi/asm/host_ops.h
index c9f77dd7fbe7..986340ba9d8d 100644
--- a/arch/um/lkl/include/uapi/asm/host_ops.h
+++ b/arch/um/lkl/include/uapi/asm/host_ops.h
@@ -17,6 +17,8 @@ struct lkl_jmp_buf {
  * These operations must be provided by a host library or by the application
  * itself.
  *
+ * @print - optional operation that receives console messages
+ *
  * @sem_alloc - allocate a host semaphore an initialize it to count
  * @sem_free - free a host semaphore
  * @sem_up - perform an up operation on the semaphore
@@ -70,6 +72,8 @@ struct lkl_jmp_buf {
  * @jmp_buf_longjmp - perform a jump back to the saved jump buffer
  */
 struct lkl_host_operations {
+	void (*print)(const char *str, int len);
+
 	struct lkl_sem *(*sem_alloc)(int count);
 	void (*sem_free)(struct lkl_sem *sem);
 	void (*sem_up)(struct lkl_sem *sem);
diff --git a/arch/um/lkl/kernel/console.c b/arch/um/lkl/kernel/console.c
new file mode 100644
index 000000000000..54d7f756c6da
--- /dev/null
+++ b/arch/um/lkl/kernel/console.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <asm/host_ops.h>
+
+static void console_write(struct console *con, const char *str,
+			  unsigned int len)
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
+static int __init lkl_console_init(void)
+{
+	register_console(&lkl_console);
+	return 0;
+}
+core_initcall(lkl_console_init);
-- 
2.21.0 (Apple Git-122.2)
