Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268451AbUHLAYN@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:36820 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268453AbUHLAYM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 20:24:12 -0400
Date: Wed, 11 Aug 2004 17:23:24 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: clear_user_highpage()
Message-Id: <20040811172324.33f351bf.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0408111654440.1839@ppc970.osdl.org>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	<Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
	<20040811165307.46ff1eb6.davem@redhat.com>
	<Pine.LNX.4.58.0408111654440.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 11 Aug 2004 17:00:37 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> You didn't read my message. If it doesn't crap on the caches when you do 
> the stores, it _will_ crap on the bus both when you do the stores _and_ 
> when you actually read the page.

I understand what you're saying.

> In other words, you will have taken _more_ of a hit later on. It's just 
> that it won't be a nice profile hit, it will be a nasty "everything runs 
> slower later".
> 
> Caches work best when you have good temporal locality. You are removing 
> that locality, and thus you are making your caches _less_ efficient.
> 
> That's a very _fundamental_ argument. 

Here is some more data.

If I use the cache bypassing stores on sparc64 for clear page (which I
do and always have), it takes roughly 4400 cycles to clear a page out
on a 750Mhz cpu regardless of whether the page is in the L2 cache or
not.

Conversely, I played with a version that did not do cache bypass and
for a cache hit it was phenominal, about twice as fast, but for the
cache miss case it was very slow, some 20,000 cycles.  I played around
with trying to prefetch the data into the L2 cache, that didn't help
much in the miss case at all.

Also, when the user takes that first write fault on the anonymous
page, it typically access the first several bytes (it is usually a
malloc chunk or similar), it doesn't trypically walk the entire page.
So to me, bringing the whole thing in seems inefficient.  Let the
process bring the cache lines in, when it's really needed, which (for
all the cache lines in that page) is not necessarily when the write
fault occurs and we clear the page out.  If it happened to be in the
L2 cache at clear_user_highpage() time, it'll stay there during the
clearing and that's great too.

Is that logic fundamentally flawed?

> Larger caches will happen. My argument will get only more relevant. Your 
> approach will force cache misses and tons of memory bus traffic. 

I agree with you.  But I believe, given the data above wrt. sparc64,
it is a profitable scheme at least on that platform.

You definitely have piqued my interest in some things.  I'll try out
the expensive clear_user_highpage() that brings the data into the L2
cache always, and see if that makes kernel builds faster.  Although
I think the fact that clear_user_highpage() will be 5 times slower on
the L2 miss case might nullify any gains bringing the data in always
for the user might give.

We'll see.
