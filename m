Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39875 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbeIGG1r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2018 02:27:47 -0400
Date: Fri, 7 Sep 2018 09:47:57 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 05/26] csky: System Call
Message-ID: <20180907014757.GB8288@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <bff609c9d2c5f0085448cc7d4227614ab7b7116a.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a1W5yvymAHKLTP5EwLm_usUqVBBE_86pRp0TmxrTiTfjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1W5yvymAHKLTP5EwLm_usUqVBBE_86pRp0TmxrTiTfjA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180907014757.RYBScGhyn4KTscHB5C2JS7_g9F7S46PpUC5aUjgpUpQ@z>

On Thu, Sep 06, 2018 at 04:10:49PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
> 
> > +SYSCALL_DEFINE6(mmap2,
> > +       unsigned long, addr,
> > +       unsigned long, len,
> > +       unsigned long, prot,
> > +       unsigned long, flags,
> > +       unsigned long, fd,
> > +       off_t, offset)
> > +{
> > +       if (unlikely(offset & (~PAGE_MASK >> 12)))
> > +               return -EINVAL;
> > +       return sys_mmap_pgoff(addr, len, prot, flags, fd,
> > +               offset >> (PAGE_SHIFT - 12));
> > +}
> 
> Please call ksys_mmap_pgoff() instead of sys_mmap_pgoff() here.
Ok.

> The prototype in include/asm-generic/syscalls.h uses 'unsigned long'
> for the last argument as well, not off_t.
Ok, unsigned long for last argument.
 
> > +struct mmap_arg_struct {
> > +       unsigned long addr;
> > +       unsigned long len;
> > +       unsigned long prot;
> > +       unsigned long flags;
> > +       unsigned long fd;
> > +       unsigned long offset;
> > +};
> > +
> > +SYSCALL_DEFINE1(mmap,
> > +       struct mmap_arg_struct *, arg)
> 
> Something is still wrong here, there should be no way to
> call sys_mmap(), since it's not in the syscall table.
You are right, remove it.

> > +       return sys_fadvise64_64(fd, offset, len, advice);
> > +}
> 
> And call ksys_fadvise64_64() here.
Ok.

 Guo Ren
