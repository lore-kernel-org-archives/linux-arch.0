Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:50101 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfBRVH6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 16:07:58 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 7/8] csky: Use latest system call ABI
Date: Mon, 18 Feb 2019 22:07:11 +0100
Message-ID: <20190218210712.3503891-8-arnd@arndb.de>
In-Reply-To: <20190218210712.3503891-1-arnd@arndb.de>
References: <20190218210712.3503891-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: y2038@lists.linaro.org
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, yury.norov@gmail.com, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Stafford Horne <shorne@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Palmer Dabbelt <palmer@sifive.com>, Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>, arnd@arndb.de, linux-riscv@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>
Message-ID: <20190218210711.ZhlLaekQaMrtXMyH9HIPC7EJV7_vCC2O09EnXEHCa6g@z>

We don't yet have an upstream glibc port for csky, so there is no user
space for the existing ABI, and we can remove the definitions for 32-bit
time_t, off_t and struct resource.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig                   | 1 -
 arch/csky/include/uapi/asm/unistd.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 6959e0b1e956..398113c845f5 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -1,6 +1,5 @@
 config CSKY
 	def_bool y
-	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
index ec60e49cea66..224c9a9ab45b 100644
--- a/arch/csky/include/uapi/asm/unistd.h
+++ b/arch/csky/include/uapi/asm/unistd.h
@@ -2,8 +2,6 @@
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
 #define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_SET_GET_RLIMIT
-#define __ARCH_WANT_TIME32_SYSCALLS
 #include <asm-generic/unistd.h>
 
 #define __NR_set_thread_area	(__NR_arch_specific_syscall + 0)
-- 
2.20.0
