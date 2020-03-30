From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v4 03/25] um lkl: host interface
Date: Mon, 30 Mar 2020 23:45:35 +0900
Message-ID: <f5d1cc3f16ad744cf4f18b8cc2dead79bf123011.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45667 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgC3Oqw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 10:46:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id t4so850304plq.12
        for <linux-arch@vger.kernel.org>; Mon, 30 Mar 2020 07:46:50 -0700 (PDT)
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Michael Zimmermann <sigmaepsilon92@gmail.com>, Patrick Collins <pscollins@google.com>, Pierre-Hugues Husson <phh@phh.me>, Yuan Liu <liuyuan@google.com>, Hajime Tazaki <thehajime@gmail.com>

From: Octavian Purdila <tavi.purdila@gmail.com>

This patch introduces the host operations that define the interface
between the LKL and the host. These operations must be provided either
by a host library or by the application itself.

Cc: Michael Zimmermann <sigmaepsilon92@gmail.com>
Cc: Patrick Collins <pscollins@google.com>
Cc: Pierre-Hugues Husson <phh@phh.me>
Cc: Yuan Liu <liuyuan@google.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/lkl/include/asm/host_ops.h      | 10 ++++++++++
 arch/um/lkl/include/uapi/asm/host_ops.h | 26 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 arch/um/lkl/include/asm/host_ops.h
 create mode 100644 arch/um/lkl/include/uapi/asm/host_ops.h

diff --git a/arch/um/lkl/include/asm/host_ops.h b/arch/um/lkl/include/asm/host_ops.h
new file mode 100644
index 000000000000..65850f394b79
--- /dev/null
+++ b/arch/um/lkl/include/asm/host_ops.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_HOST_OPS_H
+#define _ASM_LKL_HOST_OPS_H
+
+#include "irq.h"
+#include <uapi/asm/host_ops.h>
+
+extern struct lkl_host_operations *lkl_ops;
+
+#endif
diff --git a/arch/um/lkl/include/uapi/asm/host_ops.h b/arch/um/lkl/include/uapi/asm/host_ops.h
new file mode 100644
index 000000000000..7cfb0a93e6a6
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/host_ops.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_UAPI_LKL_HOST_OPS_H
+#define _ASM_UAPI_LKL_HOST_OPS_H
+
+/* Defined in {posix,nt}-host.c */
+struct lkl_mutex;
+struct lkl_sem;
+struct lkl_tls_key;
+typedef unsigned long lkl_thread_t;
+struct lkl_jmp_buf {
+	unsigned long buf[32];
+};
+
+/**
+ * lkl_host_operations - host operations used by the Linux kernel
+ *
+ * These operations must be provided by a host library or by the application
+ * itself.
+ *
+ */
+struct lkl_host_operations {
+};
+
+void lkl_bug(const char *fmt, ...);
+
+#endif
-- 
2.21.0 (Apple Git-122.2)
