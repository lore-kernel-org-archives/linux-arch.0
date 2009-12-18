From: Dave Chinner <david@fromorbit.com>
Subject: Re: [git patches] xfs and block fixes for virtually indexed arches
Date: Fri, 18 Dec 2009 23:00:22 +1100
Message-ID: <20091218120022.GH4850@discord.disaster>
References: <alpine.LFD.2.00.0912170950330.15740@localhost.localdomain> <20091217193648.GI4489@kernel.dk> <1261094220.2752.27.camel@mulgrave.site> <20091218095944G.fujita.tomonori@lab.ntt.co.jp> <1261120128.3013.8.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1261120128.3013.8.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, jens.axboe@oracle.com, torvalds@linux-foundation.org, tytso@mit.edu, kyle@mcmartin.ca, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, hch@infradead.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 18, 2009 at 08:08:48AM +0100, James Bottomley wrote:
> On Fri, 2009-12-18 at 10:00 +0900, FUJITA Tomonori wrote:
> An alternative proposal to modifying the block layer to do coherency,
> might be simply to have the fs layer do a vunmap before doing I/O and
> re-vmap when it's completed. 

I don't think that works for XFS as it stands. Unmapping across
IO would have to guarantee we remap the buffer at the same
address after IO because we currently assume that mapped address
of the buffer can't change while references are held on the buffer.
That seems like an awful lot of complexity compared to the few lines
of code in XFS and the arches needed to support this.

> That would ensure the architecturally
> correct flushing of the aliases, and would satisfy the expectations of
> blk_rq_map_kern().  The down side is that vmap/vmalloc set up and clear
> page tables, which isn't necessary and might impact performance (xfs
> people?)

We play lots of tricks in XFS to avoid mapping buffers when we can
because of the performance impact it has.  Nick Piggin's recent
work getting vmap to scale helped a lot, but it is still best to
avoid mapped buffers where possible.

> If the performance impact of the above is too great, then we might
> introduce a vmalloc sync API to do the flush before and the invalidate
> after (would have to be called twice, once before I/O and once after).
> This is sort of a violation of our architectural knowledge layering,
> since the user of a vmap/vmalloc area has to know intrinsically how to
> handle I/O instead of having it just work(tm), but since the users are
> few and specialised, it's not going to lead to too many coding problems.
> 
> Any opinions?

Personally I see nothing wrong with the original patch series. If
the block layer mods are contentious, then just drop that patch
until a real need is brought to life.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
