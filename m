Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbeLMQ7m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Dec 2018 11:59:42 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v3 21/24] mips: Introduce vdso_direct
Date: Thu, 13 Dec 2018 16:57:43 +0000
Message-ID: <20181213165746.56930-22-vincenzo.frascino@arm.com>
In-Reply-To: <20181213165746.56930-1-vincenzo.frascino@arm.com>
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181213165743.L2l8GObnRVUWgmy8QmqRvCksgosXrKxs6DOyGX2HaEI@z>

vdso_direct is an architectural clock configuration parameter that
exposes the usage of not of the vDSO.

If vdso_direct is false, the time related syscalls will be used instead
of the vDSO library.

This patch introduces the parameter in the mips architecture to prepare
the ground for the support of the generic vDSO library.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/mips/include/asm/clocksource.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/clocksource.h b/arch/mips/include/asm/clocksource.h
index 3deb1d0c1a94..eab11ee4871a 100644
--- a/arch/mips/include/asm/clocksource.h
+++ b/arch/mips/include/asm/clocksource.h
@@ -23,6 +23,7 @@
  * @vdso_clock_mode: Method the VDSO should use to access the clocksource.
  */
 struct arch_clocksource_data {
+	bool vdso_direct;
 	u8 vdso_clock_mode;
 };
 
-- 
2.19.2
