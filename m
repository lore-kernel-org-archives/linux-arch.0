Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268345AbUHLCI2@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:51411 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268349AbUHLCI2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 22:08:28 -0400
Date: Thu, 12 Aug 2004 04:08:25 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: clear_user_highpage()
Message-ID: <20040812020825.GA14411@wotan.suse.de>
References: <20040811161537.5e24c2b6.davem@redhat.com> <Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org> <20040811165307.46ff1eb6.davem@redhat.com> <Pine.LNX.4.58.0408111654440.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408111654440.1839@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Aug 11, 2004 at 05:00:37PM -0700, Linus Torvalds wrote:
> You didn't read my message. If it doesn't crap on the caches when you do 
> the stores, it _will_ crap on the bus both when you do the stores _and_ 
> when you actually read the page.

I discovered this the hard way on Opteron too. At some point
I was doing clear_page using cache bypassing write combining stores.
That was done because it was faster in microbenchmarks that just
tested the function. But on actual macro benchmarks it was quite
bad because the applications were eating cache misses all the time.

Doing it in the idle loop would have the same problem.

When I could see it making sense would be for page table 
pages though (especially when you cache in a bitmap what ptes
have been actually touched and ignore the rest) 

> In other words, you will have taken _more_ of a hit later on. It's just 
> that it won't be a nice profile hit, it will be a nasty "everything runs 
> slower later".

Yep, it's a bad idea.

-Andi
