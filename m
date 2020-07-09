Return-Path: <SRS0=IHIJ=AU=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgGIVUf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 17:20:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C423CC08C5CE
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 14:20:34 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o22so1659360pjw.2
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 14:20:34 -0700 (PDT)
Subject: [PATCH v2 5/5] unicore32: Use the generic devmem_is_allowed()
Date: Thu,  9 Jul 2020 14:19:25 -0700
Message-ID: <20200709211925.1926557-6-palmer@dabbelt.com>
In-Reply-To: <20200709211925.1926557-1-palmer@dabbelt.com>
References: <20200709211925.1926557-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: zong.li@sifive.com, rppt@linux.ibm.com
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu, gxt@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>, linus.walleij@linaro.org, akpm@linux-foundation.org, mchehab+samsung@kernel.org, gregory.0xf0@gmail.com, masahiroy@kernel.org, Nick Desaulniers <ndesaulniers@google.com>, bgolaszewski@baylibre.com, steve@sk2.org, tglx@linutronix.de, keescook@chromium.org, alex@ghiti.fr, mcgrof@kernel.org, mark.rutland@arm.com, james.morse@arm.com, alex.shi@linux.alibaba.com, andriy.shevchenko@linux.intel.com, broonie@kernel.org, rdunlap@infradead.org, davem@davemloft.net, rostedt@goodmis.org, dan.j.williams@intel.com, mhiramat@kernel.org, krzk@kernel.org, zaslonko@linux.ibm.com, matti.vaittinen@fi.rohmeurope.com, uwe@kleine-koenig.org, clabbe@baylibre.com, changbin.du@intel.com, Greg KH <gregkh@linuxfoundation.org>, paulmck@kernel.org, pmladek@suse.com, brendanhiggins@google.com, glider@google.com, elver@google.com, davidgow@google.com, ardb@kernel.org, takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
Message-ID: <20200709211925.7z8EoKL6083ZmJGYMf8TzmkkihXl_Q7IYB9G2pZ0Tdk@z>

From: Palmer Dabbelt <palmerdabbelt@google.com>

Aside from being inlineable, this is exactly the same as the arm64
version, which I recently copied into lib/ for use by the RISC-V port.

[I haven't even build tested this.  The lib/ patch is on riscv/for-next,
which I'm targeting for 5.9, so this won't work alone.  See the cover
letter for more details.]

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/unicore32/Kconfig          |  2 +-
 arch/unicore32/include/asm/io.h | 23 -----------------------
 2 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 11ba1839d198..7610571044f4 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -2,7 +2,6 @@
 config UNICORE32
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
@@ -12,6 +11,7 @@ config UNICORE32
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
 	select HAVE_PCI
+	select GENERIC_LIB_DEVMEM_IS_ALLOWED
 	select VIRT_TO_BUS
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select GENERIC_FIND_FIRST_BIT
diff --git a/arch/unicore32/include/asm/io.h b/arch/unicore32/include/asm/io.h
index bd4e7c332f85..4560d2531655 100644
--- a/arch/unicore32/include/asm/io.h
+++ b/arch/unicore32/include/asm/io.h
@@ -42,28 +42,5 @@ extern void __uc32_iounmap(volatile void __iomem *addr);
 #define PIO_MASK		(unsigned int)(IO_SPACE_LIMIT)
 #define PIO_RESERVED		(PIO_OFFSET + PIO_MASK + 1)
 
-#ifdef CONFIG_STRICT_DEVMEM
-
-#include <linux/ioport.h>
-#include <linux/mm.h>
-
-/*
- * devmem_is_allowed() checks to see if /dev/mem access to a certain
- * address is valid. The argument is a physical page number.
- * We mimic x86 here by disallowing access to system RAM as well as
- * device-exclusive MMIO regions. This effectively disable read()/write()
- * on /dev/mem.
- */
-static inline int devmem_is_allowed(unsigned long pfn)
-{
-	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
-		return 0;
-	if (!page_is_ram(pfn))
-		return 1;
-	return 0;
-}
-
-#endif /* CONFIG_STRICT_DEVMEM */
-
 #endif	/* __KERNEL__ */
 #endif	/* __UNICORE_IO_H__ */
-- 
2.27.0.383.g050319c2ae-goog
