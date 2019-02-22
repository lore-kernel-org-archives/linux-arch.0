Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfBVM0M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 07:26:12 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v5 12/23] lib: vdso: Add compat support
Date: Fri, 22 Feb 2019 12:24:19 +0000
Message-ID: <20190222122430.21180-13-vincenzo.frascino@arm.com>
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190222122419.KGjrjd1awbPDeQBCFVttzN7BqsWEHqpBuajL9DlqoPI@z>

Some 64 bit architectures have support for 32 bit applications that
require a separate version of the vDSOs.

Add support to the generic code for compat fallback functions.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 lib/vdso/gettimeofday.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 39f92f7d3218..466d0c68fa80 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -20,7 +20,11 @@
  * - clock_gettime_fallback(): fallback for clock_gettime.
  * - clock_getres_fallback(): fallback for clock_getres.
  */
+#ifdef ENABLE_COMPAT_VDSO
+#include <asm/vdso/compat_gettimeofday.h>
+#else
 #include <asm/vdso/gettimeofday.h>
+#endif /* ENABLE_COMPAT_VDSO */
 
 static notrace int do_hres(const struct vdso_data *vd,
 			   clockid_t clk,
-- 
2.20.1
