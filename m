Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:56509 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751062AbWEQUGE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 May 2006 16:06:04 -0400
Date: Wed, 17 May 2006 22:06:00 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch] s390 kconfig cleanup.
In-Reply-To: <1147884656.5540.28.camel@localhost>
Message-ID: <Pine.LNX.4.62.0605172203590.22663@pademelon.sonytel.be>
References: <20060515171645.GA11397@skybase> <20060517132501.GC1604@parisc-linux.org>
 <1147884656.5540.28.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 17 May 2006, Martin Schwidefsky wrote:
> On Wed, 2006-05-17 at 07:25 -0600, Matthew Wilcox wrote: 
> > > @@ -824,6 +827,7 @@ config DTLK
> > >  
> > >  config R3964
> > >  	tristate "Siemens R3964 line discipline"
> > > +	depends on !S390
> > >  	---help---
> > >  	  This driver allows synchronous communication with devices using the
> > >  	  Siemens R3964 packet protocol. Unless you are dealing with special
> > 
> > I'd be tempted to not bother adding a depends here ... it won't do any
> > harm; it's not controlling hardware after all.
> 
> Seems out of place to me. But we have a bunch of other strange config
> options as well, e.g. support for the Amiga AFFS filesystem. Anybody
> who wants to attach an Amiga disk to a mainframe?

Or a disk image using the loop device?

You can use the same reasoning against any non-native Linux file system...

But compiling too many file systems doesn't hurt, it even gives us extra
compile coverage ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
