Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268415AbUHLAsG@vger.kernel.org>
Received: from holomorphy.com ([207.189.100.168]:48519 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266199AbUHLArF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 20:47:05 -0400
Date: Wed, 11 Aug 2004 17:46:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: clear_user_highpage()
Message-ID: <20040812004654.GX11200@holomorphy.com>
References: <20040811161537.5e24c2b6.davem@redhat.com> <Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 11 Aug 2004, David S. Miller wrote:
>> The PPC people used to zero out pages in the cpu idle loop
>> and I'd definitely like to do something along those lines
>> on sparc64 as well, I feel it would be extremely effective.

On Wed, Aug 11, 2004 at 04:46:10PM -0700, Linus Torvalds wrote:
> No. It sucks. It sucks so bad it's not funny.
> It sucks because it eats CPU and memory bandwidth when it shouldn't be 
> eaten. It's a total disaster on SMP, but it's bad on UP too.

Results from prototype prezeroing patches (ca. 2001) showed that
dedicating a cpu on a 16x machine to prezeroing userspace pages (doing
no other work on that cpu) improved kernel compile (insert sound of
projectile vomiting here) "benchmarks". This suggests cache pollution
and scheduling latency can be circumvented under some circumstances.


On Wed, Aug 11, 2004 at 04:46:10PM -0700, Linus Torvalds wrote:
> It sucks because it does bad things to cache behaviour. Sure, you'll move 
> the cost away from "clear_user_highpage", but the thing is, you will _not_ 
> move it into the idle time. What you will do is to move it into some 
> random time _after_ the idle time, when the idle thing has crapped all 
> over your caches.
> The thing is, you make your cache footprint per CPU _much_ bigger, and you 
> spread it out a lot over time too, so you make it even worse.

Uncached zeroing, dedicated cpus, or appropriate cache semantics (e.g.
not allocating a cacheline either via some special instruction or by
the cache in general not allocating lines on some writes and/or zeroing
writes that miss) negate this.


On Wed, Aug 11, 2004 at 04:46:10PM -0700, Linus Torvalds wrote:
> The clearing will then be totally hidden in the profiles, because you will
> have turned a nice and well-behaved "this is there the time goes" profile
> into a mush of "we're taking cache misses at random times, and we don't
> know why".
> That, btw, is a _classic_ mistake in profiling. Move the work around so 
> that it's not as visible any more.
> In other words, don't do it. It's a mistake. It is optimizing the profile 
> without actually optimizing what you want _done_. 
> Btw, this is exactly what the totally brain-damaged slab stuff does. It 
> takes away the peaks, but does so by having worse cache access patterns 
> all around. 

I beg to differ; slab preconstruction, when it has not been effective,
has had to do with the heaviness of the slab allocator and when the
slab allocator is circumvented it's effective even where it's otherwise
too heavyweight. Zeroing pagetables is in fact the poster child for this,
where almost all architectures have cached prezeroed pagetables forever.
Reinstating caching of i386 pagetables improved SDET performance by a
consistent (and hence statistically significant) margin of 1%-1.5%.

One of the key aspects of an access pattern that makes preconstruction
useful is that very little of the allocated memory is actually touched
during typical accesses. Hence, the construction of the object pollutes
the cache with numerous cachelines that are rarely touched. Objects as
large as pages, e.g. pagetable pages, show this very well. Typical
usage of the upper levels is sparse, and for smaller processes the
lower levels are also sparsely-used.

Userspace likewise can't be assumed to reference an entire zeroed page
allocated to it. Userspace can't be predicted but it is also typical
there for only small portions of large data structures to be referenced.
e.g. a large, say, PAGE_SIZE buffer is allocated for read() traffic, but
all typical read()'s are only a few bytes in length.

And in general the "precharging" stalls taking unnecessary misses for
the cachelines of the object that are rarely accessed, pollutes the
cache with those cachelines of the object that are rarely accessed, and
burns a few extra cycles (dwarfed by the misses on the unnecessarily-
touched cachelines) doing an unnecessary pass over the object.


On Wed, Aug 11, 2004 at 04:46:10PM -0700, Linus Torvalds wrote:
> Look at it this way:
>  - it might be worth doing in big batches under some kind of user control, 
>    when you really can _control_ that it happens at a good time.
>    I _might_ buy into this argument. Make it a batch thing that really 
>    screws the caches, but only does so very seldom, when the user asked
>    for it.
>  - but we aren't supposed to have that much memory free _anyway_, and 
>    trying to keep it around on a separate list is horrible for 
>    fragmentation.  So batching huge things up is likely not a good idea 
>    either.
>  - with caches growing larger, it's actually BETTER to clear the page at 
>    usage time, because then the CPU that actually touches the page won't 
>    have to bring in the page in from memory. We'll blow one page of cache 
>    by clearing it, but we will blow it in a "good" way - hopefully with
>    almost no memory traffic at all (ie the clear can be done as pure 
>    invalidate cycles, no read-back into the CPU).
> And the thing is, the background clearing will just get worse and worse.
> In summary: it's a _good_ thing when you see a sharp peak in your 
> profiles, and you can say "I know exactly what that peak is for, and it's 
> doing exactly the work it should be doing and nothing else".

The real flaws I see in background zeroing are fragmentation and
scheduling latency (or potential loss of cpus dedicated to the purpose).
Preventing cache pollution is already a prerequisite for remotely
non-naive implementations.

The scheduling latency aspect is due to the fact that many cpus have
caching semantics that require extremely slow uncached accesss to
prevent cache pollution, and that page zeroing is slow enough of an
operation to noticeably stall rescheduling userspace. It's possible
that this could be mitigated by incrementally zeroing pages and polling
TIF_NEED_RESCHED between blocks of a page, but the background zeroing
efforts went in a rather different, useless direction (dedicating cpus).

The fragmentation bits are just as you say, an artifact of segregating a
pool of pages from the general pool of free pages that can be coalesced.
I haven't come up with any methods to address this.

In general, I despise background processing and would rather see
event-driven methods of accomplishing preconstruction, though I've no
idea whatsoever how those would be carried out for userspace memory.


-- wli
