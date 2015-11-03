From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 10/28] lkl: memory mapped I/O support
Date: Tue,  3 Nov 2015 22:20:41 +0200
Message-ID: <1446582059-17355-11-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:18465 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964819AbbKCUXL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Nov 2015 15:23:11 -0500
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>

All memory mapped I/O access is redirected to the host via the
iomem_access host operation. The host can setup the memory mapped I/O
region via the ioremap operation.

This allows the host to implement support for various devices, such as
block or network devices.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 arch/lkl/include/asm/io.h | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 arch/lkl/include/asm/io.h

diff --git a/arch/lkl/include/asm/io.h b/arch/lkl/include/asm/io.h
new file mode 100644
index 0000000..fd6f4af
--- /dev/null
+++ b/arch/lkl/include/asm/io.h
@@ -0,0 +1,104 @@
+#ifndef _ASM_LKL_IO_H
+#define _ASM_LKL_IO_H
+
+#include <asm/bug.h>
+#include <asm/host_ops.h>
+
+#define __raw_readb __raw_readb
+static inline u8 __raw_readb(const volatile void __iomem *addr)
+{
+	int ret;
+	u8 value;
+
+	ret = lkl_ops->iomem_access(addr, &value, sizeof(value), 0);
+	WARN(ret, "error reading iomem %p", addr);
+
+	return value;
+}
+
+#define __raw_readw __raw_readw
+static inline u16 __raw_readw(const volatile void __iomem *addr)
+{
+	int ret;
+	u16 value;
+
+	ret = lkl_ops->iomem_access(addr, &value, sizeof(value), 0);
+	WARN(ret, "error reading iomem %p", addr);
+
+	return value;
+}
+
+#define __raw_readl __raw_readl
+static inline u32 __raw_readl(const volatile void __iomem *addr)
+{
+	int ret;
+	u32 value;
+
+	ret = lkl_ops->iomem_access(addr, &value, sizeof(value), 0);
+	WARN(ret, "error reading iomem %p", addr);
+
+	return value;
+}
+
+#ifdef CONFIG_64BIT
+#define __raw_readq __raw_readq
+static inline u64 __raw_readq(const volatile void __iomem *addr)
+{
+	int ret;
+	u64 value;
+
+	ret = lkl_ops->iomem_access(addr, &value, sizeof(value), 0);
+	WARN(ret, "error reading iomem %p", addr);
+
+	return value;
+}
+#endif /* CONFIG_64BIT */
+
+#define __raw_writeb __raw_writeb
+static inline void __raw_writeb(u8 value, volatile void __iomem *addr)
+{
+	int ret;
+
+	ret = lkl_ops->iomem_access(addr, &value, sizeof(value), 1);
+	WARN(ret, "error writing iomem %p", addr);
+}
+
+#define __raw_writew __raw_writew
+static inline void __raw_writew(u16 value, volatile void __iomem *addr)
+{
+	int ret;
+
+	ret = lkl_ops->iomem_access(addr, &value, sizeof(value), 1);
+	WARN(ret, "error writing iomem %p", addr);
+}
+
+#define __raw_writel __raw_writel
+static inline void __raw_writel(u32 value, volatile void __iomem *addr)
+{
+	int ret;
+
+	ret = lkl_ops->iomem_access(addr, &value, sizeof(value), 1);
+	WARN(ret, "error writing iomem %p", addr);
+}
+
+#ifdef CONFIG_64BIT
+#define __raw_writeq __raw_writeq
+static inline void __raw_writeq(u64 value, volatile void __iomem *addr)
+{
+	int ret;
+
+	ret = lkl_ops->iomem_access(addr, &value, sizeof(value), 1);
+	WARN(ret, "error writing iomem %p", addr);
+}
+#endif /* CONFIG_64BIT */
+
+#define ioremap ioremap
+static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
+{
+	return (void __iomem *)lkl_ops->ioremap(offset, size);
+}
+
+#include <asm-generic/io.h>
+
+#endif /* _ASM_LKL_IO_H */
+
-- 
2.1.0
