From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Tue, 22 Nov 2016 12:05:40 +0100
Message-ID: <20161122110557.1533467-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:55592 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752526AbcKVLGm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2016 06:06:42 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <linux@armlinux.org.uk>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Nicolas Pitre <nico@linaro.org>, linux-arm-kernel@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, regressions@leemhuis.info, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org

This adds an asm/asm-prototypes.h header for ARM to fix the broken symbol
versioning for symbols exported from assembler files.

I couldn't find the correct prototypes for the compiler builtins,
so I went with the fake 'void f(void)' prototypes that we had
before, restoring the state before they were moved.

Originally I assumed that the problem was just a harmless warning
in unusual configurations, but as Uwe found, we actually need this
to load most modules when symbol versioning is enabled, as it is
in many distro kernels.

Cc: Uwe Kleine-König <uwe@kleine-koenig.org>
Fixes: 4dd1837d7589 ("arm: move exports to definitions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Compared to the earlier version, I dropped the changes to the
csumpartial files, which now get handled correctly by Kbuild
even when the export comes from a macro, and I also dropped the
changes to the bitops files, which were already fixed in a
patch from Nico.

The patch applies cleanly on top of the rmk/fixes tree but has
no effect there, as it also needs 4efca4ed05cb ("kbuild: modversions
for EXPORT_SYMBOL() for asm") and cc6acc11cad1 ("kbuild: be more
careful about matching preprocessed asm ___EXPORT_SYMBOL").

With the combination of rmk/fixes, torvalds/master and these two
patches, symbol versioning works again on ARM. As it is still
broken on almost all other architectures (powerpc is fixed,
x86 has a patch), I wonder if we should make CONFIG_MODVERSIONS
as broken for everything else.
---
 arch/arm/include/asm/asm-prototypes.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 arch/arm/include/asm/asm-prototypes.h

diff --git a/arch/arm/include/asm/asm-prototypes.h b/arch/arm/include/asm/asm-prototypes.h
new file mode 100644
index 000000000000..04e5616a7b15
--- /dev/null
+++ b/arch/arm/include/asm/asm-prototypes.h
@@ -0,0 +1,34 @@
+#include <linux/arm-smccc.h>
+#include <linux/bitops.h>
+#include <linux/ftrace.h>
+#include <linux/io.h>
+#include <linux/platform_data/asoc-imx-ssi.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include <asm/checksum.h>
+#include <asm/div64.h>
+#include <asm/memory.h>
+
+extern void __aeabi_idivmod(void);
+extern void __aeabi_idiv(void);
+extern void __aeabi_lasr(void);
+extern void __aeabi_llsl(void);
+extern void __aeabi_llsr(void);
+extern void __aeabi_lmul(void);
+extern void __aeabi_uidivmod(void);
+extern void __aeabi_uidiv(void);
+extern void __aeabi_ulcmp(void);
+
+extern void __ashldi3(void);
+extern void __ashrdi3(void);
+extern void __bswapdi2(void);
+extern void __bswapsi2(void);
+extern void __divsi3(void);
+extern void __do_div64(void);
+extern void __lshrdi3(void);
+extern void __modsi3(void);
+extern void __muldi3(void);
+extern void __ucmpdi2(void);
+extern void __udivsi3(void);
+extern void __umodsi3(void);
-- 
2.9.0
