From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [PATCH] Microblaze: implement dma-coherent API andrefactorcache
 flush code.
Date: Tue, 6 May 2008 09:23:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0805060923100.3160@anakin>
References: <20080505223706.1236C1C8004E@mail131-sin.bigfish.com>
 <1210028237.5798.121.camel@localhost> <20080505231206.922A61C780C0@mail19-wa4.bigfish.com>
 <1210032899.5798.179.camel@localhost> <20080506003104.4717D19B8050@mail213-sin.bigfish.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wilson.telenet-ops.be ([195.130.132.42]:54784 "EHLO
	wilson.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbYEFHXp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 03:23:45 -0400
In-Reply-To: <20080506003104.4717D19B8050@mail213-sin.bigfish.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Cc: John Williams <john.williams@petalogix.com>, arnd@arndb.de, linux-arch@vger.kernel.org, John Linn <linnj@xilinx.com>, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org

On Mon, 5 May 2008, Stephen Neuendorffer wrote:
> > -----Original Message-----
> > From: John Williams [mailto:john.williams@petalogix.com]
> > 
> > Sure - what I meant is can dma_alloc just call kmalloc to do it's
> work?
> 
> I scanned through Linux Device Drivers, and it appears that calling
> get_free_pages is:
> 1) more efficient than kmalloc for large allocations
> 2) allocates physically contiguous memory, which kmalloc doesn't
> necessarily do if there's an mmu.

kmalloc() allocates physically contiguous memory, vmalloc() doesn't.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
