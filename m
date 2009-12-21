From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [git patches] xfs and block fixes for virtually indexed arches
Date: Mon, 21 Dec 2009 11:14:39 -0600
Message-ID: <1261415679.2619.121.camel@mulgrave.site>
References: <20091216043618.GB9104@hera.kernel.org>
	 <20091217132256.GO28962@bombadil.infradead.org>
	 <alpine.LFD.2.00.0912170811130.15740@localhost.localdomain>
	 <20091217163036.GE2123@thunk.org>
	 <alpine.LFD.2.00.0912170839550.15740@localhost.localdomain>
	 <20091217170743.GA10431@infradead.org>
	 <alpine.LFD.2.00.0912170928310.15740@localhost.localdomain>
	 <20091219183305.GA10568@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58183 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756881AbZLUROm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 21 Dec 2009 12:14:42 -0500
In-Reply-To: <20091219183305.GA10568@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, tytso@mit.edu, Kyle McMartin <kyle@mcmartin.ca>, linux-parisc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

On Sat, 2009-12-19 at 18:33 +0000, Ralf Baechle wrote:
> On Thu, Dec 17, 2009 at 09:42:15AM -0800, Linus Torvalds wrote:
> 
> > 
> > I also think that the changes to bio_map_kernel() and bio_map_kern_endio() 
> > are not just "fundamentally ugly", I think they are made worse by the fact 
> > that it's not even done "right". You both flush the virtual caches before 
> > the IO and invalidate after - when the real pattern should be that you 
> > flush it before a write, and invalidate it after a read.
> > 
> > And I really think that would be all much more properly done at the 
> > _caller_ level, not by the BIO layer.
> > 
> > You must have some locking and allocation etc logic at the caller anyway, 
> > why doesn't _that_ level just do the flushing or invalidation?
> 
> And then there are certain types of caches that need invalidation before
> _and_ after a DMA transaction as a workaround for a processor being
> grossly abused in a system that it should not be used in.  Basically the
> issue is that falsly speculated stores may dirty caches.

Um, so that's just so wrong it doesn't even seem possible.  It would
mean that a speculation could make a line dirty while DMA was in
progress to the underlying memory.  There's always going to be a window
between the DMA completion and the software invalidation where the dirty
line could be flushed, thus corrupting the DMA transfer.

Hopefully steps have been taken to see that whoever thought this was a
good idea isn't still contributing to the gene pool?

James
