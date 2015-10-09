From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 18/20] arch: kill ioremap_fullcache()
Date: Fri, 09 Oct 2015 18:17:13 -0400
Message-ID: <20151009221712.32203.57265.stgit@dwillia2-desk3.jf.intel.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Nothing calls this helper, and now that ioremap_cache() is being
deprecated these can also be removed.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/frv/include/asm/io.h        |    5 -----
 arch/m68k/include/asm/io_mm.h    |    6 ------
 arch/m68k/include/asm/io_no.h    |    5 -----
 arch/microblaze/include/asm/io.h |    1 -
 arch/tile/include/asm/io.h       |    1 -
 5 files changed, 18 deletions(-)

diff --git a/arch/frv/include/asm/io.h b/arch/frv/include/asm/io.h
index 70dfbea8c8d7..2b6ff56a2d2f 100644
--- a/arch/frv/include/asm/io.h
+++ b/arch/frv/include/asm/io.h
@@ -272,11 +272,6 @@ static inline void __iomem *ioremap_wt(unsigned long physaddr, unsigned long siz
 	return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
 }
 
-static inline void __iomem *ioremap_fullcache(unsigned long physaddr, unsigned long size)
-{
-	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
-}
-
 #define ioremap_wc ioremap_nocache
 #define ioremap_uc ioremap_nocache
 
diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index c98ac81582ac..89361b7bfafc 100644
--- a/arch/m68k/include/asm/io_mm.h
+++ b/arch/m68k/include/asm/io_mm.h
@@ -474,12 +474,6 @@ static inline void __iomem *ioremap_wt(unsigned long physaddr,
 {
 	return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
 }
-static inline void __iomem *ioremap_fullcache(unsigned long physaddr,
-				      unsigned long size)
-{
-	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
-}
-
 static inline void memset_io(volatile void __iomem *addr, unsigned char val, int count)
 {
 	__builtin_memset((void __force *) addr, val, count);
diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
index ad7bd40e6742..2690fa99dc56 100644
--- a/arch/m68k/include/asm/io_no.h
+++ b/arch/m68k/include/asm/io_no.h
@@ -159,11 +159,6 @@ static inline void *ioremap_wt(unsigned long physaddr, unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
 }
-static inline void *ioremap_fullcache(unsigned long physaddr, unsigned long size)
-{
-	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
-}
-
 #define	iounmap(addr)	do { } while(0)
 
 /*
diff --git a/arch/microblaze/include/asm/io.h b/arch/microblaze/include/asm/io.h
index 39b6315db82e..5e0cbf4e4204 100644
--- a/arch/microblaze/include/asm/io.h
+++ b/arch/microblaze/include/asm/io.h
@@ -40,7 +40,6 @@ extern void iounmap(void __iomem *addr);
 
 extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
 #define ioremap_nocache(addr, size)		ioremap((addr), (size))
-#define ioremap_fullcache(addr, size)		ioremap((addr), (size))
 #define ioremap_wc(addr, size)			ioremap((addr), (size))
 #define ioremap_wt(addr, size)			ioremap((addr), (size))
 
diff --git a/arch/tile/include/asm/io.h b/arch/tile/include/asm/io.h
index 322b5fe94781..5879af3568c5 100644
--- a/arch/tile/include/asm/io.h
+++ b/arch/tile/include/asm/io.h
@@ -56,7 +56,6 @@ extern void iounmap(volatile void __iomem *addr);
 #define ioremap_wc(physaddr, size)		ioremap(physaddr, size)
 #define ioremap_wt(physaddr, size)		ioremap(physaddr, size)
 #define ioremap_uc(physaddr, size)		ioremap(physaddr, size)
-#define ioremap_fullcache(physaddr, size)	ioremap(physaddr, size)
 
 #define mmiowb()
 
