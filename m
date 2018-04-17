From: James Hogan <jhogan@kernel.org>
Subject: [PATCH v3 1/3] alpha: Use OPTIMIZE_INLINING instead of asm/compiler.h
Date: Tue, 17 Apr 2018 11:11:04 +0100
Message-ID: <a20761a842efe590da08e835ecc5690a4cf50213.1523959603.git-series.jhogan@kernel.org>
References: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
In-Reply-To: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
References: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>
List-Id: linux-arch.vger.kernel.org

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
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
Changes in v3 (James):
- New patch in v3.
---
 arch/alpha/Kconfig                |  6 ++++++
 arch/alpha/include/asm/compiler.h | 11 -----------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index b2022885ced8..b296ba9bd8b7 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -81,6 +81,12 @@ config PGTABLE_LEVELS
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
git-series 0.9.1
