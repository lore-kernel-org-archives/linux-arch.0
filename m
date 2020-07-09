Return-Path: <SRS0=IHIJ=AU=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgGIVUW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 17:20:22 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF6FC08C5DC
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 14:20:22 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e18so1522719pgn.7
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 14:20:22 -0700 (PDT)
Subject: [PATCH v2 1/5] lib: Add a generic version of devmem_is_allowed()
Date: Thu,  9 Jul 2020 14:19:21 -0700
Message-ID: <20200709211925.1926557-2-palmer@dabbelt.com>
In-Reply-To: <20200709211925.1926557-1-palmer@dabbelt.com>
References: <20200709211925.1926557-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: zong.li@sifive.com, rppt@linux.ibm.com
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu, gxt@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>, linus.walleij@linaro.org, akpm@linux-foundation.org, mchehab+samsung@kernel.org, gregory.0xf0@gmail.com, masahiroy@kernel.org, Nick Desaulniers <ndesaulniers@google.com>, bgolaszewski@baylibre.com, steve@sk2.org, tglx@linutronix.de, keescook@chromium.org, alex@ghiti.fr, mcgrof@kernel.org, mark.rutland@arm.com, james.morse@arm.com, alex.shi@linux.alibaba.com, andriy.shevchenko@linux.intel.com, broonie@kernel.org, rdunlap@infradead.org, davem@davemloft.net, rostedt@goodmis.org, dan.j.williams@intel.com, mhiramat@kernel.org, krzk@kernel.org, zaslonko@linux.ibm.com, matti.vaittinen@fi.rohmeurope.com, uwe@kleine-koenig.org, clabbe@baylibre.com, changbin.du@intel.com, Greg KH <gregkh@linuxfoundation.org>, paulmck@kernel.org, pmladek@suse.com, brendanhiggins@google.com, glider@google.com, elver@google.com, davidgow@google.com, ardb@kernel.org, takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
Message-ID: <20200709211921.rWrA5-eqskH7yoJbqtMoKJJggnJOPO1UweAxjt6kiIY@z>

From: Palmer Dabbelt <palmerdabbelt@google.com>

As part of adding support for STRICT_DEVMEM to the RISC-V port, Zong
provided a devmem_is_allowed() implementation that's exactly the same as
all the others I checked.  Instead I'm adding a generic version, which
will soon be used.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 include/asm-generic/io.h |  4 ++++
 lib/Kconfig              |  3 +++
 lib/Kconfig.debug        |  2 +-
 lib/Makefile             |  2 ++
 lib/devmem_is_allowed.c  | 27 +++++++++++++++++++++++++++
 5 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 lib/devmem_is_allowed.c

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 8b1e020e9a03..69e3db65fba0 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1122,6 +1122,10 @@ static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
 }
 #endif
 
+#ifndef CONFIG_GENERIC_DEVMEM_IS_ALLOWED
+extern int devmem_is_allowed(unsigned long pfn);
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_GENERIC_IO_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index df3f3da95990..610c16ecbb7c 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -676,3 +676,6 @@ config GENERIC_LIB_CMPDI2
 
 config GENERIC_LIB_UCMPDI2
 	bool
+
+config GENERIC_LIB_DEVMEM_IS_ALLOWED
+	bool
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210d70a1..e095bd631ba1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1577,7 +1577,7 @@ config ARCH_HAS_DEVMEM_IS_ALLOWED
 config STRICT_DEVMEM
 	bool "Filter access to /dev/mem"
 	depends on MMU && DEVMEM
-	depends on ARCH_HAS_DEVMEM_IS_ALLOWED
+	depends on ARCH_HAS_DEVMEM_IS_ALLOWED || GENERIC_LIB_DEVMEM_IS_ALLOWED
 	default y if PPC || X86 || ARM64
 	help
 	  If this option is disabled, you allow userspace (root) access to all
diff --git a/lib/Makefile b/lib/Makefile
index b1c42c10073b..554ef14f9be5 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -318,3 +318,5 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 # KUnit tests
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+
+obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
diff --git a/lib/devmem_is_allowed.c b/lib/devmem_is_allowed.c
new file mode 100644
index 000000000000..c0d67c541849
--- /dev/null
+++ b/lib/devmem_is_allowed.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * A generic version of devmem_is_allowed.
+ *
+ * Based on arch/arm64/mm/mmap.c
+ *
+ * Copyright (C) 2020 Google, Inc.
+ * Copyright (C) 2012 ARM Ltd.
+ */
+
+#include <linux/mm.h>
+#include <linux/ioport.h>
+
+/*
+ * devmem_is_allowed() checks to see if /dev/mem access to a certain address
+ * is valid. The argument is a physical page number.  We mimic x86 here by
+ * disallowing access to system RAM as well as device-exclusive MMIO regions.
+ * This effectively disable read()/write() on /dev/mem.
+ */
+int devmem_is_allowed(unsigned long pfn)
+{
+	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
+		return 0;
+	if (!page_is_ram(pfn))
+		return 1;
+	return 0;
+}
-- 
2.27.0.383.g050319c2ae-goog
