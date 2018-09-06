Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34829 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeIFSqu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2018 14:46:50 -0400
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <bff609c9d2c5f0085448cc7d4227614ab7b7116a.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <bff609c9d2c5f0085448cc7d4227614ab7b7116a.1536138304.git.ren_guo@c-sky.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 6 Sep 2018 16:10:49 +0200
Message-ID: <CAK8P3a1W5yvymAHKLTP5EwLm_usUqVBBE_86pRp0TmxrTiTfjA@mail.gmail.com>
Subject: Re: [PATCH V3 05/26] csky: System Call
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180906141049.BldPKziarwxDifBWbnp7n59nEpaYFRIGFzj9OdBHkfI@z>

On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:

> +SYSCALL_DEFINE6(mmap2,
> +       unsigned long, addr,
> +       unsigned long, len,
> +       unsigned long, prot,
> +       unsigned long, flags,
> +       unsigned long, fd,
> +       off_t, offset)
> +{
> +       if (unlikely(offset & (~PAGE_MASK >> 12)))
> +               return -EINVAL;
> +       return sys_mmap_pgoff(addr, len, prot, flags, fd,
> +               offset >> (PAGE_SHIFT - 12));
> +}

Please call ksys_mmap_pgoff() instead of sys_mmap_pgoff() here.

The prototype in include/asm-generic/syscalls.h uses 'unsigned long'
for the last argument as well, not off_t.

> +struct mmap_arg_struct {
> +       unsigned long addr;
> +       unsigned long len;
> +       unsigned long prot;
> +       unsigned long flags;
> +       unsigned long fd;
> +       unsigned long offset;
> +};
> +
> +SYSCALL_DEFINE1(mmap,
> +       struct mmap_arg_struct *, arg)

Something is still wrong here, there should be no way to
call sys_mmap(), since it's not in the syscall table.

> +/*
> + * for abiv1 the 64bits args should be even th, So we need mov the advice forward.
> + */
> +SYSCALL_DEFINE4(csky_fadvise64_64,
> +       int, fd,
> +       int, advice,
> +       loff_t, offset,
> +       loff_t, len)
> +{
> +       return sys_fadvise64_64(fd, offset, len, advice);
> +}

And call ksys_fadvise64_64() here.

> +#undef __SYSCALL
> +#define __SYSCALL(nr, call) [nr] = (call),
> +
> +#define sys_fadvise64_64 sys_csky_fadvise64_64
> +void * const sys_call_table[__NR_syscalls] __page_aligned_data = {
> +       [0 ... __NR_syscalls - 1] = sys_ni_syscall,
> +#include <asm/unistd.h>
> +};

This looks good now.

       Arnd
