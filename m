From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] kconfig.h: remove config_enabled() macro
Date: Sun, 16 Oct 2016 20:07:58 +0900
Message-ID: <1476616078-32252-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-arch@vger.kernel.org, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Thomas Garnier <thgarnie@google.com>
List-Id: linux-arch.vger.kernel.org

The use of config_enabled() is ambiguous.  For config options,
IS_ENABLED(), IS_REACHABLE(), etc. will make intention clearer.
Sometimes config_enabled() has been used for non-config options
because it is useful to check whether the given symbol is defined
or not.

I have been tackling on deprecating config_enabled(), and now is the
time to finish this work.

Some new users have appeared for v4.9-rc1, but it is trivial to
replace them:

 - arch/x86/mm/kaslr.c
  replace config_enabled() with IS_ENABLED() because
  CONFIG_X86_ESPFIX64 and CONFIG_EFI are boolean.

 - include/asm-generic/export.h
  replace config_enabled() with __is_defined().

Then, config_enabled() can be removed now.

Going forward, please use IS_ENABLED(), IS_REACHABLE(), etc. for
config options, and __is_defined() for non-config symbols.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/mm/kaslr.c          | 6 +++---
 include/asm-generic/export.h | 2 +-
 include/linux/kconfig.h      | 5 ++---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index ddd2661..887e571 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -104,10 +104,10 @@ void __init kernel_randomize_memory(void)
 	 * consistent with the vaddr_start/vaddr_end variables.
 	 */
 	BUILD_BUG_ON(vaddr_start >= vaddr_end);
-	BUILD_BUG_ON(config_enabled(CONFIG_X86_ESPFIX64) &&
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_X86_ESPFIX64) &&
 		     vaddr_end >= EFI_VA_START);
-	BUILD_BUG_ON((config_enabled(CONFIG_X86_ESPFIX64) ||
-		      config_enabled(CONFIG_EFI)) &&
+	BUILD_BUG_ON((IS_ENABLED(CONFIG_X86_ESPFIX64) ||
+		      IS_ENABLED(CONFIG_EFI)) &&
 		     vaddr_end >= __START_KERNEL_map);
 	BUILD_BUG_ON(vaddr_end > __START_KERNEL_map);
 
diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 43199a0..63554e9 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -70,7 +70,7 @@
 #include <generated/autoksyms.h>
 
 #define __EXPORT_SYMBOL(sym, val, sec)				\
-	__cond_export_sym(sym, val, sec, config_enabled(__KSYM_##sym))
+	__cond_export_sym(sym, val, sec, __is_defined(__KSYM_##sym))
 #define __cond_export_sym(sym, val, sec, conf)			\
 	___cond_export_sym(sym, val, sec, conf)
 #define ___cond_export_sym(sym, val, sec, enabled)		\
diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
index 15ec117..8f2e059 100644
--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -31,7 +31,6 @@
  * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
  * the last step cherry picks the 2nd arg, we get a zero.
  */
-#define config_enabled(cfg)		___is_defined(cfg)
 #define __is_defined(x)			___is_defined(x)
 #define ___is_defined(val)		____is_defined(__ARG_PLACEHOLDER_##val)
 #define ____is_defined(arg1_or_junk)	__take_second_arg(arg1_or_junk 1, 0)
@@ -41,13 +40,13 @@
  * otherwise. For boolean options, this is equivalent to
  * IS_ENABLED(CONFIG_FOO).
  */
-#define IS_BUILTIN(option) config_enabled(option)
+#define IS_BUILTIN(option) __is_defined(option)
 
 /*
  * IS_MODULE(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'm', 0
  * otherwise.
  */
-#define IS_MODULE(option) config_enabled(option##_MODULE)
+#define IS_MODULE(option) __is_defined(option##_MODULE)
 
 /*
  * IS_REACHABLE(CONFIG_FOO) evaluates to 1 if the currently compiled
-- 
1.9.1
