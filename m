Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:39657 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1753940AbWKGBij (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 6 Nov 2006 20:38:39 -0500
Date: Tue, 7 Nov 2006 02:37:46 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Which architectures need 64-bit resources?
In-Reply-To: <20061106163243.GN27140@parisc-linux.org>
Message-ID: <Pine.LNX.4.62.0611070218590.28657@pademelon.sonytel.be>
References: <20061106122337.GK27140@parisc-linux.org> <20061106160206.GA10447@linux-mips.org>
 <20061106163243.GN27140@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-arch@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 6 Nov 2006, Matthew Wilcox wrote:
> On Mon, Nov 06, 2006 at 04:02:06PM +0000, Ralf Baechle wrote:
> > On Mon, Nov 06, 2006 at 05:23:37AM -0700, Matthew Wilcox wrote:
> > 
> > > +       bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (!64BIT && (ARM || X86 || MIPS || PPC) && EXPERIMENTAL)
> > 
> > For MIPS at least it would be needed for a few platforms only, so I'd
> > like to do "select RESOURCES_64BIT" as suitable for a platform. in the
> > big machine selection menu in arch/mips/Kconfig.
> 
> I don't see why you shouldn't do that anyway ... seems like ARM wants to
> do the same thing.  In fact, I'd go so far as to say this isn't an option
> that users should ever be asked.  You can tell by the help text for it:

Ah, good that the `possibility' of 64-bit resources on m68k goes away, and I
haven't `fixed' all those printf() format warnings yet...

Speaking about that: how many recently-added silencing casts should be removed
on platforms without 64-bit resources?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
