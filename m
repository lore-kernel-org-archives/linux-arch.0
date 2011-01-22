From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v5 11/27] m68knommu: introduce little-endian bitops
Date: Sat, 22 Jan 2011 22:13:43 +0900
Message-ID: <1295702039-23186-12-git-send-email-akinobu.mita@gmail.com>
References: <1295702039-23186-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295702039-23186-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Greg Ungerer <gerg@uclinux.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

Introduce little-endian bit operations by renaming native ext2 bit
operations.  The ext2 bit operations are kept as wrapper macros using
little-endian bit operations to maintain bisectability until the
conversions are finished.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Greg Ungerer <gerg@uclinux.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

Change from v4:
 - add casts in the macro to take any pointer types
 - drop acked-by line because enough changes has been made

The whole series is available in the git branch at:
 git://git.kernel.org/pub/scm/linux/kernel/git/mita/linux-2.6.git le-bitops-v5

 arch/m68k/include/asm/bitops_no.h |   33 +++++++++++++++++++++++----------
 arch/m68knommu/Kconfig            |    4 ----
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/m68k/include/asm/bitops_no.h b/arch/m68k/include/asm/bitops_no.h
index 58c67aa..e2209ac 100644
--- a/arch/m68k/include/asm/bitops_no.h
+++ b/arch/m68k/include/asm/bitops_no.h
@@ -196,7 +196,15 @@ static __inline__ int __test_bit(int nr, const volatile unsigned long * addr)
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
 
-static __inline__ int ext2_set_bit(int nr, volatile void * addr)
+#define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
+
+#define __set_bit_le(nr, addr) \
+	__set_bit((nr) ^ BITOP_LE_SWIZZLE, (unsigned long *)(addr))
+
+#define __clear_bit_le(nr, addr) \
+	__clear_bit((nr) ^ BITOP_LE_SWIZZLE, (unsigned long *)(addr))
+
+static inline int __test_and_set_bit_le(int nr, volatile void *addr)
 {
 	char retval;
 
@@ -215,7 +223,7 @@ static __inline__ int ext2_set_bit(int nr, volatile void * addr)
 	return retval;
 }
 
-static __inline__ int ext2_clear_bit(int nr, volatile void * addr)
+static inline int __test_and_clear_bit_le(int nr, volatile void *addr)
 {
 	char retval;
 
@@ -238,7 +246,7 @@ static __inline__ int ext2_clear_bit(int nr, volatile void * addr)
 	({						\
 		int ret;				\
 		spin_lock(lock);			\
-		ret = ext2_set_bit((nr), (addr));	\
+		ret = __test_and_set_bit_le((nr), (addr));	\
 		spin_unlock(lock);			\
 		ret;					\
 	})
@@ -247,12 +255,12 @@ static __inline__ int ext2_clear_bit(int nr, volatile void * addr)
 	({						\
 		int ret;				\
 		spin_lock(lock);			\
-		ret = ext2_clear_bit((nr), (addr));	\
+		ret = __test_and_clear_bit_le((nr), (addr));	\
 		spin_unlock(lock);			\
 		ret;					\
 	})
 
-static __inline__ int ext2_test_bit(int nr, const volatile void * addr)
+static inline int test_bit_le(int nr, const volatile void *addr)
 {
 	char retval;
 
@@ -271,10 +279,10 @@ static __inline__ int ext2_test_bit(int nr, const volatile void * addr)
 	return retval;
 }
 
-#define ext2_find_first_zero_bit(addr, size) \
-        ext2_find_next_zero_bit((addr), (size), 0)
+#define find_first_zero_bit_le(addr, size)	\
+	find_next_zero_bit_le((addr), (size), 0)
 
-static __inline__ unsigned long ext2_find_next_zero_bit(void *addr, unsigned long size, unsigned long offset)
+static inline unsigned long find_next_zero_bit_le(void *addr, unsigned long size, unsigned long offset)
 {
 	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
 	unsigned long result = offset & ~31UL;
@@ -324,8 +332,13 @@ found_middle:
 	return result + ffz(__swab32(tmp));
 }
 
-#define ext2_find_next_bit(addr, size, off) \
-	find_next_bit_le((unsigned long *)(addr), (size), (off))
+#define ext2_set_bit __test_and_set_bit_le
+#define ext2_clear_bit __test_and_clear_bit_le
+#define ext2_test_bit test_bit_le
+#define ext2_find_first_zero_bit find_first_zero_bit_le
+#define ext2_find_next_zero_bit find_next_zero_bit_le
+#define ext2_find_next_bit find_next_bit_le
+
 #include <asm-generic/bitops/minix.h>
 
 #endif /* __KERNEL__ */
diff --git a/arch/m68knommu/Kconfig b/arch/m68knommu/Kconfig
index 5ba4f15..704e7b9 100644
--- a/arch/m68knommu/Kconfig
+++ b/arch/m68knommu/Kconfig
@@ -40,10 +40,6 @@ config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
 
-config GENERIC_FIND_BIT_LE
-	bool
-	default y
-
 config GENERIC_GPIO
 	bool
 	default n
-- 
1.7.3.4
