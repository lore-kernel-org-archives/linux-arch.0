From: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [rfc] data race in page table setup/walking?
Date: Thu, 1 May 2008 13:45:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0805011342210.24147@blonde.site>
References: <20080429050054.GC21795@wotan.suse.de> <Pine.LNX.4.64.0804291333540.22025@blonde.site>
 <20080430060340.GE27652@wotan.suse.de> <Pine.LNX.4.64.0804301140490.4651@blonde.site>
 <20080501003542.GB11312@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080501003542.GB11312-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Memory Management List <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>

On Thu, 1 May 2008, Nick Piggin wrote:
> On Wed, Apr 30, 2008 at 12:14:51PM +0100, Hugh Dickins wrote:
> > On Wed, 30 Apr 2008, Nick Piggin wrote:
> > > 
> > > Actually, aside, all those smp_wmb() things in pgtable-3level.h can
> > > probably go away if we cared: because we could be sneaky and leverage
> > > the assumption that top and bottom will always be in the same cacheline
> > > and thus should be shielded from memory consistency problems :)
> > 
> > I've sometimes wondered along those lines.  But it would need
> > interrupts disabled, wouldn't it?  And could SMM mess it up?
> > And what about another CPU taking the cacheline to modify it
> > in between our two accesses?
> 
> Nothing more than could not already happen with the smp_wmb in there,
> AFAIKS.

Yes, one does wonder just what I was wondering ;)

Hugh
