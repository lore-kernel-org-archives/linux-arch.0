Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262634AbUKEJ1U@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:34769 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262631AbUKEJ1U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Nov 2004 04:27:20 -0500
Date: Fri, 5 Nov 2004 10:26:57 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
Subject: Re: Fw: 2.6.10-rc1-mm3
In-Reply-To: <20041105091824.GE16992@wotan.suse.de>
Message-ID: <Pine.GSO.4.61.0411051023520.15464@waterleaf.sonytel.be>
References: <20041105005257.2dc4408e.akpm@osdl.org> <20041105091824.GE16992@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 5 Nov 2004, Andi Kleen wrote:
> On Fri, Nov 05, 2004 at 12:52:57AM -0800, Andrew Morton wrote:
> > Guys, just a heads up on the 4-level pagetable stuff.  If you haven't yet
> > checked it out, please do so.
> 
> I think I converted everybody except for UML and mips, but not every architecture 

m68k seems to be missing ;-)

> has been compiled or booted.  The changes are quite straight forward 
> if something is still needed.

If you have a patch for m68k, I'd be glad to give it a try (at least compile,
booting depends on the (currently untested by me) status of post-2.6.8.1).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
