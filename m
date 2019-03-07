Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:49353 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCGQFk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Mar 2019 11:05:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/4] vdso: ARM: fix building without ARM_ARCH_TIMER
Date: Thu,  7 Mar 2019 17:05:29 +0100
Message-Id: <20190307160532.3328288-2-arnd@arndb.de>
In-Reply-To: <20190307160532.3328288-1-arnd@arndb.de>
References: <20190307160532.3328288-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

When the arch timer is disabled, the vdso fails to build:

In file included from lib/vdso/gettimeofday.c:26,
                 from <command-line>:
arch/arm/include/asm/vdso/gettimeofday.h: In function '__arch_get_hw_counter':
arch/arm/include/asm/vdso/gettimeofday.h:72:9: error: implicit declaration of function 'arch_counter_get_cntvct'; did you mean 'arch_timer_get_rate'? [-Werror=implicit-function-declaration]
  return arch_counter_get_cntvct();
         ^~~~~~~~~~~~~~~~~~~~~~~

Make it use the fallback path instead by returning a negative
error code here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/vdso/gettimeofday.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/vdso/gettimeofday.h
index 112df50920b0..77ace4a757c1 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -69,7 +69,11 @@ static __always_inline notrace int clock_getres_fallback(
 
 static __always_inline notrace u64 __arch_get_hw_counter(int clock_mode)
 {
+#ifdef CONFIG_ARM_ARCH_TIMER
 	return arch_counter_get_cntvct();
+#else
+	return -EINVAL; /* use fallback */
+#endif
 }
 
 static __always_inline notrace const struct vdso_data *__arch_get_vdso_data(void)
-- 
2.20.0
