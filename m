From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 22/27] score: create kernel files signal.c sys_score.c time.c
Date: Tue, 9 Jun 2009 19:52:47 +0200
Message-ID: <200906091952.47842.arnd@arndb.de>
References: <OF32AB4A20.4574C065-ON482575D0.00243CB1-482575D0.0024AD26@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757955AbZFIRxS@vger.kernel.org>
In-Reply-To: <OF32AB4A20.4574C065-ON482575D0.00243CB1-482575D0.0024AD26@sunplusct.com>
Sender: linux-kernel-owner@vger.kernel.org
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

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
