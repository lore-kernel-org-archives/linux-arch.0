Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org ([63.228.1.57]:43229 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263397AbUCPBiR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Mar 2004 20:38:17 -0500
Subject: Re: More DMA API junk
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1079399555.1804.232.camel@mulgrave>
References: <1079398383.1968.205.camel@gaston>
	 <1079399555.1804.232.camel@mulgrave>
Content-Type: text/plain
Message-Id: <1079400742.1968.209.camel@gaston>
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 12:32:23 +1100
Content-Transfer-Encoding: 7bit
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2004-03-16 at 12:12, James Bottomley wrote:
> On Mon, 2004-03-15 at 19:53, Benjamin Herrenschmidt wrote:
> >  - dma_is_consistent(dma_addr_t address) : Did somebody actually expect
> > anything useful out of this function ? AFAIK, it makes no sense. There
> > is simply no way an arch like ppc that use per-page cache-inhibit
> > mappings to do consistent memory will be able to tell you if a given
> > _DMA_ address is consistent... that makes no sense.
> 
> >  - dma_cache_sync(): What is that function supposed to do ? It's a
> > duplicate of the other sync() functions and David didn't even bother
> > turning it into _for_device/for_cpu... which is fine since it doesn't
> > even takes a struct device argument.
> 
> They are both used.  Look at section II of DMA-API.txt.cd ..

I've looked and I couldn't find a proper meaning for them.

> They have to do with incoherent platforms which I assume you don't have,
> but just leave them alone for those of use who are so burdened.

We do have incoherent PPCs (the embedded ones)

> Actually, I was planning to update dma_cache_sync to take a device and
> to conform to the new style (except I was thinking of an ownership flag
> rather than introducing two more APIs).  The lack of device to
> dma_cache_sync is probably irrelevant since they only apply to older
> arch's which don't have bus caches.

How can dma_is_consistent() be implemented at all on an arch that
implement consistency by allocating non-cacheable space using PTE
bits ? we just cannot know if a given dma_addr_t is mapped by the
kernel using a cacheable or non-cacheable (or both) mapping.

Regarding dma_cache_sync(), I still don't understand what it means
and what it should be used for. We have dma_consistent_sync_*,
care to explain in which cases those aren't useable and one would
have to call dma_cache_sync() ?

Ben.
