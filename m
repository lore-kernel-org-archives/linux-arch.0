From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] ARM64: fix building without CONFIG_UID16
Date: Mon, 23 Nov 2015 15:22:25 +0000
Message-ID: <20151123152225.GE4236@arm.com>
References: <3891403.6hGat7eHq5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56665 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754867AbbKWPW1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Nov 2015 10:22:27 -0500
Content-Disposition: inline
In-Reply-To: <3891403.6hGat7eHq5@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>

On Fri, Nov 20, 2015 at 12:12:21PM +0100, Arnd Bergmann wrote:
> As reported by Michal Simek, building an ARM64 kernel with CONFIG_UID16
> disabled currently fails because the system call table still needs to
> reference the individual function entry points that are provided by
> kernel/sys_ni.c in this case, and the declarations are hidden inside
> of #ifdef CONFIG_UID16:
> 
> arch/arm64/include/asm/unistd32.h:57:8: error: 'sys_lchown16' undeclared here (not in a function)
>  __SYSCALL(__NR_lchown, sys_lchown16)
> 
> I believe this problem only exists on ARM64, because older architectures
> tend to not need declarations when their system call table is built
> in assembly code, while newer architectures tend to not need UID16
> support. ARM64 only uses these system calls for compatibility with
> 32-bit ARM binaries.
> 
> This changes the CONFIG_UID16 check into CONFIG_HAVE_UID16, which is
> set unconditionally on ARM64 with CONFIG_COMPAT, so we see the
> declarations whenever we need them, but otherwise the behavior is
> unchanged.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: stable@vger.kernel.org
> Fixes: af1839eb4bd4 ("Kconfig: clean up the long arch list for the UID16 config option")
> ---
> I would suggest merging this through the arm64 tree, as this is
> likely the only architecture that cares about it, and there is little
> risk of clashes with other patches in the global headers.
> 
> The bug goes back to when arch/arm64 was introduced as far as I can
> tell, but I'm not sure if we care about stable backports or not.
> I've put stable on Cc anyway, let me know if anyone thinks we should not.

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin, can you pick this one up, please?

Will

> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index a156b82dd14c..c2b66a277e98 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -524,7 +524,7 @@ asmlinkage long sys_chown(const char __user *filename,
>  asmlinkage long sys_lchown(const char __user *filename,
>  				uid_t user, gid_t group);
>  asmlinkage long sys_fchown(unsigned int fd, uid_t user, gid_t group);
> -#ifdef CONFIG_UID16
> +#ifdef CONFIG_HAVE_UID16
>  asmlinkage long sys_chown16(const char __user *filename,
>  				old_uid_t user, old_gid_t group);
>  asmlinkage long sys_lchown16(const char __user *filename,
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 70d8500bddf1..70dd3dfde631 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -35,7 +35,7 @@ typedef __kernel_gid16_t        gid16_t;
>  
>  typedef unsigned long		uintptr_t;
>  
> -#ifdef CONFIG_UID16
> +#ifdef CONFIG_HAVE_UID16
>  /* This is defined by include/asm-{arch}/posix_types.h */
>  typedef __kernel_old_uid_t	old_uid_t;
>  typedef __kernel_old_gid_t	old_gid_t;
> 
