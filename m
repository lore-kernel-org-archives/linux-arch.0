From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
 architectures
Date: Sun, 27 Apr 2008 10:32:28 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org> <20080427172235.GA2252@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080427172235.GA2252-Aar9JVdAhcRoA3hw4S0G5QR5/fbUUdgG@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, linux arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>



On Sun, 27 Apr 2008, Adrian Bunk wrote:
> 
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

Your whole argument is premised on the assumption that the compiler does 
the right thing.

That's a *known*to*be*bogus* assumption.

Modern versions of gcc may do the right thing. Note the two very important 
code-words: "modern" and "may".

I'm just telling you that

 - older versions of gcc (and by "older" I do not mean "really ancient" or 
   "deprecated", but stuff that is still in use) are known to be total and 
   utter crap when it comes to inlining

 - even absent that, there are historical reasons stemming from even more 
   ancient versions of gcc that are no longer in use.

In other words, my arguments have nothing to do with "I wish". They are 
plain facts. Why argue with them?

			Linus
