From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 5/7] bug: Clean up helper macros to remove __WARN_TAINT()
Date: Mon, 19 Aug 2019 16:41:09 -0700
Message-ID: <20190819234111.9019-6-keescook@chromium.org>
References: <20190819234111.9019-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190819234111.9019-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Drew Davenport <ddavenport@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

In preparation for cleaning up "cut here" even more, this removes the
__WARN_*TAINT() helpers, as they limit the ability to add new BUGFLAG_*
flags to call sites. They are removed by expanding them into full
__WARN_FLAGS() calls.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/bug.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index f76efbcbe3b5..6ea8d258cb96 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -62,13 +62,11 @@ struct bug_entry {
 #endif
 
 #ifdef __WARN_FLAGS
-#define __WARN_TAINT(taint)		__WARN_FLAGS(BUGFLAG_TAINT(taint))
-#define __WARN_ONCE_TAINT(taint)	__WARN_FLAGS(BUGFLAG_ONCE|BUGFLAG_TAINT(taint))
-
 #define WARN_ON_ONCE(condition) ({				\
 	int __ret_warn_on = !!(condition);			\
 	if (unlikely(__ret_warn_on))				\
-		__WARN_ONCE_TAINT(TAINT_WARN);			\
+		__WARN_FLAGS(BUGFLAG_ONCE |			\
+			     BUGFLAG_TAINT(TAINT_WARN));	\
 	unlikely(__ret_warn_on);				\
 })
 #endif
@@ -89,7 +87,7 @@ struct bug_entry {
  *
  * Use the versions with printk format strings to provide better diagnostics.
  */
-#ifndef __WARN_TAINT
+#ifndef __WARN_FLAGS
 extern __printf(4, 5)
 void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 		       const char *fmt, ...);
@@ -99,11 +97,14 @@ void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
 #else
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
-#define __WARN() do { \
-	printk(KERN_WARNING CUT_HERE); __WARN_TAINT(TAINT_WARN); \
-} while (0)
-#define __WARN_printf(taint, arg...)					\
-	do { __warn_printk(arg); __WARN_TAINT(taint); } while (0)
+#define __WARN() do {							\
+		printk(KERN_WARNING CUT_HERE);				\
+		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN));		\
+	} while (0)
+#define __WARN_printf(taint, arg...) do {				\
+		__warn_printk(arg);					\
+		__WARN_FLAGS(BUGFLAG_TAINT(taint));			\
+	} while (0)
 #endif
 
 /* used internally by panic.c */
-- 
2.17.1
