From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv1 04/12] unicore32 core architecture: low level entry and setup code
Date: Fri, 7 Jan 2011 01:04:57 +0100
Message-ID: <201101070104.57770.arnd@arndb.de>
References: <00cc01cba464$16e6a410$44b3ec30$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00cc01cba464$16e6a410$44b3ec30$@mprc.pku.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Saturday 25 December 2010, Guan Xuetao wrote:
> +#ifdef __KERNEL__
> +
> +/*
> + * Memory map description
> + */
> +# define NR_BANKS 8
> +
> +struct membank {
> +	unsigned long start;
> +	unsigned long size;
> +	unsigned int highmem;
> +};
> +
> +struct meminfo {
> +	int nr_banks;
> +	struct membank bank[NR_BANKS];
> +};
> +
> +extern struct meminfo meminfo;
> +
> +#define for_each_bank(iter, mi)				\
> +	for (iter = 0; iter < (mi)->nr_banks; iter++)
> +
> +#define bank_pfn_start(bank)	__phys_to_pfn((bank)->start)
> +#define bank_pfn_end(bank)	__phys_to_pfn((bank)->start + (bank)->size)
> +#define bank_pfn_size(bank)	((bank)->size >> PAGE_SHIFT)
> +#define bank_phys_start(bank)	((bank)->start)
> +#define bank_phys_end(bank)	((bank)->start + (bank)->size)
> +#define bank_phys_size(bank)	((bank)->size)

The membank stuff looks like a variation of the generic memblock interfaces.

> +/*
> + * Handle all unrecognised system calls.
> + *  0x9f0000 - 0x9fffff are some more esoteric system calls
> + */
> +#define NR(x) ((__UNICORE_NR_##x) - __UNICORE_NR_BASE)
> +asmlinkage int uc32_syscall(int no, struct pt_regs *regs)
> +{
> +	if ((no >> 16) != (__UNICORE_NR_BASE >> 16))
> +		return -ENOSYS;
> +
> +	switch (no & 0xffff) {
> +	/*
> +	 * Flush a region from virtual address 'r0' to virtual address 'r1'
> +	 * _exclusive_.  There is no alignment requirement on either address;
> +	 * user space does not need to know the hardware cache layout.
> +	 *
> +	 * r2 contains flags.  It should ALWAYS be passed as ZERO until it
> +	 * is defined to be something else.  For now we ignore it, but may
> +	 * the fires of hell burn in your belly if you break this rule. ;)
> +	 *
> +	 * (at a later date, we may want to allow this call to not flush
> +	 * various aspects of the cache.  Passing '0' will guarantee that
> +	 * everything necessary gets flushed to maintain consistency in
> +	 * the specified region).
> +	 */
> +	case NR(cacheflush):
> +		do_cache_op(regs->UCreg_00, regs->UCreg_01, regs->UCreg_02);
> +		return 0;
> +
> +	case NR(cmpxchg):
> +		return do_cmpxchg_op(regs);
> +
> +	default:
> +		return -ENOSYS;
> +	}
> +}

With the generic system cal interface, this function should be replaced
with straight system calls for each of the subfunctions.

Just use things definitions like

#define __NR_cacheflush __NR_arch_specific_syscall
__SYSCALL(__NR_cacheflush, sys_uc32_cacheflush)
#define __NR_cmpxchg __NR_arch_specific_syscall+1
__SYSCALL(__NR_cmpxchg, sys_uc32_cacheflush

in your asm/unistd.h file.

	Arnd
