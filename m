From: Nick Piggin <npiggin@suse.de>
Subject: Re: MMU notifiers review and some proposals
Date: Sun, 27 Jul 2008 14:38:39 +0200
Message-ID: <20080727123839.GD5223@wotan.suse.de>
References: <20080724143949.GB12897@wotan.suse.de> <20080727024520.7dd12bf0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38231 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbYG0Mil (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 27 Jul 2008 08:38:41 -0400
Content-Disposition: inline
In-Reply-To: <20080727024520.7dd12bf0.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org, andrea@qumranet.com, steiner@sgi.com, cl@linux-foundation.org

On Sun, Jul 27, 2008 at 02:45:20AM -0700, Andrew Morton wrote:
> On Thu, 24 Jul 2008 16:39:49 +0200 Nick Piggin <npiggin@suse.de> wrote:
> 
> > I think everybody is hoping to have a workable mmu notifier scheme
> > merged in 2.6.27 (myself included). However I do have some concerns
> > about the implementation proposed (in -mm).
> > 
> > I apologise for this late review, before anybody gets too upset,
> > most of my concerns have been raised before, but I'd like to state
> > my case again and involving everyone.
> 
> Nick, having read through this discussion and the code (yet again) I
> think I'll go ahead and send it all in to Linus.  On the basis that

You call. As I said, I was OK for you to use your judgement.

 
> - the code is fairly short and simple
> 
> - has no known bugs
> 
> - seems to be needed by some folks ;)
> 
> - you already have a protopatch which partially addresses your
>   concerns and afaik there's nothing blocking future improvements to
>   this implementation?

Seems like I was able to get my head around KVM and GRU more easily
than I had feared. I don't expect help, but I will say that good
simplifications will always get merged unless there is a reasonable
performance case not to, so I will work on patches.


> And a late-breaking review comment: given that about 0.000000000000001%
> of people will actually use mm_take_all_locks(), could we make its
> compilation conditional on something?  Such as CONFIG_MMU_NOTIFIER?

Well I prefer that because I don't want any new callers to pop up.
