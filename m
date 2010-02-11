From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH v2 1/5] pio-mapping: Add generic support for PIO mapping
	API
Date: Thu, 11 Feb 2010 17:55:16 +0000
Message-ID: <20100211175516.7848.39767.stgit@pc1117.cambridge.arm.com>
References: <20100211175417.7848.41807.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:42999 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755272Ab0BKRzX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Feb 2010 12:55:23 -0500
In-Reply-To: <20100211175417.7848.41807.stgit@pc1117.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Russell King <rmk@arm.linux.org.uk>

Implement partial support for PIO mapping API similar to the kmap API
used for highmem. These functions are intended to be used by device
drivers doing PIO to page cache pages that may potentially be mapped in
user space and cause cache coherency issues.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Russell King <rmk@arm.linux.org.uk>
---
 include/linux/pio-mapping.h |   65 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/pio-mapping.h

diff --git a/include/linux/pio-mapping.h b/include/linux/pio-mapping.h
new file mode 100644
index 0000000..5b216fb
--- /dev/null
+++ b/include/linux/pio-mapping.h
@@ -0,0 +1,65 @@
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
+#ifndef PIO_MAPPING_H
+#define PIO_MAPPING_H
+
+#include <linux/highmem.h>
+#include <linux/dma-mapping.h>
+
+#ifdef CONFIG_HAVE_ARCH_PIO
+#include <asm/pio-mapping.h>
+#else
+
+static inline void *pio_kmap(struct page *page, enum dma_data_direction dir)
+{
+	return kmap(page);
+}
+
+static inline void pio_kunmap(struct page *page, enum dma_data_direction dir)
+{
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
+}
+
+#endif	/* CONFIG_HAVE_ARCH_PIO */
+
+#endif	/* PIO_MAPPING_H */
