From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] arch: all: include: asm: bitops: Use bool instead of int
 for all bit test functions
Date: Mon, 29 Aug 2016 10:45:14 +0200
Message-ID: <20160829084514.GC2968@dhcp22.suse.cz>
References: <1472362755-26776-1-git-send-email-chengang@emindsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35497 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbcH2IpS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Aug 2016 04:45:18 -0400
Content-Disposition: inline
In-Reply-To: <1472362755-26776-1-git-send-email-chengang@emindsoft.com.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: chengang@emindsoft.com.cn
Cc: akpm@linux-foundation.org, minchan@kernel.org, vbabka@suse.cz, gi-oh.kim@profitbricks.com, iamjoonsoo.kim@lge.com, hillf.zj@alibaba-inc.com, mgorman@techsingularity.net, rientjes@google.com, linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetca

On Sun 28-08-16 13:39:15, chengang@emindsoft.com.cn wrote:
> From: Chen Gang <chengang@emindsoft.com.cn>
> 
> Also use the same changing to asm-generic, and also use bool variable
> instead of int variable for mips, mn10300, parisc and tile related
> functions, and also avoid checkpatch.pl to report ERROR.
> 
> Originally, except powerpc and xtensa, all another architectures intend
> to return 0 or 1. After this patch, also let powerpc and xtensa return 0
> or 1.
> 
> The patch passes cross building for mips and parisc with default config.
> All related contents are found by "grep test_bit, grep test_and" under
> arch sub-directory.

the changelog doesn't mention the most important part. Why do we want to
change this? Does it really improve thing (generate a better code) or
clears out the semantic of those functions?

> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/alpha/include/asm/bitops.h         | 16 ++++++++--------
>  arch/arc/include/asm/bitops.h           | 10 +++++-----
>  arch/arm/include/asm/bitops.h           | 12 ++++++------
>  arch/arm64/include/asm/bitops.h         |  6 +++---
>  arch/avr32/include/asm/bitops.h         |  6 +++---
>  arch/blackfin/include/asm/bitops.h      | 16 ++++++++--------
>  arch/frv/include/asm/bitops.h           | 16 ++++++++--------
>  arch/h8300/include/asm/bitops.h         |  4 ++--
>  arch/hexagon/include/asm/bitops.h       | 14 +++++++-------
>  arch/ia64/include/asm/bitops.h          | 14 +++++++-------
>  arch/m32r/include/asm/bitops.h          |  6 +++---
>  arch/m68k/include/asm/bitops.h          | 20 ++++++++++----------
>  arch/metag/include/asm/bitops.h         |  6 +++---
>  arch/mips/include/asm/bitops.h          | 16 ++++++++--------
>  arch/mips/lib/bitops.c                  | 16 ++++++++--------
>  arch/mn10300/include/asm/bitops.h       |  7 ++++---
>  arch/parisc/include/asm/bitops.h        | 16 ++++++++--------
>  arch/powerpc/include/asm/bitops.h       | 10 +++++-----
>  arch/s390/include/asm/bitops.h          | 18 +++++++++---------
>  arch/sh/include/asm/bitops-cas.h        |  6 +++---
>  arch/sh/include/asm/bitops-grb.h        |  6 +++---
>  arch/sh/include/asm/bitops-llsc.h       |  6 +++---
>  arch/sh/include/asm/bitops-op32.h       |  8 ++++----
>  arch/sparc/include/asm/bitops_32.h      |  6 +++---
>  arch/sparc/include/asm/bitops_64.h      |  6 +++---
>  arch/tile/include/asm/bitops_32.h       |  6 +++---
>  arch/tile/include/asm/bitops_64.h       | 10 +++++-----
>  arch/xtensa/include/asm/bitops.h        |  6 +++---
>  include/asm-generic/bitops/atomic.h     |  6 +++---
>  include/asm-generic/bitops/le.h         | 10 +++++-----
>  include/asm-generic/bitops/non-atomic.h |  8 ++++----
>  31 files changed, 157 insertions(+), 156 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/bitops.h b/arch/alpha/include/asm/bitops.h
> index 4bdfbd4..92d468f 100644
> --- a/arch/alpha/include/asm/bitops.h
> +++ b/arch/alpha/include/asm/bitops.h
> @@ -125,7 +125,7 @@ __change_bit(unsigned long nr, volatile void * addr)
>  	*m ^= 1 << (nr & 31);
>  }
>  
> -static inline int
> +static inline bool
>  test_and_set_bit(unsigned long nr, volatile void *addr)
>  {
>  	unsigned long oldbit;
> @@ -155,7 +155,7 @@ test_and_set_bit(unsigned long nr, volatile void *addr)
>  	return oldbit != 0;
>  }
>  
> -static inline int
> +static inline bool
>  test_and_set_bit_lock(unsigned long nr, volatile void *addr)
>  {
>  	unsigned long oldbit;
> @@ -185,7 +185,7 @@ test_and_set_bit_lock(unsigned long nr, volatile void *addr)
>  /*
>   * WARNING: non atomic version.
>   */
> -static inline int
> +static inline bool
>  __test_and_set_bit(unsigned long nr, volatile void * addr)
>  {
>  	unsigned long mask = 1 << (nr & 0x1f);
> @@ -196,7 +196,7 @@ __test_and_set_bit(unsigned long nr, volatile void * addr)
>  	return (old & mask) != 0;
>  }
>  
> -static inline int
> +static inline bool
>  test_and_clear_bit(unsigned long nr, volatile void * addr)
>  {
>  	unsigned long oldbit;
> @@ -229,7 +229,7 @@ test_and_clear_bit(unsigned long nr, volatile void * addr)
>  /*
>   * WARNING: non atomic version.
>   */
> -static inline int
> +static inline bool
>  __test_and_clear_bit(unsigned long nr, volatile void * addr)
>  {
>  	unsigned long mask = 1 << (nr & 0x1f);
> @@ -240,7 +240,7 @@ __test_and_clear_bit(unsigned long nr, volatile void * addr)
>  	return (old & mask) != 0;
>  }
>  
> -static inline int
> +static inline bool
>  test_and_change_bit(unsigned long nr, volatile void * addr)
>  {
>  	unsigned long oldbit;
> @@ -271,7 +271,7 @@ test_and_change_bit(unsigned long nr, volatile void * addr)
>  /*
>   * WARNING: non atomic version.
>   */
> -static __inline__ int
> +static __inline__ bool
>  __test_and_change_bit(unsigned long nr, volatile void * addr)
>  {
>  	unsigned long mask = 1 << (nr & 0x1f);
> @@ -282,7 +282,7 @@ __test_and_change_bit(unsigned long nr, volatile void * addr)
>  	return (old & mask) != 0;
>  }
>  
> -static inline int
> +static inline bool
>  test_bit(int nr, const volatile void * addr)
>  {
>  	return (1UL & (((const int *) addr)[nr >> 5] >> (nr & 31))) != 0UL;
> diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
> index 8da87fee..e1976ab 100644
> --- a/arch/arc/include/asm/bitops.h
> +++ b/arch/arc/include/asm/bitops.h
> @@ -60,7 +60,7 @@ static inline void op##_bit(unsigned long nr, volatile unsigned long *m)\
>   * and the old value of bit is returned
>   */
>  #define TEST_N_BIT_OP(op, c_op, asm_op)					\
> -static inline int test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
> +static inline bool test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
>  {									\
>  	unsigned long old, temp;					\
>  									\
> @@ -124,7 +124,7 @@ static inline void op##_bit(unsigned long nr, volatile unsigned long *m)\
>  }
>  
>  #define TEST_N_BIT_OP(op, c_op, asm_op)					\
> -static inline int test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
> +static inline bool test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
>  {									\
>  	unsigned long old, flags;					\
>  	m += nr >> 5;							\
> @@ -160,7 +160,7 @@ static inline void op##_bit(unsigned long nr, volatile unsigned long *m)\
>  }
>  
>  #define TEST_N_BIT_OP(op, c_op, asm_op)					\
> -static inline int test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
> +static inline bool test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
>  {									\
>  	unsigned long old;						\
>  									\
> @@ -204,7 +204,7 @@ static inline void __##op##_bit(unsigned long nr, volatile unsigned long *m)	\
>  }
>  
>  #define __TEST_N_BIT_OP(op, c_op, asm_op)				\
> -static inline int __test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
> +static inline bool __test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
>  {									\
>  	unsigned long old;						\
>  	m += nr >> 5;							\
> @@ -242,7 +242,7 @@ BIT_OPS(change, ^, CTOP_INST_AXOR_DI_R2_R2_R3)
>  /*
>   * This routine doesn't need to be atomic.
>   */
> -static inline int
> +static inline bool
>  test_bit(unsigned int nr, const volatile unsigned long *addr)
>  {
>  	unsigned long mask;
> diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
> index e943e6c..719a598 100644
> --- a/arch/arm/include/asm/bitops.h
> +++ b/arch/arm/include/asm/bitops.h
> @@ -68,7 +68,7 @@ static inline void ____atomic_change_bit(unsigned int bit, volatile unsigned lon
>  	raw_local_irq_restore(flags);
>  }
>  
> -static inline int
> +static inline bool
>  ____atomic_test_and_set_bit(unsigned int bit, volatile unsigned long *p)
>  {
>  	unsigned long flags;
> @@ -85,7 +85,7 @@ ____atomic_test_and_set_bit(unsigned int bit, volatile unsigned long *p)
>  	return (res & mask) != 0;
>  }
>  
> -static inline int
> +static inline bool
>  ____atomic_test_and_clear_bit(unsigned int bit, volatile unsigned long *p)
>  {
>  	unsigned long flags;
> @@ -102,7 +102,7 @@ ____atomic_test_and_clear_bit(unsigned int bit, volatile unsigned long *p)
>  	return (res & mask) != 0;
>  }
>  
> -static inline int
> +static inline bool
>  ____atomic_test_and_change_bit(unsigned int bit, volatile unsigned long *p)
>  {
>  	unsigned long flags;
> @@ -152,9 +152,9 @@ ____atomic_test_and_change_bit(unsigned int bit, volatile unsigned long *p)
>  extern void _set_bit(int nr, volatile unsigned long * p);
>  extern void _clear_bit(int nr, volatile unsigned long * p);
>  extern void _change_bit(int nr, volatile unsigned long * p);
> -extern int _test_and_set_bit(int nr, volatile unsigned long * p);
> -extern int _test_and_clear_bit(int nr, volatile unsigned long * p);
> -extern int _test_and_change_bit(int nr, volatile unsigned long * p);
> +extern bool _test_and_set_bit(int nr, volatile unsigned long *p);
> +extern bool _test_and_clear_bit(int nr, volatile unsigned long *p);
> +extern bool _test_and_change_bit(int nr, volatile unsigned long *p);
>  
>  /*
>   * Little endian assembly bitops.  nr = 0 -> byte 0 bit 0.
> diff --git a/arch/arm64/include/asm/bitops.h b/arch/arm64/include/asm/bitops.h
> index 9c19594..61f9f3c 100644
> --- a/arch/arm64/include/asm/bitops.h
> +++ b/arch/arm64/include/asm/bitops.h
> @@ -29,9 +29,9 @@
>  extern void set_bit(int nr, volatile unsigned long *p);
>  extern void clear_bit(int nr, volatile unsigned long *p);
>  extern void change_bit(int nr, volatile unsigned long *p);
> -extern int test_and_set_bit(int nr, volatile unsigned long *p);
> -extern int test_and_clear_bit(int nr, volatile unsigned long *p);
> -extern int test_and_change_bit(int nr, volatile unsigned long *p);
> +extern bool test_and_set_bit(int nr, volatile unsigned long *p);
> +extern bool test_and_clear_bit(int nr, volatile unsigned long *p);
> +extern bool test_and_change_bit(int nr, volatile unsigned long *p);
>  
>  #include <asm-generic/bitops/builtin-__ffs.h>
>  #include <asm-generic/bitops/builtin-ffs.h>
> diff --git a/arch/avr32/include/asm/bitops.h b/arch/avr32/include/asm/bitops.h
> index 910d537..0e3e08b 100644
> --- a/arch/avr32/include/asm/bitops.h
> +++ b/arch/avr32/include/asm/bitops.h
> @@ -128,7 +128,7 @@ static inline void change_bit(int nr, volatile void * addr)
>   * This operation is atomic and cannot be reordered.
>   * It also implies a memory barrier.
>   */
> -static inline int test_and_set_bit(int nr, volatile void * addr)
> +static inline bool test_and_set_bit(int nr, volatile void *addr)
>  {
>  	unsigned long *p = ((unsigned long *)addr) + nr / BITS_PER_LONG;
>  	unsigned long mask = 1UL << (nr % BITS_PER_LONG);
> @@ -168,7 +168,7 @@ static inline int test_and_set_bit(int nr, volatile void * addr)
>   * This operation is atomic and cannot be reordered.
>   * It also implies a memory barrier.
>   */
> -static inline int test_and_clear_bit(int nr, volatile void * addr)
> +static inline bool test_and_clear_bit(int nr, volatile void *addr)
>  {
>  	unsigned long *p = ((unsigned long *)addr) + nr / BITS_PER_LONG;
>  	unsigned long mask = 1UL << (nr % BITS_PER_LONG);
> @@ -209,7 +209,7 @@ static inline int test_and_clear_bit(int nr, volatile void * addr)
>   * This operation is atomic and cannot be reordered.
>   * It also implies a memory barrier.
>   */
> -static inline int test_and_change_bit(int nr, volatile void * addr)
> +static inline bool test_and_change_bit(int nr, volatile void *addr)
>  {
>  	unsigned long *p = ((unsigned long *)addr) + nr / BITS_PER_LONG;
>  	unsigned long mask = 1UL << (nr % BITS_PER_LONG);
> diff --git a/arch/blackfin/include/asm/bitops.h b/arch/blackfin/include/asm/bitops.h
> index b298b65..ff43a11 100644
> --- a/arch/blackfin/include/asm/bitops.h
> +++ b/arch/blackfin/include/asm/bitops.h
> @@ -47,13 +47,13 @@ asmlinkage int __raw_bit_clear_asm(volatile unsigned long *addr, int nr);
>  
>  asmlinkage int __raw_bit_toggle_asm(volatile unsigned long *addr, int nr);
>  
> -asmlinkage int __raw_bit_test_set_asm(volatile unsigned long *addr, int nr);
> +asmlinkage bool __raw_bit_test_set_asm(volatile unsigned long *addr, int nr);
>  
> -asmlinkage int __raw_bit_test_clear_asm(volatile unsigned long *addr, int nr);
> +asmlinkage bool __raw_bit_test_clear_asm(volatile unsigned long *addr, int nr);
>  
> -asmlinkage int __raw_bit_test_toggle_asm(volatile unsigned long *addr, int nr);
> +asmlinkage bool __raw_bit_test_toggle_asm(volatile unsigned long *addr, int nr);
>  
> -asmlinkage int __raw_bit_test_asm(const volatile unsigned long *addr, int nr);
> +asmlinkage bool __raw_bit_test_asm(const volatile unsigned long *addr, int nr);
>  
>  static inline void set_bit(int nr, volatile unsigned long *addr)
>  {
> @@ -73,25 +73,25 @@ static inline void change_bit(int nr, volatile unsigned long *addr)
>  	__raw_bit_toggle_asm(a, nr & 0x1f);
>  }
>  
> -static inline int test_bit(int nr, const volatile unsigned long *addr)
> +static inline bool test_bit(int nr, const volatile unsigned long *addr)
>  {
>  	volatile const unsigned long *a = addr + (nr >> 5);
>  	return __raw_bit_test_asm(a, nr & 0x1f) != 0;
>  }
>  
> -static inline int test_and_set_bit(int nr, volatile unsigned long *addr)
> +static inline bool test_and_set_bit(int nr, volatile unsigned long *addr)
>  {
>  	volatile unsigned long *a = addr + (nr >> 5);
>  	return __raw_bit_test_set_asm(a, nr & 0x1f);
>  }
>  
> -static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
> +static inline bool test_and_clear_bit(int nr, volatile unsigned long *addr)
>  {
>  	volatile unsigned long *a = addr + (nr >> 5);
>  	return __raw_bit_test_clear_asm(a, nr & 0x1f);
>  }
>  
> -static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
> +static inline bool test_and_change_bit(int nr, volatile unsigned long *addr)
>  {
>  	volatile unsigned long *a = addr + (nr >> 5);
>  	return __raw_bit_test_toggle_asm(a, nr & 0x1f);
> diff --git a/arch/frv/include/asm/bitops.h b/arch/frv/include/asm/bitops.h
> index 0df8e95..c9bf93d 100644
> --- a/arch/frv/include/asm/bitops.h
> +++ b/arch/frv/include/asm/bitops.h
> @@ -27,7 +27,7 @@
>  
>  #include <asm/atomic.h>
>  
> -static inline int test_and_clear_bit(unsigned long nr, volatile void *addr)
> +static inline bool test_and_clear_bit(unsigned long nr, volatile void *addr)
>  {
>  	unsigned int *ptr = (void *)addr;
>  	unsigned int mask = 1UL << (nr & 31);
> @@ -35,7 +35,7 @@ static inline int test_and_clear_bit(unsigned long nr, volatile void *addr)
>  	return (__atomic32_fetch_and(~mask, ptr) & mask) != 0;
>  }
>  
> -static inline int test_and_set_bit(unsigned long nr, volatile void *addr)
> +static inline bool test_and_set_bit(unsigned long nr, volatile void *addr)
>  {
>  	unsigned int *ptr = (void *)addr;
>  	unsigned int mask = 1UL << (nr & 31);
> @@ -43,7 +43,7 @@ static inline int test_and_set_bit(unsigned long nr, volatile void *addr)
>  	return (__atomic32_fetch_or(mask, ptr) & mask) != 0;
>  }
>  
> -static inline int test_and_change_bit(unsigned long nr, volatile void *addr)
> +static inline bool test_and_change_bit(unsigned long nr, volatile void *addr)
>  {
>  	unsigned int *ptr = (void *)addr;
>  	unsigned int mask = 1UL << (nr & 31);
> @@ -96,7 +96,7 @@ static inline void __change_bit(unsigned long nr, volatile void *addr)
>  	*a ^= mask;
>  }
>  
> -static inline int __test_and_clear_bit(unsigned long nr, volatile void *addr)
> +static inline bool __test_and_clear_bit(unsigned long nr, volatile void *addr)
>  {
>  	volatile unsigned long *a = addr;
>  	int mask, retval;
> @@ -108,7 +108,7 @@ static inline int __test_and_clear_bit(unsigned long nr, volatile void *addr)
>  	return retval;
>  }
>  
> -static inline int __test_and_set_bit(unsigned long nr, volatile void *addr)
> +static inline bool __test_and_set_bit(unsigned long nr, volatile void *addr)
>  {
>  	volatile unsigned long *a = addr;
>  	int mask, retval;
> @@ -120,7 +120,7 @@ static inline int __test_and_set_bit(unsigned long nr, volatile void *addr)
>  	return retval;
>  }
>  
> -static inline int __test_and_change_bit(unsigned long nr, volatile void *addr)
> +static inline bool __test_and_change_bit(unsigned long nr, volatile void *addr)
>  {
>  	volatile unsigned long *a = addr;
>  	int mask, retval;
> @@ -135,13 +135,13 @@ static inline int __test_and_change_bit(unsigned long nr, volatile void *addr)
>  /*
>   * This routine doesn't need to be atomic.
>   */
> -static inline int
> +static inline bool
>  __constant_test_bit(unsigned long nr, const volatile void *addr)
>  {
>  	return ((1UL << (nr & 31)) & (((const volatile unsigned int *) addr)[nr >> 5])) != 0;
>  }
>  
> -static inline int __test_bit(unsigned long nr, const volatile void *addr)
> +static inline bool __test_bit(unsigned long nr, const volatile void *addr)
>  {
>  	int 	* a = (int *) addr;
>  	int	mask;
> diff --git a/arch/h8300/include/asm/bitops.h b/arch/h8300/include/asm/bitops.h
> index 05999ab..8f6dfc6 100644
> --- a/arch/h8300/include/asm/bitops.h
> +++ b/arch/h8300/include/asm/bitops.h
> @@ -65,7 +65,7 @@ H8300_GEN_BITOP(change_bit, "bnot")
>  
>  #undef H8300_GEN_BITOP
>  
> -static inline int test_bit(int nr, const unsigned long *addr)
> +static inline bool test_bit(int nr, const unsigned long *addr)
>  {
>  	int ret = 0;
>  	unsigned char *b_addr;
> @@ -91,7 +91,7 @@ static inline int test_bit(int nr, const unsigned long *addr)
>  #define __test_bit(nr, addr) test_bit(nr, addr)
>  
>  #define H8300_GEN_TEST_BITOP(FNNAME, OP)				\
> -static inline int FNNAME(int nr, void *addr)				\
> +static inline bool FNNAME(int nr, void *addr)				\
>  {									\
>  	int retval = 0;							\
>  	char ccrsave;							\
> diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
> index 5e4a59b..fa6b32c 100644
> --- a/arch/hexagon/include/asm/bitops.h
> +++ b/arch/hexagon/include/asm/bitops.h
> @@ -42,7 +42,7 @@
>   * @nr:  bit number to clear
>   * @addr:  pointer to memory
>   */
> -static inline int test_and_clear_bit(int nr, volatile void *addr)
> +static inline bool test_and_clear_bit(int nr, volatile void *addr)
>  {
>  	int oldval;
>  
> @@ -66,7 +66,7 @@ static inline int test_and_clear_bit(int nr, volatile void *addr)
>   * @nr:  bit number to set
>   * @addr:  pointer to memory
>   */
> -static inline int test_and_set_bit(int nr, volatile void *addr)
> +static inline bool test_and_set_bit(int nr, volatile void *addr)
>  {
>  	int oldval;
>  
> @@ -92,7 +92,7 @@ static inline int test_and_set_bit(int nr, volatile void *addr)
>   * @nr:  bit number to set
>   * @addr:  pointer to memory
>   */
> -static inline int test_and_change_bit(int nr, volatile void *addr)
> +static inline bool test_and_change_bit(int nr, volatile void *addr)
>  {
>  	int oldval;
>  
> @@ -157,22 +157,22 @@ static inline void __change_bit(int nr, volatile unsigned long *addr)
>  }
>  
>  /*  Apparently, at least some of these are allowed to be non-atomic  */
> -static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
> +static inline bool __test_and_clear_bit(int nr, volatile unsigned long *addr)
>  {
>  	return test_and_clear_bit(nr, addr);
>  }
>  
> -static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
> +static inline bool __test_and_set_bit(int nr, volatile unsigned long *addr)
>  {
>  	return test_and_set_bit(nr, addr);
>  }
>  
> -static inline int __test_and_change_bit(int nr, volatile unsigned long *addr)
> +static inline bool __test_and_change_bit(int nr, volatile unsigned long *addr)
>  {
>  	return test_and_change_bit(nr, addr);
>  }
>  
> -static inline int __test_bit(int nr, const volatile unsigned long *addr)
> +static inline bool __test_bit(int nr, const volatile unsigned long *addr)
>  {
>  	int retval;
>  
> diff --git a/arch/ia64/include/asm/bitops.h b/arch/ia64/include/asm/bitops.h
> index 71e8145..38edf72 100644
> --- a/arch/ia64/include/asm/bitops.h
> +++ b/arch/ia64/include/asm/bitops.h
> @@ -196,7 +196,7 @@ __change_bit (int nr, volatile void *addr)
>   * This operation is atomic and cannot be reordered.  
>   * It also implies the acquisition side of the memory barrier.
>   */
> -static __inline__ int
> +static __inline__ bool
>  test_and_set_bit (int nr, volatile void *addr)
>  {
>  	__u32 bit, old, new;
> @@ -231,7 +231,7 @@ test_and_set_bit (int nr, volatile void *addr)
>   * If two examples of this operation race, one can appear to succeed
>   * but actually fail.  You must protect multiple accesses with a lock.
>   */
> -static __inline__ int
> +static __inline__ bool
>  __test_and_set_bit (int nr, volatile void *addr)
>  {
>  	__u32 *p = (__u32 *) addr + (nr >> 5);
> @@ -250,7 +250,7 @@ __test_and_set_bit (int nr, volatile void *addr)
>   * This operation is atomic and cannot be reordered.  
>   * It also implies the acquisition side of the memory barrier.
>   */
> -static __inline__ int
> +static __inline__ bool
>  test_and_clear_bit (int nr, volatile void *addr)
>  {
>  	__u32 mask, old, new;
> @@ -276,7 +276,7 @@ test_and_clear_bit (int nr, volatile void *addr)
>   * If two examples of this operation race, one can appear to succeed
>   * but actually fail.  You must protect multiple accesses with a lock.
>   */
> -static __inline__ int
> +static __inline__ bool
>  __test_and_clear_bit(int nr, volatile void * addr)
>  {
>  	__u32 *p = (__u32 *) addr + (nr >> 5);
> @@ -295,7 +295,7 @@ __test_and_clear_bit(int nr, volatile void * addr)
>   * This operation is atomic and cannot be reordered.  
>   * It also implies the acquisition side of the memory barrier.
>   */
> -static __inline__ int
> +static __inline__ bool
>  test_and_change_bit (int nr, volatile void *addr)
>  {
>  	__u32 bit, old, new;
> @@ -319,7 +319,7 @@ test_and_change_bit (int nr, volatile void *addr)
>   *
>   * This operation is non-atomic and can be reordered.
>   */
> -static __inline__ int
> +static __inline__ bool
>  __test_and_change_bit (int nr, void *addr)
>  {
>  	__u32 old, bit = (1 << (nr & 31));
> @@ -330,7 +330,7 @@ __test_and_change_bit (int nr, void *addr)
>  	return (old & bit) != 0;
>  }
>  
> -static __inline__ int
> +static __inline__ bool
>  test_bit (int nr, const volatile void *addr)
>  {
>  	return 1 & (((const volatile __u32 *) addr)[nr >> 5] >> (nr & 31));
> diff --git a/arch/m32r/include/asm/bitops.h b/arch/m32r/include/asm/bitops.h
> index 86ba2b4..5f12ceb 100644
> --- a/arch/m32r/include/asm/bitops.h
> +++ b/arch/m32r/include/asm/bitops.h
> @@ -147,7 +147,7 @@ static __inline__ void change_bit(int nr, volatile void * addr)
>   * This operation is atomic and cannot be reordered.
>   * It also implies a memory barrier.
>   */
> -static __inline__ int test_and_set_bit(int nr, volatile void * addr)
> +static __inline__ bool test_and_set_bit(int nr, volatile void *addr)
>  {
>  	__u32 mask, oldbit;
>  	volatile __u32 *a = addr;
> @@ -182,7 +182,7 @@ static __inline__ int test_and_set_bit(int nr, volatile void * addr)
>   * This operation is atomic and cannot be reordered.
>   * It also implies a memory barrier.
>   */
> -static __inline__ int test_and_clear_bit(int nr, volatile void * addr)
> +static __inline__ bool test_and_clear_bit(int nr, volatile void *addr)
>  {
>  	__u32 mask, oldbit;
>  	volatile __u32 *a = addr;
> @@ -219,7 +219,7 @@ static __inline__ int test_and_clear_bit(int nr, volatile void * addr)
>   * This operation is atomic and cannot be reordered.
>   * It also implies a memory barrier.
>   */
> -static __inline__ int test_and_change_bit(int nr, volatile void * addr)
> +static __inline__ bool test_and_change_bit(int nr, volatile void *addr)
>  {
>  	__u32 mask, oldbit;
>  	volatile __u32 *a = addr;
> diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
> index b4a9b0d..9f5835d 100644
> --- a/arch/m68k/include/asm/bitops.h
> +++ b/arch/m68k/include/asm/bitops.h
> @@ -148,13 +148,13 @@ static inline void bfchg_mem_change_bit(int nr, volatile unsigned long *vaddr)
>  #define __change_bit(nr, vaddr)	change_bit(nr, vaddr)
>  
>  
> -static inline int test_bit(int nr, const unsigned long *vaddr)
> +static inline bool test_bit(int nr, const unsigned long *vaddr)
>  {
>  	return (vaddr[nr >> 5] & (1UL << (nr & 31))) != 0;
>  }
>  
>  
> -static inline int bset_reg_test_and_set_bit(int nr,
> +static inline bool bset_reg_test_and_set_bit(int nr,
>  					    volatile unsigned long *vaddr)
>  {
>  	char *p = (char *)vaddr + (nr ^ 31) / 8;
> @@ -167,7 +167,7 @@ static inline int bset_reg_test_and_set_bit(int nr,
>  	return retval;
>  }
>  
> -static inline int bset_mem_test_and_set_bit(int nr,
> +static inline bool bset_mem_test_and_set_bit(int nr,
>  					    volatile unsigned long *vaddr)
>  {
>  	char *p = (char *)vaddr + (nr ^ 31) / 8;
> @@ -179,7 +179,7 @@ static inline int bset_mem_test_and_set_bit(int nr,
>  	return retval;
>  }
>  
> -static inline int bfset_mem_test_and_set_bit(int nr,
> +static inline bool bfset_mem_test_and_set_bit(int nr,
>  					     volatile unsigned long *vaddr)
>  {
>  	char retval;
> @@ -204,7 +204,7 @@ static inline int bfset_mem_test_and_set_bit(int nr,
>  #define __test_and_set_bit(nr, vaddr)	test_and_set_bit(nr, vaddr)
>  
>  
> -static inline int bclr_reg_test_and_clear_bit(int nr,
> +static inline bool bclr_reg_test_and_clear_bit(int nr,
>  					      volatile unsigned long *vaddr)
>  {
>  	char *p = (char *)vaddr + (nr ^ 31) / 8;
> @@ -217,7 +217,7 @@ static inline int bclr_reg_test_and_clear_bit(int nr,
>  	return retval;
>  }
>  
> -static inline int bclr_mem_test_and_clear_bit(int nr,
> +static inline bool bclr_mem_test_and_clear_bit(int nr,
>  					      volatile unsigned long *vaddr)
>  {
>  	char *p = (char *)vaddr + (nr ^ 31) / 8;
> @@ -229,7 +229,7 @@ static inline int bclr_mem_test_and_clear_bit(int nr,
>  	return retval;
>  }
>  
> -static inline int bfclr_mem_test_and_clear_bit(int nr,
> +static inline bool bfclr_mem_test_and_clear_bit(int nr,
>  					       volatile unsigned long *vaddr)
>  {
>  	char retval;
> @@ -254,7 +254,7 @@ static inline int bfclr_mem_test_and_clear_bit(int nr,
>  #define __test_and_clear_bit(nr, vaddr)	test_and_clear_bit(nr, vaddr)
>  
>  
> -static inline int bchg_reg_test_and_change_bit(int nr,
> +static inline bool bchg_reg_test_and_change_bit(int nr,
>  					       volatile unsigned long *vaddr)
>  {
>  	char *p = (char *)vaddr + (nr ^ 31) / 8;
> @@ -267,7 +267,7 @@ static inline int bchg_reg_test_and_change_bit(int nr,
>  	return retval;
>  }
>  
> -static inline int bchg_mem_test_and_change_bit(int nr,
> +static inline bool bchg_mem_test_and_change_bit(int nr,
>  					       volatile unsigned long *vaddr)
>  {
>  	char *p = (char *)vaddr + (nr ^ 31) / 8;
> @@ -279,7 +279,7 @@ static inline int bchg_mem_test_and_change_bit(int nr,
>  	return retval;
>  }
>  
> -static inline int bfchg_mem_test_and_change_bit(int nr,
> +static inline bool bfchg_mem_test_and_change_bit(int nr,
>  						volatile unsigned long *vaddr)
>  {
>  	char retval;
> diff --git a/arch/metag/include/asm/bitops.h b/arch/metag/include/asm/bitops.h
> index 2671134..11df061 100644
> --- a/arch/metag/include/asm/bitops.h
> +++ b/arch/metag/include/asm/bitops.h
> @@ -48,7 +48,7 @@ static inline void change_bit(unsigned int bit, volatile unsigned long *p)
>  	__global_unlock1(flags);
>  }
>  
> -static inline int test_and_set_bit(unsigned int bit, volatile unsigned long *p)
> +static inline bool test_and_set_bit(unsigned int bit, volatile unsigned long *p)
>  {
>  	unsigned long flags;
>  	unsigned long old;
> @@ -67,7 +67,7 @@ static inline int test_and_set_bit(unsigned int bit, volatile unsigned long *p)
>  	return (old & mask) != 0;
>  }
>  
> -static inline int test_and_clear_bit(unsigned int bit,
> +static inline bool test_and_clear_bit(unsigned int bit,
>  				     volatile unsigned long *p)
>  {
>  	unsigned long flags;
> @@ -87,7 +87,7 @@ static inline int test_and_clear_bit(unsigned int bit,
>  	return (old & mask) != 0;
>  }
>  
> -static inline int test_and_change_bit(unsigned int bit,
> +static inline bool test_and_change_bit(unsigned int bit,
>  				      volatile unsigned long *p)
>  {
>  	unsigned long flags;
> diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
> index fa57cef..7e53c66 100644
> --- a/arch/mips/include/asm/bitops.h
> +++ b/arch/mips/include/asm/bitops.h
> @@ -30,13 +30,13 @@
>  void __mips_set_bit(unsigned long nr, volatile unsigned long *addr);
>  void __mips_clear_bit(unsigned long nr, volatile unsigned long *addr);
>  void __mips_change_bit(unsigned long nr, volatile unsigned long *addr);
> -int __mips_test_and_set_bit(unsigned long nr,
> +bool __mips_test_and_set_bit(unsigned long nr,
>  			    volatile unsigned long *addr);
> -int __mips_test_and_set_bit_lock(unsigned long nr,
> +bool __mips_test_and_set_bit_lock(unsigned long nr,
>  				 volatile unsigned long *addr);
> -int __mips_test_and_clear_bit(unsigned long nr,
> +bool __mips_test_and_clear_bit(unsigned long nr,
>  			      volatile unsigned long *addr);
> -int __mips_test_and_change_bit(unsigned long nr,
> +bool __mips_test_and_change_bit(unsigned long nr,
>  			       volatile unsigned long *addr);
>  
>  
> @@ -210,7 +210,7 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
>   * This operation is atomic and cannot be reordered.
>   * It also implies a memory barrier.
>   */
> -static inline int test_and_set_bit(unsigned long nr,
> +static inline bool test_and_set_bit(unsigned long nr,
>  	volatile unsigned long *addr)
>  {
>  	int bit = nr & SZLONG_MASK;
> @@ -266,7 +266,7 @@ static inline int test_and_set_bit(unsigned long nr,
>   * This operation is atomic and implies acquire ordering semantics
>   * after the memory operation.
>   */
> -static inline int test_and_set_bit_lock(unsigned long nr,
> +static inline bool test_and_set_bit_lock(unsigned long nr,
>  	volatile unsigned long *addr)
>  {
>  	int bit = nr & SZLONG_MASK;
> @@ -319,7 +319,7 @@ static inline int test_and_set_bit_lock(unsigned long nr,
>   * This operation is atomic and cannot be reordered.
>   * It also implies a memory barrier.
>   */
> -static inline int test_and_clear_bit(unsigned long nr,
> +static inline bool test_and_clear_bit(unsigned long nr,
>  	volatile unsigned long *addr)
>  {
>  	int bit = nr & SZLONG_MASK;
> @@ -393,7 +393,7 @@ static inline int test_and_clear_bit(unsigned long nr,
>   * This operation is atomic and cannot be reordered.
>   * It also implies a memory barrier.
>   */
> -static inline int test_and_change_bit(unsigned long nr,
> +static inline bool test_and_change_bit(unsigned long nr,
>  	volatile unsigned long *addr)
>  {
>  	int bit = nr & SZLONG_MASK;
> diff --git a/arch/mips/lib/bitops.c b/arch/mips/lib/bitops.c
> index 3b2a1e7..8f0ba2a 100644
> --- a/arch/mips/lib/bitops.c
> +++ b/arch/mips/lib/bitops.c
> @@ -83,14 +83,14 @@ EXPORT_SYMBOL(__mips_change_bit);
>   * @nr: Bit to set
>   * @addr: Address to count from
>   */
> -int __mips_test_and_set_bit(unsigned long nr,
> +bool __mips_test_and_set_bit(unsigned long nr,
>  			    volatile unsigned long *addr)
>  {
>  	unsigned long *a = (unsigned long *)addr;
>  	unsigned bit = nr & SZLONG_MASK;
>  	unsigned long mask;
>  	unsigned long flags;
> -	int res;
> +	bool res;
>  
>  	a += nr >> SZLONG_LOG;
>  	mask = 1UL << bit;
> @@ -109,14 +109,14 @@ EXPORT_SYMBOL(__mips_test_and_set_bit);
>   * @nr: Bit to set
>   * @addr: Address to count from
>   */
> -int __mips_test_and_set_bit_lock(unsigned long nr,
> +bool __mips_test_and_set_bit_lock(unsigned long nr,
>  				 volatile unsigned long *addr)
>  {
>  	unsigned long *a = (unsigned long *)addr;
>  	unsigned bit = nr & SZLONG_MASK;
>  	unsigned long mask;
>  	unsigned long flags;
> -	int res;
> +	bool res;
>  
>  	a += nr >> SZLONG_LOG;
>  	mask = 1UL << bit;
> @@ -135,13 +135,13 @@ EXPORT_SYMBOL(__mips_test_and_set_bit_lock);
>   * @nr: Bit to clear
>   * @addr: Address to count from
>   */
> -int __mips_test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
> +bool __mips_test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long *a = (unsigned long *)addr;
>  	unsigned bit = nr & SZLONG_MASK;
>  	unsigned long mask;
>  	unsigned long flags;
> -	int res;
> +	bool res;
>  
>  	a += nr >> SZLONG_LOG;
>  	mask = 1UL << bit;
> @@ -160,13 +160,13 @@ EXPORT_SYMBOL(__mips_test_and_clear_bit);
>   * @nr: Bit to change
>   * @addr: Address to count from
>   */
> -int __mips_test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
> +bool __mips_test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long *a = (unsigned long *)addr;
>  	unsigned bit = nr & SZLONG_MASK;
>  	unsigned long mask;
>  	unsigned long flags;
> -	int res;
> +	bool res;
>  
>  	a += nr >> SZLONG_LOG;
>  	mask = 1UL << bit;
> diff --git a/arch/mn10300/include/asm/bitops.h b/arch/mn10300/include/asm/bitops.h
> index fe6f8e2..5b00e95 100644
> --- a/arch/mn10300/include/asm/bitops.h
> +++ b/arch/mn10300/include/asm/bitops.h
> @@ -68,7 +68,7 @@ static inline void __clear_bit(unsigned long nr, volatile void *addr)
>  /*
>   * test bit
>   */
> -static inline int test_bit(unsigned long nr, const volatile void *addr)
> +static inline bool test_bit(unsigned long nr, const volatile void *addr)
>  {
>  	return 1UL & (((const volatile unsigned int *) addr)[nr >> 5] >> (nr & 31));
>  }
> @@ -133,9 +133,10 @@ extern void change_bit(unsigned long nr, volatile void *addr);
>  /*
>   * test and change bit
>   */
> -static inline int __test_and_change_bit(unsigned long nr, volatile void *addr)
> +static inline bool __test_and_change_bit(unsigned long nr, volatile void *addr)
>  {
> -	int	mask, retval;
> +	int mask;
> +	bool retval;
>  	unsigned int *a = (unsigned int *)addr;
>  
>  	a += nr >> 5;
> diff --git a/arch/parisc/include/asm/bitops.h b/arch/parisc/include/asm/bitops.h
> index 3f9406d..bac163d 100644
> --- a/arch/parisc/include/asm/bitops.h
> +++ b/arch/parisc/include/asm/bitops.h
> @@ -59,17 +59,17 @@ static __inline__ void change_bit(int nr, volatile unsigned long * addr)
>  	_atomic_spin_unlock_irqrestore(addr, flags);
>  }
>  
> -static __inline__ int test_and_set_bit(int nr, volatile unsigned long * addr)
> +static __inline__ bool test_and_set_bit(int nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
>  	unsigned long old;
>  	unsigned long flags;
> -	int set;
> +	bool set;
>  
>  	addr += (nr >> SHIFT_PER_LONG);
>  	_atomic_spin_lock_irqsave(addr, flags);
>  	old = *addr;
> -	set = (old & mask) ? 1 : 0;
> +	set = (old & mask) ? true : false;
>  	if (!set)
>  		*addr = old | mask;
>  	_atomic_spin_unlock_irqrestore(addr, flags);
> @@ -77,17 +77,17 @@ static __inline__ int test_and_set_bit(int nr, volatile unsigned long * addr)
>  	return set;
>  }
>  
> -static __inline__ int test_and_clear_bit(int nr, volatile unsigned long * addr)
> +static __inline__ bool test_and_clear_bit(int nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
>  	unsigned long old;
>  	unsigned long flags;
> -	int set;
> +	bool set;
>  
>  	addr += (nr >> SHIFT_PER_LONG);
>  	_atomic_spin_lock_irqsave(addr, flags);
>  	old = *addr;
> -	set = (old & mask) ? 1 : 0;
> +	set = (old & mask) ? true : false;
>  	if (set)
>  		*addr = old & ~mask;
>  	_atomic_spin_unlock_irqrestore(addr, flags);
> @@ -95,7 +95,7 @@ static __inline__ int test_and_clear_bit(int nr, volatile unsigned long * addr)
>  	return set;
>  }
>  
> -static __inline__ int test_and_change_bit(int nr, volatile unsigned long * addr)
> +static __inline__ bool test_and_change_bit(int nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
>  	unsigned long oldbit;
> @@ -107,7 +107,7 @@ static __inline__ int test_and_change_bit(int nr, volatile unsigned long * addr)
>  	*addr = oldbit ^ mask;
>  	_atomic_spin_unlock_irqrestore(addr, flags);
>  
> -	return (oldbit & mask) ? 1 : 0;
> +	return (oldbit & mask) ? true : false;
>  }
>  
>  #include <asm-generic/bitops/non-atomic.h>
> diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
> index 59abc62..7838138 100644
> --- a/arch/powerpc/include/asm/bitops.h
> +++ b/arch/powerpc/include/asm/bitops.h
> @@ -100,7 +100,7 @@ static __inline__ void change_bit(int nr, volatile unsigned long *addr)
>  /* Like DEFINE_BITOP(), with changes to the arguments to 'op' and the output
>   * operands. */
>  #define DEFINE_TESTOP(fn, op, prefix, postfix, eh)	\
> -static __inline__ unsigned long fn(			\
> +static __inline__ bool fn(				\
>  		unsigned long mask,			\
>  		volatile unsigned long *_p)		\
>  {							\
> @@ -129,26 +129,26 @@ DEFINE_TESTOP(test_and_clear_bits, andc, PPC_ATOMIC_ENTRY_BARRIER,
>  DEFINE_TESTOP(test_and_change_bits, xor, PPC_ATOMIC_ENTRY_BARRIER,
>  	      PPC_ATOMIC_EXIT_BARRIER, 0)
>  
> -static __inline__ int test_and_set_bit(unsigned long nr,
> +static __inline__ bool test_and_set_bit(unsigned long nr,
>  				       volatile unsigned long *addr)
>  {
>  	return test_and_set_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
>  }
>  
> -static __inline__ int test_and_set_bit_lock(unsigned long nr,
> +static __inline__ bool test_and_set_bit_lock(unsigned long nr,
>  				       volatile unsigned long *addr)
>  {
>  	return test_and_set_bits_lock(BIT_MASK(nr),
>  				addr + BIT_WORD(nr)) != 0;
>  }
>  
> -static __inline__ int test_and_clear_bit(unsigned long nr,
> +static __inline__ bool test_and_clear_bit(unsigned long nr,
>  					 volatile unsigned long *addr)
>  {
>  	return test_and_clear_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
>  }
>  
> -static __inline__ int test_and_change_bit(unsigned long nr,
> +static __inline__ bool test_and_change_bit(unsigned long nr,
>  					  volatile unsigned long *addr)
>  {
>  	return test_and_change_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
> diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
> index 8043f10..71e6202 100644
> --- a/arch/s390/include/asm/bitops.h
> +++ b/arch/s390/include/asm/bitops.h
> @@ -173,7 +173,7 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *ptr)
>  	__BITOPS_LOOP(addr, mask, __BITOPS_XOR, __BITOPS_NO_BARRIER);
>  }
>  
> -static inline int
> +static inline bool
>  test_and_set_bit(unsigned long nr, volatile unsigned long *ptr)
>  {
>  	unsigned long *addr = __bitops_word(nr, ptr);
> @@ -184,7 +184,7 @@ test_and_set_bit(unsigned long nr, volatile unsigned long *ptr)
>  	return (old & mask) != 0;
>  }
>  
> -static inline int
> +static inline bool
>  test_and_clear_bit(unsigned long nr, volatile unsigned long *ptr)
>  {
>  	unsigned long *addr = __bitops_word(nr, ptr);
> @@ -195,7 +195,7 @@ test_and_clear_bit(unsigned long nr, volatile unsigned long *ptr)
>  	return (old & ~mask) != 0;
>  }
>  
> -static inline int
> +static inline bool
>  test_and_change_bit(unsigned long nr, volatile unsigned long *ptr)
>  {
>  	unsigned long *addr = __bitops_word(nr, ptr);
> @@ -228,7 +228,7 @@ static inline void __change_bit(unsigned long nr, volatile unsigned long *ptr)
>  	*addr ^= 1 << (nr & 7);
>  }
>  
> -static inline int
> +static inline bool
>  __test_and_set_bit(unsigned long nr, volatile unsigned long *ptr)
>  {
>  	unsigned char *addr = __bitops_byte(nr, ptr);
> @@ -239,7 +239,7 @@ __test_and_set_bit(unsigned long nr, volatile unsigned long *ptr)
>  	return (ch >> (nr & 7)) & 1;
>  }
>  
> -static inline int
> +static inline bool
>  __test_and_clear_bit(unsigned long nr, volatile unsigned long *ptr)
>  {
>  	unsigned char *addr = __bitops_byte(nr, ptr);
> @@ -250,7 +250,7 @@ __test_and_clear_bit(unsigned long nr, volatile unsigned long *ptr)
>  	return (ch >> (nr & 7)) & 1;
>  }
>  
> -static inline int
> +static inline bool
>  __test_and_change_bit(unsigned long nr, volatile unsigned long *ptr)
>  {
>  	unsigned char *addr = __bitops_byte(nr, ptr);
> @@ -261,7 +261,7 @@ __test_and_change_bit(unsigned long nr, volatile unsigned long *ptr)
>  	return (ch >> (nr & 7)) & 1;
>  }
>  
> -static inline int test_bit(unsigned long nr, const volatile unsigned long *ptr)
> +static inline bool test_bit(unsigned long nr, const volatile unsigned long *ptr)
>  {
>  	const volatile unsigned char *addr;
>  
> @@ -270,7 +270,7 @@ static inline int test_bit(unsigned long nr, const volatile unsigned long *ptr)
>  	return (*addr >> (nr & 7)) & 1;
>  }
>  
> -static inline int test_and_set_bit_lock(unsigned long nr,
> +static inline bool test_and_set_bit_lock(unsigned long nr,
>  					volatile unsigned long *ptr)
>  {
>  	if (test_bit(nr, ptr))
> @@ -321,7 +321,7 @@ static inline void __clear_bit_inv(unsigned long nr, volatile unsigned long *ptr
>  	return __clear_bit(nr ^ (BITS_PER_LONG - 1), ptr);
>  }
>  
> -static inline int test_bit_inv(unsigned long nr,
> +static inline bool test_bit_inv(unsigned long nr,
>  			       const volatile unsigned long *ptr)
>  {
>  	return test_bit(nr ^ (BITS_PER_LONG - 1), ptr);
> diff --git a/arch/sh/include/asm/bitops-cas.h b/arch/sh/include/asm/bitops-cas.h
> index 88f793c..c4fde9c 100644
> --- a/arch/sh/include/asm/bitops-cas.h
> +++ b/arch/sh/include/asm/bitops-cas.h
> @@ -46,7 +46,7 @@ static inline void change_bit(int nr, volatile void *addr)
>  	while (__bo_cas(a, old, old^mask) != old);
>  }
>  
> -static inline int test_and_set_bit(int nr, volatile void *addr)
> +static inline bool test_and_set_bit(int nr, volatile void *addr)
>  {
>  	unsigned mask, old;
>  	volatile unsigned *a = addr;
> @@ -60,7 +60,7 @@ static inline int test_and_set_bit(int nr, volatile void *addr)
>  	return !!(old & mask);
>  }
>  
> -static inline int test_and_clear_bit(int nr, volatile void *addr)
> +static inline bool test_and_clear_bit(int nr, volatile void *addr)
>  {
>  	unsigned mask, old;
>  	volatile unsigned *a = addr;
> @@ -74,7 +74,7 @@ static inline int test_and_clear_bit(int nr, volatile void *addr)
>  	return !!(old & mask);
>  }
>  
> -static inline int test_and_change_bit(int nr, volatile void *addr)
> +static inline bool test_and_change_bit(int nr, volatile void *addr)
>  {
>  	unsigned mask, old;
>  	volatile unsigned *a = addr;
> diff --git a/arch/sh/include/asm/bitops-grb.h b/arch/sh/include/asm/bitops-grb.h
> index e73af33..866f26a 100644
> --- a/arch/sh/include/asm/bitops-grb.h
> +++ b/arch/sh/include/asm/bitops-grb.h
> @@ -71,7 +71,7 @@ static inline void change_bit(int nr, volatile void * addr)
>                  : "memory" , "r0", "r1");
>  }
>  
> -static inline int test_and_set_bit(int nr, volatile void * addr)
> +static inline bool test_and_set_bit(int nr, volatile void *addr)
>  {
>          int     mask, retval;
>  	volatile unsigned int *a = addr;
> @@ -102,7 +102,7 @@ static inline int test_and_set_bit(int nr, volatile void * addr)
>          return retval;
>  }
>  
> -static inline int test_and_clear_bit(int nr, volatile void * addr)
> +static inline bool test_and_clear_bit(int nr, volatile void *addr)
>  {
>          int     mask, retval,not_mask;
>          volatile unsigned int *a = addr;
> @@ -136,7 +136,7 @@ static inline int test_and_clear_bit(int nr, volatile void * addr)
>          return retval;
>  }
>  
> -static inline int test_and_change_bit(int nr, volatile void * addr)
> +static inline bool test_and_change_bit(int nr, volatile void *addr)
>  {
>          int     mask, retval;
>          volatile unsigned int *a = addr;
> diff --git a/arch/sh/include/asm/bitops-llsc.h b/arch/sh/include/asm/bitops-llsc.h
> index d8328be..7dcf5ea 100644
> --- a/arch/sh/include/asm/bitops-llsc.h
> +++ b/arch/sh/include/asm/bitops-llsc.h
> @@ -64,7 +64,7 @@ static inline void change_bit(int nr, volatile void *addr)
>  	);
>  }
>  
> -static inline int test_and_set_bit(int nr, volatile void *addr)
> +static inline bool test_and_set_bit(int nr, volatile void *addr)
>  {
>  	int	mask, retval;
>  	volatile unsigned int *a = addr;
> @@ -89,7 +89,7 @@ static inline int test_and_set_bit(int nr, volatile void *addr)
>  	return retval != 0;
>  }
>  
> -static inline int test_and_clear_bit(int nr, volatile void *addr)
> +static inline bool test_and_clear_bit(int nr, volatile void *addr)
>  {
>  	int	mask, retval;
>  	volatile unsigned int *a = addr;
> @@ -115,7 +115,7 @@ static inline int test_and_clear_bit(int nr, volatile void *addr)
>  	return retval != 0;
>  }
>  
> -static inline int test_and_change_bit(int nr, volatile void *addr)
> +static inline bool test_and_change_bit(int nr, volatile void *addr)
>  {
>  	int	mask, retval;
>  	volatile unsigned int *a = addr;
> diff --git a/arch/sh/include/asm/bitops-op32.h b/arch/sh/include/asm/bitops-op32.h
> index f0ae7e9..f677a4e 100644
> --- a/arch/sh/include/asm/bitops-op32.h
> +++ b/arch/sh/include/asm/bitops-op32.h
> @@ -88,7 +88,7 @@ static inline void __change_bit(int nr, volatile unsigned long *addr)
>   * If two examples of this operation race, one can appear to succeed
>   * but actually fail.  You must protect multiple accesses with a lock.
>   */
> -static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
> +static inline bool __test_and_set_bit(int nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -107,7 +107,7 @@ static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
>   * If two examples of this operation race, one can appear to succeed
>   * but actually fail.  You must protect multiple accesses with a lock.
>   */
> -static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
> +static inline bool __test_and_clear_bit(int nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -118,7 +118,7 @@ static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
>  }
>  
>  /* WARNING: non atomic and it can be reordered! */
> -static inline int __test_and_change_bit(int nr,
> +static inline bool __test_and_change_bit(int nr,
>  					    volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
> @@ -134,7 +134,7 @@ static inline int __test_and_change_bit(int nr,
>   * @nr: bit number to test
>   * @addr: Address to start counting from
>   */
> -static inline int test_bit(int nr, const volatile unsigned long *addr)
> +static inline bool test_bit(int nr, const volatile unsigned long *addr)
>  {
>  	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
>  }
> diff --git a/arch/sparc/include/asm/bitops_32.h b/arch/sparc/include/asm/bitops_32.h
> index 600ed1d..afe275a 100644
> --- a/arch/sparc/include/asm/bitops_32.h
> +++ b/arch/sparc/include/asm/bitops_32.h
> @@ -28,7 +28,7 @@ unsigned long ___change_bit(unsigned long *addr, unsigned long mask);
>   * within the first byte. Sparc is BIG-Endian. Unless noted otherwise
>   * all bit-ops return 0 if bit was previously clear and != 0 otherwise.
>   */
> -static inline int test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
> +static inline bool test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long *ADDR, mask;
>  
> @@ -48,7 +48,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
>  	(void) ___set_bit(ADDR, mask);
>  }
>  
> -static inline int test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
> +static inline bool test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long *ADDR, mask;
>  
> @@ -68,7 +68,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
>  	(void) ___clear_bit(ADDR, mask);
>  }
>  
> -static inline int test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
> +static inline bool test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long *ADDR, mask;
>  
> diff --git a/arch/sparc/include/asm/bitops_64.h b/arch/sparc/include/asm/bitops_64.h
> index 2d52240..8cbd032 100644
> --- a/arch/sparc/include/asm/bitops_64.h
> +++ b/arch/sparc/include/asm/bitops_64.h
> @@ -15,9 +15,9 @@
>  #include <asm/byteorder.h>
>  #include <asm/barrier.h>
>  
> -int test_and_set_bit(unsigned long nr, volatile unsigned long *addr);
> -int test_and_clear_bit(unsigned long nr, volatile unsigned long *addr);
> -int test_and_change_bit(unsigned long nr, volatile unsigned long *addr);
> +bool test_and_set_bit(unsigned long nr, volatile unsigned long *addr);
> +bool test_and_clear_bit(unsigned long nr, volatile unsigned long *addr);
> +bool test_and_change_bit(unsigned long nr, volatile unsigned long *addr);
>  void set_bit(unsigned long nr, volatile unsigned long *addr);
>  void clear_bit(unsigned long nr, volatile unsigned long *addr);
>  void change_bit(unsigned long nr, volatile unsigned long *addr);
> diff --git a/arch/tile/include/asm/bitops_32.h b/arch/tile/include/asm/bitops_32.h
> index d1406a9..9ef0ba4 100644
> --- a/arch/tile/include/asm/bitops_32.h
> +++ b/arch/tile/include/asm/bitops_32.h
> @@ -80,7 +80,7 @@ static inline void change_bit(unsigned nr, volatile unsigned long *addr)
>   * This operation is atomic and cannot be reordered.
>   * It also implies a memory barrier.
>   */
> -static inline int test_and_set_bit(unsigned nr, volatile unsigned long *addr)
> +static inline bool test_and_set_bit(unsigned nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	addr += BIT_WORD(nr);
> @@ -96,7 +96,7 @@ static inline int test_and_set_bit(unsigned nr, volatile unsigned long *addr)
>   * This operation is atomic and cannot be reordered.
>   * It also implies a memory barrier.
>   */
> -static inline int test_and_clear_bit(unsigned nr, volatile unsigned long *addr)
> +static inline bool test_and_clear_bit(unsigned nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	addr += BIT_WORD(nr);
> @@ -112,7 +112,7 @@ static inline int test_and_clear_bit(unsigned nr, volatile unsigned long *addr)
>   * This operation is atomic and cannot be reordered.
>   * It also implies a memory barrier.
>   */
> -static inline int test_and_change_bit(unsigned nr,
> +static inline bool test_and_change_bit(unsigned nr,
>  				      volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
> diff --git a/arch/tile/include/asm/bitops_64.h b/arch/tile/include/asm/bitops_64.h
> index bb1a292..d970306 100644
> --- a/arch/tile/include/asm/bitops_64.h
> +++ b/arch/tile/include/asm/bitops_64.h
> @@ -52,9 +52,9 @@ static inline void change_bit(unsigned nr, volatile unsigned long *addr)
>   * barrier(), to block until the atomic op is complete.
>   */
>  
> -static inline int test_and_set_bit(unsigned nr, volatile unsigned long *addr)
> +static inline bool test_and_set_bit(unsigned nr, volatile unsigned long *addr)
>  {
> -	int val;
> +	bool val;
>  	unsigned long mask = (1UL << (nr % BITS_PER_LONG));
>  	smp_mb();  /* barrier for proper semantics */
>  	val = (__insn_fetchor((void *)(addr + nr / BITS_PER_LONG), mask)
> @@ -64,9 +64,9 @@ static inline int test_and_set_bit(unsigned nr, volatile unsigned long *addr)
>  }
>  
>  
> -static inline int test_and_clear_bit(unsigned nr, volatile unsigned long *addr)
> +static inline bool test_and_clear_bit(unsigned nr, volatile unsigned long *addr)
>  {
> -	int val;
> +	bool val;
>  	unsigned long mask = (1UL << (nr % BITS_PER_LONG));
>  	smp_mb();  /* barrier for proper semantics */
>  	val = (__insn_fetchand((void *)(addr + nr / BITS_PER_LONG), ~mask)
> @@ -76,7 +76,7 @@ static inline int test_and_clear_bit(unsigned nr, volatile unsigned long *addr)
>  }
>  
>  
> -static inline int test_and_change_bit(unsigned nr,
> +static inline bool test_and_change_bit(unsigned nr,
>  				      volatile unsigned long *addr)
>  {
>  	unsigned long mask = (1UL << (nr % BITS_PER_LONG));
> diff --git a/arch/xtensa/include/asm/bitops.h b/arch/xtensa/include/asm/bitops.h
> index d349018..485d95d 100644
> --- a/arch/xtensa/include/asm/bitops.h
> +++ b/arch/xtensa/include/asm/bitops.h
> @@ -154,7 +154,7 @@ static inline void change_bit(unsigned int bit, volatile unsigned long *p)
>  			: "memory");
>  }
>  
> -static inline int
> +static inline bool
>  test_and_set_bit(unsigned int bit, volatile unsigned long *p)
>  {
>  	unsigned long tmp, value;
> @@ -175,7 +175,7 @@ test_and_set_bit(unsigned int bit, volatile unsigned long *p)
>  	return tmp & mask;
>  }
>  
> -static inline int
> +static inline bool
>  test_and_clear_bit(unsigned int bit, volatile unsigned long *p)
>  {
>  	unsigned long tmp, value;
> @@ -196,7 +196,7 @@ test_and_clear_bit(unsigned int bit, volatile unsigned long *p)
>  	return tmp & mask;
>  }
>  
> -static inline int
> +static inline bool
>  test_and_change_bit(unsigned int bit, volatile unsigned long *p)
>  {
>  	unsigned long tmp, value;
> diff --git a/include/asm-generic/bitops/atomic.h b/include/asm-generic/bitops/atomic.h
> index 4967351..eb68d8d 100644
> --- a/include/asm-generic/bitops/atomic.h
> +++ b/include/asm-generic/bitops/atomic.h
> @@ -124,7 +124,7 @@ static inline void change_bit(int nr, volatile unsigned long *addr)
>   * It may be reordered on other architectures than x86.
>   * It also implies a memory barrier.
>   */
> -static inline int test_and_set_bit(int nr, volatile unsigned long *addr)
> +static inline bool test_and_set_bit(int nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -148,7 +148,7 @@ static inline int test_and_set_bit(int nr, volatile unsigned long *addr)
>   * It can be reorderdered on other architectures other than x86.
>   * It also implies a memory barrier.
>   */
> -static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
> +static inline bool test_and_clear_bit(int nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -171,7 +171,7 @@ static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
>   * This operation is atomic and cannot be reordered.
>   * It also implies a memory barrier.
>   */
> -static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
> +static inline bool test_and_change_bit(int nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
> index 6173154..c610b99 100644
> --- a/include/asm-generic/bitops/le.h
> +++ b/include/asm-generic/bitops/le.h
> @@ -49,7 +49,7 @@ extern unsigned long find_next_bit_le(const void *addr,
>  #error "Please fix <asm/byteorder.h>"
>  #endif
>  
> -static inline int test_bit_le(int nr, const void *addr)
> +static inline bool test_bit_le(int nr, const void *addr)
>  {
>  	return test_bit(nr ^ BITOP_LE_SWIZZLE, addr);
>  }
> @@ -74,22 +74,22 @@ static inline void __clear_bit_le(int nr, void *addr)
>  	__clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
>  }
>  
> -static inline int test_and_set_bit_le(int nr, void *addr)
> +static inline bool test_and_set_bit_le(int nr, void *addr)
>  {
>  	return test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
>  }
>  
> -static inline int test_and_clear_bit_le(int nr, void *addr)
> +static inline bool test_and_clear_bit_le(int nr, void *addr)
>  {
>  	return test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
>  }
>  
> -static inline int __test_and_set_bit_le(int nr, void *addr)
> +static inline bool __test_and_set_bit_le(int nr, void *addr)
>  {
>  	return __test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
>  }
>  
> -static inline int __test_and_clear_bit_le(int nr, void *addr)
> +static inline bool __test_and_clear_bit_le(int nr, void *addr)
>  {
>  	return __test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
>  }
> diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bitops/non-atomic.h
> index 697cc2b..fea2b40 100644
> --- a/include/asm-generic/bitops/non-atomic.h
> +++ b/include/asm-generic/bitops/non-atomic.h
> @@ -54,7 +54,7 @@ static inline void __change_bit(int nr, volatile unsigned long *addr)
>   * If two examples of this operation race, one can appear to succeed
>   * but actually fail.  You must protect multiple accesses with a lock.
>   */
> -static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
> +static inline bool __test_and_set_bit(int nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -73,7 +73,7 @@ static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
>   * If two examples of this operation race, one can appear to succeed
>   * but actually fail.  You must protect multiple accesses with a lock.
>   */
> -static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
> +static inline bool __test_and_clear_bit(int nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -84,7 +84,7 @@ static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
>  }
>  
>  /* WARNING: non atomic and it can be reordered! */
> -static inline int __test_and_change_bit(int nr,
> +static inline bool __test_and_change_bit(int nr,
>  					    volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
> @@ -100,7 +100,7 @@ static inline int __test_and_change_bit(int nr,
>   * @nr: bit number to test
>   * @addr: Address to start counting from
>   */
> -static inline int test_bit(int nr, const volatile unsigned long *addr)
> +static inline bool test_bit(int nr, const volatile unsigned long *addr)
>  {
>  	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
>  }
> -- 
> 1.9.3
> 

-- 
Michal Hocko
SUSE Labs
