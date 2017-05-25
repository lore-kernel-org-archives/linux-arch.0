From: Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH v5 4/6] linux/bug.h: correct "space required before that '-'"
Date: Thu, 25 May 2017 13:03:14 +0100
Message-ID: <20170525120316.24473-5-abbotti@mev.co.uk>
References: <20170525120316.24473-1-abbotti@mev.co.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp120.ord1c.emailsrvr.com ([108.166.43.120]:49223 "EHLO
        smtp120.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1423976AbdEYMDw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 May 2017 08:03:52 -0400
In-Reply-To: <20170525120316.24473-1-abbotti@mev.co.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Ian Abbott <abbotti@mev.co.uk>, Jakub Kicinski <jakub.kicinski@netronome.com>, Johannes Berg <johannes.berg@intel.com>, Kees Cook <keescook@chromium.org>, Michal Nazarewicz <mina86@mina86.com>, Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steven Rostedt <rostedt@goodmis.org>

Correct these checkpatch.pl errors:

|ERROR: space required before that '-' (ctx:OxO)
|#37: FILE: include/linux/bug.h:37:
|+#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))

|ERROR: space required before that '-' (ctx:OxO)
|#38: FILE: include/linux/bug.h:38:
|+#define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:-!!(e); }))

I decided to wrap the bitfield expressions that begin with minus signs
in parentheses rather than insert spaces before the minus signs.

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
 include/linux/bug.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bug.h b/include/linux/bug.h
index 216a1b79653d..483207cb99fb 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -36,8 +36,8 @@ struct pt_regs;
  * e.g. in a structure initializer (or where-ever else comma expressions
  * aren't permitted).
  */
-#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
-#define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:-!!(e); }))
+#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
+#define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:(-!!(e)); }))
 
 /*
  * BUILD_BUG_ON_INVALID() permits the compiler to check the validity of the
-- 
2.11.0
