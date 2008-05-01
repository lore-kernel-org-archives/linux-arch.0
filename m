Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60797 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752002AbYEADZ0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Apr 2008 23:25:26 -0400
Date: Wed, 30 Apr 2008 20:24:48 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [rfc] data race in page table setup/walking?
In-Reply-To: <20080501002955.GA11312@wotan.suse.de>
Message-ID: <alpine.LFD.1.10.0804302020050.5994@woody.linux-foundation.org>
References: <20080429050054.GC21795@wotan.suse.de> <Pine.LNX.4.64.0804291333540.22025@blonde.site> <20080430060340.GE27652@wotan.suse.de> <alpine.LFD.1.10.0804300848390.2997@woody.linux-foundation.org> <20080501002955.GA11312@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, linux-arch@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20080501032448.ry7eN2JTvJStvTzC_X7v2cisaCgs18yPxcFvUzix5LQ@z>



On Thu, 1 May 2008, Nick Piggin wrote:
> > 
> > Of course, on x86, the write ordering is strictly defined, and even if the 
> > CPU reorders writes they are guaranteed to never show up re-ordered, so 
> > this is not an issue. But I wanted to point out that memory ordering is 
> > *not* just about cachelines, and being in the same cacheline is no 
> > guarantee of anything, even if it can have *some* effects.
> 
> Well it is a guarantee about cache coherency presumably, but I guess
> you're taking that for granted.

Yes, I'm taking cache coherency for granted, I don't think it's worth even 
worrying about non-coherent cases.

> But I'm surprised that two writes to the same cacheline (different
> words) can be reordered. Of course write buffers are technically outside
> the coherency domain, but I would have thought any implementation will
> actually treat writes to the same line as aliasing. Is there a counter
> example?

I don't know if anybody does it, but no, normally I would *not* expect any 
alias logic to have anything to do with cachelines. Aliasing within a 
cacheline is so common (spills to the stack, if nothing else) that if the 
CPU has some write buffer alias logic, I'd expect it to be byte or perhaps 
word-granular.

So I think that at least in theory it is quite possible that a later write 
hits the same cacheline first, just because the write data or address got 
resolved first and the architecture allows out-of-order memory accesses. 

Whether you'll ever see it in practice, I don't know.  Never on x86, of 
course.

		Linus
