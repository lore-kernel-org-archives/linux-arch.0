From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 19/20] arch: remove ioremap_cache, replace with arch_memremap
Date: Fri, 09 Oct 2015 18:17:18 -0400
Message-ID: <20151009221718.32203.54261.stgit@dwillia2-desk3.jf.intel.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Now that all call sites for ioremap_cache() have been converted to
memremap(MEMREMAP_WB) we can now proceed with removing the
implementation in the archs.  This amounts to replacing the per-arch
ioremap_cache() implementation with arch_memremap.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/x86/pat.txt    |    2 --
 arch/arm/include/asm/io.h    |    4 ----
 arch/arm/mm/ioremap.c        |    7 -------
 arch/arm/mm/nommu.c          |    7 -------
 arch/arm64/include/asm/io.h  |    1 -
 arch/arm64/mm/ioremap.c      |   18 +-----------------
 arch/ia64/include/asm/io.h   |    6 ------
 arch/sh/include/asm/io.h     |    7 -------
 arch/x86/include/asm/io.h    |    2 --
 arch/x86/mm/ioremap.c        |    7 -------
 arch/xtensa/include/asm/io.h |   11 -----------
 kernel/Makefile              |    2 +-
 kernel/memremap.c            |   18 +++++-------------
 lib/Kconfig                  |    1 +
 14 files changed, 8 insertions(+), 85 deletions(-)

diff --git a/Documentation/x86/pat.txt b/Documentation/x86/pat.txt
index 8c908fa5ea26..73d3635f6a3f 100644
--- a/Documentation/x86/pat.txt
+++ b/Documentation/x86/pat.txt
@@ -32,8 +32,6 @@ API                    |    RAM   |  ACPI,...  |  Reserved/Holes  |
                        |          |            |                  |
 ioremap                |    --    |    UC-     |       UC-        |
                        |          |            |                  |
-ioremap_cache          |    --    |    WB      |       WB         |
-                       |          |            |                  |
 ioremap_uc             |    --    |    UC      |       UC         |
                        |          |            |                  |
 ioremap_nocache        |    --    |    UC-     |       UC-        |
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index ca76d59cb6f3..191d0f6eeead 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -355,7 +355,6 @@ static inline void memcpy_toio(volatile void __iomem *to, const void *from,
  * Function		Memory type	Cacheability	Cache hint
  * ioremap()		Device		n/a		n/a
  * ioremap_nocache()	Device		n/a		n/a
- * ioremap_cache()	Normal		Writeback	Read allocate
  * memremap(WB)		Normal		Writeback	Read allocate
  * ioremap_wc()		Normal		Non-cacheable	n/a
  * ioremap_wt()		Normal		Non-cacheable	n/a
@@ -393,9 +392,6 @@ void __iomem *ioremap(resource_size_t res_cookie, size_t size);
 #define ioremap ioremap
 #define ioremap_nocache ioremap
 
-void __iomem *ioremap_cache(resource_size_t res_cookie, size_t size);
-#define ioremap_cache ioremap_cache
-
 void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size);
 #define ioremap_wc ioremap_wc
 #define ioremap_wt ioremap_wc
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index f6249b98ed16..991146fa0eba 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -378,13 +378,6 @@ void __iomem *ioremap(resource_size_t res_cookie, size_t size)
 }
 EXPORT_SYMBOL(ioremap);
 
-void __iomem *ioremap_cache(resource_size_t res_cookie, size_t size)
-{
-	return arch_ioremap_caller(res_cookie, size, MT_DEVICE_CACHED,
-				   __builtin_return_address(0));
-}
-EXPORT_SYMBOL(ioremap_cache);
-
 void *arch_memremap(resource_size_t res_cookie, size_t size,
 		unsigned long flags)
 {
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index d88353e1fe80..84d033501553 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -366,13 +366,6 @@ void __iomem *ioremap(resource_size_t res_cookie, size_t size)
 }
 EXPORT_SYMBOL(ioremap);
 
-void __iomem *ioremap_cache(resource_size_t res_cookie, size_t size)
-{
-	return __arm_ioremap_caller(res_cookie, size, MT_DEVICE_CACHED,
-				    __builtin_return_address(0));
-}
-EXPORT_SYMBOL(ioremap_cache);
-
 void *arch_memremap(resource_size_t res_cookie, size_t size, unsigned long flags)
 {
 	if ((flags & MEMREMAP_WB) == 0)
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 44be1e03ed65..51376353a722 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -165,7 +165,6 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
  */
 extern void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot);
 extern void __iounmap(volatile void __iomem *addr);
-extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 
 #define ioremap(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
 #define ioremap_nocache(addr, size)	__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 9db5a12654a0..83b9db4672d1 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -84,26 +84,10 @@ void __iounmap(volatile void __iomem *io_addr)
 {
 	unsigned long addr = (unsigned long)io_addr & PAGE_MASK;
 
-	/*
-	 * We could get an address outside vmalloc range in case
-	 * of ioremap_cache() reusing a RAM mapping.
-	 */
-	if (VMALLOC_START <= addr && addr < VMALLOC_END)
-		vunmap((void *)addr);
+	vunmap((void *)addr);
 }
 EXPORT_SYMBOL(__iounmap);
 
-void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
-{
-	/* For normal memory we already have a cacheable mapping. */
-	if (pfn_valid(__phys_to_pfn(phys_addr)))
-		return (void __iomem *)__phys_to_virt(phys_addr);
-
-	return __ioremap_caller(phys_addr, size, __pgprot(PROT_NORMAL),
-				__builtin_return_address(0));
-}
-EXPORT_SYMBOL(ioremap_cache);
-
 void *arch_memremap(phys_addr_t phys_addr, size_t size, unsigned long flags)
 {
 	if ((flags & MEMREMAP_WB) == 0)
diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
index 9041bbe2b7b4..defcd10bbf54 100644
--- a/arch/ia64/include/asm/io.h
+++ b/arch/ia64/include/asm/io.h
@@ -431,12 +431,6 @@ extern void __iomem * early_ioremap (unsigned long phys_addr, unsigned long size
 #define early_memremap(phys_addr, size)        early_ioremap(phys_addr, size)
 extern void early_iounmap (volatile void __iomem *addr, unsigned long size);
 #define early_memunmap(addr, size)             early_iounmap(addr, size)
-static inline void __iomem * ioremap_cache (unsigned long phys_addr, unsigned long size)
-{
-	return ioremap(phys_addr, size);
-}
-#define ioremap_cache ioremap_cache
-
 
 /*
  * String version of IO memory access ops:
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 3280a6bfa503..0d188164daf8 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -337,13 +337,6 @@ static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
 	return __ioremap_mode(offset, size, PAGE_KERNEL_NOCACHE);
 }
 
-static inline void __iomem *
-ioremap_cache(phys_addr_t offset, unsigned long size)
-{
-	return __ioremap_mode(offset, size, PAGE_KERNEL);
-}
-#define ioremap_cache ioremap_cache
-
 #ifdef CONFIG_HAVE_IOREMAP_PROT
 static inline void __iomem *
 ioremap_prot(phys_addr_t offset, unsigned long size, unsigned long flags)
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index de25aad07853..e643a96f7c23 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -182,10 +182,8 @@ extern void __iomem *ioremap_nocache(resource_size_t offset, unsigned long size)
 extern void __iomem *ioremap_uc(resource_size_t offset, unsigned long size);
 #define ioremap_uc ioremap_uc
 
-extern void __iomem *ioremap_cache(resource_size_t offset, unsigned long size);
 extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size,
 				unsigned long prot_val);
-
 /*
  * The default ioremap() behavior is non-cached:
  */
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 3762ad93bd87..4bfe8b490b9a 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -310,13 +310,6 @@ void __iomem *ioremap_wt(resource_size_t phys_addr, unsigned long size)
 }
 EXPORT_SYMBOL(ioremap_wt);
 
-void __iomem *ioremap_cache(resource_size_t phys_addr, unsigned long size)
-{
-	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WB,
-				__builtin_return_address(0));
-}
-EXPORT_SYMBOL(ioremap_cache);
-
 void *arch_memremap(resource_size_t phys_addr, size_t size,
 		unsigned long flags)
 {
diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
index 867840f5400f..9bfbecc0fc99 100644
--- a/arch/xtensa/include/asm/io.h
+++ b/arch/xtensa/include/asm/io.h
@@ -48,17 +48,6 @@ static inline void __iomem *ioremap_nocache(unsigned long offset,
 		BUG();
 }
 
-static inline void __iomem *ioremap_cache(unsigned long offset,
-		unsigned long size)
-{
-	if (offset >= XCHAL_KIO_PADDR
-	    && offset - XCHAL_KIO_PADDR < XCHAL_KIO_SIZE)
-		return (void*)(offset-XCHAL_KIO_PADDR+XCHAL_KIO_CACHED_VADDR);
-	else
-		BUG();
-}
-#define ioremap_cache ioremap_cache
-
 #define ioremap_wc ioremap_nocache
 #define ioremap_wt ioremap_nocache
 
diff --git a/kernel/Makefile b/kernel/Makefile
index 53abf008ecb3..323df949d803 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -102,7 +102,7 @@ obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
 obj-$(CONFIG_TORTURE_TEST) += torture.o
 obj-$(CONFIG_MEMBARRIER) += membarrier.o
 
-obj-$(CONFIG_HAS_IOMEM) += memremap.o
+obj-$(CONFIG_ARCH_HAS_MEMREMAP) += memremap.o
 
 $(obj)/configs.o: $(obj)/config_data.h
 
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 8bd5fe05d4a4..68b5d54fff01 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -16,22 +16,14 @@
 #include <linux/mm.h>
 #include <linux/memory_hotplug.h>
 
-#ifndef ioremap_cache
-/* temporary while we convert existing ioremap_cache users to memremap */
-__weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
-{
-	return ioremap(offset, size);
-}
-#endif
-
-/* temporary while we convert arch implementations to arch_memremap */
 __weak void *arch_memremap(resource_size_t offset, size_t size,
 		unsigned long flags)
 {
-	if (flags & MEMREMAP_WB)
-		return (void __force *) ioremap_cache(offset, size);
-	else if (flags & MEMREMAP_WT)
-		return (void __force *) ioremap_wt(offset, size);
+	if (!IS_ENABLED(CONFIG_MMU))
+		return (void *) (unsigned long) offset;
+	WARN_ONCE(1, "%s in %s should only be called in NOMMU configurations\n",
+			__func__, __FILE__);
+	return NULL;
 }
 
 /**
diff --git a/lib/Kconfig b/lib/Kconfig
index 8d99b4e6a45b..672c92e9dfe7 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -523,6 +523,7 @@ config ARCH_HAS_SG_CHAIN
 	bool
 
 config ARCH_HAS_MEMREMAP
+	default !MMU
 	bool
 
 config ARCH_HAS_PMEM_API
