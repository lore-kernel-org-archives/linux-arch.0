From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 1/3] kbuild: improve EXPORT_SYMBOL() parsing from asm code
Date: Wed, 30 Nov 2016 03:50:22 -0500
Message-ID: <1480495824-4151-2-git-send-email-nicolas.pitre@linaro.org>
References: <1480495824-4151-1-git-send-email-nicolas.pitre@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480495824-4151-1-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Nicholas Piggin <npiggin@gmail.com>, Michal Marek <mmarek@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, viro@zeniv.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

First, make the asm-prototypes.h presence optional.  The next patch will
make it unneeded for modversion support.

Use the -D__GENKSYMS__ like we do for .c files but to expand the
EXPORT_SYMBOL macro using the preprocessor instead of a sed script.
The preprocessor output parsing is then limited to a simpler filtering
and made more robust against multiple assembly statements on a single
line.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 include/asm-generic/export.h |  9 +++++++++
 scripts/Makefile.build       | 20 ++++++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 63554e9f6e..39a19dc366 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -28,6 +28,8 @@
 #define KSYM(name) name
 #endif
 
+#if defined(__KERNEL__) && !defined(__GENKSYMS__)
+
 /*
  * note on .section use: @progbits vs %progbits nastiness doesn't matter,
  * since we immediately emit into those sections anyway.
@@ -82,6 +84,13 @@ KSYM(__kcrctab_\name):
 #define __EXPORT_SYMBOL(sym, val, sec) ___EXPORT_SYMBOL sym, val, sec
 #endif
 
+#else /* __GENKSYMS__ */
+
+/* create a preprocessor output suitable for cmd_gensymtypes_S */
+#define __EXPORT_SYMBOL(sym, val, sec) EXPORT_SYMBOL(sym)
+
+#endif /* __GENKSYMS__ */
+
 #define EXPORT_SYMBOL(name)					\
 	__EXPORT_SYMBOL(name, KSYM_FUNC(KSYM(name)),)
 #define EXPORT_SYMBOL_GPL(name) 				\
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 7675d11ee6..ebf6e08ae4 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -325,15 +325,15 @@ $(real-objs-m:.o=.s): modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
 # This is convoluted. The .S file must first be preprocessed to run guards and
 # expand names, then the resulting exports must be constructed into plain
 # EXPORT_SYMBOL(symbol); to build our dummy C file, and that gets preprocessed
-# to make the genksyms input.
+# to make the genksyms input. See also include/asm-generic/export.h.
 #
 # These mirror gensymtypes_c and co above, keep them in synch.
 cmd_gensymtypes_S =                                                         \
-    (echo "\#include <linux/kernel.h>" ;                                    \
-     echo "\#include <asm/asm-prototypes.h>" ;                              \
-    $(CPP) $(a_flags) $< |                                                  \
-     grep "\<___EXPORT_SYMBOL\>" |                                          \
-     sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ) | \
+    ( echo "\#include <linux/kernel.h>" ;                                   \
+      if [ -e $(srctree)/arch/$(SRCARCH)/include/asm/asm-prototypes.h ];    \
+      then echo "\#include <asm/asm-prototypes.h>"; fi;                     \
+      $(CPP) -D__GENKSYMS__ $(a_flags) $< | tr ";" "\n" |                   \
+      sed -n -e '/EXPORT_SYMBOL(/s/$$/;/p' ) |                              \
     $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
     $(GENKSYMS) $(if $(1), -T $(2))                                         \
      $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
@@ -363,13 +363,6 @@ cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<
 
 else
 
-ASM_PROTOTYPES := $(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/asm-prototypes.h)
-
-ifeq ($(ASM_PROTOTYPES),)
-cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<
-
-else
-
 # versioning matches the C process described above, with difference that
 # we parse asm-prototypes.h C header to get function definitions.
 
@@ -387,7 +380,6 @@ cmd_modversions_S =								\
 		mv -f $(@D)/.tmp_$(@F) $@;					\
 	fi;
 endif
-endif
 
 $(obj)/%.o: $(src)/%.S $(objtool_obj) FORCE
 	$(call if_changed_rule,as_o_S)
-- 
2.7.4
