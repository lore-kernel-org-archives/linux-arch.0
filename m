From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [rfc] data race in page table setup/walking?
Date: Wed, 30 Apr 2008 07:37:39 +1000
Message-ID: <1209505059.18023.193.camel@pasglop>
References: <20080429050054.GC21795@wotan.suse.de>
	 <Pine.LNX.4.64.0804291333540.22025@blonde.site>
Reply-To: benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0804291333540.22025-popGQ1T0qN76K7/ahGyk6A@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Cc: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Memory Management List <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>


On Tue, 2008-04-29 at 13:36 +0100, Hugh Dickins wrote:
> 
> Ugh.  It's just so irritating to introduce these blockages against
> such a remote possibility (but there again, that's what so much of
> kernel code has to be about).  Is there any other way of handling it?

Not that much overhead... I think smp_read_barrier_depends() is a nop on
most archs no ? The data dependency between all the pointers takes care
of ordering in many cases. So it boils down to smp_wmb's when setting
which is not that expensive.

Cheers,
Ben.
