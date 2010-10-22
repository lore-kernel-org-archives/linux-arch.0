From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH v2 06/22] m68knommu: introduce little-endian bitops
Date: Fri, 22 Oct 2010 15:47:08 +1000
Message-ID: <4CC1255C.90009@snapgear.com>
References: <1287672077-5797-1-git-send-email-akinobu.mita@gmail.com> <1287672077-5797-7-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1287672077-5797-7-git-send-email-akinobu.mita@gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Ungerer <gerg@uclinux.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, linux-m68k@lists.linux-m68k.org
List-Id: linux-arch.vger.kernel.org

On 22/10/10 00:41, Akinobu Mita wrote:
> Introduce little-endian bit operations by renaming native ext2 bit
> operations. The ext2 bit operations are kept as wrapper macros using
> little-endian bit operations to maintain bisectability until the
> conversions are finished.
>
> Signed-off-by: Akinobu Mita<akinobu.mita@gmail.com>
> Cc: Greg Ungerer<gerg@uclinux.org>

I see no problems here.

Acked-by: Greg Ungerer <gerg@uclinux.org>


> Cc: Geert Uytterhoeven<geert@linux-m68k.org>
> Cc: Roman Zippel<zippel@linux-m68k.org>
> Cc: Andreas Schwab<schwab@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> ---
> No change from previous submission
>
>   arch/m68k/include/asm/bitops_no.h |   40 +++++++++++++++++++++++++++++-------
>   1 files changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/arch/m68k/include/asm/bitops_no.h b/arch/m68k/include/asm/bitops_no.h
> index 292e1ce..9f5eb02 100644
> --- a/arch/m68k/include/asm/bitops_no.h
> +++ b/arch/m68k/include/asm/bitops_no.h
> @@ -196,7 +196,15 @@ static __inline__ int __test_bit(int nr, const volatile unsigned long * addr)
>   #include<asm-generic/bitops/hweight.h>
>   #include<asm-generic/bitops/lock.h>
>
> -static __inline__ int ext2_set_bit(int nr, volatile void * addr)
> +#define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1)&  ~0x7)
> +
> +#define __set_le_bit(nr, addr) \
> +	__set_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
> +
> +#define __clear_le_bit(nr, addr) \
> +	__clear_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
> +
> +static inline int __test_and_set_le_bit(int nr, volatile void *addr)
>   {
>   	char retval;
>
> @@ -215,7 +223,7 @@ static __inline__ int ext2_set_bit(int nr, volatile void * addr)
>   	return retval;
>   }
>
> -static __inline__ int ext2_clear_bit(int nr, volatile void * addr)
> +static inline int __test_and_clear_le_bit(int nr, volatile void *addr)
>   {
>   	char retval;
>
> @@ -238,7 +246,7 @@ static __inline__ int ext2_clear_bit(int nr, volatile void * addr)
>   	({						\
>   		int ret;				\
>   		spin_lock(lock);			\
> -		ret = ext2_set_bit((nr), (addr));	\
> +		ret = __test_and_set_le_bit((nr), (addr));	\
>   		spin_unlock(lock);			\
>   		ret;					\
>   	})
> @@ -247,12 +255,12 @@ static __inline__ int ext2_clear_bit(int nr, volatile void * addr)
>   	({						\
>   		int ret;				\
>   		spin_lock(lock);			\
> -		ret = ext2_clear_bit((nr), (addr));	\
> +		ret = __test_and_clear_le_bit((nr), (addr));	\
>   		spin_unlock(lock);			\
>   		ret;					\
>   	})
>
> -static __inline__ int ext2_test_bit(int nr, const volatile void * addr)
> +static inline int test_le_bit(int nr, const volatile void *addr)
>   {
>   	char retval;
>
> @@ -271,10 +279,10 @@ static __inline__ int ext2_test_bit(int nr, const volatile void * addr)
>   	return retval;
>   }
>
> -#define ext2_find_first_zero_bit(addr, size) \
> -        ext2_find_next_zero_bit((addr), (size), 0)
> +#define find_first_zero_le_bit(addr, size)	\
> +	find_next_zero_le_bit((addr), (size), 0)
>
> -static __inline__ unsigned long ext2_find_next_zero_bit(void *addr, unsigned long size, unsigned long offset)
> +static inline unsigned long find_next_zero_le_bit(void *addr, unsigned long size, unsigned long offset)
>   {
>   	unsigned long *p = ((unsigned long *) addr) + (offset>>  5);
>   	unsigned long result = offset&  ~31UL;
> @@ -324,8 +332,24 @@ found_middle:
>   	return result + ffz(__swab32(tmp));
>   }
>
> +#define ext2_set_bit(nr, addr)	\
> +	__test_and_set_le_bit(nr, addr)
> +
> +#define ext2_clear_bit(nr, addr)	\
> +	test_and_clear_le_bit(nr, addr)
> +
> +#define ext2_test_bit(nr, addr)	\
> +	test_le_bit(nr, addr)
> +
> +#define ext2_find_first_zero_bit(addr, size) \
> +	find_first_zero_le_bit(addr, size)
> +
> +#define ext2_find_next_zero_bit(addr, size, offset)	\
> +	find_next_zero_le_bit(addr, size, offset)
> +
>   #define ext2_find_next_bit(addr, size, off) \
>   	find_next_le_bit((unsigned long *)(addr), (size), (off))
> +
>   #include<asm-generic/bitops/minix.h>
>
>   #endif /* __KERNEL__ */


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
