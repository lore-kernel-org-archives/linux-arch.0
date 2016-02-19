From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFC v2 2/7] tables.h: add linker table support
Date: Fri, 19 Feb 2016 05:45:54 -0800
Message-ID: <1455889559-9428-3-git-send-email-mcgrof@kernel.org>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc: benh@kernel.crashing.org, ming.lei@canonical.com, masami.hiramatsu.pt@hitachi.com, linux-arch@vger.kernel.org, xen-devel@lists.xensource.com, linux@arm.linux.org.uk, x86@kernel.org, anil.s.keshavamurthy@intel.com, arnd@arndb.de, rusty@rustcorp.com.au, jbaron@akamai.com, boris.ostrovsky@oracle.com, andriy.shevchenko@linux.intel.com, mcb30@ipxe.org, jgross@suse.com, ananth@in.ibm.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, luto@amacapital.net, "Luis R. Rodriguez" <mcgrof@kernel.org>, david.vrabel@citrix.com, dwmw2@infradead.org, davem@davemloft.net
List-Id: linux-arch.vger.kernel.org

A linker table is a data structure that is stitched together from items
in multiple object files. Linux has historically implicitly used linker
tables for ages, however they were all built in an adhoc manner which
requires linker script modifications, per architecture. This adds a
general linker table solution so that a new linker table can be
implemented by changing C code only. The Linux linker table was
originally based on Michael Brown's iPXE's linker table solution but
has been significantly modified to fit Linux's use in its integration.

The same philosoph is borrowed, extended and further simplified:

Linker tables enable an extremely light weight linker build time
solution for feature ordering and selection, this can help to both
simplify init sequences in a generic fashion and helps avoiding code
bit-rotting when desirable.

Bit rotting avoidance is enabled by *granting the option* to force
compilation of code and only enable linking object code in when
specific features have been enabled. It accomplishes this by using
linker sections, the lightweight feature ordering of code is enabled
by taking advantage of the old binutils ld SORT() on features
specific sections.

Contrary to iPXE's solution, which strives to force compilation
of all features, Linux' solution strives to encourage usage of linker
tables to force compilation of code *only on designated code*. Linker
tables can be used without requiring one to force code compilation
of features that use it though, to take advantage of the simplification
of init sequences.

Linux code that uses linker tables *and* wishes to always require
compilation but selectively linking must use new kbuild target object
that helps accomplishes this, table-y. Linux code that uses linker
tables but does not want to require forcing compilation can use the
good 'ol obj-y targets.

Used commit 67a10ef000cb7 from iPXE upstream [0] as the starting point
for development and evaluation of Linux's integration, further changes
made and evaluation of different linker table options for Linux are
available on the linker-table userspace tree [1].

[0] git://git.ipxe.org/ipxe.git
[1] https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linker-tables.git/

v2:

- modified completely to match feedback by community, made equivalent
  modifications to userspace solution. This is pretty much a complete
  rewrite of how we present and use linker tables. By using standard
  sections we no longer have to make custom linker script extensions
  for each new linker table solution, you just pick a linker table
  type by section type.
- extend documention considerably, including use of kdoc
- drop ICC hacks per popular request to ignore such issues for now
- use sections.h - this lets us streamline a clean use case of
  well documented sections. To help further with this make use of
  SECTION_TBL() to allow use of these in code and SECTION_TBL_ALL()
  on linker scripts, as well as SECTION_TBL_ALL_STR() on relocs.c
  when needed.

Cc: Michael Brown <mcb30@ipxe.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 Documentation/DocBook/Makefile           |   2 +-
 Documentation/DocBook/linker-tables.tmpl | 169 ++++++++
 Documentation/kbuild/makefiles.txt       |  19 +
 arch/x86/tools/relocs.c                  |   3 +
 include/asm-generic/vmlinux.lds.h        |  15 +-
 include/linux/sections.h                 |   4 +-
 include/linux/tables.h                   | 696 +++++++++++++++++++++++++++++++
 scripts/Makefile.build                   |   4 +-
 scripts/Makefile.clean                   |   1 +
 scripts/Makefile.lib                     |  12 +
 tools/include/linux/sections.h           |  13 +
 11 files changed, 929 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/DocBook/linker-tables.tmpl
 create mode 100644 include/linux/tables.h
 create mode 100644 tools/include/linux/sections.h

diff --git a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
index f2dfd46bf30a..57ff543f4d38 100644
--- a/Documentation/DocBook/Makefile
+++ b/Documentation/DocBook/Makefile
@@ -16,7 +16,7 @@ DOCBOOKS := z8530book.xml device-drivers.xml \
 	    alsa-driver-api.xml writing-an-alsa-driver.xml \
 	    tracepoint.xml gpu.xml media_api.xml w1.xml \
 	    writing_musb_glue_layer.xml crypto-API.xml iio.xml \
-	    sections.xml
+	    sections.xml linker-tables.xml
 
 include Documentation/DocBook/media/Makefile
 
diff --git a/Documentation/DocBook/linker-tables.tmpl b/Documentation/DocBook/linker-tables.tmpl
new file mode 100644
index 000000000000..1256d3e3cd4d
--- /dev/null
+++ b/Documentation/DocBook/linker-tables.tmpl
@@ -0,0 +1,169 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE set PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
+<set>
+  <setinfo>
+    <title>Linux linker tables</title>
+    <subtitle>
+      Explains Linux' linker tables work.
+    </subtitle>
+
+    <copyright>
+      <year>2015-2016</year>
+      <holder>Luis R. Rodriguez</holder>
+    </copyright>
+
+    <authorgroup>
+      <author>
+        <firstname>Luis</firstname>
+        <surname>Rodriguez</surname>
+        <affiliation>
+          <address><email>mcgrof@kernel.org</email></address>
+        </affiliation>
+      </author>
+    </authorgroup>
+
+    <legalnotice>
+      <para>
+        This documentation is free software; you can redistribute
+        it and/or modify it under the terms of the GNU General Public
+        License version 2 as published by the Free Software Foundation.
+      </para>
+      <para>
+        This documentation is distributed in the hope that it will be
+        useful, but WITHOUT ANY WARRANTY; without even the implied
+        warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+        See the GNU General Public License for more details.
+      </para>
+      <para>
+        You should have received a copy of the GNU General Public
+        License along with this documentation; if not, write to the Free
+        Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+        MA 02111-1307 USA
+      </para>
+      <para>
+        For more details see the file COPYING in the source
+        distribution of Linux.
+      </para>
+    </legalnotice>
+
+    <abstract>
+      <para>
+        This book documents the Linux' use of linker tables, how you can
+        use them and how they work.
+      </para>
+    </abstract>
+  </setinfo>
+  <book id="linux-linux-tables">
+    <bookinfo>
+      <title>Linux linker tables</title>
+
+      <abstract>
+!Pinclude/linux/tables.h Introduction
+      </abstract>
+    </bookinfo>
+
+      <chapter>
+      <title>About Linker tables</title>
+
+	<sect1>
+	<title>Linker table provenance and userspace testing</title>
+!Pinclude/linux/tables.h Linker table provenance and userspace testing
+	</sect1>
+
+	<sect1>
+	<title>The code bit-rot problem</title>
+!Pinclude/linux/tables.h The code bit-rot problem
+	</sect1>
+
+	<sect1>
+	<title>Avoiding the code bit-rot problem when desirable</title>
+!Pinclude/linux/tables.h Avoiding the code bit-rot problem when desirable
+	</sect1>
+      </chapter>
+
+      <chapter>
+      <title>Using linker tables in Linux</title>
+
+	<sect1>
+      <title>Using target table-y and table-n</title>
+!Pinclude/linux/tables.h Using target table-y and table-n
+	</sect1>
+
+	<sect1>
+	<title>Opting out of forcing compilation</title>
+!Pinclude/linux/tables.h Opting out of forcing compilation
+	</sect1>
+
+	<sect1>
+	<title>How linker tables simplify inits</title>
+!Pinclude/linux/tables.h How linker tables simplify inits
+	</sect1>
+
+      </chapter>
+
+      <chapter>
+      <title>Linker table helpers</title>
+!Pinclude/linux/tables.h LINKTABLE_ALIGNMENT
+!Finclude/linux/tables.h LINKTABLE_SIZE
+!Finclude/linux/tables.h LINKTABLE_EMPTY
+!Finclude/linux/tables.h LINKTABLE_START
+!Finclude/linux/tables.h LINKTABLE_END
+!Finclude/linux/tables.h LINKTABLE_ADDR_WITHIN
+      </chapter>
+
+      <chapter>
+      <title>Constructing Linker tables</title>
+!Pinclude/linux/tables.h Constructing linker tables
+
+	<sect1>
+	<title>Weak linker tables constructors</title>
+!Pinclude/linux/tables.h Weak linker tables constructors
+!Finclude/linux/tables.h LINKTABLE_TEXT_WEAK
+!Finclude/linux/tables.h LINKTABLE_DATA_WEAK
+!Finclude/linux/tables.h LINKTABLE_RO_WEAK
+!Finclude/linux/tables.h LINKTABLE_INIT_WEAK
+!Finclude/linux/tables.h LINKTABLE_INIT_DATA_WEAK
+	</sect1>
+
+	<sect1>
+	<title>Regular linker linker table constructors</title>
+!Pinclude/linux/tables.h Regular linker linker table constructors
+!Finclude/linux/tables.h LINKTABLE_TEXT
+!Finclude/linux/tables.h LINKTABLE_DATA
+!Finclude/linux/tables.h LINKTABLE_RO
+!Finclude/linux/tables.h LINKTABLE_INIT
+!Finclude/linux/tables.h LINKTABLE_INIT_DATA
+	</sect1>
+      </chapter>
+
+      <chapter>
+      <title>Declaring Linker tables</title>
+!Pinclude/linux/tables.h Declaring Linker tables
+!Finclude/linux/tables.h DECLARE_LINKTABLE_TEXT
+!Finclude/linux/tables.h DECLARE_LINKTABLE_DATA
+!Finclude/linux/tables.h DECLARE_LINKTABLE_RO
+!Finclude/linux/tables.h DECLARE_LINKTABLE_INIT
+!Finclude/linux/tables.h DECLARE_LINKTABLE_INIT_DATA
+      </chapter>
+
+      <chapter>
+      <title>Defining Linker tables</title>
+!Pinclude/linux/tables.h Defining Linker tables
+!Finclude/linux/tables.h DEFINE_LINKTABLE_TEXT
+!Finclude/linux/tables.h DEFINE_LINKTABLE_DATA
+!Finclude/linux/tables.h DEFINE_LINKTABLE_RO
+!Finclude/linux/tables.h DEFINE_LINKTABLE_INIT
+!Finclude/linux/tables.h DEFINE_LINKTABLE_INIT_DATA
+      </chapter>
+
+      <chapter>
+      <title>Iterating over Linker tables</title>
+!Pinclude/linux/tables.h Iterating over Linker tables
+!Finclude/linux/tables.h LINKTABLE_FOR_EACH
+!Finclude/linux/tables.h LINKTABLE_RUN_ALL
+!Finclude/linux/tables.h LINKTABLE_RUN_ERR
+      </chapter>
+
+  </book>
+</set>
diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 13f888a02a3d..a0a35445d968 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -1088,6 +1088,25 @@ When kbuild executes, the following steps are followed (roughly):
 	In this example, extra-y is used to list object files that
 	shall be built, but shall not be linked as part of built-in.o.
 
+    table-y table-m and table-
+
+	To avoid code bit-rot you may wish to avoid using #ifdefs on your
+	code. Bit-rot is possible if certain features may not be enabled
+	on certain build environments. The table-y, specifies targets which you
+	always wish to force compilation on, but wish to only enable linking in
+	if the feature is enabled, these are features taking advantage of
+	Linux's linker tables. For details on how to implement a feature using
+	linker tablesrefer to include/linux/tables.h. Use of table-m is not
+	yet supported.
+
+	Example:
+		table-$(CONFIG-FEATURE_FOO) += foo.o
+
+	An alternative to using table-y, is to use extra-y followed by the
+	respective obj-y:
+
+		extra-y += foo.o
+		obj-$(CONFIG-FEATURE_FOO) += foo.o
 
 --- 6.7 Commands useful for building a boot image
 
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 0c2fae8d929d..07b335c67139 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -1,4 +1,5 @@
 /* This is included from relocs_32/64.c */
+#include <linux/sections.h>
 
 #define ElfW(type)		_ElfW(ELF_BITS, type)
 #define _ElfW(bits, type)	__ElfW(bits, type)
@@ -68,6 +69,8 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"__end_rodata|"
 	"__initramfs_start|"
 	"(jiffies|jiffies_64)|"
+	SECTION_TBL_ALL_STR(SECTION_RODATA) "|"
+	SECTION_TBL_ALL_STR(SECTION_INIT) "|"
 #if ELF_BITS == 64
 	"__per_cpu_load|"
 	"init_per_cpu__.*|"
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c4bd0e2c173c..eb23738ef4bd 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -55,6 +55,7 @@
 #endif
 
 #include <linux/export.h>
+#include <linux/sections.h>
 
 /* Align . to a 8 byte boundary equals to maximum function alignment. */
 #define ALIGN_FUNCTION()  . = ALIGN(8)
@@ -199,7 +200,8 @@
 
 /* .data section */
 #define DATA_DATA							\
-	*(.data)							\
+	*(SECTION_DATA)							\
+	*(SORT(SECTION_TBL_ALL(SECTION_DATA)))				\
 	*(.ref.data)							\
 	*(.data..shared_aligned) /* percpu related */			\
 	MEM_KEEP(init.data)						\
@@ -255,7 +257,9 @@
 	. = ALIGN((align));						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		VMLINUX_SYMBOL(__start_rodata) = .;			\
-		*(.rodata) *(.rodata.*)					\
+		*(.rodata)						\
+		*(SORT(SECTION_TBL_ALL(SECTION_RODATA)))		\
+		*(.rodata.*)						\
 		*(__vermagic)		/* Kernel version magic */	\
 		. = ALIGN(8);						\
 		VMLINUX_SYMBOL(__start___tracepoints_ptrs) = .;		\
@@ -422,7 +426,8 @@
  * during second ld run in second ld pass when generating System.map */
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
-		*(.text.hot .text .text.fixup .text.unlikely)		\
+		*(.text.hot SECTION_TEXT .text.fixup .text.unlikely)		\
+		*(SORT(SECTION_TBL_ALL(SECTION_TEXT)))			\
 		*(.ref.text)						\
 	MEM_KEEP(init.text)						\
 	MEM_KEEP(exit.text)						\
@@ -507,7 +512,8 @@
 
 /* init and exit section handling */
 #define INIT_DATA							\
-	*(.init.data)							\
+	*(SECTION_INIT_DATA)						\
+	*(SORT(SECTION_TBL_ALL(SECTION_INIT_DATA)))			\
 	MEM_DISCARD(init.data)						\
 	KERNEL_CTORS()							\
 	MCOUNT_REC()							\
@@ -531,6 +537,7 @@
 
 #define INIT_TEXT							\
 	*(.init.text)							\
+	*(SORT(SECTION_TBL_ALL(SECTION_INIT)))				\
 	MEM_DISCARD(init.text)
 
 #define EXIT_DATA							\
diff --git a/include/linux/sections.h b/include/linux/sections.h
index 7b47bea4956a..53de435e0056 100644
--- a/include/linux/sections.h
+++ b/include/linux/sections.h
@@ -203,6 +203,8 @@
 #define SECTION_TBL(section, name, level)                         	\
 	__SECTION_TBL(section, name, level)
 
+#endif /* __ASSEMBLY__ */
+
 /*
  * For use on linker scripts and helpers
  */
@@ -219,6 +221,4 @@
 #define SECTION_TBL_ALL(section)					\
 	___SECTION_TBL(section,*)
 
-#endif /* __ASSEMBLY__ */
-
 #endif /* _LINUX_SECTIONS_H */
diff --git a/include/linux/tables.h b/include/linux/tables.h
new file mode 100644
index 000000000000..292b704f2b4d
--- /dev/null
+++ b/include/linux/tables.h
@@ -0,0 +1,696 @@
+#ifndef _LINUX_LINKER_TABLES_H
+#define _LINUX_LINKER_TABLES_H
+
+#include <linux/sections.h>
+
+/*
+ * Linux linker tables
+ *
+ * Copyright (C) 2005-2009 Michael Brown <mcb30@ipxe.org>
+ * Copyright (C) 2015-2016 Luis R. Rodriguez <mcgrof@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Due to this file being licensed under the GPL there is controversy over
+ * whether this permits you to write a module that #includes this file
+ * without placing your module under the GPL.  Please consult a lawyer for
+ * advice before doing this.
+ */
+
+/**
+ * DOC: Introduction
+ *
+ * A linker table is a data structure that is stitched together from items
+ * in multiple object files. Linux has historically implicitly used linker
+ * tables for ages, however they were all built in an adhoc manner which
+ * requires linker script modifications, per architecture. This linker table
+ * solution provides a general linker table facility so that a new linker table
+ * can be implemented by changing C code only.
+ *
+ * Linker tables help you simplify init sequences by using ELF sections, linker
+ * build time selective sorting (disabled options get ignored), and can
+ * optionally also be used to help you avoid code bit-rot due to #ifdery
+ * collateral.
+ */
+
+/**
+ * DOC: Linker table provenance and userspace testing
+ *
+ * The Linux implementation of linker tables is derivative of iPXE linker
+ * table's solution (iPXE commit 67a10ef000cb7 [0]).  To see how this code
+ * evolved or to extend and test and use this code in userspace refer to the
+ * userspace linker-table tree [1].  This repository can be used for ease of
+ * testing of extensions and sampling of changes prior to inclusion into Linux,
+ * it is intended to be kept up to date to match Linux's solution. Contrary to
+ * iPXE's solution, which strives to force compilation of everything using
+ * linker tables, Linux's solution allows for developers to be selective over
+ * where one wishes to force compilation, this then is just an optional feature
+ * for the Linux linker table solution.
+ *
+ * [0] git://git.ipxe.org/ipxe.git
+ *
+ * [1] https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linker-tables.git/
+ */
+
+/**
+ * DOC: The code bit-rot problem
+ *
+ * Overuse of C #ifdefs can be problematic for certain types of code.  Linux
+ * provides a rich array of features, but all these features take up valuable
+ * space in a kernel image. The traditional solution to this problem has been
+ * for each feature to have its own Kconfig entry and for the respective code
+ * to be wrapped around #ifdefs, allowing the feature to be compiled in only
+ * if desired.
+ *
+ * The problem with this is that over time it becomes very difficult and time
+ * consuming to compile, let alone test, all possible versions of Linux. Code
+ * that is not typically used tends to suffer from bit-rot over time. It can
+ * become difficult to predict which combinations of compile-time options will
+ * result in code that can compile and link correctly.
+ */
+
+/**
+ * DOC: Avoiding the code bit-rot problem when desirable
+ *
+ * To solve the code bit-rot problem linker tables can be used on Linux, it
+ * enables you to always force compiling of select features that one wishes to
+ * avoid bit-rot while still enabling you to disable linking feature code into
+ * the final kernel image if the features have been disabled via Kconfig.
+ * Linux's linker tables allows for developers to be selective over where one
+ * wishes to take advantage of the optional feature of forcing compilation and
+ * only linking in enabled features.
+ *
+ * To use linker tables and to optionally take advantage of avoiding code
+ * bit-rot, feature code should be implemented in separate C files, and should
+ * be designed to always be compiled -- they should not be guarded with a C
+ * code #ifdef CONFIG_FOO statements, consideration must also be taken for
+ * sub-features which depend on the main CONFIG_FOO option, as they will be
+ * disabled if they depend on CONFIG_FOO and therefore not compiled. To force
+ * compilation and only link when features are needed a new optional target
+ * table-y can be used on Makefiles, documented below.
+ *
+ * Currently only built-in features are supported, modular support is not
+ * yet supported, however you can make use of sub-features for modules
+ * if they are independent and can simply be linked into modules.
+ */
+
+/**
+ * DOC: Using target table-y and table-n
+ *
+ * Let's assume we want to always force compilation of feature FOO in the
+ * kernel but avoid linking it. When you enable the FOO feature via Kconfig
+ * you'd end up with:
+ *
+ *	#define CONFIG_FOO 1
+ *
+ * You typically would then just use this on your Makefile to selectively
+ * compile and link the feature:
+ *
+ *	obj-$(CONFIG_FOO) += foo.o
+ *
+ * You could instead optionally use the new linker table object:
+ *
+ *	table-$(CONFIG_FOO) += foo.o
+ *
+ * Alternatively, this would be the equivalent of listing:
+ *
+ *	extra += foo.o
+ *	obj-$(CONFIG_FOO) += foo.o
+ *
+ * Both are mechanisms which can be used to take advantage of forcing
+ * compilation with linker tables, however making use of table-$(CONFIG_FOO)
+ * is encouraged as it helps with annotating linker tables clearly where
+ * compilation is forced.
+ */
+
+/**
+ * DOC: Opting out of forcing compilation
+ *
+ * If you want to opt-out of forcing compilation you would use the typical
+ * obj-$(CONFIG_FOO) += foo.o and foo.o will only be compiled and linked
+ * in when enabled. Using both table-$(CONFIG_FOO) and obj-($CONFIG_FOO)
+ * will result with the feature on your binary only if you've enabled
+ * CONFIG_FOO, however using table-$(CONFIG_FOO) will always force compilation,
+ * this is why avoiding code bit-rot is an optional fature for Linux linker
+ * tables.
+ */
+
+/**
+ * DOC: How linker tables simplify inits
+ *
+ * Traditionally, we would implement features in C code as follows:
+ *
+ *	foo_init();
+ *
+ * You'd then have a foo.h which would have:
+ *
+ *	#ifdef CONFIG_FOO
+ *	#else
+ *	static inline void foo(void) { }
+ *	#endif
+ *
+ * With linker tables this is no longer necessary as your init routines would
+ * be implicit, you'd instead call:
+ *
+ *	call_init_fns();
+ *
+ * call_init_fns() would call all functions present in your init table and if
+ * and only if foo.o gets linked in, then its initialisation function will be
+ * called, whether you use obj-$(CONFIG_FOO) or table-$(CONFIG_FOO).
+ *
+ * The linker script takes care of assembling the tables for us. All of our
+ * table sections have names of the format SECTION_NAME*.tbl.NAME.N. Here
+ * SECTION_NAME is one of the standard sections in include/linux/sections.h,
+ * and NAME designates the specific use case for the linker table, the table.
+ * N is a digit decimal number used to impose an "order level" upon the tables
+ * if required. NN= (empty string) is reserved for the symbol indicating "table
+ * start", and N=~ is reserved for the symbol indicating "table end". In order
+ * for the call_init_fns() to work behind the scenes the custom linker script
+ * would need to define the beginning of the table, the end of the table, and
+ * in between it should use SORT() to give order-level effect. Now, typically
+ * such type of requirements would require custom linker script modifications
+ * but Linux's linker tables builds on top of already existing standard Linux
+ * ELF sections, each with different purposes. This lets you build and add
+ * new tables without needing custom linker script modifications. This is
+ * also done to support all architectures. All that is needed then is to
+ * ensure a respective common linker table entry is added to the shared
+ * include/asm-generic/vmlinux.lds.h. There should be a respective:
+ *
+ *	*(SORT(SECTION_TBL_ALL(SECTION_NAME)))
+ *
+ * entry for each type of supported section there. If your SECTION_NAME
+ * is not yet supported, consider adding support for it.
+ *
+ * The order-level is really only a helper, if only one order level is
+ * used, the next contributing factor to order is the order of the code
+ * in the C file, and the order of the objects in the Makefile. Using
+ * an order level then should not really be needed in most cases, its
+ * use however enables to compartamentalize code into tables where ordering
+ * through C file or through the Makefile would otherwise be very difficult
+ * or if one wanted to enable very specific initialization semantics.
+ *
+ * As an example, suppose that we want to create a "frobnicator"
+ * feature framework, and allow for several independent modules to
+ * provide frobnicating services. Then we would create a frob.h
+ * header file containing e.g.
+ *
+ *	struct frobnicator {
+ *		const char *name;
+ *		void (*frob) (void);
+ *	};
+ *
+ *	DECLARE_LINKTABLE_INIT(struct frobnicator, frobnicator_fns);
+ *
+ * Any module providing frobnicating services would look something
+ * like
+ *
+ *	#include "frob.h"
+ *	static void my_frob(void) {
+ *		... Do my frobnicating
+ *	}
+ *	LINKTABLE(frobnicator_fns, all) my_frobnicator = {
+ *		.name = "my_frob",
+ *		.frob = my_frob,
+ *	};
+ *
+ * The central frobnicator code (frob.c) would use the frobnicating
+ * modules as follows
+ *
+ *	#include "frob.h"
+ *
+ *	void frob_all(void) {
+ *		struct frob *frob;
+ *
+ *		LINKTABLE_FOR_EACH(frob, frobnicator_fns) {
+ *			pr_info("Calling frobnicator \"%s\"\n", frob->name);
+ *			frob->frob();
+ *		}
+ *	}
+ */
+
+/**
+ * DOC: Linker table helpers
+ *
+ * These are helpers for linker tables.
+ */
+
+/**
+ * LINKTABLE_ALIGNMENT - get linker table alignment
+ *
+ * @name: linker table
+ *
+ * Gives you the linker table alignment.
+ */
+#define LINKTABLE_ALIGNMENT(name)	__alignof__(__typeof__(name[0]))
+
+/**
+ * LINKTABLE_SIZE - get number of entries in linker table
+ *
+ * @name: linker table
+ *
+ * This gives you the number of entries in linker table.
+ * Example usage:
+ *
+ *   unsigned int num_frobs = LINKTABLE_SIZE(frobnicator_fns);
+ */
+#define LINKTABLE_SIZE(name)	((name##__end) - (name))
+
+/**
+ * LINKTABLE_EMPTY - check if link table is empty
+ *
+ * @name: linker table
+ *
+ * Returns true if link table is emtpy.
+ *
+ *   bool is_empty = LINKTABLE_EMPTY(frobnicator_fns);
+ */
+#define LINKTABLE_EMPTY(name)	(LINKTABLE_SIZE(name) == 0)
+
+/**
+ * LINKTABLE_START - get address of start of linker table.
+ *
+ * @tbl: linker table
+ *
+ * This gives you the start address of the linker table.
+ * This should give you the address of the first entry.
+ *
+ */
+#define LINKTABLE_START(tbl)	tbl
+
+/**
+ * LINKTABLE_END - get address of endd of linker table.
+ *
+ * @tbl: linker table
+ *
+ * This gives you the end address of the linker table.
+ * This should give you the address of the end of the
+ * linker table. This will match the start address if the
+ * linker table is empty.
+ */
+#define LINKTABLE_END(tbl)	tbl##__end
+
+/**
+ * LINKTABLE_ADDR_WITHIN - returns true if address is in range
+ *
+ * @tbl: linker table
+ * @address: address to query for
+ *
+ * Returns true if the address is part of the linker table.
+ */
+#define LINKTABLE_ADDR_WITHIN(tbl, addr)				\
+	 (addr >= (unsigned long) LINKTABLE_START(tbl) &&		\
+          addr < (unsigned long) LINKTABLE_END(tbl))
+
+/**
+ * DOC: Constructing linker tables
+ *
+ * Linker tables constructors are used to build an entry into a linker table.
+ * Linker table constructors exist for each type of supported section.
+ *
+ * You have weak and regular type of link table entry constructors.
+ */
+
+/**
+ * DOC: Weak linker tables constructors
+ *
+ * The weak attribute is desirable if you want an entry you can replace at
+ * link time. A very special use case for linker tables is the first entry.
+ * A weak attribute is used for the first entry to ensure that this entry's
+ * address matches the end address of the table when the linker table is
+ * emtpy, but will also point to the first real entry of the table once not
+ * empty. When the first entry is linked in, it takes place of the first entry.
+ */
+
+/**
+ * LINKTABLE_DATA_WEAK - Constructs a weak linker table entry for data
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Constructs a weak linker table which we data.
+ */
+#define LINKTABLE_DATA_WEAK(name, level)				\
+	      __typeof__(name[0])					\
+	      __attribute__((used,					\
+			     weak,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(SECTION_TBL(SECTION_DATA, name, level))))
+
+/**
+ * LINKTABLE_TEXT_WEAK - Constructs a weak linker table entry for execution
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Constructs a weak linker table which we for execution. These will be
+ * read-only.
+ */
+#define LINKTABLE_TEXT_WEAK(name, level)				\
+	      __typeof__(name[0])					\
+	      __attribute__((used,					\
+			     weak,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(SECTION_TBL(SECTION_TEXT, name, level))))
+
+
+/**
+ * LINKTABLE_RO_WEAK - Constructs a weak read-only linker table entry
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Constructs a weak linker table which we know only requires read-only access.
+ */
+#define LINKTABLE_RO_WEAK(name, level)					\
+	const __typeof__(name[0])					\
+	      __attribute__((used,					\
+			     weak,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(SECTION_TBL(SECTION_RODATA, name, level))))
+
+/**
+ * LINKTABLE_INIT_WEAK - Constructs a weak linker table entry for init code
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Constructs a weak linker table which will need at init for execution.
+ */
+#define LINKTABLE_INIT_WEAK(name, level)					\
+	      __typeof__(name[0])					\
+	      __attribute__((used,					\
+			     weak,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(SECTION_TBL(SECTION_INIT, name, level))))
+
+/**
+ * LINKTABLE_INIT_DATA_WEAK - Constructs a weak linker table entry for initdata
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Constructs a weak linker table which will need at init for data.
+ */
+#define LINKTABLE_INIT_DATA_WEAK(name, level)				\
+	      __typeof__(name[0])					\
+	      __attribute__((used,					\
+			     weak,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(SECTION_TBL(SECTION_INIT_DATA, name, level))))
+
+/**
+ * DOC: Regular linker linker table constructors
+ *
+ * Regular constructors are expected to be used for valid linker table entries.
+ * Valid uses of weak entries other than the beginning and is currently
+ * untested but should in theory work.
+ */
+
+/**
+ * LINKTABLE_TEXT - Declares a linker table entry for execution
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Declares a linker table to be used for execution.
+ */
+#define LINKTABLE_TEXT(name, level)					\
+	      __typeof__(name[0])					\
+	      __attribute__((used,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(SECTION_TBL(SECTION_TEXT, name, level))))
+
+/**
+ * LINKTABLE_DATA - Declares a data linker table entry
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Declares a data linker table entry. These are read-write.
+ */
+#define LINKTABLE_DATA(name, level)					\
+	      __typeof__(name[0])					\
+	      __attribute__((used,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(SECTION_TBL(SECTION_DATA, name, level))))
+/**
+ * LINKTABLE_RO - Declares a read-only linker table entry.
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Declares a linker table which we know only requires read-only access.
+ */
+#define LINKTABLE_RO(name, level)					\
+	const __typeof__(name[0])					\
+	      __attribute__((used,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(SECTION_TBL(SECTION_RODATA, name, level))))
+
+/**
+ * LINKTABLE_INIT - Declares a linker table entry to be used on init.
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Declares a linker table entry which we will use during init for execution.
+ */
+#define LINKTABLE_INIT(name, level)					\
+	      __typeof__(name[0])					\
+	      __attribute__((used,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(SECTION_TBL(SECTION_INIT, name, level))))
+/**
+ * LINKTABLE_INIT_DATA - Declares a linker table entry to be used on init data.
+ *
+ * @name: linker table name
+ * @level: order level
+ *
+ * Declares a linker table entry which we will use during init for data.
+ */
+#define LINKTABLE_INIT_DATA(name, level)					\
+	      __typeof__(name[0])					\
+	      __attribute__((used,					\
+			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
+			     section(SECTION_TBL(SECTION_INIT_DATA, name, level))))
+
+
+/**
+ * DOC: Declaring Linker tables
+ *
+ * Declarers are used to help code access the linker tables. Typically
+ * header files for subsystems would declare the linker tables to enable
+ * easy access to add new entries, and to iterate over the list of table.
+ */
+
+/**
+ * DECLARE_LINKTABLE_TEXT - Declares linker table entry for exectuion
+ *
+ * @type: data type
+ * @name: table name
+ *
+ * Declares a linker table entry for execution.
+ */
+#define DECLARE_LINKTABLE_TEXT(type, name)				\
+	 extern type name[], name##__end[];
+
+/**
+ * DECLARE_LINKTABLE_DATA - Declares a data linker table entry
+ *
+ * @type: data type
+ * @name: table name
+ *
+ * Declares a data linker table entry.
+ */
+#define DECLARE_LINKTABLE_DATA(type, name)				\
+	 extern type name[], name##__end[];
+
+/**
+ * DECLARE_LINKTABLE_RO - Declares a read-only linker table entry
+ *
+ * @type: data type
+ * @name: table name
+ *
+ * Declares a read-only linker table entry.
+ */
+#define DECLARE_LINKTABLE_RO(type, name)				\
+	 extern const type name[], name##__end[];
+
+/**
+ * DECLARE_LINKTABLE_INIT - Declares a linker table entry to be used on init
+ *
+ * @type: data type
+ * @name: table name
+ *
+ * Declares a linker table entry to be used on init for execution.
+ */
+#define DECLARE_LINKTABLE_INIT(type, name)				\
+	 extern type name[], name##__end[];
+
+/**
+ * DECLARE_LINKTABLE_INIT_DATA - Declares a data init linker table entry
+ *
+ * @type: data type
+ * @name: table name
+ *
+ * Declares a linker table entry to be used on init for data
+ */
+#define DECLARE_LINKTABLE_INIT_DATA(type, name)				\
+	 extern type name[], name##__end[];
+
+
+/**
+ * DOC: Defining Linker tables
+ *
+ * Linker tables are defined in the code that takes ownership over
+ * the linker table. This is typically done in the same code that is in
+ * charge of iterating over the linker table as well.
+ */
+
+/**
+ * DEFINE_LINKTABLE_TEXT - Defines a linker table for execution
+ *
+ * @type: data type
+ * @name: table name
+ *
+ * Defines a linker table which used for execution.
+ */
+#define DEFINE_LINKTABLE_TEXT(type, name)				\
+	DECLARE_LINKTABLE_TEXT(type, name);				\
+	LINKTABLE_TEXT_WEAK(name, ) VMLINUX_SYMBOL(name)[0] = {};	\
+	LTO_REFERENCE_INITCALL(name);					\
+	LINKTABLE_TEXT(name, ~) VMLINUX_SYMBOL(name##__end)[0] = {};\
+	LTO_REFERENCE_INITCALL(name##__end);
+
+/**
+ * DEFINE_LINKTABLE_DATA - Defines a linker table for data
+ *
+ * @type: data type
+ * @name: table name
+ *
+ * Defines a linker table which used for data.
+ */
+#define DEFINE_LINKTABLE_DATA(type, name)				\
+	DECLARE_LINKTABLE_DATA(type, name);				\
+	LINKTABLE_DATA_WEAK(name, ) VMLINUX_SYMBOL(name)[0] = {};	\
+	LTO_REFERENCE_INITCALL(name);					\
+	LINKTABLE_DATA(name, ~) VMLINUX_SYMBOL(name##__end)[0] = {};\
+	LTO_REFERENCE_INITCALL(name##__end);
+
+/**
+ * DEFINE_LINKTABLE_RO - Defines a read-only linker table
+ *
+ * @type: data type
+ * @name: table name
+ *
+ * Defines a linker table which we know only requires read-only access.
+ */
+#define DEFINE_LINKTABLE_RO(type, name)					\
+	DECLARE_LINKTABLE_RO(type, name);				\
+	LINKTABLE_RO_WEAK(name, ) VMLINUX_SYMBOL(name)[0] = {};		\
+	LTO_REFERENCE_INITCALL(name);					\
+	LINKTABLE_RO(name, ~) VMLINUX_SYMBOL(name##__end)[0] = {};	\
+	LTO_REFERENCE_INITCALL(name##__end);
+
+/**
+ * DEFINE_LINKTABLE_INIT - Defines an init time linker table for execution
+ *
+ * @type: data type
+ * @name: table name
+ *
+ * Defines a linker table. If you are adding a new type you should
+ * enable CONFIG_DEBUG_SECTION_MISMATCH and ensure routines that make
+ * use of the linker tables get a respective __ref tag.
+ */
+#define DEFINE_LINKTABLE_INIT(type, name)					\
+	DECLARE_LINKTABLE_INIT(type, name);					\
+	LINKTABLE_INIT_WEAK(name, ) VMLINUX_SYMBOL(name)[0] = {};		\
+	LTO_REFERENCE_INITCALL(name);						\
+	LINKTABLE_INIT(name, ~) VMLINUX_SYMBOL(name##__end)[0] = {};	\
+	LTO_REFERENCE_INITCALL(name##__end);
+
+/**
+ * DEFINE_LINKTABLE_INIT_DATA - Defines an init time linker table for data
+ *
+ * @type: data type
+ * @name: table name
+ *
+ * Defines a linker table for init data. If you are adding a new type you
+ * should enable CONFIG_DEBUG_SECTION_MISMATCH and ensure routines that make
+ * use of the linker tables get a respective __ref tag.
+ */
+#define DEFINE_LINKTABLE_INIT_DATA(type, name)					\
+	DECLARE_LINKTABLE_INIT_DATA(type, name);					\
+	LINKTABLE_INIT_DATA_WEAK(name, ) VMLINUX_SYMBOL(name)[0] = {};		\
+	LTO_REFERENCE_INITCALL(name);						\
+	LINKTABLE_INIT_DATA(name, ~) VMLINUX_SYMBOL(name##__end)[0] = {};	\
+	LTO_REFERENCE_INITCALL(name##__end);
+
+/**
+ * DOC: Iterating over Linker tables
+ *
+ * To make use of the linker tables you want to be able to iterate over
+ * them. This section documents the different iterators available.
+ */
+
+/**
+ * LINKTABLE_FOR_EACH - iterate through all entries within a linker table
+ *
+ * @pointer: entry pointer
+ * @tbl: linker table
+ *
+ * Example usage:
+ *
+ *   struct frobnicator *frob;
+ *
+ *   LINKTABLE_FOR_EACH(frob, frobnicator_fns) {
+ *     ...
+ *   }
+ */
+#define LINKTABLE_FOR_EACH(pointer, tbl)				\
+	for (pointer = LINKTABLE_START(tbl);				\
+	     pointer < LINKTABLE_END(tbl);				\
+	     pointer++)
+
+/**
+ * LINKTABLE_RUN_ALL - iterate and run through all entries on a linker table
+ *
+ * @tbl: linker table
+ * @func: structure name for the function name we want to call.
+ * @args...: arguments to pass to func
+ *
+ * Example usage:
+ *
+ *   LINKTABLE_RUN_ALL(frobnicator_fns, some_run,);
+ */
+#define LINKTABLE_RUN_ALL(tbl, func, args...)				\
+do {									\
+	size_t i;							\
+	for (i = 0; i < LINKTABLE_SIZE(tbl); i++)			\
+		(tbl[i]).func (args);					\
+} while (0);
+
+/**
+ * LINKTABLE_RUN_ERR - run each linker table entry func and return error if any
+ *
+ * @tbl: linker table
+ * @func: structure name for the function name we want to call.
+ * @args...: arguments to pass to func
+ *
+ * Example usage:
+ *
+ *   unsigned int err = LINKTABLE_RUN_ERR(frobnicator_fns, some_run,);
+ */
+#define LINKTABLE_RUN_ERR(tbl, func, args...)				\
+({									\
+	size_t i;							\
+	int err = 0;							\
+	for (i = 0; !err && i < LINKTABLE_SIZE(tbl); i++)		\
+		err = (tbl[i]).func (args);				\
+		err; \
+})
+
+#endif /* _LINUX_LINKER_TABLES_H */
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2c47f9c305aa..33720528edaf 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -91,7 +91,7 @@ modorder-target := $(obj)/modules.order
 
 # We keep a list of all modules in $(MODVERDIR)
 
-__build: $(if $(KBUILD_BUILTIN),$(builtin-target) $(lib-target) $(extra-y)) \
+__build: $(if $(KBUILD_BUILTIN),$(builtin-target) $(lib-target) $(extra-y) $(table-y)) \
 	 $(if $(KBUILD_MODULES),$(obj-m) $(modorder-target)) \
 	 $(subdir-ym) $(always)
 	@:
@@ -294,7 +294,7 @@ $(obj)/%.o: $(src)/%.S FORCE
 	$(call if_changed_dep,as_o_S)
 
 targets += $(real-objs-y) $(real-objs-m) $(lib-y)
-targets += $(extra-y) $(MAKECMDGOALS) $(always)
+targets += $(extra-y) $(table-y) $(MAKECMDGOALS) $(always)
 
 # Linker scripts preprocessor (.lds.S -> .lds)
 # ---------------------------------------------------------------------------
diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
index 55c96cb8070f..0af1e12c9749 100644
--- a/scripts/Makefile.clean
+++ b/scripts/Makefile.clean
@@ -36,6 +36,7 @@ subdir-ymn	:= $(addprefix $(obj)/,$(subdir-ymn))
 # directory
 
 __clean-files	:= $(extra-y) $(extra-m) $(extra-)       \
+		   $(table-y) $(table-m) $(table-)       \
 		   $(always) $(targets) $(clean-files)   \
 		   $(host-progs)                         \
 		   $(hostprogs-y) $(hostprogs-m) $(hostprogs-)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 2edbcadb3d7f..5c71d1b0631a 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -12,6 +12,16 @@ export KBUILD_SUBDIR_CCFLAGS := $(KBUILD_SUBDIR_CCFLAGS) $(subdir-ccflags-y)
 # Figure out what we need to build from the various variables
 # ===========================================================================
 
+# Linker tables objects always wish to be built to avoid bit-rot in
+# code, but only linked in *iff* they were enabled. We accomplish this
+# using pegging linker table objects into extra-y, which forces
+# compilation and then using the respective table-y and table-m as
+# as hints for things we do want enabled. Objects which we want to
+# avoid linking in will be in table-, not table-y and table-m.
+extra-y += $(table-)
+obj-m += $(table-m)
+obj-y += $(table-y)
+
 # When an object is listed to be built compiled-in and modular,
 # only build the compiled-in version
 
@@ -72,6 +82,8 @@ real-objs-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)
 # Add subdir path
 
 extra-y		:= $(addprefix $(obj)/,$(extra-y))
+table-y		:= $(addprefix $(obj)/,$(table-y))
+table-m		:= $(addprefix $(obj)/,$(table-m))
 always		:= $(addprefix $(obj)/,$(always))
 targets		:= $(addprefix $(obj)/,$(targets))
 modorder	:= $(addprefix $(obj)/,$(modorder))
diff --git a/tools/include/linux/sections.h b/tools/include/linux/sections.h
new file mode 100644
index 000000000000..cc6f07f11583
--- /dev/null
+++ b/tools/include/linux/sections.h
@@ -0,0 +1,13 @@
+#ifndef _TOOLS_LINUX_SECTIONS_H_
+
+/* Mostly a copy of what we need only */
+
+#define SECTION_INIT			.init.text
+#define SECTION_RODATA			.rodata
+
+#define ___SECTION_TBL_STR(section, name)				\
+	#section ".tbl." #name
+#define SECTION_TBL_ALL_STR(section)					\
+	___SECTION_TBL_STR(section, *)
+
+#endif /* _TOOLS_LINUX_SECTIONS_H_ */
-- 
2.7.0
