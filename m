From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 09/15] Make the ISO bitops use 32-bit values internally
Date: Wed, 18 May 2016 16:11:45 +0100
Message-ID: <146358430541.8596.17764991541114458706.stgit@warthog.procyon.org.uk>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org
List-Id: linux-arch.vger.kernel.org

Make the ISO bitops use 32-bit values internally so that on x86 we emit the
smaller BTRL/BTSL/BTCL instructions rather than BTRQ/BTSQ/BTCQ (which
require a prefix).

However, if we're going to do this, we really need to change the bit
numbers for test_bit(), set_bit(), test_and_set_bit(), etc. to be int
rather than long because BTR/BTS/BTC take a bit number that's the same size
as the memory variable size.

This means that BTSQ, for example, has a bit number in the range
-2^63..2^63-1 whereas BTSL only has a range of -2^31..2^31-1.  So,
technically, the current inline-asm set_bit() and co. for non-constant bit
number are implemented incorrectly as they can't handle the full range of
the long bit number.  However, in practice, it's probably not a problem.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/asm-generic/iso-bitops.h |   57 +++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/include/asm-generic/iso-bitops.h b/include/asm-generic/iso-bitops.h
index 64d5067e3a67..e87b91965e67 100644
--- a/include/asm-generic/iso-bitops.h
+++ b/include/asm-generic/iso-bitops.h
@@ -18,11 +18,12 @@
 static __always_inline
 bool test_bit(long bit, const volatile unsigned long *addr)
 {
-	unsigned long mask = 1UL << (bit & (BITS_PER_LONG - 1));
-	unsigned long old;
+	const volatile unsigned int *addr32 = (const volatile unsigned int *)addr;
+	unsigned int mask = 1U << (bit & (32 - 1));
+	unsigned int old;
 
-	addr += bit >> _BITOPS_LONG_SHIFT;
-	old = __atomic_load_n(addr, __ATOMIC_RELAXED);
+	addr32 += bit >> 5;
+	old = __atomic_load_n(addr32, __ATOMIC_RELAXED);
 	return old & mask;
 }
 
@@ -44,10 +45,11 @@ bool test_bit(long bit, const volatile unsigned long *addr)
 static __always_inline
 void iso_set_bit(long bit, volatile unsigned long *addr, int memorder)
 {
-	unsigned long mask = 1UL << (bit & (BITS_PER_LONG - 1));
+	volatile unsigned int *addr32 = (volatile unsigned int *)addr;
+	unsigned int mask = 1U << (bit & (32 - 1));
 
-	addr += bit >> _BITOPS_LONG_SHIFT;
-	__atomic_fetch_or(addr, mask, memorder);
+	addr32 += bit >> 5;
+	__atomic_fetch_or(addr32, mask, memorder);
 }
 
 #define set_bit(b, a) iso_set_bit((b), (a), __ATOMIC_ACQ_REL)
@@ -75,10 +77,11 @@ void iso_set_bit(long bit, volatile unsigned long *addr, int memorder)
 static __always_inline
 void iso_clear_bit(long bit, volatile unsigned long *addr, int memorder)
 {
-	unsigned long mask = 1UL << (bit & (BITS_PER_LONG - 1));
+	volatile unsigned int *addr32 = (volatile unsigned int *)addr;
+	unsigned int mask = 1U << (bit & (32 - 1));
 
-	addr += bit >> _BITOPS_LONG_SHIFT;
-	__atomic_fetch_and(addr, ~mask, memorder);
+	addr32 += bit >> 5;
+	__atomic_fetch_and(addr32, ~mask, memorder);
 }
 
 #define clear_bit(b, a) iso_clear_bit((b), (a), __ATOMIC_ACQ_REL)
@@ -105,10 +108,11 @@ void iso_clear_bit(long bit, volatile unsigned long *addr, int memorder)
 static __always_inline
 void iso_change_bit(long bit, volatile unsigned long *addr, int memorder)
 {
-	unsigned long mask = 1UL << (bit & (BITS_PER_LONG - 1));
+	volatile unsigned int *addr32 = (volatile unsigned int *)addr;
+	unsigned int mask = 1U << (bit & (32 - 1));
 
-	addr += bit >> _BITOPS_LONG_SHIFT;
-	__atomic_fetch_xor(addr, mask, memorder);
+	addr32 += bit >> 5;
+	__atomic_fetch_xor(addr32, mask, memorder);
 }
 
 #define change_bit(b, a) iso_change_bit((b), (a), __ATOMIC_ACQ_REL)
@@ -124,11 +128,12 @@ void iso_change_bit(long bit, volatile unsigned long *addr, int memorder)
 static __always_inline
 bool iso_test_and_set_bit(long bit, volatile unsigned long *addr, int memorder)
 {
-	unsigned long mask = 1UL << (bit & (BITS_PER_LONG - 1));
-	unsigned long old;
+	volatile unsigned int *addr32 = (volatile unsigned int *)addr;
+	unsigned int mask = 1U << (bit & (32 - 1));
+	unsigned int old;
 
-	addr += bit >> _BITOPS_LONG_SHIFT;
-	old = __atomic_fetch_or(addr, mask, memorder);
+	addr32 += bit >> 5;
+	old = __atomic_fetch_or(addr32, mask, memorder);
 	return old & mask;
 }
 
@@ -146,11 +151,12 @@ bool iso_test_and_set_bit(long bit, volatile unsigned long *addr, int memorder)
 static __always_inline
 bool iso_test_and_clear_bit(long bit, volatile unsigned long *addr, int memorder)
 {
-	unsigned long mask = 1UL << (bit & (BITS_PER_LONG - 1));
-	unsigned long old;
+	volatile unsigned int *addr32 = (volatile unsigned int *)addr;
+	unsigned int mask = 1U << (bit & (32 - 1));
+	unsigned int old;
 
-	addr += bit >> _BITOPS_LONG_SHIFT;
-	old = __atomic_fetch_and(addr, ~mask, memorder);
+	addr32 += bit >> 5;
+	old = __atomic_fetch_and(addr32, ~mask, memorder);
 	return old & mask;
 }
 
@@ -168,11 +174,12 @@ bool iso_test_and_clear_bit(long bit, volatile unsigned long *addr, int memorder
 static __always_inline
 bool iso_test_and_change_bit(long bit, volatile unsigned long *addr, int memorder)
 {
-	unsigned long mask = 1UL << (bit & (BITS_PER_LONG - 1));
-	unsigned long old;
+	volatile unsigned int *addr32 = (volatile unsigned int *)addr;
+	unsigned int mask = 1U << (bit & (32 - 1));
+	unsigned int old;
 
-	addr += bit >> _BITOPS_LONG_SHIFT;
-	old = __atomic_fetch_xor(addr, mask, memorder);
+	addr32 += bit >> 5;
+	old = __atomic_fetch_xor(addr32, mask, memorder);
 	return old & mask;
 }
 
