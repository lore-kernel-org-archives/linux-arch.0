From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH v4 04/10] x86: Makefile: Add build and config option for CONFIG_FG_KASLR
Date: Fri, 17 Jul 2020 10:00:01 -0700
Message-ID: <20200717170008.5949-5-kristen@linux.intel.com>
References: <20200717170008.5949-1-kristen@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20200717170008.5949-1-kristen@linux.intel.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Cc: arjan@linux.intel.com, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com, Kristen Carlson Accardi <kristen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Allow user to select CONFIG_FG_KASLR if dependencies are met. Change
the make file to build with -ffunction-sections if CONFIG_FG_KASLR.

While the only architecture that supports CONFIG_FG_KASLR does not
currently enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION, make sure these
2 features play nicely together for the future by ensuring that if
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is selected when used with
CONFIG_FG_KASLR the function sections will not be consolidated back
into .text. Thanks to Kees Cook for the dead code elimination changes.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Tony Luck <tony.luck@intel.com>
---
 Makefile                          |  6 +++++-
 arch/x86/Kconfig                  |  4 ++++
 include/asm-generic/vmlinux.lds.h | 16 ++++++++++++++--
 init/Kconfig                      | 14 ++++++++++++++
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 0b5f8538bde5..66427b12de53 100644
--- a/Makefile
+++ b/Makefile
@@ -872,7 +872,7 @@ KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
 endif
 
 ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
-KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
+KBUILD_CFLAGS_KERNEL += -fdata-sections
 LDFLAGS_vmlinux += --gc-sections
 endif
 
@@ -880,6 +880,10 @@ ifdef CONFIG_LIVEPATCH
 KBUILD_CFLAGS += $(call cc-option, -flive-patching=inline-clone)
 endif
 
+ifneq ($(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION)$(CONFIG_FG_KASLR),)
+KBUILD_CFLAGS += -ffunction-sections
+endif
+
 ifdef CONFIG_SHADOW_CALL_STACK
 CC_FLAGS_SCS	:= -fsanitize=shadow-call-stack
 KBUILD_CFLAGS	+= $(CC_FLAGS_SCS)
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 883da0abf779..e7a2db3e270d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -372,6 +372,10 @@ config CC_HAS_SANE_STACKPROTECTOR
 	   We have to make sure stack protector is unconditionally disabled if
 	   the compiler produces broken code.
 
+config ARCH_HAS_FG_KASLR
+	def_bool y
+	depends on RANDOMIZE_BASE && X86_64
+
 menu "Processor type and features"
 
 config ZONE_DMA
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index db600ef218d7..a5552cf28d5d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -93,14 +93,12 @@
  * sections to be brought in with rodata.
  */
 #ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
-#define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
 #define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..LPBX*
 #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
 #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]*
 #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]*
 #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
 #else
-#define TEXT_MAIN .text
 #define DATA_MAIN .data
 #define SDATA_MAIN .sdata
 #define RODATA_MAIN .rodata
@@ -108,6 +106,20 @@
 #define SBSS_MAIN .sbss
 #endif
 
+/*
+ * Both LD_DEAD_CODE_DATA_ELIMINATION and CONFIG_FG_KASLR options enable
+ * -ffunction-sections, which produces separately named .text sections. In
+ * the case of CONFIG_FG_KASLR, they need to stay distict so they can be
+ * separately randomized. Without CONFIG_FG_KASLR, the separate .text
+ * sections can be collected back into a common section, which makes the
+ * resulting image slightly smaller
+ */
+#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) && !defined(CONFIG_FG_KASLR)
+#define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
+#else
+#define TEXT_MAIN .text
+#endif
+
 /*
  * Align to a 32 byte boundary equal to the
  * alignment gcc 4.5 uses for a struct
diff --git a/init/Kconfig b/init/Kconfig
index 0498af567f70..82f042a1062f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1990,6 +1990,20 @@ config PROFILING
 config TRACEPOINTS
 	bool
 
+config FG_KASLR
+	bool "Function Granular Kernel Address Space Layout Randomization"
+	depends on $(cc-option, -ffunction-sections)
+	depends on ARCH_HAS_FG_KASLR
+	default n
+	help
+	  This option improves the randomness of the kernel text
+	  over basic Kernel Address Space Layout Randomization (KASLR)
+	  by reordering the kernel text at boot time. This feature
+	  uses information generated at compile time to re-layout the
+	  kernel text section at boot time at function level granularity.
+
+	  If unsure, say N.
+
 endmenu		# General setup
 
 source "arch/Kconfig"
-- 
2.20.1
