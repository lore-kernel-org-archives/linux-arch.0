From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 21/29] score: Use generic init_task
Date: Mon, 30 Apr 2012 22:38:50 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1204302238120.6271@ionos>
References: <20120430194725.763322463@linutronix.de> <20120430194846.862605948@linutronix.de> <4F9EF43C.3090608@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35968 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756716Ab2D3Uix (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Apr 2012 16:38:53 -0400
In-Reply-To: <4F9EF43C.3090608@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Chen Liqin <liqin.chen@sunplusct.com>

On Mon, 30 Apr 2012, KOSAKI Motohiro wrote:

> (4/30/12 4:16 PM), Thomas Gleixner wrote:
> > Same code. Use the generic version.
> > 
> > Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> > Cc: Chen Liqin<liqin.chen@sunplusct.com>
> > ---
> >   arch/score/Kconfig         |    1 +
> >   arch/score/kernel/Makefile |    2 +-
> >   2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > Index: tip/arch/score/Kconfig
> > ===================================================================
> > --- tip.orig/arch/score/Kconfig
> > +++ tip/arch/score/Kconfig
> > @@ -9,6 +9,7 @@ config SCORE
> >          select HAVE_MEMBLOCK_NODE_MAP
> >          select ARCH_DISCARD_MEMBLOCK
> >          select GENERIC_CPU_DEVICES
> > +       select HAVE_GENERIC_INIT_TASK
> > 
> >   choice
> >   	prompt "System type"
> > Index: tip/arch/score/kernel/Makefile
> > ===================================================================
> > --- tip.orig/arch/score/kernel/Makefile
> > +++ tip/arch/score/kernel/Makefile
> > @@ -4,7 +4,7 @@
> > 
> >   extra-y	:= head.o vmlinux.lds
> > 
> > -obj-y += entry.o init_task.o irq.o process.o ptrace.o \
> > +obj-y += entry.o irq.o process.o ptrace.o \
> >   	setup.o signal.o sys_score.o time.o traps.o \
> >   	sys_call_table.o
> 
> Almost patches delete arch specific init-task. But this patch doesn't.
> Is this really intentional?

Not really. I missed it :( Will fix.

Thanks,

	tglx
