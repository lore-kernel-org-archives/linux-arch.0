Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:60060 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755846AbZFIRw7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2009 13:52:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 22/27] score: create kernel files signal.c sys_score.c time.c
Date: Tue, 9 Jun 2009 19:52:47 +0200
References: <OF32AB4A20.4574C065-ON482575D0.00243CB1-482575D0.0024AD26@sunplusct.com>
In-Reply-To: <OF32AB4A20.4574C065-ON482575D0.00243CB1-482575D0.0024AD26@sunplusct.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <200906091952.47842.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org
Message-ID: <20090609175247.76-sHYHXN8PSOeAzPqxv8NbBc-waf6R-OoItiaLOM_g@z>

On Tuesday 09 June 2009, liqin.chen@sunplusct.com wrote:
> +asmlinkage long sys_mmap(unsigned long addr, size_t len,
> +                       unsigned long prot, unsigned long flags,
> +                       unsigned long fd, off_t offset)
> +{
> +       int err = -EINVAL;
> +
> +       if (offset & ~PAGE_MASK) {
> +               printk(KERN_INFO "no pagemask in mmap\r\n");
> +               goto out;
> +       }
> +
> +       err = sys_mmap2(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
> +out:
> +       return err;
> +}

A 32 bit kernel should only need sys_mmap2, not sys_mmap, because it is
trivial to convert in user space.

> +
> +asmlinkage long score_vfork(struct pt_regs *regs)
> +{
> +       return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs->regs[0],
> +                                               regs, 0, NULL, NULL);
> +}
> +
> +/*
> + * Fork a new task - this creates a new program thread.
> + * This is called indirectly via a small wrapper
> + */
> +asmlinkage int
> +score_fork(struct pt_regs *regs)
> +{
> +       return do_fork(SIGCHLD, regs->regs[0], regs, 0, NULL, NULL);
> +}

Similarly, you should not need vfork and fork any more, because they can
be handled in user space through clone().

	Arnd <><
