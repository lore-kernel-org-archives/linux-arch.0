From: Nick Piggin <npiggin@suse.de>
Subject: Re: MMU notifiers review and some proposals
Date: Sat, 26 Jul 2008 14:33:29 +0200
Message-ID: <20080726123329.GB17958@wotan.suse.de>
References: <20080724143949.GB12897@wotan.suse.de> <20080725214552.GB21150@duo.random> <20080726030810.GA18896@wotan.suse.de> <20080726113813.GD21150@duo.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57947 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934AbYGZMdd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 26 Jul 2008 08:33:33 -0400
Content-Disposition: inline
In-Reply-To: <20080726113813.GD21150@duo.random>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Arcangeli <andrea@qumranet.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org, steiner@sgi.com, cl@linux-foundation.org

On Sat, Jul 26, 2008 at 01:38:13PM +0200, Andrea Arcangeli wrote:
> On Sat, Jul 26, 2008 at 05:08:10AM +0200, Nick Piggin wrote:
> > Anyway, I just voice my opinion and let Andrew and Linus decide. To be
> > clear: I have not found any actual bugs in Andrea's -mm patchset, only
> > some dislikes of the approach.
> 
> Yes, like I said I think this is a matter of taste of what you like of
> the tradeoff. There are disadvantages and advantages in both and if we
> wait forever to please everyone taste, it'll never go in.

And for this item, I think there has been a bit too much emphasis
on pleasing the taste of the drivers and not enough on the core
VM. My concern about adding a new TLB flushing design to core VM
was never taken seriously, for example. Nor was my request for
performance numbers. And I did ask early in the year.

I believe when you don't have any real numbers for justification,
the only sane thing to do is go with the most minimal and simplest
implementation first, and add complexity if/when it can be justified.
