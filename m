From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH -mm 5/6] m68k: convert little-endian bitops macros to static inline functions
Date: Thu, 27 Jan 2011 22:56:22 +0900
Message-ID: <1296136583-13815-6-git-send-email-akinobu.mita@gmail.com>
References: <1296136583-13815-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296136583-13815-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

(This patch is intended to be folded into the patch in -mm:
m68k-introduce-little-endian-bitops.patch)

The little-endian bitops on m68k are written as preprocessor
macros with the cast to "unsigned long *".
This means that even non-pointers will be accepted without an error, and
that is a Very Bad Thing.

This converts the little-endian bitops macros to static inline functions
with proper prototypes.

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/m68k/include/asm/bitops_mm.h |   41 ++++++++++++++++++++++++++----------
 1 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/arch/m68k/include/asm/bitops_mm.h b/arch/m68k/include/asm/bitops_mm.h
index 1177a48..9d69f6e 100644
--- a/arch/m68k/include/asm/bitops_mm.h
+++ b/arch/m68k/include/asm/bitops_mm.h
@@ -327,18 +327,35 @@ static inline int __fls(int x)
 
 /* Bitmap functions for the little endian bitmap. */
 
-#define __set_bit_le(nr, addr)	\
-	__set_bit((nr) ^ 24, (unsigned long *)(addr))
-#define __clear_bit_le(nr, addr)	\
-	__clear_bit((nr) ^ 24, (unsigned long *)(addr))
-#define __test_and_set_bit_le(nr, addr)	\
-	__test_and_set_bit((nr) ^ 24, (unsigned long *)(addr))
-#define test_and_set_bit_le(nr, addr)	\
-	test_and_set_bit((nr) ^ 24, (unsigned long *)(addr))
-#define __test_and_clear_bit_le(nr, addr)	\
-	__test_and_clear_bit((nr) ^ 24, (unsigned long *)(addr))
-#define test_and_clear_bit_le(nr, addr)	\
-	test_and_clear_bit((nr) ^ 24, (unsigned long *)(addr))
+static inline void __set_bit_le(int nr, void *addr)
+{
+	__set_bit(nr ^ 24, addr);
+}
+
+static inline void __clear_bit_le(int nr, void *addr)
+{
+	__clear_bit(nr ^ 24, addr);
+}
+
+static inline int __test_and_set_bit_le(int nr, void *addr)
+{
+	return __test_and_set_bit(nr ^ 24, addr);
+}
+
+static inline int test_and_set_bit_le(int nr, void *addr)
+{
+	return test_and_set_bit(nr ^ 24, addr);
+}
+
+static inline int __test_and_clear_bit_le(int nr, void *addr)
+{
+	return __test_and_clear_bit(nr ^ 24, addr);
+}
+
+static inline int test_and_clear_bit_le(int nr, void *addr)
+{
+	return test_and_clear_bit(nr ^ 24, addr);
+}
 
 static inline int test_bit_le(int nr, const void *vaddr)
 {
-- 
1.7.3.4
