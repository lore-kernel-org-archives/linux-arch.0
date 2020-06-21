From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH v4 1/2] linux/bits.h: fix unsigned less than zero warnings
Date: Sun, 21 Jun 2020 07:42:09 +0200
Message-ID: <20200621054210.14804-1-rikard.falkeborn@gmail.com>
References: <20200620213632.60c2c6b99ec9cf9392fa128d@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgFUFmR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Jun 2020 01:42:17 -0400
In-Reply-To: <20200620213632.60c2c6b99ec9cf9392fa128d@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: andy.shevchenko@gmail.com, arnd@arndb.de, emil.l.velikov@gmail.com, geert@linux-m68k.org, keescook@chromium.org, linus.walleij@linaro.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com, rikard.falkeborn@gmail.com, syednwaris@gmail.com, vilhelm.gray@gmail.com, yamada.masahiro@socionext.com

When calling the GENMASK and GENMASK_ULL macros with zero lower bit and
an unsigned unknown high bit, some gcc versions warn due to the
comparisons of the high and low bit in GENMASK_INPUT_CHECK.

To silence the warnings, only perform the check if both inputs are
known. This does not trigger any warnings, from the Wtype-limits help:

	Warn if a comparison is always true or always false due to the
	limited range of the data type, but do not warn for constant
	expressions.

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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
v3-v4
Added Emils Reviewed-by.

v2-v3
Added Andys Reviewed-by.

v1->v2
Change to require both high and low bit to be constant expressions
instead of introducing somewhat arbitrary casts

 include/linux/bits.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 4671fbf28842..35ca3f5d11a0 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -23,7 +23,8 @@
 #include <linux/build_bug.h>
 #define GENMASK_INPUT_CHECK(h, l) \
 	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
-		__builtin_constant_p((l) > (h)), (l) > (h), 0)))
+		__builtin_constant_p(l) && __builtin_constant_p(h), \
+		(l) > (h), 0)))
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
-- 
2.27.0
