Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:60866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbfH3N71 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Aug 2019 09:59:27 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2 7/8] mips: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
Date: Fri, 30 Aug 2019 14:59:01 +0100
Message-ID: <20190830135902.20861-8-vincenzo.frascino@arm.com>
In-Reply-To: <20190830135902.20861-1-vincenzo.frascino@arm.com>
References: <20190830135902.20861-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com, tglx@linutronix.de, salyzyn@android.com, 0x7f454c46@gmail.com, luto@kernel.org
Message-ID: <20190830135901.b6p7dW79xLc2g_TE36GHVvsTIWXZ0c2xw0HBQvd-qFw@z>

VDSO_HAS_32BIT_FALLBACK has been removed from the core since
the architectures that support the generic vDSO library have
been converted to support the 32 bit fallbacks.

Remove unused VDSO_HAS_32BIT_FALLBACK from mips vdso.

Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/mips/include/asm/vdso/gettimeofday.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
index e78462e8ca2e..5ad2b086626d 100644
--- a/arch/mips/include/asm/vdso/gettimeofday.h
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -107,8 +107,6 @@ static __always_inline int clock_getres_fallback(
 
 #if _MIPS_SIM != _MIPS_SIM_ABI64
 
-#define VDSO_HAS_32BIT_FALLBACK	1
-
 static __always_inline long clock_gettime32_fallback(
 					clockid_t _clkid,
 					struct old_timespec32 *_ts)
-- 
2.23.0
