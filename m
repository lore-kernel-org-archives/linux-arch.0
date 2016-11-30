From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 2/3] kbuild: make modversion for exported asm symbols more convivial
Date: Wed, 30 Nov 2016 03:50:23 -0500
Message-ID: <1480495824-4151-3-git-send-email-nicolas.pitre@linaro.org>
References: <1480495824-4151-1-git-send-email-nicolas.pitre@linaro.org>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1480495824-4151-1-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Nicholas Piggin <npiggin@gmail.com>, Michal Marek <mmarek@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, viro@zeniv.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Rather than having an asm-prototypes.h file where C prototypes for exported
asm symbols are centralized, let's have some macros that can be used
directly in the code where those symbols are exported for genksyms
consumption.  Either the prototype is provided directly if no include
files has it, or the include file containing it is specified.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 include/asm-generic/export.h | 15 +++++++++++++++
 scripts/Makefile.build       | 22 +++++++++++++++-------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 39a19dc366..83dda5f840 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -84,11 +84,26 @@ KSYM(__kcrctab_\name):
 #define __EXPORT_SYMBOL(sym, val, sec) ___EXPORT_SYMBOL sym, val, sec
 #endif
 
+/* in the non genksyms case those are no-ops */
+#define SYMBOL_CPROTO(expr)
+#define SYMBOL_CPROTO_INCLUDE(file)
+
 #else /* __GENKSYMS__ */
 
 /* create a preprocessor output suitable for cmd_gensymtypes_S */
 #define __EXPORT_SYMBOL(sym, val, sec) EXPORT_SYMBOL(sym)
 
+/*
+ * The cmd_gensymtypes_S kbuild command recognizes the following:
+ *
+ * Provide a C prototype for genksyms: SYMBOL_CPROTO(expr)
+ * example: SYMBOL_CPROTO(void foobar(int x, int y))
+ *
+ * Specify an include file that contains C prototypes for genksyms:
+ * SYMBOL_CPROTO_INCLUDE(quoted_filename)
+ * example: SYMBOL_CPROTO_INCLUDE(<linux/string.h>)
+ */
+
 #endif /* __GENKSYMS__ */
 
 #define EXPORT_SYMBOL(name)					\
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index ebf6e08ae4..58ebc4b15d 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -317,24 +317,32 @@ modkern_aflags := $(KBUILD_AFLAGS_KERNEL) $(AFLAGS_KERNEL)
 $(real-objs-m)      : modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
 $(real-objs-m:.o=.s): modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
 
-# .S file exports must have their C prototypes defined in asm/asm-prototypes.h
-# or a file that it includes, in order to get versioned symbols. We build a
-# dummy C file that includes asm-prototypes and the EXPORT_SYMBOL lines from
-# the .S file (with trailing ';'), and run genksyms on that, to extract vers.
+# In order to get versioned symbols, .S file exports must have their C prototypes:
+# - defined in asm/asm-prototypes.h or a file that it includes, or
+# - provided in a file specified by SYMBOL_CPROTO_INCLUDE(), or
+# - specified directly by SYMBOL_CPROTO().
+# We build a dummy C file that includes asm-prototypes and the EXPORT_SYMBOL
+# lines from the .S file (with trailing ';'), and run genksyms on that, to
+# extract vers.
 #
 # This is convoluted. The .S file must first be preprocessed to run guards and
 # expand names, then the resulting exports must be constructed into plain
 # EXPORT_SYMBOL(symbol); to build our dummy C file, and that gets preprocessed
 # to make the genksyms input. See also include/asm-generic/export.h.
 #
+# The -Ulinux is necessary otherwise SYMBOL_CPROTO_INCLUDE(<linux/bitops.h>)
+# is turned into #include <1/bitops.h> due to "linux" being defined to 1.
+#
 # These mirror gensymtypes_c and co above, keep them in synch.
 cmd_gensymtypes_S =                                                         \
     ( echo "\#include <linux/kernel.h>" ;                                   \
       if [ -e $(srctree)/arch/$(SRCARCH)/include/asm/asm-prototypes.h ];    \
       then echo "\#include <asm/asm-prototypes.h>"; fi;                     \
-      $(CPP) -D__GENKSYMS__ $(a_flags) $< | tr ";" "\n" |                   \
-      sed -n -e '/EXPORT_SYMBOL(/s/$$/;/p' ) |                              \
-    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
+      $(CPP) -D__GENKSYMS__ $(a_flags) -Ulinux $< | tr ";" "\n" |           \
+      sed -n -e '/EXPORT_SYMBOL(/s/$$/;/p'                                  \
+             -e 's/SYMBOL_CPROTO(\(.*\))/\1;/p'                             \
+             -e 's/SYMBOL_CPROTO_INCLUDE(\(.*\))/\#include \1/p' ) |        \
+    $(CPP) -D__GENKSYMS__ -I$(@D) $(c_flags) -xc - |                        \
     $(GENKSYMS) $(if $(1), -T $(2))                                         \
      $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
      $(if $(KBUILD_PRESERVE),-p)                                            \
-- 
2.7.4

