From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
	architectures
Date: Sun, 27 Apr 2008 14:32:52 -0400
Message-ID: <20080427183252.GB23828@infradead.org>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org> <20080427172235.GA2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org> <20080427174714.GB2252@cs181133002.pp.htv.fi> <20080427180007.GB28483@infradead.org> <20080427180957.GA25964@uranus.ravnborg.org> <20080427181411.GA31667@infradead.org> <alpine.LFD.1.10.0804271118500.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804271118500.2896-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

On Sun, Apr 27, 2008 at 11:24:28AM -0700, Linus Torvalds wrote:
> The thing is, the "inline" vs "always_inline" thing _could_ make sense, 
> but sadly doesn't much.
> 
> Part of it is that gcc imnsho inlines too aggressively anyway in the 
> absense of "inline", so there's no way "inline" can mean "you might 
> inline" this, because gcc will do that anyway even without it. As a 
> result, in _practice_ "inline" and "always_inline" end up being very close 
> to each other - perhaps more so than they should.

Yes, absolutely.   In recent gcc versions it's in fact so bad that xfs
had to add a hack to mark every function not explicitly marker inline
noinline because otherwise gcc would inline gazillions of big functions
which combines with it's horrible liveness analysis led to enormous
stack useage.  (I think the liveness part is getting better these days
to be fair)

> It will take time before we've sorted out all the fall-out, because I bet 
> there is still code out there that _should_ use __always_inline, but 
> doesn't.

Given that __always_inline only shows up in non-x86 arch code in
homeopathic quantity it's a fair bet that there's a lot of breakage
waiting there.  Which was one of the initial complains about the way
it's done..
