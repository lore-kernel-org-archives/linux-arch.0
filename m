From: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
	architectures
Date: Sun, 27 Apr 2008 21:36:27 +0200
Message-ID: <20080427193627.GA32654@elte.hu>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org> <20080427172235.GA2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org> <20080427174714.GB2252@cs181133002.pp.htv.fi> <20080427180007.GB28483@infradead.org> <20080427180957.GA25964@uranus.ravnborg.org> <20080427181411.GA31667@infradead.org> <alpine.LFD.1.10.0804271118500.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804271118500.2896-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>


* Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:

> I do obviously think that we're right to move into the direction that 
> "inline" should be a hint. In fact, the biggest issue I have with the 
> new kconfig option is that I think it should probably be 
> unconditional, but I suspect that compiler issues and architecture 
> issues make that not be a good idea.
> 
> It will take time before we've sorted out all the fall-out, because I 
> bet there is still code out there that _should_ use __always_inline, 
> but doesn't.

yeah, we i think had one such issue in x86 (merged upstream prior and 
independently of this feature iirc). We also know that something on 
powerpc doesnt work right out of box with inline being a hint. And 
that's OK and expected - for years we had "inline == always_inline" and 
there was just no force that moved against that. It was in fact 
surprising how well it all worked out on x86 when we reintroduced this 
feature.

btw., another new aspect of this whole area is that a number of major 
distributions now do CONFIG_CC_OPTIMIZE_FOR_SIZE=y in their kernels, and 
that seems to have brought new life into -Os development and with every 
new gcc generation we get denser and denser code generated. It is an 
interesting fact that generating good _small_ code needs a very good 
compiler that understands the code flow very accurately and is able to 
find the smallest possible representation for that.

A side-effect of that is if we do -Os _and_ turn inline into a hint via 
CONFIG_CC_OPTIMIZE_INLINING=y, gcc tends to do a better job than before. 
It cannot just go and inline stuff agressively in stark contrast to the 
-Os goal that was given to it. It still does not do a perfect job though 
- but now at least it has a _chance_ to improve. With always_inline we 
gave gcc no leeway at all.

a second aspect is that there's always the chance that some other 
compiler comes along that does things better than gcc. Again, with 
inline being a necessity we make it impossible for even sane compilers 
to do the right thing.

and a third aspect is that in the current -git kernel we have exactly 
11801 inlines in non-include files. Fighting the constant influx of them 
was a futile act 3 years ago when Arjan and me created this feature for 
the first time and it is futile today. It is a compiler domain problem 
and we should not waste any manpower "fighting" them. Life is too short :)

	Ingo
