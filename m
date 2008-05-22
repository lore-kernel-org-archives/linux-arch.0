From: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc] add io barriers, remove mmiowb
Date: Thu, 22 May 2008 11:51:21 +0200
Message-ID: <20080522095121.GA18012@wotan.suse.de>
References: <20080521152855.GE8897@wotan.suse.de> <yq0fxsaivo4.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:36000 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755698AbYEVJvY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 May 2008 05:51:24 -0400
Content-Disposition: inline
In-Reply-To: <yq0fxsaivo4.fsf@jaguar.mkp.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jes Sorensen <jes@sgi.com>
Cc: linux-arch@vger.kernel.org, jbarnes@virtuousgeek.org, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, May 22, 2008 at 04:34:51AM -0400, Jes Sorensen wrote:
> >>>>> "Nick" == Nick Piggin <npiggin@suse.de> writes:
> 
> Nick> mb and wmb are now no longer guaranteed to order system memory
> Nick> operations with device memory stores. mmiowb has been introduced
> Nick> to provide this ordering (when combined with a mb, wmb, or
> Nick> spin_unlock). Unfortunately, it appears to be rather less well
> Nick> understood among both users and implementors than even the old
> Nick> memory barrier scheme. It also subtly breaks existing code that
> Nick> uses mb or wmb (if only on sn2). I really think it is not a good
> Nick> solution.
> 
> Nick> The alternative I propose is to restore mb and wmb to their full
> Nick> strength.  This does mean that sn2 has to do the equivalent of
> Nick> mb+mmiowb, wmb+mmiowb respectively, but that's the price you pay
> Nick> for weak memory ordering.
> 
> Nick,
> 
> Introducing this constraint would make me less than pleased I have to
> admit. It's a very expensive operation to do since it requires going
> out talking to the PCI bridge, doing that on every wmb() is going to
> really hurt :-(

Right, but probably the large majority of wmb() callers actually
just want io_wmb(). This would relieve much of the performance
problem, I'd say.

Of those that really want a wmb() and cannot be converted to
io_wmb(), I don't think it is a good option to actually just weaken
wmb() because we deem that doing what the caller asked for is too
expensive.

I guess with the ia64_mf(), Altix probably does not reorder PCI
stores past earlier cacheable stores, so _some_ wmb()s actually
do not require the full mmiowb case (if we only need to order
an earlier RAM store with a later PCI store). However, again,
weakening wmb() is not a good option because it really requires
an audit of the entire tree to do that.

We _could_ introduce partial barriers like store/iostore iostore/store,
but really, I think the io_wmb is a pretty good first step, and I
haven't actually seen any numbers indicating it would be a performance
problem.
