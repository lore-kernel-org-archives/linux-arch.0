Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:56116 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbaBVTgx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 22 Feb 2014 14:36:53 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id E161E534B7A
	for <linux-arch@vger.kernel.org>; Sat, 22 Feb 2014 20:23:45 +0100 (CET)
Date: Sat, 22 Feb 2014 11:23:27 -0800
From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH RESEND] bug: When !CONFIG_BUG, simplify WARN_ON_ONCE and
 family
Message-ID: <20140222192325.GA12587@thin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20140222192327.WMP2Zjqd_myxD1aj2Swb4RZMj79uhHmGioW4XwcNEEQ@z>

When !CONFIG_BUG, WARN_ON and family become simple passthroughs of their
condition argument; however, WARN_ON_ONCE and family still have
conditions and a boolean to detect one-time invocation, even though the
warning they'd emit doesn't exist.  Make the existing definitions
conditional on CONFIG_BUG, and map them all to the passthrough WARN_ON
when !CONFIG_BUG.

This saves 4.4k on a minimized configuration (smaller than
allnoconfig), and 20.6k with defconfig plus CONFIG_BUG=n.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---

diff's presentation here is not the easiest for reviewing purposes.
Effectively, this is moving the existing definitions of WARN_ON_ONCE and
family up into the CONFIG_BUG branch of the #ifdef, and then adding new
stub versions in the !CONFIG_BUG branch.

 include/asm-generic/bug.h | 57 +++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 7d10f96..34223e0 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -106,33 +106,6 @@ extern void warn_slowpath_null(const char *file, const int line);
 	unlikely(__ret_warn_on);					\
 })
 
-#else /* !CONFIG_BUG */
-#ifndef HAVE_ARCH_BUG
-#define BUG() do {} while(0)
-#endif
-
-#ifndef HAVE_ARCH_BUG_ON
-#define BUG_ON(condition) do { if (condition) ; } while(0)
-#endif
-
-#ifndef HAVE_ARCH_WARN_ON
-#define WARN_ON(condition) ({						\
-	int __ret_warn_on = !!(condition);				\
-	unlikely(__ret_warn_on);					\
-})
-#endif
-
-#ifndef WARN
-#define WARN(condition, format...) ({					\
-	int __ret_warn_on = !!(condition);				\
-	unlikely(__ret_warn_on);					\
-})
-#endif
-
-#define WARN_TAINT(condition, taint, format...) WARN_ON(condition)
-
-#endif
-
 #define WARN_ON_ONCE(condition)	({				\
 	static bool __section(.data.unlikely) __warned;		\
 	int __ret_warn_once = !!(condition);			\
@@ -163,6 +136,36 @@ extern void warn_slowpath_null(const char *file, const int line);
 	unlikely(__ret_warn_once);				\
 })
 
+#else /* !CONFIG_BUG */
+#ifndef HAVE_ARCH_BUG
+#define BUG() do {} while(0)
+#endif
+
+#ifndef HAVE_ARCH_BUG_ON
+#define BUG_ON(condition) do { if (condition) ; } while(0)
+#endif
+
+#ifndef HAVE_ARCH_WARN_ON
+#define WARN_ON(condition) ({						\
+	int __ret_warn_on = !!(condition);				\
+	unlikely(__ret_warn_on);					\
+})
+#endif
+
+#ifndef WARN
+#define WARN(condition, format...) ({					\
+	int __ret_warn_on = !!(condition);				\
+	unlikely(__ret_warn_on);					\
+})
+#endif
+
+#define WARN_ON_ONCE(condition) WARN_ON(condition)
+#define WARN_ONCE(condition, format...) WARN_ON(condition)
+#define WARN_TAINT(condition, taint, format...) WARN_ON(condition)
+#define WARN_TAINT_ONCE(condition, taint, format...) WARN_ON(condition)
+
+#endif
+
 /*
  * WARN_ON_SMP() is for cases that the warning is either
  * meaningless for !SMP or may even cause failures.
-- 
1.9.0

