Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:42149 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfBRVH6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 16:07:58 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/8] unicore32: Fix __ARCH_WANT_STAT64 definition
Date: Mon, 18 Feb 2019 22:07:09 +0100
Message-ID: <20190218210712.3503891-6-arnd@arndb.de>
In-Reply-To: <20190218210712.3503891-1-arnd@arndb.de>
References: <20190218210712.3503891-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: y2038@lists.linaro.org
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, yury.norov@gmail.com, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Stafford Horne <shorne@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Palmer Dabbelt <palmer@sifive.com>, Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>, arnd@arndb.de, linux-riscv@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>
Message-ID: <20190218210709.7UjpZnMwAvZRkqchDbG7xE3F-UFfG97b6Mj6veifMbM@z>

The __ARCH_WANT_STAT64 macro must be defined before including
asm-generic/unistd.h. I got this right for everything except
unicore32.

Fixes: bf4b6a7d371e ("y2038: Remove stat64 family from default syscall set")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/unicore32/include/uapi/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/unicore32/include/uapi/asm/unistd.h b/arch/unicore32/include/uapi/asm/unistd.h
index 4e5e624f5d7e..54a7378a70b1 100644
--- a/arch/unicore32/include/uapi/asm/unistd.h
+++ b/arch/unicore32/include/uapi/asm/unistd.h
@@ -13,9 +13,9 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_TIME32_SYSCALLS
 
 /* Use the standard ABI for syscalls. */
 #include <asm-generic/unistd.h>
-#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_CLONE
-- 
2.20.0
