From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 10/10] pmem: convert to generic memremap
Date: Sun, 19 Jul 2015 20:18:28 -0400
Message-ID: <20150720001828.30857.70895.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20209 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755174AbbGTAYZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Jul 2015 20:24:25 -0400
In-Reply-To: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
Cc: linux-arch@vger.kernel.org, tony.luck@intel.com, linux@arm.linux.org.uk, arnd@arndb.de, benh@kernel.crashing.org, mcgrof@suse.com, x86@kernel.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, geert@linux-m68k.org, toshi.kani@hp.com, ross.zwisler@linux.intel.com, hch@lst.de, linux-arm-kernel@lists.infradead.org

Update memremap_pmem() to query the architecture for the mapping type of
the given persistent memory range  and then pass those flags to generic
memremap().  arch_memremap_pmem_flags() is provided an address range to
evaluate in the event an arch has a need for different mapping types by
address range.  For example the ACPI NFIT carries EFI mapping types in
its memory range description table.

Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/io.h         |    7 +------
 arch/x86/mm/ioremap.c             |   10 ++++++++++
 drivers/nvdimm/pmem.c             |    2 +-
 include/linux/pmem.h              |   29 ++++++++++++++---------------
 tools/testing/nvdimm/Kbuild       |    4 ++--
 tools/testing/nvdimm/test/iomap.c |   34 +++++++++++++++++++++++++---------
 6 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index d0817f2762ab..3ca5d45b52b8 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -250,12 +250,7 @@ static inline void flush_write_buffers(void)
 #endif
 }
 
-static inline void __pmem *arch_memremap_pmem(resource_size_t offset,
-	unsigned long size)
-{
-	return (void __force __pmem *) ioremap_cache(offset, size);
-}
-
+unsigned long arch_memremap_pmem_flags(resource_size_t offset, size_t size);
 #endif /* __KERNEL__ */
 
 extern void native_io_delay(void);
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 4920f735f551..640e4c334836 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -203,6 +203,16 @@ err_free_memtype:
 	return NULL;
 }
 
+unsigned long arch_memremap_pmem_flags(resource_size_t offset, size_t size)
+{
+	/*
+	 * TODO: check the mapping type provided by platform firmware,
+	 * per range.
+	 */
+	return MEMREMAP_CACHE | MEMREMAP_STRICT;
+}
+EXPORT_SYMBOL(arch_memremap_pmem_flags);
+
 /**
  * ioremap_nocache     -   map bus memory into CPU space
  * @phys_addr:    bus address of the memory
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index ade9eb917a4d..bdc35110783f 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -211,7 +211,7 @@ static int pmem_rw_bytes(struct nd_namespace_common *ndns,
 
 static void pmem_free(struct pmem_device *pmem)
 {
-	memunmap_pmem(pmem->virt_addr);
+	memunmap(pmem->virt_addr);
 	release_mem_region(pmem->phys_addr, pmem->size);
 	kfree(pmem);
 }
diff --git a/include/linux/pmem.h b/include/linux/pmem.h
index d2114045a6c4..28a0b989f46d 100644
--- a/include/linux/pmem.h
+++ b/include/linux/pmem.h
@@ -28,10 +28,10 @@ static inline bool __arch_has_wmb_pmem(void)
 	return false;
 }
 
-static inline void __pmem *arch_memremap_pmem(resource_size_t offset,
+static inline unsigned long arch_memremap_pmem_flags(resource_size_t offset,
 		unsigned long size)
 {
-	return NULL;
+	return 0;
 }
 
 static inline void arch_memcpy_to_pmem(void __pmem *dst, const void *src,
@@ -43,8 +43,8 @@ static inline void arch_memcpy_to_pmem(void __pmem *dst, const void *src,
 
 /*
  * Architectures that define ARCH_HAS_PMEM_API must provide
- * implementations for arch_memremap_pmem(), arch_memcpy_to_pmem(),
- * arch_wmb_pmem(), and __arch_has_wmb_pmem().
+ * implementations for arch_memremap_pmem_flags(),
+ * arch_memcpy_to_pmem(), arch_wmb_pmem(), and __arch_has_wmb_pmem().
  */
 
 static inline void memcpy_from_pmem(void *dst, void __pmem const *src, size_t size)
@@ -52,11 +52,6 @@ static inline void memcpy_from_pmem(void *dst, void __pmem const *src, size_t si
 	memcpy(dst, (void __force const *) src, size);
 }
 
-static inline void memunmap_pmem(void __pmem *addr)
-{
-	iounmap((void __force __iomem *) addr);
-}
-
 /**
  * arch_has_wmb_pmem - true if wmb_pmem() ensures durability
  *
@@ -85,16 +80,15 @@ static inline bool arch_has_pmem_api(void)
  * default_memremap_pmem + default_memcpy_to_pmem is sufficient for
  * making data durable relative to i/o completion.
  */
-static void default_memcpy_to_pmem(void __pmem *dst, const void *src,
+static inline void default_memcpy_to_pmem(void __pmem *dst, const void *src,
 		size_t size)
 {
 	memcpy((void __force *) dst, src, size);
 }
 
-static void __pmem *default_memremap_pmem(resource_size_t offset,
-		unsigned long size)
+static inline unsigned long default_memremap_pmem_flags(void)
 {
-	return (void __pmem __force *)ioremap_wt(offset, size);
+	return MEMREMAP_WT | MEMREMAP_STRICT;
 }
 
 /**
@@ -112,9 +106,14 @@ static void __pmem *default_memremap_pmem(resource_size_t offset,
 static inline void __pmem *memremap_pmem(resource_size_t offset,
 		unsigned long size)
 {
+	unsigned long flags;
+
 	if (arch_has_pmem_api())
-		return arch_memremap_pmem(offset, size);
-	return default_memremap_pmem(offset, size);
+		flags = arch_memremap_pmem_flags(offset, size);
+	else
+		flags = default_memremap_pmem_flags();
+
+	return (void __pmem *) memremap(offset, size, flags);
 }
 
 /**
diff --git a/tools/testing/nvdimm/Kbuild b/tools/testing/nvdimm/Kbuild
index f56914c7929b..8c0f9fc72d6e 100644
--- a/tools/testing/nvdimm/Kbuild
+++ b/tools/testing/nvdimm/Kbuild
@@ -1,9 +1,9 @@
-ldflags-y += --wrap=ioremap_wt
 ldflags-y += --wrap=ioremap_wc
 ldflags-y += --wrap=devm_ioremap_nocache
-ldflags-y += --wrap=ioremap_cache
 ldflags-y += --wrap=ioremap_nocache
 ldflags-y += --wrap=iounmap
+ldflags-y += --wrap=memremap
+ldflags-y += --wrap=memunmap
 ldflags-y += --wrap=__request_region
 ldflags-y += --wrap=__release_region
 
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index 64bfaa50831c..21288f34a5ca 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -80,11 +80,20 @@ void __iomem *__wrap_devm_ioremap_nocache(struct device *dev,
 }
 EXPORT_SYMBOL(__wrap_devm_ioremap_nocache);
 
-void __iomem *__wrap_ioremap_cache(resource_size_t offset, unsigned long size)
+void *__wrap_memremap(resource_size_t offset, size_t size,
+		unsigned long flags)
 {
-	return __nfit_test_ioremap(offset, size, ioremap_cache);
+	struct nfit_test_resource *nfit_res;
+
+	rcu_read_lock();
+	nfit_res = get_nfit_res(offset);
+	rcu_read_unlock();
+	if (nfit_res)
+		return (void __iomem *) nfit_res->buf + offset
+			- nfit_res->res->start;
+	return memremap(offset, size, flags);
 }
-EXPORT_SYMBOL(__wrap_ioremap_cache);
+EXPORT_SYMBOL(__wrap_memremap);
 
 void __iomem *__wrap_ioremap_nocache(resource_size_t offset, unsigned long size)
 {
@@ -92,12 +101,6 @@ void __iomem *__wrap_ioremap_nocache(resource_size_t offset, unsigned long size)
 }
 EXPORT_SYMBOL(__wrap_ioremap_nocache);
 
-void __iomem *__wrap_ioremap_wt(resource_size_t offset, unsigned long size)
-{
-	return __nfit_test_ioremap(offset, size, ioremap_wt);
-}
-EXPORT_SYMBOL(__wrap_ioremap_wt);
-
 void __iomem *__wrap_ioremap_wc(resource_size_t offset, unsigned long size)
 {
 	return __nfit_test_ioremap(offset, size, ioremap_wc);
@@ -117,6 +120,19 @@ void __wrap_iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(__wrap_iounmap);
 
+void __wrap_memunmap(void *addr)
+{
+	struct nfit_test_resource *nfit_res;
+
+	rcu_read_lock();
+	nfit_res = get_nfit_res((unsigned long) addr);
+	rcu_read_unlock();
+	if (nfit_res)
+		return;
+	return memunmap(addr);
+}
+EXPORT_SYMBOL(__wrap_memunmap);
+
 struct resource *__wrap___request_region(struct resource *parent,
 		resource_size_t start, resource_size_t n, const char *name,
 		int flags)
