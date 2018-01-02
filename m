From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] microblaze: fix iounmap prototype
Date: Tue,  2 Jan 2018 12:47:20 +0100
Message-ID: <20180102114720.3408356-2-arnd@arndb.de>
References: <20180102114720.3408356-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180102114720.3408356-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Babu Moger <babu.moger@oracle.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

The missing 'volatile' keyword on the iounmap argument leads to lots of
harmless warnings in an allmodconfig build:

sound/pci/echoaudio/echoaudio.c:1879:10: warning: passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/microblaze/include/asm/io.h | 2 +-
 arch/microblaze/mm/pgtable.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/include/asm/io.h b/arch/microblaze/include/asm/io.h
index 39b6315db82e..c7968139486f 100644
--- a/arch/microblaze/include/asm/io.h
+++ b/arch/microblaze/include/asm/io.h
@@ -36,7 +36,7 @@ extern resource_size_t isa_mem_base;
 #ifdef CONFIG_MMU
 #define page_to_bus(page)	(page_to_phys(page))
 
-extern void iounmap(void __iomem *addr);
+extern void iounmap(volatile void __iomem *addr);
 
 extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
 #define ioremap_nocache(addr, size)		ioremap((addr), (size))
diff --git a/arch/microblaze/mm/pgtable.c b/arch/microblaze/mm/pgtable.c
index 4c0599239915..7f525962cdfa 100644
--- a/arch/microblaze/mm/pgtable.c
+++ b/arch/microblaze/mm/pgtable.c
@@ -127,7 +127,7 @@ void __iomem *ioremap(phys_addr_t addr, unsigned long size)
 }
 EXPORT_SYMBOL(ioremap);
 
-void iounmap(void __iomem *addr)
+void iounmap(volatile void __iomem *addr)
 {
 	if ((__force void *)addr > high_memory &&
 					(unsigned long) addr < ioremap_bot)
-- 
2.9.0
