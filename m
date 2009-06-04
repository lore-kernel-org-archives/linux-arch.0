From: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
	the Kernel Summit
Date: Thu, 4 Jun 2009 10:23:48 +0100
Message-ID: <20090604092348.GC17321@csn.ul.ie>
References: <20090603114344.bf852654.akpm@linux-foundation.org> <FF038EB85946AA46B18DFEE6E6F8A2890151520C@xmb-rtp-218.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-embedded-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <FF038EB85946AA46B18DFEE6E6F8A2890151520C@xmb-rtp-218.amer.cisco.com>
Sender: linux-embedded-owner@vger.kernel.org
To: "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King <rmk@arm.linux.org.uk>, James.Bottomley@hansenpartnership.com, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, ksummit-2009-discuss@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 03, 2009 at 11:11:13PM -0400, David VomLehn (dvomlehn) wrote:
> David Delaney has a proof-of-concept of an idea of his which was
> presented at the last CELF, which is basically to put the kernel and
> loadable kernel modules closely enough together that you can avoid the
> use of long jumps. He sees a better than 1% improvement in performance,
> which we've duplicated using a slightly different approach. This is nice
> payback for little work and, though it doesn't help on all processors,
> it helps on several.
> 
> The problem is: how do you allocate memory with the magical "close to
> the kernel" attribute? We have something that adds a new ZONE_KERNEL
> (this name has some problems, actually).

As this is about addresses of text, I imagine that you really care about the
virtual address the module is loaded at which is what the virtual address
space is responsible for and not the physical addresses which zones are
concerned with. Would that be right?

If that was the case, this could be potentially be done by moving where
the vmalloc address space is located or possibly splitting it in two. By
locating some portion of the vmalloc address space above the kernel
image, the kernel modules could be loaded in there.

It's different for the DMA problem, it really requires particular physical
addresses. No one trying to implementat Andrew's suggestion is a bit of a
surprise because basically, it'd do the job as far as I can see but is not
an issue that hurts me so I never sat down to try implementing it. Granted,
increasing the number of zones adds its own problem but it's for large numbers
of zones and there are other things that could be done to the allocator to
reduce its cache footprint. The big plus is that it plays very well with
reclaim and I would expect it to perform better than than searching the
free lists for a suitable page which would be a bit of a hatchet job.

> It seems like a pretty good
> solution if you look at zones as conceptually concentric usages, but
> with the current zone implementation, each zone must be contiguous. So,
> if we're talking about changing what zones are done, I'd like to throw
> this into the pot.
> 
> > -----Original Message-----
> > From: linux-embedded-owner@vger.kernel.org 
> > [mailto:linux-embedded-owner@vger.kernel.org] On Behalf Of 
> > Andrew Morton
> > Sent: Wednesday, June 03, 2009 11:44 AM
> > To: Russell King
> > Cc: James.Bottomley@HansenPartnership.com; 
> > linux-arch@vger.kernel.org; linux-embedded@vger.kernel.org; 
> > ksummit-2009-discuss@lists.linux-foundation.org
> > Subject: Re: [Ksummit-2009-discuss] Representing Embedded 
> > Architectures at the Kernel Summit
> > 
> > On Wed, 3 Jun 2009 18:09:25 +0100
> > Russell King <rmk@arm.linux.org.uk> wrote:
> > 
> > > In
> > > fact, on ARM the DMA mask is exactly that - it's a 100% 
> > proper mask.  It's
> > > not a bunch of zeros in the MSB followed by a bunch of ones 
> > down to the
> > > LSB.  It can be a bunch of ones, a bunch of zeros, followed 
> > by a bunch of
> > > ones.
> > > 
> > > The way we occasionally have to deal with this is to trial 
> > an allocation,
> > > see if the physical address fits, if not free the page and 
> > try again with
> > > GFP_DMA set.
> > 
> > A couple of times I've suggested that we have the ability to allocate
> > one zone per address bit, so a 32-bit machine with 4k pages would end
> > up having 20 zones.  Then, your funny DMA mask can be directly passed
> > into the page allocator as a zone mask and voila, I think.
> > 
> > > There's many stories I've heard on what is supposed to take 
> > care of the
> > > coherency that I now just close my ears to the problem and chant "it
> > > doesn't exist, people aren't seeing it, mainline folk just 
> > don't give
> > > a damn".  Really.  It is a problem on _some_ ARM devices 
> > and has been
> > > for several years now, and I've 100% given up caring about it.
> > 
> > I wasn't even aware that there was an issue here.  Please don't blame
> > "mainline folk" for something they weren't told about!
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-embedded" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> _______________________________________________
> Ksummit-2009-discuss mailing list
> Ksummit-2009-discuss@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/ksummit-2009-discuss
> 

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
