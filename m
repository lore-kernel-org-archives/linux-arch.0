From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
 the Kernel Summit
Date: Wed, 03 Jun 2009 19:01:02 +0000
Message-ID: <1244055662.3527.14.camel@mulgrave.site>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	 <1244034286.24482.84.camel@pc1117.cambridge.arm.com>
	 <1244045997.21423.303.camel@mulgrave.site>
	 <20090603170925.GA8330@flint.arm.linux.org.uk>
	 <20090603114344.bf852654.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <20090603114344.bf852654.akpm@linux-foundation.org>
Sender: linux-embedded-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, ksummit-2009-discuss@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On Wed, 2009-06-03 at 11:43 -0700, Andrew Morton wrote:
> On Wed, 3 Jun 2009 18:09:25 +0100
> Russell King <rmk@arm.linux.org.uk> wrote:
> 
> > In
> > fact, on ARM the DMA mask is exactly that - it's a 100% proper mask.  It's
> > not a bunch of zeros in the MSB followed by a bunch of ones down to the
> > LSB.  It can be a bunch of ones, a bunch of zeros, followed by a bunch of
> > ones.
> > 
> > The way we occasionally have to deal with this is to trial an allocation,
> > see if the physical address fits, if not free the page and try again with
> > GFP_DMA set.
> 
> A couple of times I've suggested that we have the ability to allocate
> one zone per address bit, so a 32-bit machine with 4k pages would end
> up having 20 zones.  Then, your funny DMA mask can be directly passed
> into the page allocator as a zone mask and voila, I think.

The objection I heard to that one is that the zone machinery works
better with fewer zones ... but we could certainly align them along
known boundaries for allocations (if it's only bit X that's the problem,
say, you only need an additional zone covering that one).

Based on this, I dug up the initial proposal, it was the Ottawa Kernel
Summit in 2005 (I'm a packrat; I keep all my old presentations):

http://www.hansenpartnership.com/sites/hansenpartnership.com/files/jejb/kernel_summit_iommu.pdf

kmalloc_mask() is right at the end.  It basically died for lack of
interest and the fact that GFP_DMA32 satisfied 99% of the actual use
cases.

James
