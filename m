From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
 architectures
Date: Sun, 27 Apr 2008 11:24:28 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804271118500.2896@woody.linux-foundation.org>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org> <20080427172235.GA2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org>
 <20080427174714.GB2252@cs181133002.pp.htv.fi> <20080427180007.GB28483@infradead.org> <20080427180957.GA25964@uranus.ravnborg.org> <20080427181411.GA31667@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080427181411.GA31667-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>



On Sun, 27 Apr 2008, Christoph Hellwig wrote:
> 
> As Linus mentioned the hint doesn't make any sense because gcc will
> get it wrong anyway.  In fact when you look at kernel code it tends
> to inline the everything and the kitchensink as long as there's just
> one caller and this bloat the stack but doesn't inline where it needs
> to.  Better don't try to mess with that and do it explicit.

The thing is, the "inline" vs "always_inline" thing _could_ make sense, 
but sadly doesn't much.

Part of it is that gcc imnsho inlines too aggressively anyway in the 
absense of "inline", so there's no way "inline" can mean "you might 
inline" this, because gcc will do that anyway even without it. As a 
result, in _practice_ "inline" and "always_inline" end up being very close 
to each other - perhaps more so than they should.

I do obviously think that we're right to move into the direction that 
"inline" should be a hint. In fact, the biggest issue I have with the new 
kconfig option is that I think it should probably be unconditional, but I 
suspect that compiler issues and architecture issues make that not be a 
good idea.

It will take time before we've sorted out all the fall-out, because I bet 
there is still code out there that _should_ use __always_inline, but 
doesn't.

			Linus
