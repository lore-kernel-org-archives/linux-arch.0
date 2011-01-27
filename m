From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH -mm 1/6] asm-generic: convert little-endian bitops macros to static inline functions
Date: Thu, 27 Jan 2011 22:56:18 +0900
Message-ID: <1296136583-13815-2-git-send-email-akinobu.mita@gmail.com>
References: <1296136583-13815-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296136583-13815-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Mikael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "Luck, Tony" <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@mcmartin.ca>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mundt <lethal@linux-sh.org>, Kazumoto Kojima <kkojima@rr.iij4u.or.jp>, Hirokazu Takata <takata@linux-m32r.org>, "David S. Miller" <davem@davemloft.net>, Chris Zankel <chris@zankel.net>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, "H. Peter Anvin" <hpa@zytor.com>Benjamin Herrenschmidt <b>
List-Id: linux-arch.vger.kernel.org

(This patch is intended to be folded into the patch in -mm:
asm-generic-change-little-endian-bitops-to-take-any-pointer-types.patch)

The little-endian bitops on asm-generic are written as preprocessor
macros with the cast to "unsigned long *".
This means that even non-pointers will be accepted without an error, and
that is a Very Bad Thing.

This converts the little-endian bitops macros to static inline functions
with proper prototypes.

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Mikael Starvik <starvik@axis.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: "Luck, Tony" <tony.luck@intel.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Kyle McMartin <kyle@mcmartin.ca>
Cc: Matthew Wilcox <matthew@wil.cx>
Cc: Grant Grundler <grundler@parisc-linux.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Kazumoto Kojima <kkojima@rr.iij4u.or.jp>
Cc: Hirokazu Takata <takata@linux-m32r.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Chris Zankel <chris@zankel.net>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
 include/asm-generic/bitops/le.h |   73 +++++++++++++++++++++++++++------------
 1 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
index 7644a15..946a21b 100644
--- a/include/asm-generic/bitops/le.h
+++ b/include/asm-generic/bitops/le.h
@@ -8,12 +8,23 @@
 
 #define BITOP_LE_SWIZZLE	0
 
-#define find_next_zero_bit_le(addr, size, offset) \
-	find_next_zero_bit((unsigned long *)(addr), size, offset)
-#define find_next_bit_le(addr, size, offset) \
-	find_next_bit((unsigned long *)(addr), size, offset)
-#define find_first_zero_bit_le(addr, size) \
-	find_first_zero_bit((unsigned long *)(addr), size)
+static inline unsigned long find_next_zero_bit_le(const void *addr,
+		unsigned long size, unsigned long offset)
+{
+	return find_next_zero_bit(addr, size, offset);
+}
+
+static inline unsigned long find_next_bit_le(const void *addr,
+		unsigned long size, unsigned long offset)
+{
+	return find_next_bit(addr, size, offset);
+}
+
+static inline unsigned long find_first_zero_bit_le(const void *addr,
+		unsigned long size)
+{
+	return find_first_zero_bit(addr, size);
+}
 
 #elif defined(__BIG_ENDIAN)
 
@@ -31,21 +42,39 @@ extern unsigned long find_next_bit_le(const void *addr,
 #error "Please fix <asm/byteorder.h>"
 #endif
 
-#define test_bit_le(nr, addr) \
-	test_bit((nr) ^ BITOP_LE_SWIZZLE, (unsigned long *)(addr))
-#define __set_bit_le(nr, addr) \
-	__set_bit((nr) ^ BITOP_LE_SWIZZLE, (unsigned long *)(addr))
-#define __clear_bit_le(nr, addr) \
-	__clear_bit((nr) ^ BITOP_LE_SWIZZLE, (unsigned long *)(addr))
-
-#define test_and_set_bit_le(nr, addr) \
-	test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, (unsigned long *)(addr))
-#define test_and_clear_bit_le(nr, addr) \
-	test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, (unsigned long *)(addr))
-
-#define __test_and_set_bit_le(nr, addr) \
-	__test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, (unsigned long *)(addr))
-#define __test_and_clear_bit_le(nr, addr) \
-	__test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, (unsigned long *)(addr))
+static inline int test_bit_le(int nr, const void *addr)
+{
+	return test_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+}
+
+static inline void __set_bit_le(int nr, void *addr)
+{
+	__set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+}
+
+static inline void __clear_bit_le(int nr, void *addr)
+{
+	__clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+}
+
+static inline int test_and_set_bit_le(int nr, void *addr)
+{
+	return test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+}
+
+static inline int test_and_clear_bit_le(int nr, void *addr)
+{
+	return test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+}
+
+static inline int __test_and_set_bit_le(int nr, void *addr)
+{
+	return __test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+}
+
+static inline int __test_and_clear_bit_le(int nr, void *addr)
+{
+	return __test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+}
 
 #endif /* _ASM_GENERIC_BITOPS_LE_H_ */
-- 
1.7.3.4
