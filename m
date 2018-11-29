Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730385AbeK3EMg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Nov 2018 23:12:36 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2 16/28] lib: vdso: Add compat support
Date: Thu, 29 Nov 2018 17:05:18 +0000
Message-ID: <20181129170530.37789-17-vincenzo.frascino@arm.com>
In-Reply-To: <20181129170530.37789-1-vincenzo.frascino@arm.com>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181129170518.rTuRjwkBIBbXs9BRQiIBoDXtupXwT9qx8qZG2uxlomI@z>

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
index a8cfeeb1f40a..19a5337fd066 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -15,7 +15,11 @@
 #include <linux/hrtimer.h>
 #include <vdso/datapage.h>
 
+#ifdef ENABLE_COMPAT_VDSO
+#include <asm/vdso/compat_gettimeofday.h>
+#else
 #include <asm/vdso/gettimeofday.h>
+#endif /* ENABLE_COMPAT_VDSO */
 
 /* To improve performances, in this file, __always_inline it is used
  * for the functions called multiple times.
-- 
2.19.2
