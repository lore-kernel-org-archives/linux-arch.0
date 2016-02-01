From: Jeffrey Merkey <jeffmerkey@gmail.com>
Subject: [PATCH v4 2/4] Add WARN_XX() debugging options
Date: Mon,  1 Feb 2016 16:35:50 -0700
Message-ID: <1454369752-20706-2-git-send-email-jeffmerkey@gmail.com>
References: <1454369752-20706-1-git-send-email-jeffmerkey@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f195.google.com ([209.85.214.195]:35221 "EHLO
	mail-ob0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbcBAXf6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Feb 2016 18:35:58 -0500
In-Reply-To: <1454369752-20706-1-git-send-email-jeffmerkey@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, linux-arch@vger.kernel.org

This patch series adds config options which can be set during compile to
direct the compiler to output a breakpoint instruction anywhere a BUG()
or WARN() macro has been placed in the kernel to trigger the system to
enter a debugger if a bug is detected by the system.  Use of this
compile time option also allows conditional breakpoints to be set in the
kernel with these currently used macros.

This addition is extremely useful for debugging hard and soft lockups
real time and quickly from a console debugger, and other areas of the
kernel.

Signed-off-by: Jeffrey Merkey <jeffmerkey@gmail.com>
---
 include/asm-generic/bug.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 630dd23..ed86cd2 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -90,14 +90,26 @@ extern void warn_slowpath_null(const char *file, const int line);
 })
 #endif
 
+#ifdef CONFIG_DEBUG_WARN
 #ifndef WARN
-#define WARN(condition, format...) ({						\
+#define WARN(condition, format...) ({					\
 	int __ret_warn_on = !!(condition);				\
 	if (unlikely(__ret_warn_on))					\
 		__WARN_printf(format);					\
+	BUG();								\
 	unlikely(__ret_warn_on);					\
 })
 #endif
+#else
+#ifndef WARN
+#define WARN(condition, format...) ({					\
+	int __ret_warn_on = !!(condition);				\
+	if (unlikely(__ret_warn_on))					\
+		__WARN_printf(format);					\
+	unlikely(__ret_warn_on);					\
+})
+#endif
+#endif
 
 #define WARN_TAINT(condition, taint, format...) ({			\
 	int __ret_warn_on = !!(condition);				\
-- 
1.8.3.1
