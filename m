Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268373AbUHLCwT@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:50088 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268372AbUHLCwT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 22:52:19 -0400
Date: Wed, 11 Aug 2004 19:51:36 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: clear_user_highpage()
Message-Id: <20040811195136.27783228.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0408111835200.1839@ppc970.osdl.org>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	<Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
	<20040811165307.46ff1eb6.davem@redhat.com>
	<Pine.LNX.4.58.0408111654440.1839@ppc970.osdl.org>
	<20040811172324.33f351bf.davem@redhat.com>
	<Pine.LNX.4.58.0408111835200.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 11 Aug 2004 18:46:56 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> Ok. This is exactly why you want to have a "establish cache line" 
> instruction. Because you _cannot_ make a perfect memset without one.

I can prefetch for one or multiple writes, but these only install the
cacheline in exclusive state if no other cpu responds to the snoop.

> Clearly the ultrasparc doesn't figure out the clear cache-line, and makes 
> the regular memset() be a fairly synchronous "read cacheline + writeout". 
> Which will indeed suck. 

The cache bypassing block stores store 64-bytes at a time (ie. a full
cache line).  So either it goes directly into the L2 cache line from
the write-cache (which itself is 2K) or it goes right out to the memory
bus as a cacheline write.

> Absolutely. What we want from a software perspective is a "get exclusive 
> cacheline without reading it from memory" using a cache line invalidate 
> setup rather than reading it.

Yes.  For the "hit in L2 case" that is what the cache-bypassing stores
on sparc64 effectively do.

> Is there no "store to cache line, but do not establish" instruction?
> Sounds like that should be the fastest one for your setup.

Yes, but it acts that way only on a L2 hit.

> Yeah, sounds horrible. I can't imagine that the cost of bringing it into 
> the cache if it wasn't already can ever really help you. Then you might as 
> well wait with brining it in until much later.

I'm still undecided.  I think there is real value in the issue William and
myself keep bringing up, which is that the arguments you propose hinge upon
the process using some significant portion of the page right after anonymous
page fault time, and I concur with William that this is not typically the
case.
