From: tytso@mit.edu
Subject: Re: [git patches] xfs and block fixes for virtually indexed arches
Date: Thu, 17 Dec 2009 12:39:57 -0500
Message-ID: <20091217173957.GG2123@thunk.org>
References: <20091216043618.GB9104@hera.kernel.org>
 <20091217132256.GO28962@bombadil.infradead.org>
 <alpine.LFD.2.00.0912170811130.15740@localhost.localdomain>
 <20091217163036.GE2123@thunk.org>
 <alpine.LFD.2.00.0912170839550.15740@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0912170839550.15740@localhost.localdomain>
Sender: linux-parisc-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kyle McMartin <kyle@mcmartin.ca>, linux-parisc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James.Bottomley@suse.de, hch@infradead.org, linux-arch@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 17, 2009 at 08:46:33AM -0800, Linus Torvalds wrote:
> kmalloc() memory should be ok. It's backed by "real pages". Doing the DMA 
> translations for such pages is trivial and fundamental.

Sure, but there's some rumors/oral traditions going around that some
block devices want bio address which are page aligned, because they
want to play some kind of refcounting game, and if you pass them a
kmalloc() memory, they will explode in some interesting and
entertaining way.  And it's Weird Shit(tm) (aka iSCSI, AoE) type
drivers, that most of us don't have access to, so just because it
works Just Fine on SATA doesn't mean anything.

And none of this is documented anywhere, which is frustrating as hell.
Just rumors that "if you do this, AoE/iSCSI will corrupt your file
systems".

    	    	    	       		       - Ted
