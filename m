From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH] arch: remove GENERIC_FIND_FIRST_BIT
Date: Sat, 13 May 2017 20:21:37 +0300
Message-ID: <20170513172137.10893-1-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam01on0064.outbound.protection.outlook.com ([104.47.34.64]:38752
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751519AbdEMRVw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 13 May 2017 13:21:52 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: Yury Norov <ynorov@caviumnetworks.com>, Akinobu Mita <akinobu.mita@gmail.com>, Paul Bolle <pebolle@tiscali.nl>

This option, if disabled, is used to alias find_first_bit() to 
find_next_bit() with the trivial macro:
#define find_first_bit(addr, size) find_next_bit((addr), (size), 0)

And the same for find_first_zero_bit().

The problem here is that the implementation of find_next_bit() is more
complex, and that extra complexity is not really needed if the offset
that passed to find_next_bit() is known to be 0.

This patch removes GENERIC_FIND_FIRST_BIT and drops the alias to find_next_bit().
Architectures that enable GENERIC_FIND_FIRST_BIT will be obviously not affected
with this change. Namely, arc, s390, tile, unicore32 and x86. Some architectures
implement their own implementations, so they are not affected too. They are: arm,
m68k, unicore32. (Unicore32 both enables the CONFIG_GENERIC_FIND_FIRST_BIT and has
custom implementation for it.) Others will switch to separate implementation.

Tested on arm64.

There is a couple of patches in the kernel that remove similar config options:
63e424c84429 ("arch: remove CONFIG_GENERIC_FIND_{NEXT_BIT,BIT_LE,LAST_BIT}") and
65af3a3f89d7 ("arch: remove CONFIG_GENERIC_FIND_NEXT_BIT again"), but the
GENERIC_FIND_FIRST_BIT is the last one that still there. So this path finishes
the work.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arc/Kconfig                  | 1 -
 arch/s390/Kconfig                 | 1 -
 arch/tile/Kconfig                 | 1 -
 arch/unicore32/Kconfig            | 1 -
 arch/x86/Kconfig                  | 1 -
 arch/x86/um/Kconfig               | 1 -
 include/asm-generic/bitops/find.h | 8 --------
 lib/Kconfig                       | 3 ---
 8 files changed, 17 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index cab9c53e0354..ebc3b1cab103 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -17,7 +17,6 @@ config ARC
 	select COMMON_CLK
 	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_FIND_FIRST_BIT
 	# for now, we don't need GENERIC_IRQ_PROBE, CONFIG_GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index e7ff58150e8f..a3e61ca22d73 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -119,7 +119,6 @@ config S390
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_DEVICES if !SMP
-	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 845dcbd8235e..423817d88b8c 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -10,7 +10,6 @@ config TILE
 	select CC_OPTIMIZE_FOR_SIZE
 	select EDAC_SUPPORT
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PENDING_IRQ if SMP
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 9629fd827d6b..c1ba1c95bd32 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -13,7 +13,6 @@ config UNICORE32
 	select HAVE_KERNEL_LZMA
 	select VIRT_TO_BUS
 	select ARCH_HAVE_CUSTOM_GPIO_H
-	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ead9e32744c7..abccd8ecb275 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -86,7 +86,6 @@ config X86
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
-	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 8436bcd9beba..fa93329042c4 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -12,7 +12,6 @@ endmenu
 
 config UML_X86
 	def_bool y
-	select GENERIC_FIND_FIRST_BIT
 
 config 64BIT
 	bool "64-bit kernel" if SUBARCH = "x86"
diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 998d4d544f18..790b333cff8b 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -29,8 +29,6 @@ extern unsigned long find_next_zero_bit(const unsigned long *addr, unsigned
 		long size, unsigned long offset);
 #endif
 
-#ifdef CONFIG_GENERIC_FIND_FIRST_BIT
-
 /**
  * find_first_bit - find the first set bit in a memory region
  * @addr: The address to start the search at
@@ -52,11 +50,5 @@ extern unsigned long find_first_bit(const unsigned long *addr,
  */
 extern unsigned long find_first_zero_bit(const unsigned long *addr,
 					 unsigned long size);
-#else /* CONFIG_GENERIC_FIND_FIRST_BIT */
-
-#define find_first_bit(addr, size) find_next_bit((addr), (size), 0)
-#define find_first_zero_bit(addr, size) find_next_zero_bit((addr), (size), 0)
-
-#endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
 #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
diff --git a/lib/Kconfig b/lib/Kconfig
index 0c8b78a9ae2e..cce523bbd3c7 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -33,9 +33,6 @@ config GENERIC_STRNLEN_USER
 config GENERIC_NET_UTILS
 	bool
 
-config GENERIC_FIND_FIRST_BIT
-	bool
-
 config NO_GENERIC_PCI_IOPORT_MAP
 	bool
 
-- 
2.11.0
