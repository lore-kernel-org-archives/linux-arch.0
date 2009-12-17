From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [git patches] xfs and block fixes for virtually indexed arches
Date: Thu, 17 Dec 2009 12:07:44 -0500
Message-ID: <20091217170743.GA10431@infradead.org>
References: <20091216043618.GB9104@hera.kernel.org> <20091217132256.GO28962@bombadil.infradead.org> <alpine.LFD.2.00.0912170811130.15740@localhost.localdomain> <20091217163036.GE2123@thunk.org> <alpine.LFD.2.00.0912170839550.15740@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0912170839550.15740@localhost.localdomain>
Sender: linux-parisc-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: tytso@mit.edu, Kyle McMartin <kyle@mcmartin.ca>, linux-parisc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James.Bottomley@suse.de, hch@infradead.org, linux-arch@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 17, 2009 at 08:46:33AM -0800, Linus Torvalds wrote:
> The whole "vmalloc is special" has always been true. If you want to 
> treat vmalloc as normal memory, you need to look up the pages yourself. We 
> have helpers for that (including helpers that populate vmalloc space from 
> a page array to begin with - so you can _start_ from some array of pages 
> and then lay them out virtually if you want to have a convenient CPU 
> access to the array).

Which is exactly what the XFS code does.  Pages are allocated manually
and we store pointers to the page struct that later get added to the
bio.  But we access them through vmap (which I added exactly for this
reason back in 2002) for kernel accesses.  On all architectures with
sane caches things just work, but for parisc, arm and friends that have
virtually indexed caches we need to make sure to flush caches for this
different access.  The vmalloc linear address is not used for I/O
everywhere.

