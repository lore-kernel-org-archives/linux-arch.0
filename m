Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268419AbUHLACk@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:22986 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268308AbUHLAAr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 20:00:47 -0400
Date: Wed, 11 Aug 2004 17:00:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: clear_user_highpage()
In-Reply-To: <20040811165307.46ff1eb6.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0408111654440.1839@ppc970.osdl.org>
References: <20040811161537.5e24c2b6.davem@redhat.com>
 <Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org> <20040811165307.46ff1eb6.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "David S. Miller" <davem@redhat.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>



On Wed, 11 Aug 2004, David S. Miller wrote:
> On Wed, 11 Aug 2004 16:46:10 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > It sucks because it does bad things to cache behaviour. Sure, you'll move 
> > the cost away from "clear_user_highpage", but the thing is, you will _not_ 
> > move it into the idle time. What you will do is to move it into some 
> > random time _after_ the idle time, when the idle thing has crapped all 
> > over your caches.
> 
> It won't crap out the caches on sparc64 and any platform with cache-bypass-
> on-miss stores.  I believe ia64 and opteron have similar mechanisms.

You didn't read my message. If it doesn't crap on the caches when you do 
the stores, it _will_ crap on the bus both when you do the stores _and_ 
when you actually read the page.

In other words, you will have taken _more_ of a hit later on. It's just 
that it won't be a nice profile hit, it will be a nasty "everything runs 
slower later".

Caches work best when you have good temporal locality. You are removing 
that locality, and thus you are making your caches _less_ efficient.

That's a very _fundamental_ argument. 

> If the store misses the L2 cache it goes straight out to main memory,
> it doesn't allocate cache lines anywhere in such cases.
> 
> I think ppc/ppc64 has this too... no, sorry, it has the data-cache allocate
> line and zero instruction, which isn't what you want here.

It's exactly what you _do_ want, it's just that you want it in 
"clear_user_highpage()". Then you have the perfect cache behaviour, 
assuming your cache is big enough that it will likely get a good hit 
ratio on the new page.

And let's admit it now: caches _are_ big enough that they get good hit 
ratios on things with good temporal locality. 

Larger caches will happen. My argument will get only more relevant. Your 
approach will force cache misses and tons of memory bus traffic. 

		Linus
