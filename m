Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:52359 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbfBRVH7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 16:07:59 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 8/8] riscv: Use latest system call ABI
Date: Mon, 18 Feb 2019 22:07:12 +0100
Message-ID: <20190218210712.3503891-9-arnd@arndb.de>
In-Reply-To: <20190218210712.3503891-1-arnd@arndb.de>
References: <20190218210712.3503891-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: y2038@lists.linaro.org
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, yury.norov@gmail.com, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Stafford Horne <shorne@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Palmer Dabbelt <palmer@sifive.com>, Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>, arnd@arndb.de, linux-riscv@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>
Message-ID: <20190218210712.FjDH9jFwcp4bP_s7sC6dfUINu9hAJDrRlD1ofhk3R8w@z>

We don't yet have an upstream glibc port for riscv, so there is no user
space for the existing ABI, and we can remove the definitions for 32-bit
time_t, off_t and struct resource and system calls based on them,
including the vdso.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/Kconfig                   | 1 -
 arch/riscv/include/uapi/asm/unistd.h | 5 +----
 arch/riscv/kernel/vdso/Makefile      | 2 ++
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 09fa3a87bf30..feeeaa60697c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -11,7 +11,6 @@ config 32BIT
 
 config RISCV
 	def_bool y
-	select ARCH_32BIT_OFF_T if !64BIT
 	# even on 32-bit, physical (and DMA) addresses are > 32-bits
 	select PHYS_ADDR_T_64BIT
 	select OF
diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
index 486a288b454c..0e2eeeb1fd27 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -17,11 +17,8 @@
 
 #ifdef __LP64__
 #define __ARCH_WANT_NEW_STAT
-#endif /* __LP64__ */
 #define __ARCH_WANT_SET_GET_RLIMIT
-#ifndef __LP64__
-#define __ARCH_WANT_TIME32_SYSCALLS
-#endif
+#endif /* __LP64__ */
 
 #include <asm-generic/unistd.h>
 
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index eed1c137f618..fec62b24df89 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -2,9 +2,11 @@
 
 # Symbols present in the vdso
 vdso-syms  = rt_sigreturn
+ifdef CONFIG_64BIT
 vdso-syms += gettimeofday
 vdso-syms += clock_gettime
 vdso-syms += clock_getres
+endif
 vdso-syms += getcpu
 vdso-syms += flush_icache
 
-- 
2.20.0
