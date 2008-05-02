From: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc] data race in page table setup/walking?
Date: Fri, 2 May 2008 03:43:37 +0200
Message-ID: <20080502014337.GA11844@wotan.suse.de>
References: <20080429050054.GC21795@wotan.suse.de> <Pine.LNX.4.64.0804291333540.22025@blonde.site> <20080430060340.GE27652@wotan.suse.de> <alpine.LFD.1.10.0804300848390.2997@woody.linux-foundation.org> <20080501002955.GA11312@wotan.suse.de> <alpine.LFD.1.10.0804302020050.5994@woody.linux-foundation.org> <20080502012006.GD30768@wotan.suse.de> <alpine.LFD.1.10.0805011832010.5994@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:59043 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbYEBBnk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 May 2008 21:43:40 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805011832010.5994@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hugh Dickins <hugh@veritas.com>, linux-arch@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Thu, May 01, 2008 at 06:33:45PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 2 May 2008, Nick Piggin wrote:
> > 
> > I guess it is possible. But at least in the case of write address, you'd
> > have to wait for later stores anyway in order to do the alias detection,
> > which might be the most common case.
> 
> No, just the *address*. The data for the second store may not be ready, 
> but the address may have been resolved (and checked that it doesn't fault 
> etc) and the previous store may complete.

Yes in the case of other dependencies I agreed that it would be possible.
In the case of just address it doesn't really make sense.
