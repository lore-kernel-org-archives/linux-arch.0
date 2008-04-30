From: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [rfc] data race in page table setup/walking?
Date: Wed, 30 Apr 2008 08:17:42 +0200
Message-ID: <20080430061741.GG27652@wotan.suse.de>
References: <20080429050054.GC21795@wotan.suse.de> <Pine.LNX.4.64.0804291333540.22025@blonde.site> <20080430060340.GE27652@wotan.suse.de> <20080429.230543.98200575.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080429.230543.98200575.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org

On Tue, Apr 29, 2008 at 11:05:43PM -0700, David Miller wrote:
> From: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
> Date: Wed, 30 Apr 2008 08:03:40 +0200
> 
> > Hardware walkers, I shouldn't worry too much about, except as a thought
> > exercise to realise that we have lockless readers. I think(?) alpha can
> > walk the linux ptes in hardware on TLB miss, but surely they will have
> > to do the requisite barriers in hardware too (otherwise things get
> > really messy)
> 
> My understanding is that all Alpha implementations walk the
> page tables in PAL code.

Ah OK. I guess that's effectively "hardware" as far as Linux is concerned.
I guess even x86 really walks the page tables in microcode as well. Basically
I just mean something that is invisible to, and obvlivious of, Linux's
locking.

 
> > Powerpc's find_linux_pte is one of the software walked lockless ones.
> > That's basically how I imagine hardware walkers essentially should operate.
> 
> Sparc64 walks the page tables lockless in it's TLB hash table miss
> handling.
> 
> MIPS does something similar.

Interesting, thanks.
