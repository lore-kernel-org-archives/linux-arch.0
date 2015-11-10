From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 1/2] asm/sections: Add helpers to check for section data
Date: Tue, 10 Nov 2015 18:11:56 +0100
Message-ID: <1447175517-10933-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33786 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544AbbKJRMA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Nov 2015 12:12:00 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Add a helper to check if an object (given an address and a size) is part
of a section (given beginning and end addresses). For convenience, also
provide a helper that performs this check for __init data using the
__init_begin and __init_end limits.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- use less ambiguous function names
- add comments to clarify further
---
 include/asm-generic/sections.h | 65 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index b58fd667f87b..af0254c09424 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -4,6 +4,7 @@
 /* References to section boundaries */
 
 #include <linux/compiler.h>
+#include <linux/types.h>
 
 /*
  * Usage guidelines:
@@ -63,4 +64,68 @@ static inline int arch_is_kernel_data(unsigned long addr)
 }
 #endif
 
+/**
+ * memory_contains - checks if an object is contained within a memory region
+ * @begin: virtual address of the beginning of the memory region
+ * @end: virtual address of the end of the memory region
+ * @virt: virtual address of the memory object
+ * @size: size of the memory object
+ *
+ * Returns: true if the object specified by @virt and @size is entirely
+ * contained within the memory region defined by @begin and @end, false
+ * otherwise.
+ */
+static inline bool memory_contains(void *begin, void *end, void *virt,
+				   size_t size)
+{
+	return virt >= begin && virt + size <= end;
+}
+
+/**
+ * memory_intersects - checks if the region occupied by an object intersects
+ *                     with another memory region
+ * @begin: virtual address of the beginning of the memory regien
+ * @end: virtual address of the end of the memory region
+ * @virt: virtual address of the memory object
+ * @size: size of the memory object
+ *
+ * Returns: true if an object's memory region, specified by @virt and @size,
+ * intersects with the region specified by @begin and @end, false otherwise.
+ */
+static inline bool memory_intersects(void *begin, void *end, void *virt,
+				     size_t size)
+{
+	void *vend = virt + size;
+
+	return (virt >= begin && virt < end) || (vend >= begin && vend < end);
+}
+
+/**
+ * init_section_contains - checks if an object is contained within the init
+ *                         section
+ * @virt: virtual address of the memory object
+ * @size: size of the memory object
+ *
+ * Returns: true if the object specified by @virt and @size is entirely
+ * contained within the init section, false otherwise.
+ */
+static inline bool init_section_contains(void *virt, size_t size)
+{
+	return memory_contains(__init_begin, __init_end, virt, size);
+}
+
+/**
+ * init_section_intersects - checks if the region occupied by an object
+ *                           intersects with the init section
+ * @virt: virtual address of the memory object
+ * @size: size of the memory object
+ *
+ * Returns: true if an object's memory region, specified by @virt and @size,
+ * intersects with the init section, false otherwise.
+ */
+static inline bool init_section_intersects(void *virt, size_t size)
+{
+	return memory_intersects(__init_begin, __init_end, virt, size);
+}
+
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
-- 
2.5.0
