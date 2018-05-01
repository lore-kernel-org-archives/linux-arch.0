From: changbin.du@intel.com
Subject: [PATCH 3/5] kernel hacking: new config NO_AUTO_INLINE to disable compiler atuo-inline optimizations
Date: Tue,  1 May 2018 21:00:12 +0800
Message-ID: <1525179614-14571-4-git-send-email-changbin.du@intel.com>
References: <1525179614-14571-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525179614-14571-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org
Cc: x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Changbin Du <changbin.du@intel.com>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-arch.vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
this option will make compiler not auto-inline kernel functions. By
enabling this option, all the kernel functions (including static ones)
will not be optimized out except those marked as inline or always_inline.
This is useful when you are using ftrace to understand the control flow
of kernel code or tracing some static functions.

Signed-off-by: Changbin Du <changbin.du@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 Makefile          |  6 ++++++
 lib/Kconfig.debug | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Makefile b/Makefile
index 619a85a..eb694f6 100644
--- a/Makefile
+++ b/Makefile
@@ -775,6 +775,12 @@ KBUILD_CFLAGS 	+= $(call cc-option, -femit-struct-debug-baseonly) \
 		   $(call cc-option,-fno-var-tracking)
 endif
 
+ifdef CONFIG_NO_AUTO_INLINE
+KBUILD_CFLAGS   += $(call cc-option, -fno-inline-functions) \
+		   $(call cc-option, -fno-inline-small-functions) \
+		   $(call cc-option, -fno-inline-functions-called-once)
+endif
+
 ifdef CONFIG_FUNCTION_TRACER
 ifndef CC_FLAGS_FTRACE
 CC_FLAGS_FTRACE := -pg
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c40c7b7..90f35ad 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -198,6 +198,19 @@ config GDB_SCRIPTS
 	  instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
 	  for further details.
 
+config NO_AUTO_INLINE
+	bool "Disable compiler atuo-inline optimizations"
+	default n
+	help
+	  This will make compiler not auto-inline kernel functions for
+	  optimization. By enabling this option, all the kernel functions
+	  (including static ones) will not be optimized out except those
+	  marked as inline or always_inline. This is useful when you are
+	  using ftrace to understand the control flow of kernel code or
+	  tracing some static functions.
+
+	  Use only if you want to debug the kernel.
+
 config ENABLE_WARN_DEPRECATED
 	bool "Enable __deprecated logic"
 	default y
-- 
2.7.4
