Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:44832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfFYQSk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Jun 2019 12:18:40 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 3/3] arm64: compat: Fix __arch_get_hw_counter() implementation
Date: Tue, 25 Jun 2019 17:18:04 +0100
Message-ID: <20190625161804.38713-3-vincenzo.frascino@arm.com>
In-Reply-To: <20190625161804.38713-1-vincenzo.frascino@arm.com>
References: <20190624133607.GI29497@fuggles.cambridge.arm.com>
 <20190625161804.38713-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com, daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com, pcc@google.com, shuah@kernel.org, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk, huw@codeweavers.com, sthotton@marvell.com, andre.przywara@arm.com
Message-ID: <20190625161804.popgHHlqRjBVQK0F3fqq72U0hll022SbeL6oaFbAItQ@z>

Provide the following fixes for the __arch_get_hw_counter()
implementation on arm64:
- Fallback on syscall when an unstable counter is detected.
- Introduce isb()s before and after the counter read to avoid
speculation of the counter value and of the seq lock
respectively.
The second isb() is a temporary solution that will be revisited
in 5.3-rc1.

These fixes restore the semantics that __arch_counter_get_cntvct()
had on arm64.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 .../include/asm/vdso/compat_gettimeofday.h     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index 93dbd935b66d..f4812777f5c5 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -12,6 +12,8 @@
 
 #include <asm/vdso/compat_barrier.h>
 
+#define __VDSO_USE_SYSCALL		ULLONG_MAX
+
 #define VDSO_HAS_CLOCK_GETRES		1
 
 static __always_inline
@@ -74,8 +76,24 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
 {
 	u64 res;
 
+	/*
+	 * clock_mode == 0 implies that vDSO are enabled otherwise
+	 * fallback on syscall.
+	 */
+	if (clock_mode)
+		return __VDSO_USE_SYSCALL;
+
+	/*
+	 * This isb() is required to prevent that the counter value
+	 * is speculated.
+	 */
 	isb();
 	asm volatile("mrrc p15, 1, %Q0, %R0, c14" : "=r" (res));
+	/*
+	 * This isb() is required to prevent that the seq lock is
+	 * speculated.
+	 */
+	isb();
 
 	return res;
 }
-- 
2.22.0
