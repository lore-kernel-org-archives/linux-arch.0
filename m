From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 01/11] Add support for GCC-4.5's __builtin_unreachable() to compiler.h (v2)
Date: Mon, 14 Sep 2009 14:55:30 -0700
Message-ID: <1252965340-31735-1-git-send-email-ddaney@caviumnetworks.com>
References: <4AAEBAC2.1050905@caviumnetworks.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932339AbZINV4J@vger.kernel.org>
In-Reply-To: <4AAEBAC2.1050905@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>
List-Id: linux-arch.vger.kernel.org

Starting with version 4.5, GCC has a new built-in function
__builtin_unreachable() that can be used in places like the kernel's
BUG() where inline assembly is used to transfer control flow.  This
eliminated the need for an endless loop in these places.

The patch adds a new macro 'unreachable()' that will expand to either
__builtin_unreachable() or an endless loop depending on the compiler
version.

Change from v1: Simplify unreachable() for non-GCC 4.5 case.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
---
 include/linux/compiler-gcc4.h |   14 ++++++++++++++
 include/linux/compiler.h      |    5 +++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/linux/compiler-gcc4.h b/include/linux/compiler-gcc4.h
index 450fa59..ab3af40 100644
--- a/include/linux/compiler-gcc4.h
+++ b/include/linux/compiler-gcc4.h
@@ -36,4 +36,18 @@
    the kernel context */
 #define __cold			__attribute__((__cold__))
 
+
+#if __GNUC_MINOR__ >= 5
+/*
+ * Mark a position in code as unreachable.  This can be used to
+ * suppress control flow warnings after asm blocks that transfer
+ * control elsewhere.
+ *
+ * Early snapshots of gcc 4.5 don't support this and we can't detect
+ * this in the preprocessor, but we can live with this because they're
+ * unreleased.  Really, we need to have autoconf for the kernel.
+ */
+#define unreachable() __builtin_unreachable()
+#endif
+
 #endif
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 04fb513..59f2089 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -144,6 +144,11 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
 # define barrier() __memory_barrier()
 #endif
 
+/* Unreachable code */
+#ifndef unreachable
+# define unreachable() do { } while (1)
+#endif
+
 #ifndef RELOC_HIDE
 # define RELOC_HIDE(ptr, off)					\
   ({ unsigned long __ptr;					\
-- 
1.6.2.5
