Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268380AbUHLDUz@vger.kernel.org>
Received: from holomorphy.com ([207.189.100.168]:45704 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268376AbUHLDUz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 23:20:55 -0400
Date: Wed, 11 Aug 2004 20:20:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: clear_user_highpage()
Message-ID: <20040812032049.GD11200@holomorphy.com>
References: <20040811161537.5e24c2b6.davem@redhat.com> <Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org> <20040812004654.GX11200@holomorphy.com> <Pine.LNX.4.58.0408111905210.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408111905210.1839@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 11 Aug 2004, William Lee Irwin III wrote:
>> Results from prototype prezeroing patches (ca. 2001) showed that
>> dedicating a cpu on a 16x machine to prezeroing userspace pages (doing
>> no other work on that cpu) improved kernel compile (insert sound of
>> projectile vomiting here) "benchmarks". This suggests cache pollution
>> and scheduling latency can be circumvented under some circumstances.

On Wed, Aug 11, 2004 at 07:18:18PM -0700, Linus Torvalds wrote:
> Heh.
> And at what point does it become a problem? Caches are growing, at some 
> point it is going to be a loss to zero memory on another CPU..

The cache pollution and scheduling latencies would have been introduced
by earlier versions of the prototype prezeroing patch (they should be
inherent to most naive implementations). The implementor of those
prototypes was unaware of PCD, PAT, and various other tricks so I'm
rather suspicious of it all, and the result is vaguely disgusting.


On Wed, Aug 11, 2004 at 07:18:18PM -0700, Linus Torvalds wrote:
> I really do believe (but can't back it up with any real numbers) that we 
> want to try to keep pages in cache as long as possible. That means keeping 
> the pages close to the last CPU that used them, btw.
> It would be interesting to see if we could make the buddy allocator more
> "per-cpu" friendly, for example - I suspect that would make much _more_ of
> a difference than pre-zeroing pages. 

Per-cpu zoning, perhaps? The hot/cold pages bits seem to achieve more
in terms of lock amortization than cache warmth, probably due to the
lists being turned over too often. Page allocation rates are truly
immense, but I've not checked the hot/cold list turnover rates to see
what's going on there in part because out-of-order frees spoil the
naive accounting methods.


On Wed, Aug 11, 2004 at 07:18:18PM -0700, Linus Torvalds wrote:
> As it is, the pages we allocate have _no_ CPU affinity (unlike 
> kmalloc/slab), and as a result they aren't even very likely to be in the 
> cache even if you have tons of cache on the CPU. 
> And my whole argument against pre-zeroing really falls totally flat if the 
> pages aren't in the cache. 
> So I'd personally be a whole lot more interested in seeing whether we 
> could have per-CPU pages than in pre-zeroing. 

There are a few other points in the design space, e.g. batching, that
haven't been tried yet. e.g. in the fault handler, do write-through
zeroing of ZERO_BATCH_SIZE - 1 pages and a cached zero of the page to
be handed to userspace when some per-cpu pool of pages is empty, or
similar nonsense (maybe via schedule_work(), or queueing pages for the
idle task to process, or something else that sounds like a plausible
way to salvage things). Truly speculative background zeroing (or "page
scrubbing") is just wrong as various workloads, e.g. routing, have next
to zero userspace participation and may literally be interested in
eliminating the last userspace process running or avoiding ever running
userspace altogether on very memory-constrained embedded systems. So I
think that if there can be a proper prezeroing implementation, it would
only perform prezeroing in response to some event or when guided by
some prediction. I guess it's a squishier objection than "implementing
it via $FOO got numbers $BAR", but anyhow.


On Wed, Aug 11, 2004 at 07:18:18PM -0700, Linus Torvalds wrote:
> Fragmentation of memory is the _big_ problem, of course. It comes up
> almost for _any_ page allocation issue. But it might be interesting to see 
> if we could have a special per-cpu "page pool" for some usage. Sized 
> fairly small - on the order of a few times the CPU cache size - and used 
> for anonymous pages that we think might be short-lived.

Well, regardless of whether zones per se are used, some larger
physically contiguous cpu-affine memory pools than the hot/cold page
lists sounds very close to this ideal. I think the important aspect
of their being physically contiguous is that the contiguity prevents
the things from fragmenting areas outside that physical region. The
flaw in all this is that there's no adequate (not even approximate that
I know of) method of predicting lifetimes of userspace pages, and
recovering from these mispredictions seems to typically involve...
(cue Darth Vader dirge) ... background processing things have to wait for.


-- wli
