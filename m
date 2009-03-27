From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/13] score - New architecure port to SunplusCT S+CORE processor
Date: Fri, 27 Mar 2009 16:26:20 +0100
Message-ID: <200903271626.20863.arnd@arndb.de>
References: <OF23D2A1D1.74CB7871-ON48257586.00098D8A-48257586.0009CE62@sunplusct.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:49683 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbZC0P1o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2009 11:27:44 -0400
In-Reply-To: <OF23D2A1D1.74CB7871-ON48257586.00098D8A-48257586.0009CE62@sunplusct.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

On Friday 27 March 2009, liqin.chen@sunplusct.com wrote:

> +
> +extern void cpu_cache_init (void);
> +extern void tlb_init (void);

In general, never put 'extern' declarations into a .c file. They are
part of an interface between different compilation units, so they
should be moved into a header file that is included by both of them.

> diff -uprN -x linux-2.6-git.ori/Documentation/dontdiff 
> linux-2.6-git.ori/arch/score/kernel/signal.c 
> linux-2.6-git.new/arch/score/kernel/signal.c
> --- linux-2.6-git.ori/arch/score/kernel/signal.c        1970-01-01 
> 08:00:00.000000000 +0800
> +++ linux-2.6-git.new/arch/score/kernel/signal.c        2009-03-26 
> 15:32:23.000000000 +0800

As mentioned in my comment on system calls, this file should largely
not exist at all, because the generic rt_sig* system calls have
replaced these functions.

You will still need do_signal, sys_rt_sigaction and sys_rt_sigreturn,
maybe others, but not sys_sig*

> +#ifdef HAVE_ARCH_UNMAPPED_AREA
> +unsigned long arch_get_unmapped_area(struct file *filp, unsigned long 
> addr,
> +       unsigned long len, unsigned long pgoff, unsigned long flags)
> +{
> +       struct vm_area_struct *vmm;
> +       int do_color_align;
> +       unsigned long task_size;

The #ifdef here looks wrong. You decide in asm/pgtable.h whether you
need it or not, but I would expect that decision to be constant.
Most new architectures don't need one. Why do you?

> +/* common code for old and new mmaps */

You only do "new" mmaps, so this function could be merged
into your sys_mmap2.

[note to myself: I should send my patch that provides
a generic version of this so architectures don't have to
copy it any more]


> +asmlinkage int sys_set_thread_area(unsigned long addr)
> +{
> +       struct thread_info *ti = task_thread_info(current);
> +
> +       ti->tp_value = addr;
> +       return 0;
> +}

Why does this have to be a systemcall? Most architectures handle
TLS in user space.

> +asmlinkage int _sys_sysscore(int cmd, long arg1, int arg2, int arg3)
> +{
> +       return 0;
> +}

What is this used for?

> +asmlinkage ssize_t sys_pwrite_wrapper(unsigned int fd, const char *buf,
> +                                       long long count,loff_t pos)
> +{
> +       return sys_pwrite64(fd, buf, (long) count, pos);
> +}
> +
> +asmlinkage ssize_t sys_pread_wrapper(unsigned int fd, char *buf,
> +                                       long long count, loff_t pos)
> +{
> +       return sys_pread64(fd, buf, (long) count, pos);
> +}

Just for consistency, I'd call these sys_pwrite64_wrapper and
sys_pread64_wrapper.

> +asmlinkage long
> +sys_fadvise64_wrapper(int fd, int unused, loff_t offset, size_t len, int 
> advice)
> +{
> +       return sys_fadvise64(fd, offset, len, advice);
> +}

This should probably be fadvise64_64, not fadvise64.

	Arnd <><
