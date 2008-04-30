From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: Re: [rfc] data race in page table setup/walking?
Date: Tue, 29 Apr 2008 23:05:43 -0700 (PDT)
Message-ID: <20080429.230543.98200575.davem@davemloft.net>
References: <20080429050054.GC21795@wotan.suse.de>
	<Pine.LNX.4.64.0804291333540.22025@blonde.site>
	<20080430060340.GE27652@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080430060340.GE27652-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin-l3A5Bk7waGM@public.gmane.org
Cc: hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org

From: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Date: Wed, 30 Apr 2008 08:03:40 +0200

> Hardware walkers, I shouldn't worry too much about, except as a thought
> exercise to realise that we have lockless readers. I think(?) alpha can
> walk the linux ptes in hardware on TLB miss, but surely they will have
> to do the requisite barriers in hardware too (otherwise things get
> really messy)

My understanding is that all Alpha implementations walk the
page tables in PAL code.

> Powerpc's find_linux_pte is one of the software walked lockless ones.
> That's basically how I imagine hardware walkers essentially should operate.

Sparc64 walks the page tables lockless in it's TLB hash table miss
handling.

MIPS does something similar.
