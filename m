Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:24537 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1947107AbWKKGSy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 11 Nov 2006 01:18:54 -0500
Subject: [PATCH] add dev_archdata to struct device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 17:18:39 +1100
Message-Id: <1163225919.4982.219.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Linux Arch list <linux-arch@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
List-ID: <linux-arch.vger.kernel.org>

Add arch specific dev_archdata to struct device

Adds an arch specific struct dev_arch to struct device. This enables
architecture to add specific fields to every device in the system, like
DMA operation pointers, NUMA node ID, firmware specific data, etc...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Andrew, this patch replaces:
  add-arch-specific-dev_sysdata-to-struct-device.patch
that you put in -mm the other day. You should also remove:
  change-acpi-to-use-dev_sysdata-instead-of-firmware_data.patch
as a new version of it is following, adapted to the name change
(sysdata -> archdata).
 
Index: linux-cell/include/asm-alpha/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-alpha/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-arm/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-arm/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-arm26/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-arm26/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-avr32/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-avr32/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-cris/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-cris/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-frv/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-frv/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-generic/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-generic/device.h	2006-11-11 14:29:36.000000000 +1100
@@ -0,0 +1,12 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef _ASM_GENERIC_DEVICE_H
+#define _ASM_GENERIC_DEVICE_H
+
+struct dev_archdata {
+};
+
+#endif /* _ASM_GENERIC_DEVICE_H */
Index: linux-cell/include/asm-h8300/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-h8300/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-i386/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-i386/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-ia64/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-ia64/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-m32r/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-m32r/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-m68k/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-m68k/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-m68knommu/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-m68knommu/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-mips/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-mips/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-parisc/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-parisc/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-powerpc/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-powerpc/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-ppc/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-ppc/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-s390/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-s390/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-sh/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-sh/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-sh64/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-sh64/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-sparc/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-sparc/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-sparc64/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-sparc64/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-um/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-um/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-v850/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-v850/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-x86_64/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-x86_64/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-xtensa/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-xtensa/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/linux/device.h
===================================================================
--- linux-cell.orig/include/linux/device.h	2006-11-11 14:25:07.000000000 +1100
+++ linux-cell/include/linux/device.h	2006-11-11 14:30:00.000000000 +1100
@@ -21,6 +21,7 @@
 #include <linux/pm.h>
 #include <asm/semaphore.h>
 #include <asm/atomic.h>
+#include <asm/device.h>
 
 #define DEVICE_NAME_SIZE	50
 #define DEVICE_NAME_HALF	__stringify(20)	/* Less than half to accommodate slop */
@@ -382,6 +383,8 @@
 
 	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
 					     override */
+	/* arch specific additions */
+	struct dev_archdata	archdata;
 
 	/* class_device migration path */
 	struct list_head	node;


