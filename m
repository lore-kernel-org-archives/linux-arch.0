Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268328AbUHLBrI@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:53930 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268264AbUHLBrH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 21:47:07 -0400
Date: Wed, 11 Aug 2004 18:46:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: clear_user_highpage()
In-Reply-To: <20040811172324.33f351bf.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0408111835200.1839@ppc970.osdl.org>
References: <20040811161537.5e24c2b6.davem@redhat.com>
 <Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org> <20040811165307.46ff1eb6.davem@redhat.com>
 <Pine.LNX.4.58.0408111654440.1839@ppc970.osdl.org> <20040811172324.33f351bf.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "David S. Miller" <davem@redhat.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>



On Wed, 11 Aug 2004, David S. Miller wrote:
> 
> If I use the cache bypassing stores on sparc64 for clear page (which I
> do and always have), it takes roughly 4400 cycles to clear a page out
> on a 750Mhz cpu regardless of whether the page is in the L2 cache or
> not.
> 
> Conversely, I played with a version that did not do cache bypass and
> for a cache hit it was phenominal, about twice as fast, but for the
> cache miss case it was very slow, some 20,000 cycles.  I played around
> with trying to prefetch the data into the L2 cache, that didn't help
> much in the miss case at all.

Ok. This is exactly why you want to have a "establish cache line" 
instruction. Because you _cannot_ make a perfect memset without one.

I'm surprised that even CPU's that have cache control instructions don't 
have the very fundamental "establish" one. ppc is actually the only one I 
know about that does that.

Clearly the ultrasparc doesn't figure out the clear cache-line, and makes 
the regular memset() be a fairly synchronous "read cacheline + writeout". 
Which will indeed suck. 

> So to me, bringing the whole thing in seems inefficient.

Absolutely. What we want from a software perspective is a "get exclusive 
cacheline without reading it from memory" using a cache line invalidate 
setup rather than reading it.

> Is that logic fundamentally flawed?

I suspect that the cache-bypass stores might be the right thing until the 
cache grows big enough that it hurts more than it helps.

Is there no "store to cache line, but do not establish" instruction?
Sounds like that should be the fastest one for your setup.

> You definitely have piqued my interest in some things.  I'll try out
> the expensive clear_user_highpage() that brings the data into the L2
> cache always, and see if that makes kernel builds faster.  Although
> I think the fact that clear_user_highpage() will be 5 times slower on
> the L2 miss case might nullify any gains bringing the data in always
> for the user might give.

Yeah, sounds horrible. I can't imagine that the cost of bringing it into 
the cache if it wasn't already can ever really help you. Then you might as 
well wait with brining it in until much later.

		Linus
