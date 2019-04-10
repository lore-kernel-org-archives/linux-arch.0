Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728881AbfDJM2l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Apr 2019 08:28:41 -0400
Date: Wed, 10 Apr 2019 13:28:34 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 01/21] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190410122834.GB21169@fuggles.cambridge.arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
 <20190405135936.7266-2-will.deacon@arm.com>
 <20190410105833.GA116161@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410105833.GA116161@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190410122834.r8xIwNni706C4GqLf6APOLgxwuPpqAM3BH1i0bmu4fs@z>

Hi Ingo,

Thanks for taking a look (diff at the end).

On Wed, Apr 10, 2019 at 12:58:33PM +0200, Ingo Molnar wrote:
> * Will Deacon <will.deacon@arm.com> wrote:
> 
> > + (*) readX(), writeX():
> >  
> > +     The readX() and writeX() MMIO accessors take a pointer to the peripheral
> > +     being accessed as an __iomem * parameter. For pointers mapped with the
> > +     default I/O attributes (e.g. those returned by ioremap()), then the
> > +     ordering guarantees are as follows:
> 
> s/then the
>  /the

Fixed.

> > +     1. All readX() and writeX() accesses to the same peripheral are ordered
> > +        with respect to each other. For example, this ensures that MMIO register
> > +	writes by the CPU to a particular device will arrive in program order.
> 
> Vertical alignment whitespace damage: some indentations are done via 
> spaces, one via tabs. Please standardize to tabs.

Fixed.

> I'd also suggest:
> 
> s/For example, this ensures
>  /For example this ensures

I'll just drop the "For example, " prefix altogether.

> > +     4. A readX() by the CPU from the peripheral will complete before any
> > +	subsequent delay() loop can begin execution. For example, this ensures
> > +	that two MMIO register writes by the CPU to a peripheral will arrive at
> > +	least 1us apart if the first write is immediately read back with readX()
> > +	and udelay(1) is called prior to the second writeX().
> 
> This might be more readable via some short code sequence instead?

Fixed.

> > +     __iomem pointers obtained with non-default attributes (e.g. those returned
> > +     by ioremap_wc()) are unlikely to provide many of these guarantees.
> 
> This part is a bit confusing I think, because it's so cryptic. "Unlikely" 
> as in probabilistic? ;-) So I think we should at least give some scope of 
> the exceptions and expected trouble, or at least direct people to those 
> APIs to see what the semantics are?

Right, so I'm trying to tackle the common case of ioremap() in this patch.
There isn't an agreed portable semantics for ioremap_wc() yet, so I'm taking
a punt for now but it's something I'd like to get back to in the future.
I've tried to clean up the wording in the diff below to spell out that
this this is currently arch-specific.

> >  
> > + (*) readX_relaxed(), writeX_relaxed():
> >  
> > +     These are similar to readX() and writeX(), but provide weaker memory
> > +     ordering guarantees. Specifically, they do not guarantee ordering with
> > +     respect to normal memory accesses or delay() loops (i.e bullets 2-4 above)
> > +     but they are still guaranteed to be ordered with respect to other accesses
> > +     to the same peripheral when operating on __iomem pointers mapped with the
> > +     default I/O attributes.
> >  
> > + (*) readsX(), writesX():
> >  
> > +     The readsX() and writesX() MMIO accessors are designed for accessing
> > +     register-based, memory-mapped FIFOs residing on peripherals that are not
> > +     capable of performing DMA. Consequently, they provide only the ordering
> > +     guarantees of readX_relaxed() and writeX_relaxed(), as documented above.
> 
> So is there any difference between 'X_relaxed' and 'sX' variants? What is 
> the 's' about?
