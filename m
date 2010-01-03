From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHv2 2/5] parisc: add mm API for DMA to vmalloc/vmap areas
Date: Mon, 04 Jan 2010 07:12:52 +1100
Message-ID: <1262549572.2173.261.camel@pasglop>
References: <1261603345-2494-1-git-send-email-James.Bottomley@suse.de>
	 <1261603345-2494-2-git-send-email-James.Bottomley@suse.de>
	 <1261603345-2494-3-git-send-email-James.Bottomley@suse.de>
	 <1262467992.2173.247.camel@pasglop>
	 <1262469190.2741.27.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1262469190.2741.27.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-arch.vger.kernel.org

On Sat, 2010-01-02 at 15:53 -0600, James Bottomley wrote:
> 
> > See my other message on that subject but I believe this is a
> sub-optimal
> > semantic. I'd rather expose separately dma_vmap_sync_outbound vs.
> > dma_vma_sync_inboud_before vs. dma_vma_sync_inboud_after.
> 
> Well, this is such a micro optimisation, is it really worth it?

It's not that "micro" in the sense that flush can take significantly
longer than invalidate. Mostly a non issue except in network.... most
non cache coherent systems are low end and pretty sensitive to that sort
of stuff, especially when used as ... routers :-) But yes, it probably
doesn't matter in your current case of XFS vmap, I was mostly trying to
push toward generically exposing finer interfaces :-) And god knows
who'll use your vmap DMA APIs in the future.

> If I map exactly to architectural operations, it's flush (without
> invalidate if possible) before an outbound DMA transfer and nothing
> after.  For inbound, it's invalidate before and after (the after only
> assuming the architecture can do speculative move in), but doing a
> flush first instead of an invalidate on DMA inbound produces a correct
> result on architectures I know about.

It is correct. Just sub-optimal ;-) However it does handle another quirk
which is side effect on "edges". If all is well, the DMA buffer is
completely self contained in its own cache lines but experience shows
that isn't always the case and it might share a cache line on the edges
(typical with skb's).

This is of course utterly broken except in one case (which I -think- is
the case with skb's) where the data sharing the cache line isn't
accessed during the DMA transfer.

However, for that to work, as you can see, one needs to flush and not
invalidate the "edge" cache lines before the inbound transfer. So your
approach of flush + invalidate is "safer". But I'd still rather have the
semantic exposed at a higher level so that arch can decide what to use
and allow for the micro-optimisation...

> Your logic assumes the cache line is dirty.  If you look at the XFS
> usage, it never seems to do local modifications on a read, so the line
> should be clean.  At least on parisc, a flush of a clean cache line is
> exactly equivalent to an invalidate.  Even if there's some write into
> the read area in xfs I've missed, it's only a few extra cycles because
> the lines are mostly clean.

Right, in your case of vmap, it doesn't seem to be a big deal, but heh,
somebody is bound to use it again for something else right ? :-)

Anyways, just some thoughts I've been having about DMA APIs in general,
I don't say we must change it now, especially not the existing ones, but
for a -new- API like that I would have preferred if it exposed a richer
semantic from day 1.

Cheers,
Ben.

