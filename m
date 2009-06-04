From: "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
Subject: RE: [Ksummit-2009-discuss] Representing Embedded Architectures at the Kernel Summit
Date: Wed, 3 Jun 2009 23:11:13 -0400
Message-ID: <FF038EB85946AA46B18DFEE6E6F8A2890151520C@xmb-rtp-218.amer.cisco.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com><1244034286.24482.84.camel@pc1117.cambridge.arm.com><1244045997.21423.303.camel@mulgrave.site><20090603170925.GA8330@flint.arm.linux.org.uk> <20090603114344.bf852654.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:44454 "EHLO
	rtp-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbZFDDUr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2009 23:20:47 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20090603114344.bf852654.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Russell King <rmk@arm.linux.org.uk>
Cc: James.Bottomley@HansenPartnership.com, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, ksummit-2009-discuss@lists.linux-foundation.org

David Delaney has a proof-of-concept of an idea of his which was
presented at the last CELF, which is basically to put the kernel and
loadable kernel modules closely enough together that you can avoid the
use of long jumps. He sees a better than 1% improvement in performance,
which we've duplicated using a slightly different approach. This is nice
payback for little work and, though it doesn't help on all processors,
it helps on several.

The problem is: how do you allocate memory with the magical "close to
the kernel" attribute? We have something that adds a new ZONE_KERNEL
(this name has some problems, actually). It seems like a pretty good
solution if you look at zones as conceptually concentric usages, but
with the current zone implementation, each zone must be contiguous. So,
if we're talking about changing what zones are done, I'd like to throw
this into the pot.

> -----Original Message-----
> From: linux-embedded-owner@vger.kernel.org 
> [mailto:linux-embedded-owner@vger.kernel.org] On Behalf Of 
> Andrew Morton
> Sent: Wednesday, June 03, 2009 11:44 AM
> To: Russell King
> Cc: James.Bottomley@HansenPartnership.com; 
> linux-arch@vger.kernel.org; linux-embedded@vger.kernel.org; 
> ksummit-2009-discuss@lists.linux-foundation.org
> Subject: Re: [Ksummit-2009-discuss] Representing Embedded 
> Architectures at the Kernel Summit
> 
> On Wed, 3 Jun 2009 18:09:25 +0100
> Russell King <rmk@arm.linux.org.uk> wrote:
> 
> > In
> > fact, on ARM the DMA mask is exactly that - it's a 100% 
> proper mask.  It's
> > not a bunch of zeros in the MSB followed by a bunch of ones 
> down to the
> > LSB.  It can be a bunch of ones, a bunch of zeros, followed 
> by a bunch of
> > ones.
> > 
> > The way we occasionally have to deal with this is to trial 
> an allocation,
> > see if the physical address fits, if not free the page and 
> try again with
> > GFP_DMA set.
> 
> A couple of times I've suggested that we have the ability to allocate
> one zone per address bit, so a 32-bit machine with 4k pages would end
> up having 20 zones.  Then, your funny DMA mask can be directly passed
> into the page allocator as a zone mask and voila, I think.
> 
> > There's many stories I've heard on what is supposed to take 
> care of the
> > coherency that I now just close my ears to the problem and chant "it
> > doesn't exist, people aren't seeing it, mainline folk just 
> don't give
> > a damn".  Really.  It is a problem on _some_ ARM devices 
> and has been
> > for several years now, and I've 100% given up caring about it.
> 
> I wasn't even aware that there was an issue here.  Please don't blame
> "mainline folk" for something they weren't told about!
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-embedded" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
