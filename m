From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [microblaze-uclinux] Re: microblaze syscall list
Date: Fri, 25 Apr 2008 13:32:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804251331230.29595@anakin>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com>
 <200804221515.28075.arnd@arndb.de> <480FA729.3000406@seznam.cz>
 <200804241311.09881.arnd@arndb.de> <4810D4A4.7050900@seznam.cz>
 <4811A623.80104@itee.uq.edu.au> <20080425100614.GB14990@parisc-linux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080425100614.GB14990-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: John Williams <jwilliams-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org>, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, git-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org

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
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
