From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] bitfield: Use __ffs64(x) to fix missing __ffsdi2()
Date: Mon,  9 Oct 2017 10:40:49 +0200
Message-ID: <1507538449-22775-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:47512 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbdJIIkx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 04:40:53 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jakub Kicinski <jakub.kicinski@netronome.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: kbuild test robot <fengguang.wu@intel.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

On most architectures[*], gcc turns __builtin_ffsll() into a call to
__ffsdi2(), which is not provided by any architecture, leading to
failures like:

    rcar-gen3-cpg.c:(.text+0x289): undefined reference to `__ffsdi2'

To fix this, use __ffs64() instead, which is available on all
architectures.

[*] Known exceptions are some 64-bit architectures like amd64, arm64,
    ia64, powerpc64, and tilegx.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Fixes: 3e9b3112ec74f192 ("add basic register-field manipulation macros")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/bitfield.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 8b9d6fff002db113..0a827677372756fa 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -15,6 +15,7 @@
 #ifndef _LINUX_BITFIELD_H
 #define _LINUX_BITFIELD_H
 
+#include <linux/bitops.h>
 #include <linux/bug.h>
 
 /*
@@ -46,7 +47,7 @@
  *  reg |= FIELD_PREP(REG_FIELD_C, c);
  */
 
-#define __bf_shf(x) (__builtin_ffsll(x) - 1)
+#define __bf_shf(x) __ffs64(x)
 
 #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)			\
 	({								\
-- 
2.7.4
