From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 11/15] x86: Use ISO bitops
Date: Wed, 18 May 2016 16:12:00 +0100
Message-ID: <146358432028.8596.7926127062587912916.stgit@warthog.procyon.org.uk>
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

Make x86 use the ISO intrinsic bitops.

This boots fine, however it can't NOP out the LOCK prefixes if the number
of online CPUs is 1.

Without this patch, according to size -A, .text for my test kernel is:

	.text                     6268277   18446744071578845184

with this patch:

	.text                     6273589   18446744071578845184

There are still some underoptimisations to be dealt with.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/bitops.h |  143 +----------------------------------------
 1 file changed, 2 insertions(+), 141 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 7766d1cf096e..f89aec3a41d2 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -25,6 +25,8 @@
 # error "Unexpected BITS_PER_LONG"
 #endif
 
+#include <asm-generic/iso-bitops.h>
+
 #define BIT_64(n)			(U64_C(1) << (n))
 
 /*
@@ -54,35 +56,6 @@
 #define CONST_MASK(nr)			(1 << ((nr) & 7))
 
 /**
- * set_bit - Atomically set a bit in memory
- * @nr: the bit to set
- * @addr: the address to start counting from
- *
- * This function is atomic and may not be reordered.  See __set_bit()
- * if you do not require the atomic guarantees.
- *
- * Note: there are no guarantees that this function will not be reordered
- * on non x86 architectures, so if you are writing portable code,
- * make sure not to rely on its reordering guarantees.
- *
- * Note that @nr may be almost arbitrarily large; this function is not
- * restricted to acting on a single-word quantity.
- */
-static __always_inline void
-set_bit(long nr, volatile unsigned long *addr)
-{
-	if (IS_IMMEDIATE(nr)) {
-		asm volatile(LOCK_PREFIX "orb %1,%0"
-			: CONST_MASK_ADDR(nr, addr)
-			: "iq" ((u8)CONST_MASK(nr))
-			: "memory");
-	} else {
-		asm volatile(LOCK_PREFIX "bts %1,%0"
-			: BITOP_ADDR(addr) : "Ir" (nr) : "memory");
-	}
-}
-
-/**
  * __set_bit - Set a bit in memory
  * @nr: the bit to set
  * @addr: the address to start counting from
@@ -96,44 +69,6 @@ static __always_inline void __set_bit(long nr, volatile unsigned long *addr)
 	asm volatile("bts %1,%0" : ADDR : "Ir" (nr) : "memory");
 }
 
-/**
- * clear_bit - Clears a bit in memory
- * @nr: Bit to clear
- * @addr: Address to start counting from
- *
- * clear_bit() is atomic and may not be reordered.  However, it does
- * not contain a memory barrier, so if it is used for locking purposes,
- * you should call smp_mb__before_atomic() and/or smp_mb__after_atomic()
- * in order to ensure changes are visible on other processors.
- */
-static __always_inline void
-clear_bit(long nr, volatile unsigned long *addr)
-{
-	if (IS_IMMEDIATE(nr)) {
-		asm volatile(LOCK_PREFIX "andb %1,%0"
-			: CONST_MASK_ADDR(nr, addr)
-			: "iq" ((u8)~CONST_MASK(nr)));
-	} else {
-		asm volatile(LOCK_PREFIX "btr %1,%0"
-			: BITOP_ADDR(addr)
-			: "Ir" (nr));
-	}
-}
-
-/*
- * clear_bit_unlock - Clears a bit in memory
- * @nr: Bit to clear
- * @addr: Address to start counting from
- *
- * clear_bit() is atomic and implies release semantics before the memory
- * operation. It can be used for an unlock.
- */
-static __always_inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
-{
-	barrier();
-	clear_bit(nr, addr);
-}
-
 static __always_inline void __clear_bit(long nr, volatile unsigned long *addr)
 {
 	asm volatile("btr %1,%0" : ADDR : "Ir" (nr));
@@ -172,54 +107,6 @@ static __always_inline void __change_bit(long nr, volatile unsigned long *addr)
 }
 
 /**
- * change_bit - Toggle a bit in memory
- * @nr: Bit to change
- * @addr: Address to start counting from
- *
- * change_bit() is atomic and may not be reordered.
- * Note that @nr may be almost arbitrarily large; this function is not
- * restricted to acting on a single-word quantity.
- */
-static __always_inline void change_bit(long nr, volatile unsigned long *addr)
-{
-	if (IS_IMMEDIATE(nr)) {
-		asm volatile(LOCK_PREFIX "xorb %1,%0"
-			: CONST_MASK_ADDR(nr, addr)
-			: "iq" ((u8)CONST_MASK(nr)));
-	} else {
-		asm volatile(LOCK_PREFIX "btc %1,%0"
-			: BITOP_ADDR(addr)
-			: "Ir" (nr));
-	}
-}
-
-/**
- * test_and_set_bit - Set a bit and return its old value
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This operation is atomic and cannot be reordered.
- * It also implies a memory barrier.
- */
-static __always_inline int test_and_set_bit(long nr, volatile unsigned long *addr)
-{
-	GEN_BINARY_RMWcc(LOCK_PREFIX "bts", *addr, "Ir", nr, "%0", "c");
-}
-
-/**
- * test_and_set_bit_lock - Set a bit and return its old value for lock
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This is the same as test_and_set_bit on x86.
- */
-static __always_inline int
-test_and_set_bit_lock(long nr, volatile unsigned long *addr)
-{
-	return test_and_set_bit(nr, addr);
-}
-
-/**
  * __test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
@@ -240,19 +127,6 @@ static __always_inline int __test_and_set_bit(long nr, volatile unsigned long *a
 }
 
 /**
- * test_and_clear_bit - Clear a bit and return its old value
- * @nr: Bit to clear
- * @addr: Address to count from
- *
- * This operation is atomic and cannot be reordered.
- * It also implies a memory barrier.
- */
-static __always_inline int test_and_clear_bit(long nr, volatile unsigned long *addr)
-{
-	GEN_BINARY_RMWcc(LOCK_PREFIX "btr", *addr, "Ir", nr, "%0", "c");
-}
-
-/**
  * __test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to clear
  * @addr: Address to count from
@@ -292,19 +166,6 @@ static __always_inline int __test_and_change_bit(long nr, volatile unsigned long
 	return oldbit;
 }
 
-/**
- * test_and_change_bit - Change a bit and return its old value
- * @nr: Bit to change
- * @addr: Address to count from
- *
- * This operation is atomic and cannot be reordered.
- * It also implies a memory barrier.
- */
-static __always_inline int test_and_change_bit(long nr, volatile unsigned long *addr)
-{
-	GEN_BINARY_RMWcc(LOCK_PREFIX "btc", *addr, "Ir", nr, "%0", "c");
-}
-
 static __always_inline int constant_test_bit(long nr, const volatile unsigned long *addr)
 {
 	return ((1UL << (nr & (BITS_PER_LONG-1))) &
