Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268430AbUHKX5x@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:15561 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268353AbUHKXyH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 19:54:07 -0400
Date: Wed, 11 Aug 2004 16:53:07 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: clear_user_highpage()
Message-Id: <20040811165307.46ff1eb6.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	<Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 11 Aug 2004 16:46:10 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> It sucks because it does bad things to cache behaviour. Sure, you'll move 
> the cost away from "clear_user_highpage", but the thing is, you will _not_ 
> move it into the idle time. What you will do is to move it into some 
> random time _after_ the idle time, when the idle thing has crapped all 
> over your caches.

It won't crap out the caches on sparc64 and any platform with cache-bypass-
on-miss stores.  I believe ia64 and opteron have similar mechanisms.

If the store misses the L2 cache it goes straight out to main memory,
it doesn't allocate cache lines anywhere in such cases.

I think ppc/ppc64 has this too... no, sorry, it has the data-cache allocate
line and zero instruction, which isn't what you want here.

> The thing is, you make your cache footprint per CPU _much_ bigger, and you 
> spread it out a lot over time too, so you make it even worse.
> 
> The clearing will then be totally hidden in the profiles, because you will
> have turned a nice and well-behaved "this is there the time goes" profile
> into a mush of "we're taking cache misses at random times, and we don't
> know why".

Therefore, I do not believe any of this is applicable.
