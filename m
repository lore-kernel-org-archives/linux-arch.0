From: Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH v5 1/6] asm-generic/bug.h: declare struct pt_regs; before function prototype
Date: Thu, 25 May 2017 13:03:11 +0100
Message-ID: <20170525120316.24473-2-abbotti@mev.co.uk>
References: <20170525120316.24473-1-abbotti@mev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170525120316.24473-1-abbotti@mev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Ian Abbott <abbotti@mev.co.uk>, Jakub Kicinski <jakub.kicinski@netronome.com>, Johannes Berg <johannes.berg@intel.com>, Kees Cook <keescook@chromium.org>, Michal Nazarewicz <mina86@mina86.com>, Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-arch.vger.kernel.org

The declaration of `__warn()` has `struct pt_regs *regs` as one of its
parameters.  This can result in compiler warnings if `struct regs` is
not already declared.  Add an empty declaration of `struct pt_regs` to
avoid the warnings.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Michal Nazarewicz <mina86@mina86.com>
---
v3: Actually, there was no v1 or v2.  I called this v3 to match the
series.
v4: Corrected 'Acked-by:' line in patch description.
v5: Added Acked-by for Michal Nazarewicz.
---
 include/asm-generic/bug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index d6f4aed479a1..87191357d303 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -97,6 +97,7 @@ extern void warn_slowpath_null(const char *file, const int line);
 
 /* used internally by panic.c */
 struct warn_args;
+struct pt_regs;
 
 void __warn(const char *file, int line, void *caller, unsigned taint,
 	    struct pt_regs *regs, struct warn_args *args);
-- 
2.11.0
