Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268200AbUJTPSR@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:39613 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268166AbUJTPSA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Oct 2004 11:18:00 -0400
Date: Wed, 20 Oct 2004 17:17:40 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
Subject: Re: 4level page tables architecture porting
In-Reply-To: <200410201706.00435.arnd@arndb.de>
Message-ID: <Pine.GSO.4.61.0410201714490.6837@waterleaf.sonytel.be>
References: <20041020131340.GA5282@mschwid3.boeblingen.de.ibm.com>
 <20041020143949.GB32257@wotan.suse.de> <200410201706.00435.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andi Kleen <ak@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 20 Oct 2004, Arnd Bergmann wrote:
> On Middeweken 20 Oktober 2004 16:39, Andi Kleen  wrote:
> > BTW
> > The motivation for really large address space spaces is actually not really
> > to use that much memory, but just to be able to mmap extremly large
> > files. The original reason I started this was because some users wanted
> > to mmap 300GB files and it didn't work because the shared
> > libraries were in the way. So if you consider that it may be worth
> > enlarging it at some point anyways.
> 
> Doesn't that mean spending another page for each running process? I would
> rather like to see a way to use a dynamic page table layout, where 32 bit
> tasks always use only two level page tables, while 64 bit tasks start
> with two or three levels and then go to four or five levels when users
> map files that don't fit in.

That's a bit like the extension blocks for files in file systems. If you need a
larger file size, add extension blocks containing (double/triple/...) indirect
pointers to more data blocks.

> Which architectures are actually capable of doing this? It's probably
> not worth spending much work on that if it's an s390 only thing.

I guess most RISC architectures that use software TLB refill can use whatever
scheme you want.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
