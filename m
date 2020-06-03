From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] linux/bits.h: fix unsigned less than zero warnings
Date: Thu,  4 Jun 2020 00:02:26 +0200
Message-ID: <20200603220226.916269-1-rikard.falkeborn@gmail.com>
References: <20200603215314.GA916134@rikard>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200603215314.GA916134@rikard>
Sender: linux-kernel-owner@vger.kernel.org
To: rikard.falkeborn@gmail.com
Cc: akpm@linux-foundation.org, andy.shevchenko@gmail.com, arnd@arndb.de, emil.l.velikov@gmail.com, keescook@chromium.org, linus.walleij@linaro.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, syednwaris@gmail.com, vilhelm.gray@gmail.com, yamada.masahiro@socionext.com, kbuild test robot <lkp@intel.com>
List-Id: linux-arch.vger.kernel.org

When calling the GENMASK and GENMASK_ULL macros with zero lower bit and
an unsigned unknown high bit, some gcc versions warn due to the
comparisons of the high and low bit in GENMASK_INPUT_CHECK.

To silence the warnings, cast the inputs to int before doing the
comparisons. The only valid inputs to GENMASK() and GENMASK_ULL() are
are 0 to 31 or 63. Anything outside this is undefined due to the shifts
in GENMASK()/GENMASK_ULL(). Therefore, casting the inputs to int do not
change the values for valid known inputs. For unknown values, the check
does not change anything since it's a compile-time check only.

As an example of the warning, kindly reported by the kbuild test robot:

from drivers/mfd/atmel-smc.c:11:
drivers/mfd/atmel-smc.c: In function 'atmel_smc_cs_encode_ncycles':
include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
|                            ^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
|                                                              ^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
|   ^~~~~~~~~~~~~~~~~~~
>> drivers/mfd/atmel-smc.c:49:25: note: in expansion of macro 'GENMASK'
49 |  unsigned int lsbmask = GENMASK(msbpos - 1, 0);
|                         ^~~~~~~

Fixes: 295bcca84916 ("linux/bits.h: add compile time sanity check of GENMASK inputs")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Emil Velikov <emil.l.velikov@gmail.com>
Reported-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 include/linux/bits.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 4671fbf28842..293d1ee71a48 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -21,9 +21,10 @@
 #if !defined(__ASSEMBLY__) && \
 	(!defined(CONFIG_CC_IS_GCC) || CONFIG_GCC_VERSION >= 49000)
 #include <linux/build_bug.h>
+/* Avoid Wtype-limits warnings by casting the inputs to int */
 #define GENMASK_INPUT_CHECK(h, l) \
 	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
-		__builtin_constant_p((l) > (h)), (l) > (h), 0)))
+		__builtin_constant_p((int)(l) > (int)(h)), (int)(l) > (int)(h), 0)))
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
-- 
2.27.0
