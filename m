From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all architectures
Date: Sun, 27 Apr 2008 20:09:57 +0200
Message-ID: <20080427180957.GA25964@uranus.ravnborg.org>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org> <20080427172235.GA2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org> <20080427174714.GB2252@cs181133002.pp.htv.fi> <20080427180007.GB28483@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080427180007.GB28483-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

On Sun, Apr 27, 2008 at 02:00:07PM -0400, Christoph Hellwig wrote:
> On Sun, Apr 27, 2008 at 08:47:14PM +0300, Adrian Bunk wrote:
> > What I want instead:
> > - we continue to force the compiler to always inline with "inline"
> > - we remove the inline's in .c files and make too big functions in 
> >   headers out-of-line
> 
> It doesn't matter whether we use inline or always_inline to force
> inlining of a function, that's just syntactical sugar.

inline => the developer hints the compiler that it may
          be a good idea to inline this function

always_inline => the developer tell gcc that for some obscure reasons
                 MUST always inline uses of this function

> What is rather
> annoying is that with the config option we'd have something marked
> inline without actually meaning it's inline.
With the config option we pass the inline hint to gcc (if enabled).
So with the config option we have the possibility to pass a _hint_ to
gcc about inlining.

Before the config option there were no difference between
static int alwyas_inline foo() {}
and
static int inline foo() {}

With the config option we now have a situation where they actually
differ as they should do (assuming gcc > 4.x).

> And what's even worse
> is that this is depending on a user-visible config option which is
> entirely stupid.
So you say that it is safe to assume all places where we really need
always_inline are annotedted such - and we do not need a simple
config option that the user can uncheck.
Fine by me - I prefer the simpler solution.

	Sam
