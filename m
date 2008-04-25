Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from edna.telenet-ops.be ([195.130.132.58]:47835 "EHLO
	edna.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbYDYLce (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Apr 2008 07:32:34 -0400
Date: Fri, 25 Apr 2008 13:32:28 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [microblaze-uclinux] Re: microblaze syscall list
In-Reply-To: <20080425100614.GB14990@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0804251331230.29595@anakin>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com>
 <200804221515.28075.arnd@arndb.de> <480FA729.3000406@seznam.cz>
 <200804241311.09881.arnd@arndb.de> <4810D4A4.7050900@seznam.cz>
 <4811A623.80104@itee.uq.edu.au> <20080425100614.GB14990@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: John Williams <jwilliams@itee.uq.edu.au>, microblaze-uclinux@itee.uq.edu.au, Arnd Bergmann <arnd@arndb.de>, Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, git@xilinx.com
Message-ID: <20080425113228.7NTHMBJrePiUcrQuA-2ggFnoAzw7PLYf8YJJDfNuqKo@z>

On Fri, 25 Apr 2008, Matthew Wilcox wrote:
> On Fri, Apr 25, 2008 at 07:36:35PM +1000, John Williams wrote:
> > Please remember that MicroBlaze has been around as an arch for > 4 
> > years, just not in the kernel.org tree.  These older style syscall 
> > interfaces are all part of the uClibc and glibc ports for MicroBlaze.
> 
> So is it fair to say that you now understand this was the Wrong Way To
> Do Things, and if anyone asks, you'd recommend getting an arch merged
> into kernel.org sooner rather than later?

It's also an indicator we should have an asm-generic/unistd.h ASAP (as
Arnd suggested), to make sure future archs don't make the same mistake
over and over again.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
