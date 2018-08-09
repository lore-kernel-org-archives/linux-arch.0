Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr730101.outbound.protection.outlook.com ([40.107.73.101]:45037
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732399AbeHIULh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Aug 2018 16:11:37 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: [PATCH v6 1/4] alpha: Use OPTIMIZE_INLINING instead of asm/compiler.h
Date: Thu,  9 Aug 2018 10:44:41 -0700
Message-Id: <20180809174444.31705-2-paul.burton@mips.com>
In-Reply-To: <20180809174444.31705-1-paul.burton@mips.com>
References: <20180809174444.31705-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mips@linux-mips.org
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-alpha@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-arch@vger.kernel.org, linux-um@lists.infradead.org, Paul Burton <paul.burton@mips.com>

From: James Hogan <jhogan@kernel.org>

Use CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING and CONFIG_OPTIMIZE_INLINING
instead of undefining the inline macros in the alpha specific
asm/compiler.h. This is to allow asm/compiler.h to become a general
header that can be used for overriding linux/compiler*.h.

A build of alpha's defconfig on GCC 7.3 before and after this series
(i.e. this commit and "compiler.h: Allow arch-specific overrides" which
includes asm/compiler.h from linux/compiler_types.h) results in the
following size differences, which appear harmless to me:

$ ./scripts/bloat-o-meter vmlinux.1 vmlinux.2
add/remove: 1/1 grow/shrink: 3/0 up/down: 264/-348 (-84)
Function                                     old     new   delta
cap_bprm_set_creds                          1496    1664    +168
cap_issubset                                   -      68     +68
flex_array_put                               328     344     +16
cap_capset                                   488     500     +12
nonroot_raised_pE.constprop                  348       -    -348
Total: Before=5823709, After=5823625, chg -0.00%

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: James Hogan <jhogan@kernel.org>
Acked-by: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-alpha@vger.kernel.org

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3:
- New patch in v3.

 arch/alpha/Kconfig                |  6 ++++++
 arch/alpha/include/asm/compiler.h | 11 -----------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 04a4a138ed13..649b41621520 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -74,6 +74,12 @@ config PGTABLE_LEVELS
 	int
 	default 3
 
+config ARCH_SUPPORTS_OPTIMIZED_INLINING
+	def_bool y
+
+config OPTIMIZE_INLINING
+	def_bool y
+
 source "init/Kconfig"
 source "kernel/Kconfig.freezer"
 
diff --git a/arch/alpha/include/asm/compiler.h b/arch/alpha/include/asm/compiler.h
index 5159ba259d65..ae645959018a 100644
--- a/arch/alpha/include/asm/compiler.h
+++ b/arch/alpha/include/asm/compiler.h
@@ -4,15 +4,4 @@
 
 #include <uapi/asm/compiler.h>
 
-/* Some idiots over in <linux/compiler.h> thought inline should imply
-   always_inline.  This breaks stuff.  We'll include this file whenever
-   we run into such problems.  */
-
-#include <linux/compiler.h>
-#undef inline
-#undef __inline__
-#undef __inline
-#undef __always_inline
-#define __always_inline		inline __attribute__((always_inline))
-
 #endif /* __ALPHA_COMPILER_H */
-- 
2.18.0
