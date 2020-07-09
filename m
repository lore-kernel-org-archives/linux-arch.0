From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 4/5] arm64: Use the generic devmem_is_allowed()
Date: Thu,  9 Jul 2020 13:05:51 -0700
Message-ID: <20200709200552.1910298-5-palmer@dabbelt.com>
References: <20200709200552.1910298-1-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200709200552.1910298-1-palmer@dabbelt.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-riscv@lists.infradead.org, zong.li@sifive.com
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu, gxt@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>, akpm@linux-foundation.org, linus.walleij@linaro.org, rppt@linux.ibm.com, mchehab+samsung@kernel.org, gregory.0xf0@gmail.com, masahiroy@kernel.org, Nick Desaulniers <ndesaulniers@google.com>, bgolaszewski@baylibre.com, tglx@linutronix.de, steve@sk2.org, keescook@chromium.org, mcgrof@kernel.org, alex@ghiti.fr, mark.rutland@arm.com, james.morse@arm.com, andriy.shevchenko@linux.intel.com, alex.shi@linux.alibaba.com, davem@davemloft.net, rdunlap@infradead.org, broonie@kernel.org, uwe@kleine-koenig.org, rostedt@goodmis.org, dan.j.williams@intel.com, mhiramat@kernel.org
List-Id: linux-arch.vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

I recently copied this into lib/ for use by the RISC-V port.

[I haven't even build tested this.  The lib/ patch is on riscv/for-next,
which I'm targeting for 5.9, so this won't work alone.  See the cover
letter for more details.]

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/arm64/Kconfig          |  1 +
 arch/arm64/include/asm/io.h |  2 --
 arch/arm64/mm/mmap.c        | 21 ---------------------
 3 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 66dc41fd49f2..0770ed21a8c4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -110,6 +110,7 @@ config ARM64
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
+	select GENERIC_LIB_DEVMEM_IS_ALLOWED
 	select GENERIC_PCI_IOMAP
 	select GENERIC_PTDUMP
 	select GENERIC_SCHED_CLOCK
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index ff50dd731852..c53eba1a7fd2 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -200,6 +200,4 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 extern int valid_phys_addr_range(phys_addr_t addr, size_t size);
 extern int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
 
-extern int devmem_is_allowed(unsigned long pfn);
-
 #endif	/* __ASM_IO_H */
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 3028bacbc4e9..07937b49cb88 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -47,24 +47,3 @@ int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
 {
 	return !(((pfn << PAGE_SHIFT) + size) & ~PHYS_MASK);
 }
-
-#ifdef CONFIG_STRICT_DEVMEM
-
-#include <linux/ioport.h>
-
-/*
- * devmem_is_allowed() checks to see if /dev/mem access to a certain address
- * is valid. The argument is a physical page number.  We mimic x86 here by
- * disallowing access to system RAM as well as device-exclusive MMIO regions.
- * This effectively disable read()/write() on /dev/mem.
- */
-int devmem_is_allowed(unsigned long pfn)
-{
-	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
-		return 0;
-	if (!page_is_ram(pfn))
-		return 1;
-	return 0;
-}
-
-#endif
-- 
2.27.0.383.g050319c2ae-goog
