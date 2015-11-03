From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 17/28] lkl tools: host lib: memory mapped I/O helpers
Date: Tue,  3 Nov 2015 22:20:48 +0200
Message-ID: <1446582059-17355-18-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-arch.vger.kernel.org

This patch adds helpers for implementing the memory mapped I/O host
operations that can be used by code that implements host
devices. Generic host operations for lkl_ioremap and lkl_iomem_access
are provided that allows multiplexing multiple I/O memory mapped
regions.

The host device code can create a new memory mapped I/O region with
register_iomem(). Read and write access functions need to be provided
by the caller.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 tools/lkl/lib/iomem.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/lkl/lib/iomem.h |  14 ++++++
 2 files changed, 133 insertions(+)
 create mode 100644 tools/lkl/lib/iomem.c
 create mode 100644 tools/lkl/lib/iomem.h

diff --git a/tools/lkl/lib/iomem.c b/tools/lkl/lib/iomem.c
new file mode 100644
index 0000000..bef6b71
--- /dev/null
+++ b/tools/lkl/lib/iomem.c
@@ -0,0 +1,119 @@
+#include <string.h>
+#include <stdint.h>
+#include <lkl_host.h>
+
+#include "iomem.h"
+
+#define IOMEM_OFFSET_BITS		24
+#define IOMEM_ADDR_MARK			0x8000000
+#define MAX_IOMEM_REGIONS		(IOMEM_ADDR_MARK >> IOMEM_OFFSET_BITS)
+
+#define IOMEM_ADDR_TO_INDEX(addr) \
+	((((uintptr_t)addr & ~IOMEM_ADDR_MARK) >> IOMEM_OFFSET_BITS))
+#define IOMEM_ADDR_TO_OFFSET(addr) \
+	(((uintptr_t)addr) & ((1 << IOMEM_OFFSET_BITS) - 1))
+#define IOMEM_INDEX_TO_ADDR(i) \
+	(void *)(uintptr_t)((i << IOMEM_OFFSET_BITS) | IOMEM_ADDR_MARK)
+
+static struct iomem_region {
+	void *base;
+	void *iomem_addr;
+	int size;
+	const struct lkl_iomem_ops *ops;
+} *iomem_regions[MAX_IOMEM_REGIONS];
+
+static struct iomem_region *find_iomem_reg(void *base)
+{
+	int i;
+
+	for (i = 0; i < MAX_IOMEM_REGIONS; i++)
+		if (iomem_regions[i] && iomem_regions[i]->base == base)
+			return iomem_regions[i];
+
+	return NULL;
+}
+
+int register_iomem(void *base, int size, const struct lkl_iomem_ops *ops)
+{
+	struct iomem_region *iomem_reg;
+	int i;
+
+	if (size > (1 << IOMEM_OFFSET_BITS) - 1)
+		return -1;
+
+	if (find_iomem_reg(base))
+		return -1;
+
+	for (i = 0; i < MAX_IOMEM_REGIONS; i++)
+		if (!iomem_regions[i])
+			break;
+
+	if (i >= MAX_IOMEM_REGIONS)
+		return -1;
+
+	iomem_reg = lkl_host_ops.mem_alloc(sizeof(*iomem_reg));
+	if (!iomem_reg)
+		return -1;
+
+	iomem_reg->base = base;
+	iomem_reg->size = size;
+	iomem_reg->ops = ops;
+	iomem_reg->iomem_addr = IOMEM_INDEX_TO_ADDR(i);
+
+	iomem_regions[i] = iomem_reg;
+
+	return 0;
+}
+
+void unregister_iomem(void *iomem_base)
+{
+	struct iomem_region *iomem_reg = find_iomem_reg(iomem_base);
+	unsigned int index;
+
+	if (!iomem_reg) {
+		lkl_printf("%s: invalid iomem base %p\n", __func__, iomem_base);
+		return;
+	}
+
+	index = IOMEM_ADDR_TO_INDEX(iomem_reg->iomem_addr);
+	if (index >= MAX_IOMEM_REGIONS) {
+		lkl_printf("%s: invalid iomem_addr %p\n", __func__,
+			   iomem_reg->iomem_addr);
+		return;
+	}
+
+	iomem_regions[index] = NULL;
+	lkl_host_ops.mem_free(iomem_reg->base);
+	lkl_host_ops.mem_free(iomem_reg);
+}
+
+void *lkl_ioremap(long addr, int size)
+{
+	struct iomem_region *iomem_reg = find_iomem_reg((void *)addr);
+
+	if (iomem_reg && size <= iomem_reg->size)
+		return iomem_reg->iomem_addr;
+
+	return NULL;
+}
+
+int lkl_iomem_access(const volatile void *addr, void *res, int size, int write)
+{
+	struct iomem_region *iomem_reg;
+	int index = IOMEM_ADDR_TO_INDEX(addr);
+	int offset = IOMEM_ADDR_TO_OFFSET(addr);
+	int ret;
+
+	if (index > MAX_IOMEM_REGIONS || !iomem_regions[index] ||
+	    offset + size > iomem_regions[index]->size)
+		return -1;
+
+	iomem_reg = iomem_regions[index];
+
+	if (write)
+		ret = iomem_reg->ops->write(iomem_reg->base, offset, res, size);
+	else
+		ret = iomem_reg->ops->read(iomem_reg->base, offset, res, size);
+
+	return ret;
+}
diff --git a/tools/lkl/lib/iomem.h b/tools/lkl/lib/iomem.h
new file mode 100644
index 0000000..53707d7
--- /dev/null
+++ b/tools/lkl/lib/iomem.h
@@ -0,0 +1,14 @@
+#ifndef _LKL_LIB_IOMEM_H
+#define _LKL_LIB_IOMEM_H
+
+struct lkl_iomem_ops {
+	int (*read)(void *data, int offset, void *res, int size);
+	int (*write)(void *data, int offset, void *value, int size);
+};
+
+int register_iomem(void *base, int size, const struct lkl_iomem_ops *ops);
+void unregister_iomem(void *iomem_base);
+void *lkl_ioremap(long addr, int size);
+int lkl_iomem_access(const volatile void *addr, void *res, int size, int write);
+
+#endif /* _LKL_LIB_IOMEM_H */
-- 
2.1.0
