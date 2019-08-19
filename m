Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43388 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbfHSXlW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 19:41:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id v12so2119194pfn.10
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 16:41:22 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 6/7] bug: Consolidate __WARN_FLAGS usage
Date: Mon, 19 Aug 2019 16:41:10 -0700
Message-ID: <20190819234111.9019-7-keescook@chromium.org>
In-Reply-To: <20190819234111.9019-1-keescook@chromium.org>
References: <20190819234111.9019-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Drew Davenport <ddavenport@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190819234110.fDvRfbjVXi9Rpe9RMYzJyE4sswj4GRLVvkC3oFsh12Y@z>

Instead of having separate tests for __WARN_FLAGS, merge the two #ifdef
blocks and replace the synonym WANT_WARN_ON_SLOWPATH macro.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/bug.h | 18 +++++++-----------
 kernel/panic.c            |  2 +-
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 6ea8d258cb96..588dd59a5b72 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -61,16 +61,6 @@ struct bug_entry {
 #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
 #endif
 
-#ifdef __WARN_FLAGS
-#define WARN_ON_ONCE(condition) ({				\
-	int __ret_warn_on = !!(condition);			\
-	if (unlikely(__ret_warn_on))				\
-		__WARN_FLAGS(BUGFLAG_ONCE |			\
-			     BUGFLAG_TAINT(TAINT_WARN));	\
-	unlikely(__ret_warn_on);				\
-})
-#endif
-
 /*
  * WARN(), WARN_ON(), WARN_ON_ONCE, and so on can be used to report
  * significant kernel issues that need prompt attention if they should ever
@@ -91,7 +81,6 @@ struct bug_entry {
 extern __printf(4, 5)
 void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 		       const char *fmt, ...);
-#define WANT_WARN_ON_SLOWPATH
 #define __WARN()		__WARN_printf(TAINT_WARN, NULL)
 #define __WARN_printf(taint, arg...)					\
 	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
@@ -105,6 +94,13 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 		__warn_printk(arg);					\
 		__WARN_FLAGS(BUGFLAG_TAINT(taint));			\
 	} while (0)
+#define WARN_ON_ONCE(condition) ({				\
+	int __ret_warn_on = !!(condition);			\
+	if (unlikely(__ret_warn_on))				\
+		__WARN_FLAGS(BUGFLAG_ONCE |			\
+			     BUGFLAG_TAINT(TAINT_WARN));	\
+	unlikely(__ret_warn_on);				\
+})
 #endif
 
 /* used internally by panic.c */
diff --git a/kernel/panic.c b/kernel/panic.c
index dc2243429903..233219b3fb34 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -588,7 +588,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 	add_taint(taint, LOCKDEP_STILL_OK);
 }
 
-#ifdef WANT_WARN_ON_SLOWPATH
+#ifndef __WARN_FLAGS
 void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 		       const char *fmt, ...)
 {
-- 
2.17.1
