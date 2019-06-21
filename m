Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:55408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbfFUJxd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Jun 2019 05:53:33 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v7 09/25] lib: vdso: Add compat support
Date: Fri, 21 Jun 2019 10:52:36 +0100
Message-ID: <20190621095252.32307-10-vincenzo.frascino@arm.com>
In-Reply-To: <20190621095252.32307-1-vincenzo.frascino@arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, Shijith Thotton <sthotton@marvell.com>, Andre Przywara <andre.przywara@arm.com>
Message-ID: <20190621095236.2NS_wte5cCWiYWiQv2dDDxp6gNiDE2BWzjlMvJCubK8@z>

Some 64 bit architectures have support for 32 bit applications that
require a separate version of the vDSOs.

Add support to the generic code for compat fallback functions.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Shijith Thotton <sthotton@marvell.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
---
 lib/vdso/gettimeofday.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 473e2dda0220..fc43f457ed2c 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -21,7 +21,11 @@
  * - clock_gettime_fallback(): fallback for clock_gettime.
  * - clock_getres_fallback(): fallback for clock_getres.
  */
+#ifdef ENABLE_COMPAT_VDSO
+#include <asm/vdso/compat_gettimeofday.h>
+#else
 #include <asm/vdso/gettimeofday.h>
+#endif /* ENABLE_COMPAT_VDSO */
 
 static int do_hres(const struct vdso_data *vd,
 		   clockid_t clk,
-- 
2.21.0
