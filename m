Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be ([80.88.33.193]:63881 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263734AbUELUt7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 12 May 2004 16:49:59 -0400
Date: Wed, 12 May 2004 22:49:28 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
Subject: Re: Implement print_modules()
In-Reply-To: <20040512124910.0af06300.akpm@osdl.org>
Message-ID: <Pine.GSO.4.58.0405122247130.29476@waterleaf.sonytel.be>
References: <20040512173905.GA24382@devserv.devel.redhat.com>
 <20040512124910.0af06300.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Paul Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 12 May 2004, Andrew Morton wrote:
> Arjan van de Ven <arjanv@redhat.com> wrote:
> > the patch below resolves the "Not Yet Implemented" print_modules() thing.
> > This is a really useful feature for distros; it allows us to do statistical
> > analysis on which modules are present how often in oopses compared to how
> > often they are used normally.
> > In addition it helps to spot candidates for certain bugs without having to
> > go back to the customer asking for this information.
> >
>
> OK.  Only three architectures are calling print_modules() at this time.
> arch maintainers should consider adding a call.  We have a stub at present
> so the change can go in any time.

This (untested) one should do the trick for m68k:

--- linux-2.6.6/arch/m68k/kernel/traps.c	2004-05-03 11:01:24.000000000 +0200
+++ linux-m68k-2.6.6/arch/m68k/kernel/traps.c	2004-05-12 22:44:39.000000000 +0200
@@ -1187,6 +1187,7 @@ void die_if_kernel (char *str, struct pt

 	console_verbose();
 	printk("%s: %08x\n",str,nr);
+	print_modules();
 	printk("PC: [<%08lx>]",fp->pc);
 	print_symbol(" %s\n", fp->pc);
 	printk("\nSR: %04x  SP: %p  a2: %08lx\n",

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
