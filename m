Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262642AbUKEJxQ@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:21395 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262632AbUKEJxP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Nov 2004 04:53:15 -0500
Date: Fri, 5 Nov 2004 10:53:12 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: Fw: 2.6.10-rc1-mm3
Message-ID: <20041105095312.GH16992@wotan.suse.de>
References: <20041105005257.2dc4408e.akpm@osdl.org> <20041105091824.GE16992@wotan.suse.de> <Pine.GSO.4.61.0411051023520.15464@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0411051023520.15464@waterleaf.sonytel.be>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Nov 05, 2004 at 10:26:57AM +0100, Geert Uytterhoeven wrote:
> On Fri, 5 Nov 2004, Andi Kleen wrote:
> > On Fri, Nov 05, 2004 at 12:52:57AM -0800, Andrew Morton wrote:
> > > Guys, just a heads up on the 4-level pagetable stuff.  If you haven't yet
> > > checked it out, please do so.
> > 
> > I think I converted everybody except for UML and mips, but not every architecture 
> 
> m68k seems to be missing ;-)

Oh, yes I think I frightened back from the messy sun3 code. 

The conversion would be slightly messy because you don't use init_mm for the kernel.
Is that really needed? The change would be cleaner if that was fixed first.

-Andi
