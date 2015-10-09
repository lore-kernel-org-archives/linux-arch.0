From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 01/20] x86: introduce arch_memremap()
Date: Fri, 09 Oct 2015 18:15:43 -0400
Message-ID: <20151009221543.32203.63200.stgit@dwillia2-desk3.jf.intel.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ross Zwisler <ross.zwisler@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

In preparation for removing ioremap_cache() introduce arch_memremap()
for x86.  For now, arch_memremap(..., MEMREMAP_WB) and
arch_memremap(..., MEMREMAP_WT) are aliases for ioremap_cache() and
ioremap_wt() respectively.  While the memremap() conversion patches are
filtering through the other sub-systems further development of the
memremap interface may proceed.

This also initiates the guarantee that a successful call to
memremap(..., MEMREMAP_WB) has indeed established a cached mapping and
has not silently fallen back to uncached.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/x86/pat.txt |    2 ++
 arch/x86/Kconfig          |    1 +
 arch/x86/mm/ioremap.c     |   17 +++++++++++++++++
 drivers/nvdimm/Kconfig    |    2 +-
 include/linux/io.h        |    1 +
 kernel/memremap.c         |   25 +++++++++++++------------
 lib/Kconfig               |    5 ++++-
 7 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/Documentation/x86/pat.txt b/Documentation/x86/pat.txt
index 54944c71b819..8c908fa5ea26 100644
--- a/Documentation/x86/pat.txt
+++ b/Documentation/x86/pat.txt
@@ -40,6 +40,8 @@ ioremap_nocache        |    --    |    UC-     |       UC-        |
                        |          |            |                  |
 ioremap_wc             |    --    |    --      |       WC         |
                        |          |            |                  |
+memremap(MEMREMAP_WB)  |    WB    |    WB      |       WB         |
+                       |          |            |                  |
 ioremap_wt             |    --    |    --      |       WT         |
                        |          |            |                  |
 set_memory_uc          |    UC-   |    --      |       --         |
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 328c8352480c..488cb210d055 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -27,6 +27,7 @@ config X86
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_MEMREMAP
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_MMIO_FLUSH
 	select ARCH_HAS_SG_CHAIN
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index b9c78f3bcd67..123431ae702f 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -317,6 +317,23 @@ void __iomem *ioremap_cache(resource_size_t phys_addr, unsigned long size)
 }
 EXPORT_SYMBOL(ioremap_cache);
 
+void *arch_memremap(resource_size_t phys_addr, size_t size,
+		unsigned long flags)
+{
+	int prot;
+
+	if (flags & MEMREMAP_WB)
+		prot = _PAGE_CACHE_MODE_WB;
+	else if (flags & MEMREMAP_WT)
+		prot = _PAGE_CACHE_MODE_WT;
+	else
+		return NULL;
+
+	return (void __force *) __ioremap_caller(phys_addr, size, prot,
+			__builtin_return_address(0));
+}
+EXPORT_SYMBOL(arch_memremap);
+
 void __iomem *ioremap_prot(resource_size_t phys_addr, unsigned long size,
 				unsigned long prot_val)
 {
diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index 53c11621d5b1..b8e9d8b46f33 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -1,5 +1,6 @@
 menuconfig LIBNVDIMM
 	tristate "NVDIMM (Non-Volatile Memory Device) Support"
+	depends on ARCH_HAS_MEMREMAP
 	depends on PHYS_ADDR_T_64BIT
 	depends on BLK_DEV
 	help
@@ -19,7 +20,6 @@ if LIBNVDIMM
 config BLK_DEV_PMEM
 	tristate "PMEM: Persistent memory block device support"
 	default LIBNVDIMM
-	depends on HAS_IOMEM
 	select ND_BTT if BTT
 	select ND_PFN if NVDIMM_PFN
 	help
diff --git a/include/linux/io.h b/include/linux/io.h
index de64c1e53612..4f150781735d 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -153,5 +153,6 @@ enum {
 
 void *memremap(resource_size_t offset, size_t size, unsigned long flags);
 void memunmap(void *addr);
+void *arch_memremap(resource_size_t offset, size_t size, unsigned long flags);
 
 #endif /* _LINUX_IO_H */
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 72b0c66628b6..8bd5fe05d4a4 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -24,6 +24,16 @@ __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
 }
 #endif
 
+/* temporary while we convert arch implementations to arch_memremap */
+__weak void *arch_memremap(resource_size_t offset, size_t size,
+		unsigned long flags)
+{
+	if (flags & MEMREMAP_WB)
+		return (void __force *) ioremap_cache(offset, size);
+	else if (flags & MEMREMAP_WT)
+		return (void __force *) ioremap_wt(offset, size);
+}
+
 /**
  * memremap() - remap an iomem_resource as cacheable memory
  * @offset: iomem resource start address
@@ -48,7 +58,6 @@ __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
 void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 {
 	int is_ram = region_intersects(offset, size, "System RAM");
-	void *addr = NULL;
 
 	if (is_ram == REGION_MIXED) {
 		WARN_ONCE(1, "memremap attempted on mixed range %pa size: %#lx\n",
@@ -58,7 +67,6 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 
 	/* Try all mapping types requested until one returns non-NULL */
 	if (flags & MEMREMAP_WB) {
-		flags &= ~MEMREMAP_WB;
 		/*
 		 * MEMREMAP_WB is special in that it can be satisifed
 		 * from the direct map.  Some archs depend on the
@@ -66,9 +74,7 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 		 * the requested range is potentially in "System RAM"
 		 */
 		if (is_ram == REGION_INTERSECTS)
-			addr = __va(offset);
-		else
-			addr = ioremap_cache(offset, size);
+			return __va(offset);
 	}
 
 	/*
@@ -77,18 +83,13 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 	 * address mapping.  Enforce that this mapping is not aliasing
 	 * "System RAM"
 	 */
-	if (!addr && is_ram == REGION_INTERSECTS && flags) {
+	if (is_ram == REGION_INTERSECTS) {
 		WARN_ONCE(1, "memremap attempted on ram %pa size: %#lx\n",
 				&offset, (unsigned long) size);
 		return NULL;
 	}
 
-	if (!addr && (flags & MEMREMAP_WT)) {
-		flags &= ~MEMREMAP_WT;
-		addr = ioremap_wt(offset, size);
-	}
-
-	return addr;
+	return arch_memremap(offset, size, flags);
 }
 EXPORT_SYMBOL(memremap);
 
diff --git a/lib/Kconfig b/lib/Kconfig
index 2e491ac15622..8d99b4e6a45b 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -520,7 +520,10 @@ config SG_SPLIT
 #
 
 config ARCH_HAS_SG_CHAIN
-	def_bool n
+	bool
+
+config ARCH_HAS_MEMREMAP
+	bool
 
 config ARCH_HAS_PMEM_API
 	bool
