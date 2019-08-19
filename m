Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45160 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbfHSXlS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 19:41:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id w26so2118028pfq.12
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 16:41:18 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 2/7] bug: Rename __WARN_printf_taint() to __WARN_printf()
Date: Mon, 19 Aug 2019 16:41:06 -0700
Message-ID: <20190819234111.9019-3-keescook@chromium.org>
In-Reply-To: <20190819234111.9019-1-keescook@chromium.org>
References: <20190819234111.9019-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Drew Davenport <ddavenport@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190819234106.VEmsgvzYdVKIzlSyM64x8XSUG1QbnIFjYlr8COkLzgg@z>

This just renames the helper to improve readability.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/bug.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index ce466432ac3e..e9166a24b336 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -96,14 +96,14 @@ void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 extern void warn_slowpath_null(const char *file, const int line);
 #define WANT_WARN_ON_SLOWPATH
 #define __WARN()		warn_slowpath_null(__FILE__, __LINE__)
-#define __WARN_printf_taint(taint, arg...)				\
+#define __WARN_printf(taint, arg...)					\
 	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
 #else
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #define __WARN() do { \
 	printk(KERN_WARNING CUT_HERE); __WARN_TAINT(TAINT_WARN); \
 } while (0)
-#define __WARN_printf_taint(taint, arg...)				\
+#define __WARN_printf(taint, arg...)					\
 	do { __warn_printk(arg); __WARN_TAINT(taint); } while (0)
 #endif
 
@@ -127,7 +127,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 #define WARN(condition, format...) ({					\
 	int __ret_warn_on = !!(condition);				\
 	if (unlikely(__ret_warn_on))					\
-		__WARN_printf_taint(TAINT_WARN, format);		\
+		__WARN_printf(TAINT_WARN, format);			\
 	unlikely(__ret_warn_on);					\
 })
 #endif
@@ -135,7 +135,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 #define WARN_TAINT(condition, taint, format...) ({			\
 	int __ret_warn_on = !!(condition);				\
 	if (unlikely(__ret_warn_on))					\
-		__WARN_printf_taint(taint, format);			\
+		__WARN_printf(taint, format);				\
 	unlikely(__ret_warn_on);					\
 })
 
-- 
2.17.1
