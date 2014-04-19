From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 16/28] nios2: System calls handling
Date: Sat, 19 Apr 2014 22:12:28 +0200
Message-ID: <CAMuHMdXvLLNXQXYRD71Uv7F-Fh_E6EmF7_OvBUYF513cMfy8sw@mail.gmail.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<1397824031-4892-13-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:54010 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbaDSUMa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 19 Apr 2014 16:12:30 -0400
In-Reply-To: <1397824031-4892-13-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, lftan.linux@gmail.com, cltang@codesourcery.com, Pavel Machek <pavel@denx.de>

On Fri, Apr 18, 2014 at 2:26 PM, Ley Foon Tan <lftan@altera.com> wrote:
> +/* sys_cacheflush -- flush the processor cache. */
> +asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len,
> +                               unsigned int op)
> +{
> +       struct vm_area_struct *vma;
> +
> +       if (len == 0)
> +               return 0;
> +
> +       /* Check for overflow */
> +       if (addr + len < addr)
> +               return -EFAULT;
> +
> +       /*
> +        * Verify that the specified address region actually belongs
> +        * to this process.
> +        */
> +       vma = find_vma(current->mm, addr);
> +       if (vma == NULL || addr < vma->vm_start || addr + len > vma->vm_end)
> +               return -EFAULT;
> +
> +       /* Ignore the scope and cache arguments. */

This function doesn't have scope and cache arguments
(sys_cacheflush() on m68k does have them ;-)

On Sat, Apr 19, 2014 at 6:09 PM, Pavel Machek <pavel@denx.de> wrote:
> Also... explanation why you need this syscall while other
> architectures live happily without it would be nice.

12 our of 28 architectures provide such a syscall...

Is flushing the cache a privileged operation on nios2?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
