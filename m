Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbeLMQ7V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Dec 2018 11:59:21 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v3 12/24] lib: vdso: Add compat support
Date: Thu, 13 Dec 2018 16:57:34 +0000
Message-ID: <20181213165746.56930-13-vincenzo.frascino@arm.com>
In-Reply-To: <20181213165746.56930-1-vincenzo.frascino@arm.com>
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181213165734.t6VaEXCw0qH5FbN5g8r2TEzDJ0FWWDUKePDnNH6-Bow@z>

Some 64 bit architectures have support for 32 bit applications that
require a separate version of the vDSOs.

This patch adds support to the generic code for compat fallback
functions.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 lib/vdso/gettimeofday.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 30010d25bf5b..e21bd58139c8 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -28,7 +28,11 @@
  * - clock_gettime_fallback(): fallback for clock_gettime.
  * - clock_getres_fallback(): fallback for clock_getres.
  */
+#ifdef ENABLE_COMPAT_VDSO
+#include <asm/vdso/compat_gettimeofday.h>
+#else
 #include <asm/vdso/gettimeofday.h>
+#endif /* ENABLE_COMPAT_VDSO */
 
 #ifdef CONFIG_HAVE_HW_COUNTER
 static notrace int do_hres(const struct vdso_data *vd,
-- 
2.19.2
