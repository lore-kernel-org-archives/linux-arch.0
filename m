From: Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 1/1] bug: fix problem including <linux.bug.h> from linux/kernel.h
Date: Wed, 24 May 2017 14:21:07 +0100
Message-ID: <20170524132107.6919-2-abbotti@mev.co.uk>
References: <20170524132107.6919-1-abbotti@mev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170524132107.6919-1-abbotti@mev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Michal Nazarewicz <mina86@mina86.com>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Borislav Petkov <bp@suse.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Johannes Berg <johannes.berg@intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Potapenko <glider@google.com>, Ian Abbott <abbotti@mev.co.uk>
List-Id: linux-arch.vger.kernel.org

If "include/linux/kernel.h" includes <linux/bug.h>, a circular
dependency is introduced when "include/asm-generic/bug.h" includes
<linux/kernel.h>.  This results in build breakage when something
includes <asm/bug.h> before <linux/kernel.h> for architectures that
select `CONFIG_GENERIC_BUG` because `struct bug_entry` is not fully
declared (not declared at all in fact) before its members are accessed
by `is_warning_bug()`.

To avoid this problem, remove the inclusion of <linux/kernel.h> from
"include/asm-generic/bug.h", but include <linux/types.h> from
"include/linux/bug.h" because it needs the `bool` type.

A consequence of this change is that since most bug-related,
function-link macros (`BUG()`, `WARN()` etc.) make use of facilities
provided by <linux/kernel.h>, something else needs to include that
before those macros are called.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Nazarewicz <mina86@mina86.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/asm-generic/bug.h | 1 -
 include/linux/bug.h       | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 87191357d303..074a66de47f6 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -12,7 +12,6 @@
 #endif
 
 #ifndef __ASSEMBLY__
-#include <linux/kernel.h>
 
 #ifdef CONFIG_BUG
 
diff --git a/include/linux/bug.h b/include/linux/bug.h
index 687b557fc5eb..68692b775343 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -3,6 +3,7 @@
 
 #include <asm/bug.h>
 #include <linux/compiler.h>
+#include <linux/types.h>
 
 enum bug_trap_type {
 	BUG_TRAP_TYPE_NONE = 0,
-- 
2.11.0
