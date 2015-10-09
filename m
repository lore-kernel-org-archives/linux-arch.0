From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 05/20] m68k: introduce arch_memremap()
Date: Fri, 09 Oct 2015 18:16:04 -0400
Message-ID: <20151009221604.32203.58114.stgit@dwillia2-desk3.jf.intel.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Ross Zwisler <ross.zwisler@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

In preparation for removing ioremap_wt() introduce arch_memremap()
for m68k.  This simply enforces that attempts to establish writethrough
mappings fail rather than silently fall back to uncached.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/m68k/Kconfig       |    1 +
 arch/m68k/mm/kmap.c     |   17 ++++++++++++++++-
 arch/m68k/mm/sun3kmap.c |    7 +++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 498b567f007b..468b9ea6d042 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -9,6 +9,7 @@ config M68K
 	select GENERIC_ATOMIC64
 	select HAVE_UID16
 	select VIRT_TO_BUS
+	select ARCH_HAS_MEMREMAP
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IOMAP
diff --git a/arch/m68k/mm/kmap.c b/arch/m68k/mm/kmap.c
index 6e4955bc542b..519c45865127 100644
--- a/arch/m68k/mm/kmap.c
+++ b/arch/m68k/mm/kmap.c
@@ -14,12 +14,12 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/io.h>
 
 #include <asm/setup.h>
 #include <asm/segment.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
-#include <asm/io.h>
 
 #undef DEBUG
 
@@ -223,6 +223,21 @@ void __iomem *__ioremap(unsigned long physaddr, unsigned long size, int cachefla
 }
 EXPORT_SYMBOL(__ioremap);
 
+void *arch_memremap(resource_size_t offset, size_t size, unsigned long flags)
+{
+	int mode;
+
+	if (flags & MEMREMAP_WB)
+		mode = IOMAP_FULL_CACHING;
+	else if (flags & MEMREMAP_WT)
+		mode = IOMAP_WRITETHROUGH;
+	else
+		return NULL;
+
+	return (void __force *) __ioremap(offset, size, mode);
+}
+EXPORT_SYMBOL(arch_memremap);
+
 /*
  * Unmap an ioremap()ed region again
  */
diff --git a/arch/m68k/mm/sun3kmap.c b/arch/m68k/mm/sun3kmap.c
index 3dc41158c05e..981a9e423b23 100644
--- a/arch/m68k/mm/sun3kmap.c
+++ b/arch/m68k/mm/sun3kmap.c
@@ -116,6 +116,13 @@ void __iomem *__ioremap(unsigned long phys, unsigned long size, int cache)
 }
 EXPORT_SYMBOL(__ioremap);
 
+void *arch_memremap(resource_size_t offset, size_t size, unsigned long flags)
+{
+	pr_err_once("sun3: no support for memremap\n");
+	return NULL;
+}
+EXPORT_SYMBOL(arch_memremap);
+
 void iounmap(void __iomem *addr)
 {
 	vfree((void *)(PAGE_MASK & (unsigned long)addr));
