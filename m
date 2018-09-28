From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V6 33/33] csky: use asm-generic/bitops/atomic.h for all
Date: Fri, 28 Sep 2018 08:51:30 +0800
Message-ID: <1b9d599bf69cdb47d4f40bc72b3ee906adad7ca9.1538058840.git.ren_guo@c-sky.com>
References: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538058840.git.ren_guo@c-sky.com>
References: <cover.1538058840.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Specific implementation do not improve the performance, fall
back to asm-generic/bitops/atomic.h.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/bitops.h | 201 -----------------------------------------
 1 file changed, 201 deletions(-)

diff --git a/arch/csky/include/asm/bitops.h b/arch/csky/include/asm/bitops.h
index c9834f1..5d2640b 100644
--- a/arch/csky/include/asm/bitops.h
+++ b/arch/csky/include/asm/bitops.h
@@ -68,208 +68,7 @@ static __always_inline unsigned long __fls(unsigned long x)
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
-
-#ifdef CONFIG_CPU_HAS_LDSTEX
-
-/*
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
-static inline void set_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = BIT_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
-	unsigned long tmp;
-
-	/* *p  |= mask; */
-	smp_mb();
-	asm volatile (
-		"1:	ldex.w		%0, (%2)	\n"
-		"	or32		%0, %0, %1	\n"
-		"	stex.w		%0, (%2)	\n"
-		"	bez		%0, 1b		\n"
-		: "=&r"(tmp)
-		: "r"(mask), "r"(p)
-		: "memory");
-	smp_mb();
-}
-
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
-static inline void clear_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = BIT_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
-	unsigned long tmp;
-
-	/* *p &= ~mask; */
-	mask = ~mask;
-	smp_mb();
-	asm volatile (
-		"1:	ldex.w		%0, (%2)	\n"
-		"	and32		%0, %0, %1	\n"
-		"	stex.w		%0, (%2)	\n"
-		"	bez		%0, 1b		\n"
-		: "=&r"(tmp)
-		: "r"(mask), "r"(p)
-		: "memory");
-	smp_mb();
-}
-
-/**
- * change_bit - Toggle a bit in memory
- * @nr: Bit to change
- * @addr: Address to start counting from
- *
- * change_bit() is atomic and may not be reordered. It may be
- * reordered on other architectures than x86.
- * Note that @nr may be almost arbitrarily large; this function is not
- * restricted to acting on a single-word quantity.
- */
-static inline void change_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = BIT_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
-	unsigned long tmp;
-
-	/* *p ^= mask; */
-	smp_mb();
-	asm volatile (
-		"1:	ldex.w		%0, (%2)	\n"
-		"	xor32		%0, %0, %1	\n"
-		"	stex.w		%0, (%2)	\n"
-		"	bez		%0, 1b		\n"
-		: "=&r"(tmp)
-		: "r"(mask), "r"(p)
-		: "memory");
-	smp_mb();
-}
-
-/**
- * test_and_set_bit - Set a bit and return its old value
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This operation is atomic and cannot be reordered.
- * It may be reordered on other architectures than x86.
- * It also implies a memory barrier.
- */
-static inline int test_and_set_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = BIT_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
-	unsigned long old, tmp;
-
-	/*
-	 * old = *p;
-	 * *p = old | mask;
-	 */
-	smp_mb();
-	asm volatile (
-		"1:	ldex.w		%1, (%3)	\n"
-		"	mov		%0, %1		\n"
-		"	or32		%0, %0, %2	\n"
-		"	stex.w		%0, (%3)	\n"
-		"	bez		%0, 1b		\n"
-		: "=&r"(tmp), "=&r"(old)
-		: "r"(mask), "r"(p)
-		: "memory");
-	smp_mb();
-
-	return (old & mask) != 0;
-}
-
-/**
- * test_and_clear_bit - Clear a bit and return its old value
- * @nr: Bit to clear
- * @addr: Address to count from
- *
- * This operation is atomic and cannot be reordered.
- * It can be reorderdered on other architectures other than x86.
- * It also implies a memory barrier.
- */
-static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = BIT_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
-	unsigned long old, tmp, mask_not;
-
-	/*
-	 * old = *p;
-	 * *p = old & ~mask;
-	 */
-	smp_mb();
-	mask_not = ~mask;
-	asm volatile (
-		"1:	ldex.w		%1, (%3)	\n"
-		"	mov		%0, %1		\n"
-		"	and32		%0, %0, %2	\n"
-		"	stex.w		%0, (%3)	\n"
-		"	bez		%0, 1b		\n"
-		: "=&r"(tmp), "=&r"(old)
-		: "r"(mask_not), "r"(p)
-		: "memory");
-
-	smp_mb();
-
-	return (old & mask) != 0;
-}
-
-/**
- * test_and_change_bit - Change a bit and return its old value
- * @nr: Bit to change
- * @addr: Address to count from
- *
- * This operation is atomic and cannot be reordered.
- * It also implies a memory barrier.
- */
-static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = BIT_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
-	unsigned long old, tmp;
-
-	/*
-	 * old = *p;
-	 * *p = old ^ mask;
-	 */
-	smp_mb();
-	asm volatile (
-		"1:	ldex.w		%1, (%3)	\n"
-		"	mov		%0, %1		\n"
-		"	xor32		%0, %0, %2	\n"
-		"	stex.w		%0, (%3)	\n"
-		"	bez		%0, 1b		\n"
-		: "=&r"(tmp), "=&r"(old)
-		: "r"(mask), "r"(p)
-		: "memory");
-	smp_mb();
-
-	return (old & mask) != 0;
-}
-
-#else
 #include <asm-generic/bitops/atomic.h>
-#endif
 
 /*
  * bug fix, why only could use atomic!!!!
-- 
2.7.4
