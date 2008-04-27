From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
	architectures
Date: Sun, 27 Apr 2008 14:14:12 -0400
Message-ID: <20080427181411.GA31667@infradead.org>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org> <20080427172235.GA2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org> <20080427174714.GB2252@cs181133002.pp.htv.fi> <20080427180007.GB28483@infradead.org> <20080427180957.GA25964@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080427180957.GA25964-QabhHTsIXMSnlFQ6Q1D1Y0B+6BGkLq7r@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

On Sun, Apr 27, 2008 at 08:09:57PM +0200, Sam Ravnborg wrote:
> With the config option we pass the inline hint to gcc (if enabled).
> So with the config option we have the possibility to pass a _hint_ to
> gcc about inlining.
> 
> Before the config option there were no difference between
> static int alwyas_inline foo() {}
> and
> static int inline foo() {}
> 
> With the config option we now have a situation where they actually
> differ as they should do (assuming gcc > 4.x).

As Linus mentioned the hint doesn't make any sense because gcc will
get it wrong anyway.  In fact when you look at kernel code it tends
to inline the everything and the kitchensink as long as there's just
one caller and this bloat the stack but doesn't inline where it needs
to.  Better don't try to mess with that and do it explicit.

> So you say that it is safe to assume all places where we really need
> always_inline are annotedted such - and we do not need a simple
> config option that the user can uncheck.

I don't say it is that, it certainly isn't on powerpc and probably most
other architectures right now, because only x86 got the fixup so far.
But making it a user-visible option instead of an architecture opt
in/out selection doesn't make any sense.
