From: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [rfc] data race in page table setup/walking?
Date: Thu, 1 May 2008 02:35:42 +0200
Message-ID: <20080501003542.GB11312@wotan.suse.de>
References: <20080429050054.GC21795@wotan.suse.de> <Pine.LNX.4.64.0804291333540.22025@blonde.site> <20080430060340.GE27652@wotan.suse.de> <Pine.LNX.4.64.0804301140490.4651@blonde.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0804301140490.4651-popGQ1T0qN76K7/ahGyk6A@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Memory Management List <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>

On Wed, Apr 30, 2008 at 12:14:51PM +0100, Hugh Dickins wrote:
> On Wed, 30 Apr 2008, Nick Piggin wrote:
> > 
> > Actually, aside, all those smp_wmb() things in pgtable-3level.h can
> > probably go away if we cared: because we could be sneaky and leverage
> > the assumption that top and bottom will always be in the same cacheline
> > and thus should be shielded from memory consistency problems :)
> 
> I've sometimes wondered along those lines.  But it would need
> interrupts disabled, wouldn't it?  And could SMM mess it up?
> And what about another CPU taking the cacheline to modify it
> in between our two accesses?

Nothing more than could not already happen with the smp_wmb in there,
AFAIKS.

 
> I don't think we do care in that x86 PAE case, but as a general
> principal, if it can be safely assumed on all architectures (or
> more messily, just on some) under certain conditions, then shouldn't
> we be looking to use that technique (relying on a consistent view of
> separate variables clustered into the same cacheline) in critical
> places, rather than regarding it as sneaky?
> 
> But I suspect this is a chimaera, that there's actually no
> safe use to be made of it.  I'd be glad to be shown wrong.

Well Linus put a dampener on it... but if it actually did work, then
yeah I guess there are some places it could be used. I suspect that
on some implementations, being in the same cacheline would actually
fully order all transactions of a CPU, so if it did make a big
difference anywhere, we could have smp_*mb_cacheline() or something ;)
