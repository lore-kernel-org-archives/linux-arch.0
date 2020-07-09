Return-Path: <SRS0=IHIJ=AU=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbgGIUIQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 16:08:16 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD65AC08C5DC
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 13:08:15 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so1263332plo.7
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 13:08:15 -0700 (PDT)
Subject: [PATCH 2/5] RISC-V: Use the new generic devmem_is_allowed()
Date: Thu,  9 Jul 2020 13:05:49 -0700
Message-ID: <20200709200552.1910298-3-palmer@dabbelt.com>
In-Reply-To: <20200709200552.1910298-1-palmer@dabbelt.com>
References: <20200709200552.1910298-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: zong.li@sifive.com
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu, gxt@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>, akpm@linux-foundation.org, linus.walleij@linaro.org, rppt@linux.ibm.com, mchehab+samsung@kernel.org, gregory.0xf0@gmail.com, masahiroy@kernel.org, Nick Desaulniers <ndesaulniers@google.com>, bgolaszewski@baylibre.com, tglx@linutronix.de, steve@sk2.org, keescook@chromium.org, mcgrof@kernel.org, alex@ghiti.fr, mark.rutland@arm.com, james.morse@arm.com, andriy.shevchenko@linux.intel.com, alex.shi@linux.alibaba.com, davem@davemloft.net, rdunlap@infradead.org, broonie@kernel.org, uwe@kleine-koenig.org, rostedt@goodmis.org, dan.j.williams@intel.com, mhiramat@kernel.org, matti.vaittinen@fi.rohmeurope.com, zaslonko@linux.ibm.com, krzk@kernel.org, willy@infradead.org, paulmck@kernel.org, pmladek@suse.com, glider@google.com, elver@google.com, davidgow@google.com, ardb@kernel.org, takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
Message-ID: <20200709200549.kov_WUVRg4nv1s7Yc7H4FGcpwhq3EOjM-_2h3eXr0pY@z>

From: Palmer Dabbelt <palmerdabbelt@google.com>

This allows us to enable STRICT_DEVMEM.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 089293e4ad46..8ff368a65a07 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -37,6 +37,7 @@ config RISCV
 	select GENERIC_IOREMAP
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_SHOW
+	select GENERIC_LIB_DEVMEM_IS_ALLOWED
 	select GENERIC_PCI_IOMAP
 	select GENERIC_PTDUMP if MMU
 	select GENERIC_SCHED_CLOCK
-- 
2.27.0.383.g050319c2ae-goog
