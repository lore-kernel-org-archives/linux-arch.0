From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH] vmlinux.lds.h: Fix errors in comments and clean up
Date: Wed,  9 Dec 2015 02:12:14 +0100
Message-ID: <1449623534-15807-1-git-send-email-clemens.gruber@pqgruber.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Clemens Gruber <clemens.gruber@pqgruber.com>
List-Id: linux-arch.vger.kernel.org

Fix multiple errors in the comments, improve the wording, fix
indentation and clean up some areas reported by checkpatch.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 include/asm-generic/vmlinux.lds.h | 57 ++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c4bd0e2..14df54f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1,9 +1,9 @@
 /*
- * Helper macros to support writing architecture specific
+ * Helper macros to support writing architecture-specific
  * linker scripts.
  *
- * A minimal linker scripts has following content:
- * [This is a sample, architectures may have special requiriements]
+ * A minimal linker script has the following content:
+ * [This is an example, architectures may have special requirements]
  *
  * OUTPUT_FORMAT(...)
  * OUTPUT_ARCH(...)
@@ -36,7 +36,7 @@
  *	STABS_DEBUG
  *	DWARF_DEBUG
  *
- *	DISCARDS		// must be the last
+ *	DISCARDS		// must be the last section
  * }
  *
  * [__init_begin, __init_end] is the init section that may be freed after init
@@ -45,7 +45,7 @@
  * [_stext, _etext] is the text section
  * [_sdata, _edata] is the data section
  *
- * Some of the included output section have their own set of constants.
+ * Some of the included output sections have their own set of constants.
  * Examples are: [__initramfs_start, __initramfs_end] for initramfs and
  *               [__nosave_begin, __nosave_end] for the nosave data
  */
@@ -66,8 +66,9 @@
 #define STRUCT_ALIGNMENT 32
 #define STRUCT_ALIGN() . = ALIGN(STRUCT_ALIGNMENT)
 
-/* The actual configuration determine if the init/exit sections
- * are handled as text/data or they can be discarded (which
+/*
+ * The actual configuration determines if the init/exit sections
+ * are handled as text/data or if they can be discarded (which
  * often happens at runtime)
  */
 #ifdef CONFIG_HOTPLUG_CPU
@@ -216,7 +217,7 @@
 	VMLINUX_SYMBOL(__start___verbose) = .;                          \
 	*(__verbose)                                                    \
 	VMLINUX_SYMBOL(__stop___verbose) = .;				\
-	LIKELY_PROFILE()		       				\
+	LIKELY_PROFILE()						\
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
 	TRACEPOINT_STR()
@@ -249,7 +250,7 @@
 	*(.data..init_task)
 
 /*
- * Read only Data
+ * Read-only Data
  */
 #define RO_DATA_SECTION(align)						\
 	. = ALIGN((align));						\
@@ -406,20 +407,24 @@
 	}								\
 	. = ALIGN((align));
 
-/* RODATA & RO_DATA provided for backward compatibility.
- * All archs are supposed to use RO_DATA() */
+/*
+ * RODATA & RO_DATA provided for backward compatibility.
+ * All archs are supposed to use RO_DATA()
+ */
 #define RODATA          RO_DATA_SECTION(4096)
 #define RO_DATA(align)  RO_DATA_SECTION(align)
 
 #define SECURITY_INIT							\
 	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
 		VMLINUX_SYMBOL(__security_initcall_start) = .;		\
-		*(.security_initcall.init) 				\
+		*(.security_initcall.init)				\
 		VMLINUX_SYMBOL(__security_initcall_end) = .;		\
 	}
 
-/* .text section. Map to function alignment to avoid address changes
- * during second ld run in second ld pass when generating System.map */
+/*
+ * .text section. Map to function alignment to avoid address changes
+ * during second ld run in second ld pass when generating System.map
+ */
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
 		*(.text.hot .text .text.fixup .text.unlikely)		\
@@ -427,17 +432,20 @@
 	MEM_KEEP(init.text)						\
 	MEM_KEEP(exit.text)						\
 
-
-/* sched.text is aling to function alignment to secure we have same
- * address even at second ld pass when generating System.map */
+/*
+ * .sched.text section. Map to function alignment to avoid address changes
+ * during second ld run in second ld pass when generating System.map
+ */
 #define SCHED_TEXT							\
 		ALIGN_FUNCTION();					\
 		VMLINUX_SYMBOL(__sched_text_start) = .;			\
 		*(.sched.text)						\
 		VMLINUX_SYMBOL(__sched_text_end) = .;
 
-/* spinlock.text is aling to function alignment to secure we have same
- * address even at second ld pass when generating System.map */
+/*
+ * .spinlock.text section. Map to function alignment to avoid address changes
+ * during second ld run in second ld pass when generating System.map
+ */
 #define LOCK_TEXT							\
 		ALIGN_FUNCTION();					\
 		VMLINUX_SYMBOL(__lock_text_start) = .;			\
@@ -469,7 +477,7 @@
 /* Section used for early init (in .S files) */
 #define HEAD_TEXT  *(.head.text)
 
-#define HEAD_TEXT_SECTION							\
+#define HEAD_TEXT_SECTION						\
 	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {		\
 		HEAD_TEXT						\
 	}
@@ -557,7 +565,7 @@
 	}
 
 /*
- * Allow archectures to redefine BSS_FIRST_SECTIONS to add extra
+ * Allow architectures to redefine BSS_FIRST_SECTIONS to add extra
  * sections to the front of bss.
  */
 #ifndef BSS_FIRST_SECTIONS
@@ -795,12 +803,13 @@
  * The sections following CONSTRUCTORS are arranged so their
  * typical alignment matches.
  * A cacheline is typical/always less than a PAGE_SIZE so
- * the sections that has this restriction (or similar)
- * is located before the ones requiring PAGE_SIZE alignment.
+ * the sections that have this restriction (or similar ones)
+ * are located before the ones requiring PAGE_SIZE alignment.
  * NOSAVE_DATA starts and ends with a PAGE_SIZE alignment which
  * matches the requirement of PAGE_ALIGNED_DATA.
  *
- * use 0 as page_align if page_aligned data is not used */
+ * Use 0 as page_align if page_aligned data is not used
+ */
 #define RW_DATA_SECTION(cacheline, pagealigned, inittask)		\
 	. = ALIGN(PAGE_SIZE);						\
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {				\
-- 
2.6.3
