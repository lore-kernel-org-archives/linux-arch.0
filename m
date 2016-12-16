Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:60636 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760740AbcLPK5G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Dec 2016 05:57:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 03/13] ARM: div64: fix building with gcc-4.5 and lower
Date: Fri, 16 Dec 2016 11:56:24 +0100
Message-ID: <20161216105634.235457-4-arnd@arndb.de>
In-Reply-To: <20161216105634.235457-1-arnd@arndb.de>
References: <20161216105634.235457-1-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, kernel-build-reports@lists.linaro.org, kvmarm@lists.cs.columbia.edu, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20161216105624.0GR87Wy5ty8xjrWSe0I0uQnUh8UfQDUpdB5lCqSbnbI@z>

drivers/media/dvb-frontends/s921.c: In function 's921_pll_tune':
arch/arm/include/asm/div64.h:109: error: can't find a register in class 'GENERAL_REGS' while reloading 'asm'
arch/arm/include/asm/div64.h:127: error: can't find a register in class 'GENERAL_REGS' while reloading 'asm'
arch/arm/include/asm/div64.h:109: error: 'asm' operand has impossible constraints
arch/arm/include/asm/div64.h:127: error: 'asm' operand has impossible constraints
scripts/Makefile.build:299: recipe for target 'drivers/media/dvb-frontends/s921.o' failed

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/div64.h | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 7ca0c613c33b..e1c8d4a58797 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -66,27 +66,16 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
  */
 #define do_div(n, base) __div64_32(&(n), base)
 
-#elif defined(CONFIG_CPU_32v3)
+#elif GCC_VERSION < 40600
 
 /*
- * modern compiler versions (>= gcc-4.9) tend to misoptimize
- * the code for ARMv3, and this is not getting fixed any more.
+ * gcc-4.4 and gcc-4.5 tend to run out of registers in their
+ * register allocation in some functions
  */
 #define do_div(n, base) __div64_32(&(n), base)
 
 #else
 
-/*
- * gcc versions earlier than 4.0 are simply too problematic for the
- * __div64_const32() code in asm-generic/div64.h. First there is
- * gcc PR 15089 that tend to trig on more complex constructs, spurious
- * .global __udivsi3 are inserted even if none of those symbols are
- * referenced in the generated code, and those gcc versions are not able
- * to do constant propagation on long long values anyway.
- */
-
-#define __div64_const32_is_OK (__GNUC__ >= 4)
-
 static inline uint64_t __arch_xprod_64(uint64_t m, uint64_t n, bool bias)
 {
 	unsigned long long res;
-- 
2.9.0

