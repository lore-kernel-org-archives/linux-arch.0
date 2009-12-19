From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [git patches] xfs and block fixes for virtually indexed arches
Date: Sat, 19 Dec 2009 18:33:05 +0000
Message-ID: <20091219183305.GA10568@linux-mips.org>
References: <20091216043618.GB9104@hera.kernel.org>
 <20091217132256.GO28962@bombadil.infradead.org>
 <alpine.LFD.2.00.0912170811130.15740@localhost.localdomain>
 <20091217163036.GE2123@thunk.org>
 <alpine.LFD.2.00.0912170839550.15740@localhost.localdomain>
 <20091217170743.GA10431@infradead.org>
 <alpine.LFD.2.00.0912170928310.15740@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0912170928310.15740@localhost.localdomain>
Sender: linux-parisc-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, tytso@mit.edu, Kyle McMartin <kyle@mcmartin.ca>, linux-parisc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James.Bottomley@suse.de, linux-arch@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 17, 2009 at 09:42:15AM -0800, Linus Torvalds wrote:

> 
> I also think that the changes to bio_map_kernel() and bio_map_kern_endio() 
> are not just "fundamentally ugly", I think they are made worse by the fact 
> that it's not even done "right". You both flush the virtual caches before 
> the IO and invalidate after - when the real pattern should be that you 
> flush it before a write, and invalidate it after a read.
> 
> And I really think that would be all much more properly done at the 
> _caller_ level, not by the BIO layer.
> 
> You must have some locking and allocation etc logic at the caller anyway, 
> why doesn't _that_ level just do the flushing or invalidation?

And then there are certain types of caches that need invalidation before
_and_ after a DMA transaction as a workaround for a processor being
grossly abused in a system that it should not be used in.  Basically the
issue is that falsly speculated stores may dirty caches.

  Ralf
