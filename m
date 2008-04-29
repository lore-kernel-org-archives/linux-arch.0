From: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [rfc] data race in page table setup/walking?
Date: Tue, 29 Apr 2008 07:41:35 +0200
Message-ID: <20080429054135.GD21795@wotan.suse.de>
References: <20080429050054.GC21795@wotan.suse.de> <1209445724.18023.136.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1209445724.18023.136.camel@pasglop>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Memory Management List <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>

On Tue, Apr 29, 2008 at 03:08:44PM +1000, Benjamin Herrenschmidt wrote:
> 
> On Tue, 2008-04-29 at 07:00 +0200, Nick Piggin wrote:
> > 
> > At this point, the spinlock is not guaranteed to have ordered the previous
> > stores to initialize the pte page with the subsequent store to put it in the
> > page tables. So another Linux page table walker might be walking down (without
> > any locks, because we have split-leaf-ptls), and find that new pte we've
> > inserted. It might try to take the spinlock before the store from the other
> > CPU initializes it. And subsequently it might read a pte_t out before stores
> > from the other CPU have cleared the memory.
> 
> Funny, we used to have a similar race where the zeros for clearing a
> newly allocated anonymous pages end up reaching the coherency domain
> after the new PTE in set_pte, causing memory corruption on threaded
> apps. I think back then we fixed that with an explicit smp_wmb() before
> a set_pte().

Yep, I remember that one. We had the same problem with inserting pages
into the pagecache radix-tree, so I recently changed the fix to encompass
both problems: the barriers are now in SetPageUptodate and (Test)PageUptodate.


> Maybe we need that also when setting the higher levels.

That is my reading of the situation, yes.
