From: Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
	architectures
Date: Sun, 27 Apr 2008 20:22:35 +0300
Message-ID: <20080427172235.GA2252@cs181133002.pp.htv.fi>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804271002360.2896-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, linux arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

On Sun, Apr 27, 2008 at 10:06:41AM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 27 Apr 2008, Adrian Bunk wrote:
> > 
> > My opinion on this is still:
> > "OPTIMIZE" means "work around bugs in the kernel".
> 
> No.
> 
> It means that
> 
>  - gcc used to (long ago) always honor "inline", and we had kernel code 
>    that depended on that in various ways (ie required that there was no 
>    return etc).
> 
>    We've been mostly replacing the ones we know about with 
>    "__always_inline", but there may be some that remain. We'll find out, I 
>    guess.
> 
>  - gcc was a total and utter piece of horrible crap in the inlining 
>    department, doign insane things and changing their documentation to 
>    match the new behaviour (and some people then claimed that it was 
>    always documented that way).
> 
>    It would not inline big functions even when they statically collapsed 
>    to nothing, etc.
> 
> As a result, we really couldn't afford to let gcc make any inlining 
> decisions, because the compiler was simply *broken*.

I'm looking at it from a different angle, all code in the kernel should 
follow the following rules [1]:
- no functions in .c files should be marked inline
- all functions in headers should be static inline
- all functions in headers should either be very small or collapse
  to become very small after inlining

I can simply not see any usecase for a non-forced inline in the kernel,
and fixing the kernel should give a superset of the space savings of 
this "inline optimization".

> 			Linus

cu
Adrian

[1] there might be rare exceptions

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
