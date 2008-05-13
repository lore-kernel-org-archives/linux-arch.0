From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 2/2] fix SMP data race in pagetable setup vs walking
Date: Tue, 13 May 2008 09:55:32 +0200
Message-ID: <20080513075532.GA19870@wotan.suse.de>
References: <20080505112021.GC5018@wotan.suse.de> <20080505121240.GD5018@wotan.suse.de> <20080505143547.GD14809@linux.vnet.ibm.com> <20080506093823.GD10141@wotan.suse.de> <20080506133224.GD9443@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36646 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757741AbYEMHzi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2008 03:55:38 -0400
Content-Disposition: inline
In-Reply-To: <20080506133224.GD9443@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Hugh Dickins <hugh@veritas.com>, linux-arch@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>

Sorry for the delay, was busy or away from keyboard for various reasons...

On Tue, May 06, 2008 at 06:32:24AM -0700, Paul E. McKenney wrote:
> On Tue, May 06, 2008 at 11:38:24AM +0200, Nick Piggin wrote:
> > 
> > I'm wondering about this... and the problem does not only exist in
> > memory ordering situations, but also just when using a single loaded
> > value in a lot of times.
> > 
> > I'd be slightly worried about requiring this of threaded code. Even
> > the regular memory ordering bugs we even have in core mm code is kind of
> > annoying (and it is by no means just this current bug).
> > 
> > Is it such an improvement to refetch a pointer versus spilling to stack?
> > Can we just ask gcc for a -multithreading-for-dummies mode?
> 
> I have thus far not been successful on this one in the general case.
> It would be nice to be able to tell gcc that you really mean it when
> you assign to a local variable...

Yes, exactly...

 
> > In that case it isn't really an ordering issue between two variables,
> > but an issue within a single variable. And I'm not exactly sure we want
> > to go down the path of trying to handle this. At least it probably belongs
> > in a different patch.
> 
> Well, I have seen this sort of thing in real life with gcc, so I can't say
> that I agree...  I was quite surprised the first time around!

I didn't intend to suggest that you are incorrect, or that ACCESS_ONCE
is not technically required for correctness. But I question whether it
is better to try fixing this throughout our source code, or in gcc's.
