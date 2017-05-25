From: Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH v5 2/6] linux/bug.h: correct formatting of block comment
Date: Thu, 25 May 2017 13:03:12 +0100
Message-ID: <20170525120316.24473-3-abbotti@mev.co.uk>
References: <20170525120316.24473-1-abbotti@mev.co.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp120.ord1c.emailsrvr.com ([108.166.43.120]:33415 "EHLO
        smtp120.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1423957AbdEYMDn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 May 2017 08:03:43 -0400
In-Reply-To: <20170525120316.24473-1-abbotti@mev.co.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Ian Abbott <abbotti@mev.co.uk>, Jakub Kicinski <jakub.kicinski@netronome.com>, Johannes Berg <johannes.berg@intel.com>, Kees Cook <keescook@chromium.org>, Michal Nazarewicz <mina86@mina86.com>, Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steven Rostedt <rostedt@goodmis.org>

Correct these checkpatch.pl warnings:

|WARNING: Block comments use * on subsequent lines
|#34: FILE: include/linux/bug.h:34:
|+/* Force a compilation error if condition is true, but also produce a
|+   result (of value 0 and type size_t), so the expression can be used

|WARNING: Block comments use a trailing */ on a separate line
|#36: FILE: include/linux/bug.h:36:
|+   aren't permitted). */

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
v5: Actually, there was no v1 thru v4.  I called this v5 to match the
series.
---
 include/linux/bug.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/bug.h b/include/linux/bug.h
index 687b557fc5eb..ca24007e2dc3 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -30,10 +30,12 @@ struct pt_regs;
 #define BUILD_BUG_ON_NOT_POWER_OF_2(n)			\
 	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
 
-/* Force a compilation error if condition is true, but also produce a
-   result (of value 0 and type size_t), so the expression can be used
-   e.g. in a structure initializer (or where-ever else comma expressions
-   aren't permitted). */
+/*
+ * Force a compilation error if condition is true, but also produce a
+ * result (of value 0 and type size_t), so the expression can be used
+ * e.g. in a structure initializer (or where-ever else comma expressions
+ * aren't permitted).
+ */
 #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
 #define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:-!!(e); }))
 
-- 
2.11.0
