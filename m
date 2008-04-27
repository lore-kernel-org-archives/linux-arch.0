From: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all architectures
Date: Sun, 27 Apr 2008 11:40:56 -0600
Message-ID: <20080427174055.GS14990@parisc-linux.org>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org> <20080427172235.GA2252@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080427172235.GA2252-Aar9JVdAhcRoA3hw4S0G5QR5/fbUUdgG@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, linux arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

On Sun, Apr 27, 2008 at 08:22:35PM +0300, Adrian Bunk wrote:
> I'm looking at it from a different angle, all code in the kernel should 
> follow the following rules [1]:
> - no functions in .c files should be marked inline
> - all functions in headers should be static inline
> - all functions in headers should either be very small or collapse
>   to become very small after inlining
> 
> I can simply not see any usecase for a non-forced inline in the kernel,
> and fixing the kernel should give a superset of the space savings of 
> this "inline optimization".

Here's a good counterexample: kernel/mutex.c.

__mutex_lock_common wants to be inlined into __mutex_lock_*_slowpath.
and *_slowpath *shouldn't* be inlined into mutex_lock_*.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
