From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 21/27] score: create kernel files ptrace.c setup.c
Date: Mon, 15 Jun 2009 07:02:40 -0400
Message-ID: <20090615110240.GA16735@infradead.org>
References: <OF9E916A44.859476BA-ON482575D0.00243015-482575D0.0024A03A@sunplusct.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:39676 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbZFOLCj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jun 2009 07:02:39 -0400
Content-Disposition: inline
In-Reply-To: <OF9E916A44.859476BA-ON482575D0.00243015-482575D0.0024A03A@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

On Tue, Jun 09, 2009 at 02:35:45PM +0800, liqin.chen@sunplusct.com wrote:
> +long
> +arch_ptrace(struct task_struct *child, long request, long addr, long 
> data)
> +{
> +       int ret;
> +
> +       if (request == PTRACE_TRACEME) {
> +               /* are we already being traced? */
> +               if (current->ptrace & PT_PTRACED)
> +                       return -EPERM;
> +
> +               /* set the ptrace bit in the process flags. */
> +               current->ptrace |= PT_PTRACED;
> +               return 0;
> +       }
> +
> +       ret = -ESRCH;
> +       if (!child)
> +               return ret;
> +
> +       ret = -EPERM;
> +
> +       if (request == PTRACE_ATTACH) {
> +               ret = ptrace_attach(child);
> +               return ret;
> +       }
> +
> +       ret = ptrace_check_attach(child, request == PTRACE_KILL);
> +       if (ret < 0)
> +               return ret;
> +

All this stuff has been done by generic ptrace code for a long time
and is not needed at all.

> +       switch (request) {
> +       case PTRACE_PEEKTEXT: /* read word at location addr. */
> +       case PTRACE_PEEKDATA: {
> +               unsigned long tmp;
> +               int copied;
> +
> +               copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 
> 0);
> +               ret = -EIO;
> +               if (copied != sizeof(tmp))
> +                       break;
> +
> +               ret = put_user(tmp, (unsigned long *) data);
> +               return ret;
> +       }
> +

This also has a generic implementation.  Please take a look at a modern
ptrace implementation like sh, powerpc or x86 to model yours after.
