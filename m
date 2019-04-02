From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/9] Add generic function to build command line.
Date: Tue,  2 Apr 2019 09:08:36 +0000 (UTC)
Message-ID: <f4e5809587336135de2df2cbf623ead34c0a56f5.1554195798.git.christophe.leroy@c-s.fr>
References: <cover.1554195798.git.christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1554195798.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This code provides architectures with a way to build command line
based on what is built in the kernel and what is handed over by the
bootloader, based on selected compile-time options.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 include/linux/cmdline.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 include/linux/cmdline.h

diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
new file mode 100644
index 000000000000..8610ddf813ff
--- /dev/null
+++ b/include/linux/cmdline.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CMDLINE_H
+#define _LINUX_CMDLINE_H
+
+/*
+ * This function will append a builtin command line to the command
+ * line provided by the bootloader. Kconfig options can be used to alter
+ * the behavior of this builtin command line.
+ * @dest: The destination of the final appended/prepended string.
+ * @src: The starting string or NULL if there isn't one. Must not equal dest.
+ * @length: the length of dest buffer.
+ */
+static __always_inline void cmdline_build(char *dest, char *src, size_t length)
+{
+	if (length <= 0)
+		return;
+
+	dest[0] = 0;
+
+#ifdef CONFIG_CMDLINE
+	if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !src || !src[0]) {
+		strlcat(dest, CONFIG_CMDLINE, length);
+		return;
+	}
+#endif
+	if (dest != src)
+		strlcat(dest, src, length);
+#ifdef CONFIG_CMDLINE
+	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && sizeof(CONFIG_CMDLINE) > 1)
+		strlcat(dest, " " CONFIG_CMDLINE, length);
+#endif
+}
+
+#endif /* _LINUX_CMDLINE_H */
-- 
2.13.3
