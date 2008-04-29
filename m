From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [rfc] data race in page table setup/walking?
Date: Tue, 29 Apr 2008 15:08:44 +1000
Message-ID: <1209445724.18023.136.camel@pasglop>
References: <20080429050054.GC21795@wotan.suse.de>
Reply-To: benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080429050054.GC21795-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Memory Management List <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>


On Tue, 2008-04-29 at 07:00 +0200, Nick Piggin wrote:
> 
> At this point, the spinlock is not guaranteed to have ordered the previous
> stores to initialize the pte page with the subsequent store to put it in the
> page tables. So another Linux page table walker might be walking down (without
> any locks, because we have split-leaf-ptls), and find that new pte we've
> inserted. It might try to take the spinlock before the store from the other
> CPU initializes it. And subsequently it might read a pte_t out before stores
> from the other CPU have cleared the memory.

Funny, we used to have a similar race where the zeros for clearing a
newly allocated anonymous pages end up reaching the coherency domain
after the new PTE in set_pte, causing memory corruption on threaded
apps. I think back then we fixed that with an explicit smp_wmb() before
a set_pte(). Maybe we need that also when setting the higher levels.

Ben.
