Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 25 Feb 2005 22:48:09 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Changing  update_mmu_cache()
Message-ID: <20050225224809.F27842@flint.arm.linux.org.uk>
References: <1109047997.5327.70.camel@gaston> <20050222090741.B16786@flint.arm.linux.org.uk> <20050222100858.27d05a86.davem@davemloft.net> <20050225201538.B27842@flint.arm.linux.org.uk> <20050225134322.43274a9a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050225134322.43274a9a.akpm@osdl.org>; from akpm@osdl.org on Fri, Feb 25, 2005 at 01:43:22PM -0800
Sender: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: davem@davemloft.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Feb 25, 2005 at 01:43:22PM -0800, Andrew Morton wrote:
> Russell King <rmk@arm.linux.org.uk> wrote:
> >
> > The item I was referring to was my flush_cache_page() changes from
> >  January 11th (attached), posted to both linux-arch and lkml, and
> >  previous to that in November some time, along with Linus' reply,
> >  and my somewhat later reply.
> > 
> >  To be completely honest, because it has been such a long time since
> >  the solution was first developed, I no longer even know if this
> >  solution still works.  I also suspect, since I don't follow VM
> >  progress, that my knowledge of the VM is now rather out of date.
> > 
> >  On the plus side, a couple of architecture people have come forward
> >  to say that it could be beneficial to their architecture as well.
> > 
> >  I just find it extremely hard to do these architecture-wide changes
> >  and get them past Linus with little or no help from any other
> >  architecture people, especially when I'm then asked to prove that
> >  the changes do not hurt other architectures.
> > 
> >  I'm not really expecting anyone to do lots of hard work on this
> >  though... maybe just enough satisfaction feedback to from architecture
> >  people to Linus will be sufficient.
> > 
> >  The problem I now face is that we're almost at 2.6.11, and its been
> >  almost three months, so I think it's safe to assume that Linus will
> >  have forgotten everything about this, and will probably hate the
> >  patch next time around.  But maybe I'm underestimating Linus.
> 
> What does it do?  Just adds a pfn arg to flush_cache_page()?  We do that
> sort of thing quite a lot, and I can help.

Correct, and that's one of the small steps towards being able to map
the PFN in an architecture private mapping in such a way that it is
coherent with the alias we want to flush.

Essentially, ARM VIPT can only flush the whole cache, or a specific
set of cache lines determined by the VI and PT gained from a valid
page mapping.  What this gives us is the virtual address and the
pfn to be able to setup such a mapping, and flush the relevant
cache lines.


I'm sorry, I'm completely at the end of my rag over this.  I, for
one, can't operate with keeping up with the mainline kernel while
having these kinds of invasive patches outstanding for 4+ months
with zero help, and little prospect of them getting merged.

The same happened with the DMA mmap API.  With that, I've now
resorted to merging the ARM version of it and said "bugger the
other architectures."

What it basically comes down to is that a stable kernel series is
not the place for development.  It's obvious we're trying to meet
opposing demands with the existing development model, and it just
isn't working.  Well, it isn't for me at least.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
