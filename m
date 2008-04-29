From: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [rfc] data race in page table setup/walking?
Date: Tue, 29 Apr 2008 23:47:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0804292328110.23470@blonde.site>
References: <20080429050054.GC21795@wotan.suse.de>
 <Pine.LNX.4.64.0804291333540.22025@blonde.site> <1209505059.18023.193.camel@pasglop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1209505059.18023.193.camel@pasglop>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Memory Management List <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>

On Wed, 30 Apr 2008, Benjamin Herrenschmidt wrote:
> On Tue, 2008-04-29 at 13:36 +0100, Hugh Dickins wrote:
> > 
> > Ugh.  It's just so irritating to introduce these blockages against
> > such a remote possibility (but there again, that's what so much of
> > kernel code has to be about).  Is there any other way of handling it?
> 
> Not that much overhead... I think smp_read_barrier_depends() is a nop on
> most archs no ? The data dependency between all the pointers takes care
> of ordering in many cases.

Ah, you're right, I was automatically thinking smp_rmb, whereas as this
is the only_does_something_on_alpha_mb (nice to see those impressively
long comments on a "do { } while (0)" in some of the other arches ;)

(Well, frv says "barrier()" for it - does it actually need that?)

Yes, that's not bad at all; though in that case,
I am surprised it's enough to patch up the issue.

> So it boils down to smp_wmb's when setting
> which is not that expensive.

Yes, I wasn't worried about the much less common and anyway heavier
write (allocate) path, I don't begrudge the smp_wmb's there.

Thanks for calming me down!
Hugh
