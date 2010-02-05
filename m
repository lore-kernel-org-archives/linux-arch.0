From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH 1/4] pio-mapping: Add generic support for PIO mapping API
Date: Fri, 05 Feb 2010 16:31:49 +0000
Message-ID: <20100205163149.30827.29314.stgit@pc1117.cambridge.arm.com>
References: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:51893 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754090Ab0BEQbv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Feb 2010 11:31:51 -0500
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id o15GVneI005050
	for <linux-arch@vger.kernel.org>; Fri, 5 Feb 2010 16:31:49 GMT
In-Reply-To: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

Implement partial support for PIO mapping API. Currently only map/unmap
single and page functions are included. These functions are intended to
be used by device drivers doing PIO to page cache pages that may
potentially be mapped in user space and cause cache coherency issues.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 include/linux/pio-mapping.h |   61 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/pio-mapping.h

diff --git a/include/linux/pio-mapping.h b/include/linux/pio-mapping.h
new file mode 100644
index 0000000..9f53aff
--- /dev/null
+++ b/include/linux/pio-mapping.h
@@ -0,0 +1,61 @@
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
+#include <linux/mm.h>
+
+enum pio_data_direction {
+	PIO_BIDIRECTIONAL,
+	PIO_TO_DEVICE,
+	PIO_FROM_DEVICE,
+	PIO_NONE
+};
+
+#ifdef CONFIG_HAVE_ARCH_PIO
+#include <asm/pio-mapping.h>
+#else
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
+}
+
+#endif	/* CONFIG_HAVE_ARCH_PIO */
+
+#endif	/* PIO_MAPPING_H */
