From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFC v2 1/7] sections.h: add sections header to collect
	all section info
Date: Fri, 19 Feb 2016 05:45:53 -0800
Message-ID: <1455889559-9428-2-git-send-email-mcgrof@kernel.org>
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

Linux makes extensive use of custom ELF header sections,
documentation for these are well scatterred. Unify this
documentation in a central place.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 Documentation/DocBook/Makefile      |   3 +-
 Documentation/DocBook/sections.tmpl |  99 ++++++++++++++++
 include/linux/sections.h            | 224 ++++++++++++++++++++++++++++++++++++
 3 files changed, 325 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/DocBook/sections.tmpl
 create mode 100644 include/linux/sections.h

diff --git a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
index d70f9b68174e..f2dfd46bf30a 100644
--- a/Documentation/DocBook/Makefile
+++ b/Documentation/DocBook/Makefile
@@ -15,7 +15,8 @@ DOCBOOKS := z8530book.xml device-drivers.xml \
 	    80211.xml debugobjects.xml sh.xml regulator.xml \
 	    alsa-driver-api.xml writing-an-alsa-driver.xml \
 	    tracepoint.xml gpu.xml media_api.xml w1.xml \
-	    writing_musb_glue_layer.xml crypto-API.xml iio.xml
+	    writing_musb_glue_layer.xml crypto-API.xml iio.xml \
+	    sections.xml
 
 include Documentation/DocBook/media/Makefile
 
diff --git a/Documentation/DocBook/sections.tmpl b/Documentation/DocBook/sections.tmpl
new file mode 100644
index 000000000000..96d8d88c1b93
--- /dev/null
+++ b/Documentation/DocBook/sections.tmpl
@@ -0,0 +1,99 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE set PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
+<set>
+  <setinfo>
+    <title>Linux ELF sections</title>
+    <subtitle>
+      Explains Linux ELF sections
+    </subtitle>
+
+    <copyright>
+      <year>2016</year>
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
+        This book documents the different custom ELF sections used on the Linux
+	kernel and defined on Linux's custom linker script.
+      </para>
+    </abstract>
+  </setinfo>
+  <book id="linux-elf-sections">
+    <bookinfo>
+      <title>Linux kernel ELF sections</title>
+
+      <abstract>
+!Pinclude/linux/sections.h Introduction
+      </abstract>
+    </bookinfo>
+
+      <chapter>
+      <title>Core Linux kernel sections</title>
+!Pinclude/linux/sections.h Core Linux kernel sections
+!Finclude/linux/sections.h SECTION_RODATA
+!Pinclude/linux/sections.h SECTION_TEXT
+!Pinclude/linux/sections.h SECTION_DATA
+      </chapter>
+
+      <chapter>
+      <title>Linux .init* sections</title>
+!Pinclude/linux/sections.h Linux init sections
+!Finclude/linux/sections.h SECTION_INIT_DATA
+!Finclude/linux/sections.h SECTION_INIT_RODATA
+!Finclude/linux/sections.h SECTION_INIT_CALL
+      </chapter>
+
+      <chapter>
+      <title>Linux .exit* sections</title>
+!Pinclude/linux/sections.h Linux exit sections
+!Finclude/linux/sections.h SECTION_EXIT
+!Finclude/linux/sections.h SECTION_EXIT_DATA
+!Finclude/linux/sections.h SECTION_EXIT_CALL
+      </chapter>
+
+      <chapter>
+      <title>Linux .ref* sections</title>
+!Pinclude/linux/sections.h Linux references to init sections
+!Finclude/linux/sections.h SECTION_REF
+!Finclude/linux/sections.h SECTION_REF_DATA
+!Finclude/linux/sections.h SECTION_REF_RODATA
+      </chapter>
+
+  </book>
+</set>
diff --git a/include/linux/sections.h b/include/linux/sections.h
new file mode 100644
index 000000000000..7b47bea4956a
--- /dev/null
+++ b/include/linux/sections.h
@@ -0,0 +1,224 @@
+#ifndef _LINUX_SECTIONS_H
+#define _LINUX_SECTIONS_H
+/*
+ * Linux ELF sections
+ *
+ * Copyright (C) 2016 Luis R. Rodriguez <mcgrof@kernel.org>
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
+ * The Linux vmlinux binary uses a custom linker script which adds
+ * some custom specialized ELF sections. This aims to document those
+ * sections. Each section must document the goal of the section, and
+ * address concurrency considerations when applicable.
+ */
+
+/**
+ * DOC: Core Linux kernel sections
+ *
+ * These are the core Linux kernel sections.
+ */
+
+/**
+ * SECTION_RODATA - read only data
+ *
+ * Macro name for code which must be protected from write access.
+ */
+#define SECTION_RODATA			.rodata
+
+/**
+ * SECTION_TEXT - kernel code execution section, read-only
+ *
+ * Macro name used to annotate code (functions) used during regular
+ * kernel run time. This is combined with SECTION_RODATA, only this
+ * section also gets execution allowed.
+ *
+ */
+#define SECTION_TEXT			.text
+
+/**
+ * SECTION_DATA - for read-write data
+ *
+ * Macro name for read-write data.
+ */
+#define SECTION_DATA			.data
+
+/**
+ * DOC: Linux init sections
+ *
+ * These sections are used for code and data structures used during boot or
+ * module initialization. On architectures that support it (x86, x86_64), all
+ * this code is freed up by the kernel right before the fist userspace init
+ * process is called when built-in to the kernel, and if modular it is freed
+ * after module initialization. Since the code is freed so early, in theory
+ * there should be no races against freeing this code with other CPUs. Init
+ * section code and data structures should never be exported with
+ * EXPORT_SYMBOL*() as the code will quickly become unavailable to the kernel
+ * after bootup.
+ */
+
+/**
+ * SECTION_INIT - boot initialization code
+ *
+ * Macro name used to annotate code (functions) used only during boot or driver
+ * initialization.
+ *
+ */
+#define SECTION_INIT			.init.text
+
+/**
+ * SECTION_INIT_DATA - boot initialization data
+ *
+ * Macro name used to annotate data structures used only during boot or driver
+ * initialization.
+ */
+#define SECTION_INIT_DATA		.init.data
+
+/**
+ * SECTION_INIT_RODATA - boot read-only initialization data
+ *
+ * Macro name used to annotate read-only code (functions) used only during boot
+ * or driver initialization.
+ */
+#define SECTION_INIT_RODATA		.init.rodata
+
+/**
+ * SECTION_INIT_CALL - special init call
+ *
+ * Special macro name used to annotate subsystem init call. These calls are
+ * are now grouped by functionality into separate subsections. Ordering inside
+ * the subsections is determined by link order.
+ */
+#define SECTION_INIT_CALL		.initcall
+
+/**
+ * DOC: Linux exit sections
+ *
+ * These sections are used to declare a functions and data structures which
+ * are only required on exit, the function or data structure will be dropped
+ * if the code declaring this section is not compiled as a module on
+ * architectures that support this (x86, x86_64). There is no special case
+ * handling for this code when built-in to the kernel.
+ */
+
+/**
+ * SECTION_EXIT - module exit code
+ *
+ * Macro name used to annotate code (functions) used only during module
+ * unload.
+ */
+#define SECTION_EXIT			.exit.text
+
+/**
+ * SECTION_EXIT_DATA - module exit data structures
+ *
+ * Macro name used to annotate data structures used only during module
+ * unload.
+ */
+#define SECTION_EXIT_DATA		.exit.data
+
+/**
+ * SECTION_EXIT_CALL - special exit call
+ *
+ * Special macro name used to annotate an exit exit routine, order
+ * is important and maintained by link order.
+ */
+#define SECTION_EXIT_CALL		.exitcall.exit
+
+/**
+ * DOC: Linux references to init sections
+ *
+ * These sections are used to teach modpost to not warn about possible
+ * misuses of init section code from other sections. If you use this
+ * your use case should document why you are certain such use of init
+ * sectioned code is valid. For more details refer to include/linux/init.h
+ * __ref, __refdata, and __refconst documentation.
+ */
+
+/**
+ * SECTION_REF - code referencing init is valid
+ *
+ * Macro name used to annotate that code (functions) declared with this section
+ * has been vetteed as valid for its reference or use of other code (functions)
+ * or data structures which are part of the init sections.
+ */
+#define SECTION_REF			.ref.text
+
+/**
+ * SECTION_REF_DATA - reference data structure are valid
+ *
+ * Macro name used to annotate data structures declared with this section have
+ * been vetteed for its reference or use of other code (functions) or data
+ * structures part of the init sections.
+ */
+#define SECTION_REF_DATA		.ref.data
+
+/**
+ * SECTION_REF_RODATA - const code or data structure referencing init is valid
+ *
+ * Macro name used to annotate const code (functions) const data structures which
+ * has been vetteed for its reference or use of other code (functions) or data
+ * structures part of the init sections.
+ */
+#define SECTION_REF_RODATA		.ref.rodata
+
+/**
+ * DOC: Custom Linux sections
+ *
+ * These are very custom Linux sections.
+ */
+
+#ifndef __ASSEMBLY__
+
+/*
+ * Without this you end up with the section macro
+ * as part of the name
+ */
+#define __SECTION_TBL(section, name, level)				\
+	#section ".tbl." #name "." #level
+
+/**
+ * SECTION_TBL - Linux linker table section
+ *
+ * @section: respective section
+ * @name: used to describe the use case
+ * @level: the order-level for the linker table
+ *
+ * Macro name used to annotate a linker table. For more details refer to
+ * include/linux/tables.h. Linker tables use standard Linux sections defined
+ * in this file.
+ */
+#define SECTION_TBL(section, name, level)                         	\
+	__SECTION_TBL(section, name, level)
+
+/*
+ * For use on linker scripts and helpers
+ */
+#define ___SECTION_TBL(section, name)					\
+	section##.tbl.##name
+/**
+ * SECTION_TBL_ALL - glob to capture all linker table uses for this section
+ *
+ * @section: respective section
+ *
+ * Macro name used by linker script to capture all linker tables uses for
+ * the given section. This is used by include/asm-generic/vmlinux.lds.h
+ */
+#define SECTION_TBL_ALL(section)					\
+	___SECTION_TBL(section,*)
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _LINUX_SECTIONS_H */
-- 
2.7.0
