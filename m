Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58962 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbeKIWSv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Nov 2018 17:18:51 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 15/27] lib: vdso: Add compat support
Date: Fri,  9 Nov 2018 12:37:18 +0000
Message-ID: <20181109123730.8743-16-vincenzo.frascino@arm.com>
In-Reply-To: <20181109123730.8743-1-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181109123718.O1R1y4wFjqX4lzwYKG9aOYKRShOGG5ITVbgUQvRnlC4@z>

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
index ec903180d3da..572ac162bdac 100644
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
2.19.1
