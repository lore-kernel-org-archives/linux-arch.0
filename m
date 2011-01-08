From: "Guan Xuetao" <guanxuetao@mprc.pku.edu.cn>
Subject: [PATCH] asm-generic headers: add ftrace.h
Date: Sat, 8 Jan 2011 20:08:44 +0800
Message-ID: <024001cbaf2c$cbe9cc70$63bd6550$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mprc.pku.edu.cn ([162.105.203.9]:41749 "EHLO mprc.pku.edu.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934Ab1AHMIp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 8 Jan 2011 07:08:45 -0500
Content-Language: zh-cn
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

From: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>

 This patch adds ftrace.h into asm-generic headers.
 The file content could be empty in most architectures.

Signed-off-by: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
---
 include/asm-generic/ftrace.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/ftrace.h b/include/asm-generic/ftrace.h
new file mode 100644
index 0000000..51abba9
--- /dev/null
+++ b/include/asm-generic/ftrace.h
@@ -0,0 +1,16 @@
+/*
+ * linux/include/asm-generic/ftrace.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_GENERIC_FTRACE_H__
+#define __ASM_GENERIC_FTRACE_H__
+
+/*
+ * Not all architectures need their own ftrace.h, the most
+ * common definitions are already in linux/ftrace.h.
+ */
+
+#endif /* __ASM_GENERIC_FTRACE_H__ */
