Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:42822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbfH2LTR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 07:19:17 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 5/7] arm64: compat: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
Date: Thu, 29 Aug 2019 12:18:41 +0100
Message-ID: <20190829111843.41003-6-vincenzo.frascino@arm.com>
In-Reply-To: <20190829111843.41003-1-vincenzo.frascino@arm.com>
References: <20190829111843.41003-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com, tglx@linutronix.de, salyzyn@android.com, 0x7f454c46@gmail.com, luto@kernel.org
Message-ID: <20190829111841.GU3LdGmnrQU_9rr_jY6mZ_Wc6ihGUv3nXnB0V7d33YQ@z>

As a consequence of Commit 623fa33f7bd6 ("lib:vdso: Remove
VDSO_HAS_32BIT_FALLBACK") VDSO_HAS_32BIT_FALLBACK define is not
required anymore hence can be removed.

Remove unused VDSO_HAS_32BIT_FALLBACK from arm64 compat vdso.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index fe7afe0f1a3d..537b1e695365 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -16,7 +16,6 @@
 
 #define VDSO_HAS_CLOCK_GETRES		1
 
-#define VDSO_HAS_32BIT_FALLBACK		1
 #define BUILD_VDSO32			1
 
 static __always_inline
-- 
2.23.0
