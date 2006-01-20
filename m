Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:16823 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1750885AbWATMLQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Jan 2006 07:11:16 -0500
Date: Fri, 20 Jan 2006 13:10:36 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: sys_pciconfig_{read,write}
In-Reply-To: <20060120.020032.119957438.davem@davemloft.net>
Message-ID: <Pine.LNX.4.62.0601201310140.30721@pademelon.sonytel.be>
References: <20060109162718.GP19769@parisc-linux.org>
 <20060120.020032.119957438.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: matthew@wil.cx, linux-arch@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, cneira@srb.cl
List-ID: <linux-arch.vger.kernel.org>

On Fri, 20 Jan 2006, David S. Miller wrote:
> From: Matthew Wilcox <matthew@wil.cx>
> Date: Mon, 9 Jan 2006 09:27:18 -0700
> 
> [ Going through some old emails I intended to get to before
>   heading off to linux.conf.au :-) ]
> 
> > So I propose the following three patches:
> > 
> > 1/ New Kconfig symbol CONFIG_PCI_SYSCALLS to be defined by the above
> > architectures.  Makefile altered accordingly.
> > 
> > 2/ Removal of BKL from syscall implementation.
> > 
> > 3/ Removal of !CONFIG_PCI pciconfig stubs from alpha, ia64 and sparc64
> > (we already have cond_syscalls for them).
> 
> Sounds fine to me.
> 
> > I don't quite understand why we need
> > compat_sys_pciconfig_{read,write,iobase} on ppc64.  Can't these just
> > call the normal versions?
> 
> I don't see this in the current tree, were they removed as
> a result of this observation?

IIRC, yes they were removed a few days later.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
