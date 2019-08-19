Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41164 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbfHSXlU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 19:41:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so1718576pls.8
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 16:41:19 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 3/7] bug: Consolidate warn_slowpath_fmt() usage
Date: Mon, 19 Aug 2019 16:41:07 -0700
Message-ID: <20190819234111.9019-4-keescook@chromium.org>
In-Reply-To: <20190819234111.9019-1-keescook@chromium.org>
References: <20190819234111.9019-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Drew Davenport <ddavenport@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190819234107.2GE4PnSWrZGT3zbvxosmFisLvsFqc2rxbPe1k2nK8H8@z>

Instead of having a separate helper for no printk output, just
consolidate the logic into warn_slowpath_fmt().

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/bug.h |  3 +--
 kernel/panic.c            | 14 +++++++-------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index e9166a24b336..f76efbcbe3b5 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -93,9 +93,8 @@ struct bug_entry {
 extern __printf(4, 5)
 void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 		       const char *fmt, ...);
-extern void warn_slowpath_null(const char *file, const int line);
 #define WANT_WARN_ON_SLOWPATH
-#define __WARN()		warn_slowpath_null(__FILE__, __LINE__)
+#define __WARN()		__WARN_printf(TAINT_WARN, NULL)
 #define __WARN_printf(taint, arg...)					\
 	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
 #else
diff --git a/kernel/panic.c b/kernel/panic.c
index 4d8b7577c82c..51efdeb2558e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -597,19 +597,19 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 {
 	struct warn_args args;
 
+	if (!fmt) {
+		pr_warn(CUT_HERE);
+		__warn(file, line, __builtin_return_address(0), taint,
+		       NULL, NULL);
+		return;
+	}
+
 	args.fmt = fmt;
 	va_start(args.args, fmt);
 	__warn(file, line, __builtin_return_address(0), taint, NULL, &args);
 	va_end(args.args);
 }
 EXPORT_SYMBOL(warn_slowpath_fmt);
-
-void warn_slowpath_null(const char *file, int line)
-{
-	pr_warn(CUT_HERE);
-	__warn(file, line, __builtin_return_address(0), TAINT_WARN, NULL, NULL);
-}
-EXPORT_SYMBOL(warn_slowpath_null);
 #else
 void __warn_printk(const char *fmt, ...)
 {
-- 
2.17.1
