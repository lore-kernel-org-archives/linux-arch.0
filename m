Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:42842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbfH2LTS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 07:19:18 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 6/7] mips: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
Date: Thu, 29 Aug 2019 12:18:42 +0100
Message-ID: <20190829111843.41003-7-vincenzo.frascino@arm.com>
In-Reply-To: <20190829111843.41003-1-vincenzo.frascino@arm.com>
References: <20190829111843.41003-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com, tglx@linutronix.de, salyzyn@android.com, 0x7f454c46@gmail.com, luto@kernel.org
Message-ID: <20190829111842.TJcSsqvstun3kkWpsD8JhvEGNqd_-4erkyg6OtkFIKY@z>

As a consequence of Commit 623fa33f7bd6 ("lib:vdso: Remove
VDSO_HAS_32BIT_FALLBACK") VDSO_HAS_32BIT_FALLBACK define is not
required anymore hence can be removed.

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
