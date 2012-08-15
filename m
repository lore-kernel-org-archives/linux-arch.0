From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 17/31] arm64: System calls handling
Date: Wed, 15 Aug 2012 14:22:16 +0000
Message-ID: <201208151422.16335.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-18-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63426 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150Ab2HOOWT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 10:22:19 -0400
In-Reply-To: <1344966752-16102-18-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Tuesday 14 August 2012, Catalin Marinas wrote:

> +
> +/* This matches struct stat64 in glibc2.1, hence the absolutely
> + * insane amounts of padding around dev_t's.
> + * Note: The kernel zero's the padded region because glibc might read them
> + * in the hope that the kernel has stretched to using larger sizes.
> + */
> +struct stat64 {
> +	compat_u64	st_dev;
> +	unsigned char   __pad0[4];
> +
> +#define STAT64_HAS_BROKEN_ST_INO	1
> +	compat_ulong_t	__st_ino;
> +	compat_uint_t	st_mode;
> +	compat_uint_t	st_nlink;
> +
> +	compat_ulong_t	st_uid;
> +	compat_ulong_t	st_gid;
> +
> +	compat_u64	st_rdev;
> +	unsigned char   __pad3[4];
> +
> +	compat_s64	st_size;
> +	compat_ulong_t	st_blksize;
> +	compat_u64	st_blocks;	/* Number 512-byte blocks allocated. */
> +
> +	compat_ulong_t	st_atime;
> +	compat_ulong_t	st_atime_nsec;
> +
> +	compat_ulong_t	st_mtime;
> +	compat_ulong_t	st_mtime_nsec;
> +
> +	compat_ulong_t	st_ctime;
> +	compat_ulong_t	st_ctime_nsec;
> +
> +	compat_u64	st_ino;
> +};

The comment above struct stat64 is completely irrelevant here. I would instead
explain why you need your own stat64 in the first place.

> +int kernel_execve(const char *filename,
> +		  const char *const argv[],
> +		  const char *const envp[])
> +{
> +	struct pt_regs regs;
> +	int ret;
> +
> +	memset(&regs, 0, sizeof(struct pt_regs));
> +	ret = do_execve(filename,
> +			(const char __user *const __user *)argv,
> +			(const char __user *const __user *)envp, &regs);
> +	if (ret < 0)
> +		goto out;
> +
> +	/*
> +	 * Save argc to the register structure for userspace.
> +	 */
> +	regs.regs[0] = ret;
> +
> +	/*
> +	 * We were successful.  We won't be returning to our caller, but
> +	 * instead to user space by manipulating the kernel stack.
> +	 */
> +	asm(	"add	x0, %0, %1\n\t"
> +		"mov	x1, %2\n\t"
> +		"mov	x2, %3\n\t"
> +		"bl	memmove\n\t"	/* copy regs to top of stack */
> +		"mov	x27, #0\n\t"	/* not a syscall */
> +		"mov	x28, %0\n\t"	/* thread structure */
> +		"mov	sp, x0\n\t"	/* reposition stack pointer */
> +		"b	ret_to_user"
> +		:
> +		: "r" (current_thread_info()),
> +		  "Ir" (THREAD_START_SP - sizeof(regs)),
> +		  "r" (&regs),
> +		  "Ir" (sizeof(regs))
> +		: "x0", "x1", "x2", "x27", "x28", "x30", "memory");
> +
> + out:
> +	return ret;
> +}
> +EXPORT_SYMBOL(kernel_execve);

Al Viro was recently talking about a generic implementation of execve.
I can't find that now, but I think you should use that.

> +
> +asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
> +			 unsigned long prot, unsigned long flags,
> +			 unsigned long fd, off_t off)
> +{
> +	if (offset_in_page(off) != 0)
> +		return -EINVAL;
> +
> +	return sys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
> +}
> +
> +/*
> + * Wrappers to pass the pt_regs argument.
> + */
> +#define sys_execve		sys_execve_wrapper
> +#define sys_clone		sys_clone_wrapper
> +#define sys_rt_sigreturn	sys_rt_sigreturn_wrapper
> +#define sys_sigaltstack		sys_sigaltstack_wrapper

I think

#define sys_mmap sys_mmap_pgoff 

would be more appropriate than defining your own sys_mmap function here.
We should probably make that the default in asm-generic/unistd.h and
change the architectures that have their own implementation to override
it.

	Arnd
