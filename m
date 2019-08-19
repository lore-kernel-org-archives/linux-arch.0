Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43692 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbfHSXlX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 19:41:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so2072001pgb.10
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 16:41:23 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 7/7] bug: Move WARN_ON() "cut here" into exception handler
Date: Mon, 19 Aug 2019 16:41:11 -0700
Message-ID: <20190819234111.9019-8-keescook@chromium.org>
In-Reply-To: <20190819234111.9019-1-keescook@chromium.org>
References: <20190819234111.9019-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Drew Davenport <ddavenport@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190819234111.QMvrasTM_X-tMeUQx56z09_JGi5i69pDKGbPSvb08-k@z>

The original clean up of "cut here" missed the WARN_ON() case (that
does not have a printk message), which was fixed recently by adding
an explicit printk of "cut here". This had the downside of adding a
printk() to every WARN_ON() caller, which reduces the utility of using
an instruction exception to streamline the resulting code. By making
this a new BUGFLAG, all of these can be removed and "cut here" can be
handled by the exception handler.

This was very pronounced on PowerPC, but the effect can be seen on
x86 as well. The resulting text size of a defconfig build shows some
small savings from this patch:

   text    data     bss     dec     hex filename
19691167        5134320 1646664 26472151        193eed7 vmlinux.before
19676362        5134260 1663048 26473670        193f4c6 vmlinux.after

This change also opens the door for creating something like BUG_MSG(),
where a custom printk() before issuing BUG(), without confusing the "cut
here" line.

Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: Fixes: 6b15f678fb7d ("include/asm-generic/bug.h: fix "cut here" for WARN_ON for __WARN_TAINT architectures")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/bug.h |  8 +++-----
 lib/bug.c                 | 11 +++++++++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 588dd59a5b72..da471fcc5487 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -10,6 +10,7 @@
 #define BUGFLAG_WARNING		(1 << 0)
 #define BUGFLAG_ONCE		(1 << 1)
 #define BUGFLAG_DONE		(1 << 2)
+#define BUGFLAG_PRINTK		(1 << 3)
 #define BUGFLAG_TAINT(taint)	((taint) << 8)
 #define BUG_GET_TAINT(bug)	((bug)->flags >> 8)
 #endif
@@ -86,13 +87,10 @@ void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
 #else
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
-#define __WARN() do {							\
-		printk(KERN_WARNING CUT_HERE);				\
-		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN));		\
-	} while (0)
+#define __WARN()		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
 #define __WARN_printf(taint, arg...) do {				\
 		__warn_printk(arg);					\
-		__WARN_FLAGS(BUGFLAG_TAINT(taint));			\
+		__WARN_FLAGS(BUGFLAG_PRINTK | BUGFLAG_TAINT(taint));	\
 	} while (0)
 #define WARN_ON_ONCE(condition) ({				\
 	int __ret_warn_on = !!(condition);			\
diff --git a/lib/bug.c b/lib/bug.c
index 1077366f496b..6c22e8a6f9de 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -181,6 +181,15 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 		}
 	}
 
+	/*
+	 * BUG() and WARN_ON() families don't print a custom debug message
+	 * before triggering the exception handler, so we must add the
+	 * "cut here" line now. WARN() issues its own "cut here" before the
+	 * extra debugging message it writes before triggering the handler.
+	 */
+	if ((bug->flags & BUGFLAG_PRINTK) == 0)
+		printk(KERN_DEFAULT CUT_HERE);
+
 	if (warning) {
 		/* this is a WARN_ON rather than BUG/BUG_ON */
 		__warn(file, line, (void *)bugaddr, BUG_GET_TAINT(bug), regs,
@@ -188,8 +197,6 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 		return BUG_TRAP_TYPE_WARN;
 	}
 
-	printk(KERN_DEFAULT CUT_HERE);
-
 	if (file)
 		pr_crit("kernel BUG at %s:%u!\n", file, line);
 	else
-- 
2.17.1
