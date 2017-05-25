From: Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH v5 3/6] linux/bug.h: correct "(foo*)" should be "(foo *)"
Date: Thu, 25 May 2017 13:03:13 +0100
Message-ID: <20170525120316.24473-4-abbotti@mev.co.uk>
References: <20170525120316.24473-1-abbotti@mev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170525120316.24473-1-abbotti@mev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Ian Abbott <abbotti@mev.co.uk>, Jakub Kicinski <jakub.kicinski@netronome.com>, Johannes Berg <johannes.berg@intel.com>, Kees Cook <keescook@chromium.org>, Michal Nazarewicz <mina86@mina86.com>, Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-arch.vger.kernel.org

Correct this checkpatch.pl error:

|ERROR: "(foo*)" should be "(foo *)"
|#19: FILE: include/linux/bug.h:19:
|+#define BUILD_BUG_ON_NULL(e) ((void*)0)

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
 include/linux/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bug.h b/include/linux/bug.h
index ca24007e2dc3..216a1b79653d 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -16,7 +16,7 @@ struct pt_regs;
 #define __BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
 #define BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
 #define BUILD_BUG_ON_ZERO(e) (0)
-#define BUILD_BUG_ON_NULL(e) ((void*)0)
+#define BUILD_BUG_ON_NULL(e) ((void *)0)
 #define BUILD_BUG_ON_INVALID(e) (0)
 #define BUILD_BUG_ON_MSG(cond, msg) (0)
 #define BUILD_BUG_ON(condition) (0)
-- 
2.11.0
