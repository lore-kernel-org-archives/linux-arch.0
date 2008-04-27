From: Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
	architectures
Date: Sun, 27 Apr 2008 14:31:58 +0300
Message-ID: <20080427113158.GY2252@cs181133002.pp.htv.fi>
References: <20080427105100.GA14795@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080427105100.GA14795-QabhHTsIXMSnlFQ6Q1D1Y0B+6BGkLq7r@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: linux arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

On Sun, Apr 27, 2008 at 12:51:00PM +0200, Sam Ravnborg wrote:
> Fix the OPTIMIZE inline functionality such that it can be used
> by all architectures.
> To use it the arch maintainers shall add a
> "select HAVE_OPTIMIZE_INLINING" in their arch specific
> Kconfig file.
>...

My opinion on this is still:
"OPTIMIZE" means "work around bugs in the kernel".

Bugs of the following kinds:
- usage of "inline" in .c files (it should virtually never be used there)
- too big functions in header files

And this "inline optimization" reverts only the effects of some of these 
bugs.

And if the wrong code gets not inlined we can even get size increases at 
some places.

Denys and Ilpo have already done some work in fixing such bugs.

After the dust of this merge window has settled I'll try to get us a 
similar result without this "optimization".

> 	Sam
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
