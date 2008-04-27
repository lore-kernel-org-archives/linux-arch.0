From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
	architectures
Date: Sun, 27 Apr 2008 14:36:31 -0400
Message-ID: <20080427183631.GC23828@infradead.org>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org> <20080427172235.GA2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org> <20080427174714.GB2252@cs181133002.pp.htv.fi> <20080427180007.GB28483@infradead.org> <20080427180957.GA25964@uranus.ravnborg.org> <20080427181411.GA31667@infradead.org> <20080427183131.GA26937@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080427183131.GA26937-QabhHTsIXMSnlFQ6Q1D1Y0B+6BGkLq7r@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

On Sun, Apr 27, 2008 at 08:31:31PM +0200, Sam Ravnborg wrote:
> The tendency is that gcc inline *more than we whish* - not less.
> Which is why we have noinline - to cover the cases where we do not
> want stuff inlined.

Which is exactly the wrong way around.  noinline should be the default.
But that's probaby no fixable without touching gcc or doing ugly hacks
as in xfs.

> What the patch in question does is to make a difference
> between always_inle and inline.
> Previously they were the same. With the patch applied and
> with a gcc > 4.0 inline is now a hint.
> 
> Did you actually read the patch?

Yes.  As as I said I think having them the same, or rather only
having one of them makes more sense than having a hint in addition to
force.

> If you read the patch you will see that the architectures that
> want to enable this has to do an explicit HAVE_CC_INLINE_HINT
> so powerpc is not impacted by this until they request it.
> Exactly the reason why this was not widely enabled in the
> first place (but implemnted in a too x86 specific way).

Yes, and that part of your patch is a good thing, and makes it at
least sensible unlike ingos.  The patch in this mail is the one
we should probably go for short term, although the right way to
sort it out is the long one, aka goign through all users of inline
and deciding what they really want.
