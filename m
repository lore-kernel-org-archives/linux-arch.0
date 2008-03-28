From: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [patch 1/2]: x86: implement pte_special
Date: Fri, 28 Mar 2008 05:15:20 +0100
Message-ID: <20080328041519.GF8083@wotan.suse.de>
References: <20080328033149.GD8083@wotan.suse.de> <20080327.204431.201380891.davem@davemloft.net> <20080328040442.GE8083@wotan.suse.de> <20080327.210910.101408473.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080327.210910.101408473.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, shaggy-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org, axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org

On Thu, Mar 27, 2008 at 09:09:10PM -0700, David Miller wrote:
> From: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
> Date: Fri, 28 Mar 2008 05:04:42 +0100
> 
> > BTW. if you are still interested, then the powerpc64 patch might be a
> > better starting point for you. I don't know how the sparc tlb flush
> > design looks like, but if it doesn't do a synchronous IPI to invalidate
> > other threads, then you can't use the x86 approach.
> 
> I have soft bits available on sparc64, that's not my issue.
> 
> My issue is that if you implemented this differently, every platform
> would get the optimization, without having to do anything special
> at all, and I think that's such a much nicer way.

Oh, they wouldn't. It is completely tied to the low level details of
their TLB and pagetable teardown design. That's the unfortunate part
about it.

The other thing is that the "how do I know if I can refcount the page
behind this (mm,vaddr,pte) tuple" can be quite arch specific as well.
And it is also non-trivial to do because that information can be dynamic
depending on what driver mapped in that given tuple.

It is *possible*, but not trivial.
