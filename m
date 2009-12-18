From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [git patches] xfs and block fixes for virtually indexed arches
Date: Fri, 18 Dec 2009 12:51:15 +0900
Message-ID: <20091218125047U.fujita.tomonori@lab.ntt.co.jp>
References: <1261094220.2752.27.camel@mulgrave.site>
	<20091218095944G.fujita.tomonori@lab.ntt.co.jp>
	<20091218024440.GG4850@discord.disaster>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20091218024440.GG4850@discord.disaster>
Sender: linux-parisc-owner@vger.kernel.org
To: david@fromorbit.com
Cc: fujita.tomonori@lab.ntt.co.jp, James.Bottomley@suse.de, jens.axboe@oracle.com, torvalds@linux-foundation.org, tytso@mit.edu, kyle@mcmartin.ca, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, hch@infradead.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, 18 Dec 2009 13:44:40 +1100
Dave Chinner <david@fromorbit.com> wrote:

> > > So it sounds like we only need a blk_rq_map_vmalloc() using the same
> > > techniques as the patch set and we're good to go.
> > 
> > I'm not sure about it.
> > 
> > As I said before (when I was against this 'adding vmalloc support to
> > the block layer' stuff), are there potential users of this except for
> > XFS? Are there anyone who does such a thing now?
> 
> As Christoph already mentioned, XFS is not passing the vmalloc'd
> range to the block layer

Oops, I should have said a vmalloc/vmap area.


> > This API might be useful for only journaling file systems using log
> > formats that need large contiguous buffer. Sound like only XFS?
> 
> FWIW, mapped buffers larger than PAGE_SIZE are used for more than just log
> recovery in XFS. e.g. filesystems with directory block size larger
> than page size uses mapped buffers.

I see, thanks.
