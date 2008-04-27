From: Mike Galbraith <efault-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
	architectures
Date: Sun, 27 Apr 2008 22:51:54 +0200
Message-ID: <1209329514.4868.57.camel@marge.simson.net>
References: <20080427105100.GA14795@uranus.ravnborg.org>
	 <20080427113158.GY2252@cs181133002.pp.htv.fi>
	 <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org>
	 <20080427172235.GA2252@cs181133002.pp.htv.fi>
	 <alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org>
	 <20080427174714.GB2252@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080427174714.GB2252-Aar9JVdAhcRoA3hw4S0G5QR5/fbUUdgG@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, linux arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>


On Sun, 2008-04-27 at 20:47 +0300, Adrian Bunk wrote:
> On Sun, Apr 27, 2008 at 10:32:28AM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Sun, 27 Apr 2008, Adrian Bunk wrote:
> > > 
> > > I'm looking at it from a different angle, all code in the kernel should 
> > > follow the following rules [1]:
> > > - no functions in .c files should be marked inline
> > > - all functions in headers should be static inline
> > > - all functions in headers should either be very small or collapse
> > >   to become very small after inlining
> > > 
> > > I can simply not see any usecase for a non-forced inline in the kernel,
> > > and fixing the kernel should give a superset of the space savings of 
> > > this "inline optimization".
> > 
> > Your whole argument is premised on the assumption that the compiler does 
> > the right thing.
> >...
> 
> No, you seem to be misunderstanding what I am saying.
> 
> Status Quo as of 2.6.25:
> - we force the compiler to always inline with "inline"

What is wrong with that?  I believe the term is 'directive'.

> - we have inline's in .c files and too big functions in headers, and
>   both of them are wrong

Yes, correct the source.

> "inline optimization":
> - we leave the compiler the choice whether or not to inline with "inline"

How did it come to pass that we invented such a thing as an optional
directive?

	-Mike
