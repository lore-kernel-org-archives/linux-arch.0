From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 02/20] arm: introduce arch_memremap()
Date: Fri, 09 Oct 2015 18:15:48 -0400
Message-ID: <20151009221548.32203.75285.stgit@dwillia2-desk3.jf.intel.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Ross Zwisler <ross.zwisler@linux.intel.com>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

In preparation for removing ioremap_cache() introduce arch_memremap()
for arm.  For now, arch_memremap(..., MEMREMAP_WB) is an alias for
ioremap_cache().  Note that arch_memremap() is relying on memremap() to
handle remap requests to "System RAM".

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/arm/Kconfig          |    1 +
 arch/arm/include/asm/io.h |    1 +
 arch/arm/mm/ioremap.c     |   11 +++++++++++
 arch/arm/mm/nommu.c       |   10 ++++++++++
 arch/arm64/Kconfig        |    1 +
 arch/arm64/mm/ioremap.c   |   10 ++++++++++
 6 files changed, 34 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 72ad724c67ae..882771cfc63c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -3,6 +3,7 @@ config ARM
 	default y
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_MEMREMAP
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 485982084fe9..ca76d59cb6f3 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -356,6 +356,7 @@ static inline void memcpy_toio(volatile void __iomem *to, const void *from,
  * ioremap()		Device		n/a		n/a
  * ioremap_nocache()	Device		n/a		n/a
  * ioremap_cache()	Normal		Writeback	Read allocate
+ * memremap(WB)		Normal		Writeback	Read allocate
  * ioremap_wc()		Normal		Non-cacheable	n/a
  * ioremap_wt()		Normal		Non-cacheable	n/a
  *
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 0c81056c1dd7..f6249b98ed16 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -385,6 +385,17 @@ void __iomem *ioremap_cache(resource_size_t res_cookie, size_t size)
 }
 EXPORT_SYMBOL(ioremap_cache);
 
+void *arch_memremap(resource_size_t res_cookie, size_t size,
+		unsigned long flags)
+{
+	if ((flags & MEMREMAP_WB) == 0)
+		return NULL;
+
+	return (void __force *) arch_ioremap_caller(res_cookie, size,
+			MT_DEVICE_CACHED, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(arch_memremap);
+
 void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size)
 {
 	return arch_ioremap_caller(res_cookie, size, MT_DEVICE_WC,
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 1dd10936d68d..d88353e1fe80 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -373,6 +373,16 @@ void __iomem *ioremap_cache(resource_size_t res_cookie, size_t size)
 }
 EXPORT_SYMBOL(ioremap_cache);
 
+void *arch_memremap(resource_size_t res_cookie, size_t size, unsigned long flags)
+{
+	if ((flags & MEMREMAP_WB) == 0)
+		return NULL;
+
+	return (void __force *) __arm_ioremap_caller(res_cookie, size,
+			MT_DEVICE_CACHED, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(arch_memremap);
+
 void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size)
 {
 	return __arm_ioremap_caller(res_cookie, size, MT_DEVICE_WC,
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 07d1811aa03f..54ea0688586f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -6,6 +6,7 @@ config ARM64
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_MEMREMAP
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_USE_CMPXCHG_LOCKREF
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 01e88c8bcab0..9db5a12654a0 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -104,6 +104,16 @@ void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
 }
 EXPORT_SYMBOL(ioremap_cache);
 
+void *arch_memremap(phys_addr_t phys_addr, size_t size, unsigned long flags)
+{
+	if ((flags & MEMREMAP_WB) == 0)
+		return NULL;
+
+	return (void __force *) __ioremap_caller(phys_addr, size,
+			__pgprot(PROT_NORMAL), __builtin_return_address(0));
+}
+EXPORT_SYMBOL(arch_memremap);
+
 /*
  * Must be called after early_fixmap_init
  */
