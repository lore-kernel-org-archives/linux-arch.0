Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 15 Sep 2005 17:42:19 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC] killing linux/irq.h
Message-ID: <20050915164219.GA31805@infradead.org>
References: <20050909184254.GT9623@ZenIV.linux.org.uk> <Pine.LNX.4.62.0509110949390.30752@numbat.sonytel.be> <20050915163455.GD16698@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050915163455.GD16698@parisc-linux.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, viro@ZenIV.linux.org.uk, Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Sep 15, 2005 at 10:34:55AM -0600, Matthew Wilcox wrote:
> On Sun, Sep 11, 2005 at 09:50:38AM +0200, Geert Uytterhoeven wrote:
> > On Fri, 9 Sep 2005 viro@ZenIV.linux.org.uk wrote:
> > > 	We get regular portability bugs when somebody decides to include
> > > linux/irq.h into a driver instead of asm/irq.h.  It's almost always a
> > > wrong thing to do and, in fact, causes immediate breakage on e.g. arm.
> > 
> > Wouldn't it be more logical to make linux/irq.h the preferred include?
> > Usually the linux/* versions are preferred over the asm/* versions.
> 
> There's almost no reason to want <*/irq.h> in the first place.  Almost
> all drivers really want <linux/interrupt.h>

Umm, no.  <linux/interrupt.h> doesn't include <asm/irq.h> and variours
achitectures have important prototypes in there.
