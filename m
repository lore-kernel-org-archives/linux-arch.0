From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCHv2 1/5] mm: add coherence API for DMA to vmalloc/vmap
 areas
Date: Sat, 02 Jan 2010 15:54:55 -0600
Message-ID: <1262469295.2741.30.camel@mulgrave.site>
References: <1261603345-2494-1-git-send-email-James.Bottomley@suse.de>
	 <1261603345-2494-2-git-send-email-James.Bottomley@suse.de>
	 <20091224100853.GA3165@console-pimps.org>
	 <20091224123913.GD5335@parisc-linux.org>
	 <1262467678.2173.244.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:47626 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab0ABVzE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jan 2010 16:55:04 -0500
In-Reply-To: <1262467678.2173.244.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Matt Fleming <matt@console-pimps.org>, linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>, Paul Mundt <lethal@linux-sh.org>

On Sun, 2010-01-03 at 08:27 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2009-12-24 at 05:39 -0700, Matthew Wilcox wrote:
> > 
> > invalidates the processor cache for a given virtual address range
> > in the vmap area.  This API addresses the problem that the processor
> > may have performed speculative reads into its cache of the vmapped
> > area while I/O was occurring to the underlying physical pages.
> > 
> > Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
> 
> Interestingly, our DMA APIs in this regard are sub-optimal as they
> should provide 3 hooks, not 2.
> 
> Flush is good for ensuring dirty lines have been pushed out before an
> outgoing DMA.
> 
> But for incoming DMA it would be nice to properly split the 2 calls that
> may be needed on some archs, one before, one after the transfer. Sure,
> invalidate twice will "work" but the f will also be sub-optimal on some
> platforms depending on whether the platform is known to be able or not
> to speculatively load cache lines etc...
> 
> Maybe just a "before" vs. "after" argument ?
> 
> Also, the proposal goes contrary to most of our DMA APIs which don't
> actually expose the details of invalidate vs. flush but instead expose
> the direction of the transfer (both lack the above subtlety though).
> 
> Thoughts ?

Well, that's the result of the email thread.  XFS is poking deeply into
architectural issues by trying to do I/O on a vmap area.  I thought the
consensus was that if xfs wants to do that then it takes complete
responsibility for coherence rather than trying to hide it in a block
API.

James
