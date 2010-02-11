From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH v2 2/5] pio-mapping: Add ARM support for the PIO mapping
	API
Date: Thu, 11 Feb 2010 17:55:21 +0000
Message-ID: <20100211175521.7848.76633.stgit@pc1117.cambridge.arm.com>
References: <20100211175417.7848.41807.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:43004 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756251Ab0BKRz2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Feb 2010 12:55:28 -0500
In-Reply-To: <20100211175417.7848.41807.stgit@pc1117.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Russell King <rmk@arm.linux.org.uk>

This patch introduces support for the PIO mapping API on the ARM
architecture. It is currently only meant as an example for discussions
and it can be further optimised.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Russell King <rmk@arm.linux.org.uk>
---
 arch/arm/Kconfig                   |    3 ++
 arch/arm/include/asm/pio-mapping.h |   66 ++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 0 deletions(-)
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
index 0000000..28d5834
--- /dev/null
+++ b/arch/arm/include/asm/pio-mapping.h
@@ -0,0 +1,66 @@
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
+#include <asm/fixmap.h>
+
+static inline void *pio_kmap(struct page *page, enum dma_data_direction dir)
+{
+	return kmap(page);
+}
+
+static inline void pio_kunmap(struct page *page, enum dma_data_direction dir)
+{
+	if (dir == DMA_FROM_DEVICE)
+		flush_dcache_page(page);
+	kunmap(page);
+}
+
+static inline void *pio_kmap_atomic(struct page *page, enum km_type idx,
+				    enum dma_data_direction dir)
+{
+	return kmap_atomic(page, idx);
+}
+
+static inline void pio_kunmap_atomic(void *addr, enum km_type idx,
+				     enum dma_data_direction dir)
+{
+	/* address higher than FIXADDR_START are flushed in kunmap_atomic */
+	if (dir == DMA_FROM_DEVICE && addr < (void *)FIXADDR_START)
+		__cpuc_flush_dcache_area(addr, PAGE_SIZE);
+	kunmap_atomic(addr, idx);
+}
+
+static inline void pio_begin(void *addr, size_t size,
+			     enum dma_data_direction dir)
+{
+}
+
+static inline void pio_end(void *addr, size_t size,
+			   enum dma_data_direction dir)
+{
+	if (dir == DMA_FROM_DEVICE)
+		__cpuc_flush_dcache_area(addr, size);
+}
+
+#endif	/* ASM_PIO_MAPPING_H */
