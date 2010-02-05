From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH 2/4] pio-mapping: Add ARM support for the PIO mapping API
Date: Fri, 05 Feb 2010 16:31:54 +0000
Message-ID: <20100205163154.30827.6636.stgit@pc1117.cambridge.arm.com>
References: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:51905 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754090Ab0BEQb4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Feb 2010 11:31:56 -0500
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id o15GVteI005063
	for <linux-arch@vger.kernel.org>; Fri, 5 Feb 2010 16:31:55 GMT
In-Reply-To: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

This patch introduces support for the PIO mapping API on the ARM
architecture. It is currently only meant as an example for discussions
and it can be further optimised.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Kconfig                   |    3 ++
 arch/arm/include/asm/pio-mapping.h |   52 ++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/pio-mapping.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c33ca8..e48adcf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -161,6 +161,9 @@ config ARCH_MTD_XIP
 config GENERIC_HARDIRQS_NO__DO_IRQ
 	def_bool y
 
+config HAVE_ARCH_PIO
+	def_bool y
+
 if OPROFILE
 
 config OPROFILE_ARMV6
diff --git a/arch/arm/include/asm/pio-mapping.h b/arch/arm/include/asm/pio-mapping.h
new file mode 100644
index 0000000..d7c866a
--- /dev/null
+++ b/arch/arm/include/asm/pio-mapping.h
@@ -0,0 +1,52 @@
+/*
+ * include/linux/pio-mapping.h
+ *
+ * Copyright (C) 2010 ARM Ltd.
+ * Written by Catalin Marinas <catalin.marinas@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef ASM_PIO_MAPPING_H
+#define ASM_PIO_MAPPING_H
+
+#include <asm/cacheflush.h>
+
+static inline void *pio_map_single(void *addr, size_t size,
+				   enum pio_data_direction dir)
+{
+	return addr;
+}
+
+static inline void pio_unmap_single(void *addr, size_t size,
+				    enum pio_data_direction dir)
+{
+	if (dir == PIO_FROM_DEVICE)
+		__cpuc_flush_dcache_area(addr, size);
+}
+
+static inline void *pio_map_page(struct page *page, unsigned long offset,
+				 size_t size, enum pio_data_direction dir)
+{
+	return page_address(page) + offset;
+}
+
+static inline void pio_unmap_page(void *addr, size_t size,
+				  enum pio_data_direction dir)
+{
+	if (dir == PIO_FROM_DEVICE)
+		__cpuc_flush_dcache_area(addr, size);
+}
+
+#endif	/* ASM_PIO_MAPPING_H */
