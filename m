From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [rfc] data race in page table setup/walking?
Date: Wed, 30 Apr 2008 08:53:44 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804300848390.2997@woody.linux-foundation.org>
References: <20080429050054.GC21795@wotan.suse.de> <Pine.LNX.4.64.0804291333540.22025@blonde.site> <20080430060340.GE27652@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080430060340.GE27652-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Cc: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Memory Management List <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>



On Wed, 30 Apr 2008, Nick Piggin wrote:
> 
> Actually, aside, all those smp_wmb() things in pgtable-3level.h can
> probably go away if we cared: because we could be sneaky and leverage
> the assumption that top and bottom will always be in the same cacheline
> and thus should be shielded from memory consistency problems :)

Umm.

Why would we care, since smp_wmb() is a no-op? (Yea, it's a compiler 
barrier, big deal, it's not going to cost us anything).

Also, write barriers are not about cacheline access order, they tend to be 
more about the write *buffer*, ie before the write even hits the cache 
line. And a write coudl easily pass another write in the write buffer if 
there is (for example) a dependency on the address.

So even if they are in the same cacheline, if the first write needs an 
offset addition, and the second one does not, it could easily be that the 
second one hits the write buffer first (together with some alias 
detection that re-does the things if they alias).

Of course, on x86, the write ordering is strictly defined, and even if the 
CPU reorders writes they are guaranteed to never show up re-ordered, so 
this is not an issue. But I wanted to point out that memory ordering is 
*not* just about cachelines, and being in the same cacheline is no 
guarantee of anything, even if it can have *some* effects.

		Linus
