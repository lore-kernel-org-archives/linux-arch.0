From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 3/5] arm: Use the generic devmem_is_allowed()
Date: Thu,  9 Jul 2020 14:19:23 -0700
Message-ID: <20200709211925.1926557-4-palmer@dabbelt.com>
References: <20200709211925.1926557-1-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgGIVU2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 17:20:28 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB61C08E6DC
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 14:20:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d10so1341915pll.3
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 14:20:28 -0700 (PDT)
In-Reply-To: <20200709211925.1926557-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: zong.li@sifive.com, linux-riscv@lists.infradead.org, rppt@linux.ibm.com
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu, gxt@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>, linus.walleij@linaro.org, akpm@linux-foundation.org, mchehab+samsung@kernel.org, gregory.0xf0@gmail.com, masahiroy@kernel.org, Nick Desaulniers <ndesaulniers@google.com>, bgolaszewski@baylibre.com, steve@sk2.org, tglx@linutronix.de, keescook@chromium.org, alex@ghiti.fr, mcgrof@kernel.org, mark.rutland@arm.com, james.morse@arm.com, alex.shi@linux.alibaba.com, andriy.shevchenko@linux.intel.com, broonie@kernel.org, rdunlap@infradead.org, davem@davemloft.net, rostedt@goodmis.org, dan.j.williams@intel.com, mhiramat@kernel.org, krzk@kernel.org, zaslonko@linux.ibm.comm

From: Palmer Dabbelt <palmerdabbelt@google.com>

This is exactly the same as the arm64 version, which I recently copied
into lib/ for use by the RISC-V port.

[I haven't even build tested this.  The lib/ patch is on riscv/for-next,
which I'm targeting for 5.9, so this won't work alone.  See the cover
letter for more details.]

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/arm/Kconfig          |  2 +-
 arch/arm/include/asm/io.h |  1 -
 arch/arm/mm/mmap.c        | 22 ----------------------
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2ac74904a3ce..da0f88f6c196 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -5,7 +5,6 @@ config ARM
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
-	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
@@ -54,6 +53,7 @@ config ARM
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
+	select GENERIC_LIB_DEVMEM_IS_ALLOWED
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index ab2b654084fa..fc748122f1e0 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -441,7 +441,6 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
 extern int valid_phys_addr_range(phys_addr_t addr, size_t size);
 extern int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
-extern int devmem_is_allowed(unsigned long pfn);
 #endif
 
 /*
diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index b8d912ac9e61..a0f8a0ca0788 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -165,25 +165,3 @@ int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
 {
 	return (pfn + (size >> PAGE_SHIFT)) <= (1 + (PHYS_MASK >> PAGE_SHIFT));
 }
-
-#ifdef CONFIG_STRICT_DEVMEM
-
-#include <linux/ioport.h>
-
-/*
- * devmem_is_allowed() checks to see if /dev/mem access to a certain
- * address is valid. The argument is a physical page number.
- * We mimic x86 here by disallowing access to system RAM as well as
- * device-exclusive MMIO regions. This effectively disable read()/write()
- * on /dev/mem.
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
