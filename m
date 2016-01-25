From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mtd: only use __xipram annotation when XIP_KERNEL is set
Date: Mon, 25 Jan 2016 16:41:50 +0100
Message-ID: <1453736525-1959191-2-git-send-email-arnd@arndb.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:58481 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225AbcAYPnc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jan 2016 10:43:32 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org

When XIP_KERNEL is enabled, some functions are defined in the .data
ELF section because we require them to be in RAM whenever we communicate
with the flash chip. However this causes problems when FTRACE is
enabled and gcc emits calls to __gnu_mcount_nc in the function
prolog:

drivers/built-in.o: In function `cfi_chip_setup':
:(.data+0x272fc): relocation truncated to fit: R_ARM_CALL against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/built-in.o
drivers/built-in.o: In function `cfi_probe_chip':
:(.data+0x27de8): relocation truncated to fit: R_ARM_CALL against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/built-in.o
/tmp/ccY172rP.s: Assembler messages:
/tmp/ccY172rP.s:70: Warning: ignoring changed section attributes for .data
/tmp/ccY172rP.s: Error: 1 warning, treating warnings as errors
make[5]: *** [drivers/mtd/chips/cfi_probe.o] Error 1
/tmp/ccK4rjeO.s: Assembler messages:
/tmp/ccK4rjeO.s:421: Warning: ignoring changed section attributes for .data
/tmp/ccK4rjeO.s: Error: 1 warning, treating warnings as errors
make[5]: *** [drivers/mtd/chips/cfi_util.o] Error 1
/tmp/ccUvhCYR.s: Assembler messages:
/tmp/ccUvhCYR.s:1895: Warning: ignoring changed section attributes for .data
/tmp/ccUvhCYR.s: Error: 1 warning, treating warnings as errors

Specifically, this does not work because the .data section is not
marked executable, which leads LD to not generate trampolines for
long calls.

This moves the __xipram functions into their own .xiptext section instead.
The section is still placed next to .data and located in RAM but is marked
executable, which avoids the build errors.

Also, we only need to place the XIP functions into a separate section
if both CONFIG_XIP_KERNEL and CONFIG_MTD_XIP are set: When only MTD_XIP
is used, the whole kernel is still in RAM and we do not need to worry
about pulling out the rug under it. When only XIP_KERNEL but not MTD_XIP
is set, the kernel is in some form of ROM, but we never write to it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/vmlinux.lds.h |  1 +
 include/linux/mtd/xip.h           | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c4bd0e2c173c..73a2c72e4252 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -199,6 +199,7 @@
 
 /* .data section */
 #define DATA_DATA							\
+	*(.xiptext)							\
 	*(.data)							\
 	*(.ref.data)							\
 	*(.data..shared_aligned) /* percpu related */			\
diff --git a/include/linux/mtd/xip.h b/include/linux/mtd/xip.h
index abed4dec5c2f..e373690cce0a 100644
--- a/include/linux/mtd/xip.h
+++ b/include/linux/mtd/xip.h
@@ -30,7 +30,9 @@
  * obviously not be running from flash.  The __xipram is therefore marking
  * those functions so they get relocated to ram.
  */
-#define __xipram noinline __attribute__ ((__section__ (".data")))
+#ifdef CONFIG_XIP_KERNEL
+#define __xipram noinline __attribute__ ((__section__ (".xiptext")))
+#endif
 
 /*
  * Each architecture has to provide the following macros.  They must access
@@ -90,10 +92,10 @@
 #define xip_cpu_idle()  do { } while (0)
 #endif
 
-#else
+#endif /* CONFIG_MTD_XIP */
 
+#ifndef __xipram
 #define __xipram
-
-#endif /* CONFIG_MTD_XIP */
+#endif
 
 #endif /* __LINUX_MTD_XIP_H__ */
-- 
2.7.0
