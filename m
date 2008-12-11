From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 00/19] unify init_task
Date: Thu, 11 Dec 2008 15:02:54 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812111501360.13379@anakin>
References: <cover.1228966585.git.kyle@mcmartin.ca> <Pine.LNX.4.64.0812110956410.7310@anakin>
 <200812111421.46688.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from edna.telenet-ops.be ([195.130.132.58]:52150 "EHLO
	edna.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834AbYLKOC4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2008 09:02:56 -0500
In-Reply-To: <200812111421.46688.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kyle McMartin <kyle@mcmartin.ca>, linux-arch@vger.kernel.org

On Thu, 11 Dec 2008, Arnd Bergmann wrote:
> On Thursday 11 December 2008, Geert Uytterhoeven wrote:
> > > Unconverted architectures so far are m68k (because it doesn't use an explicit
> > > init_task.c), ia64 (because it faffs about with init_thread_union), and
> > > sparc{,64} (which appear to rely on some magic.)
> > 
> > m68k just has the same code as anyone else embedded in
> > arch/m68k/kernel/process.c.
> 
> There is an extra aligned(THREAD_SIZE))) attribute in the m68k thread_info
> definition, just like sparc and mips. Are you sure that removing it is
> safe on m68k?

Thanks, I missed that one. I should have launched `diff' instead of my own
eyes...

Wondering, would it harm a lot having the aligned(THREAD_SIZE) everywhere?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
