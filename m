From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Subject: Re: [RFC][PATCH] kmap_atomic_push
Date: Thu, 8 Oct 2009 19:02:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0910081850270.4553@sister.anvils>
References: <1255016123.17055.17.camel@laptop>  <20091008155344.GA11727@elte.hu>
 <1255019362.26976.311.camel@twins> <alpine.LFD.2.01.0910080945230.3432@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mk-filter-3-a-1.mail.uk.tiscali.com ([212.74.100.54]:32483 "EHLO
	mk-filter-3-a-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751492AbZJHSDr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2009 14:03:47 -0400
In-Reply-To: <alpine.LFD.2.01.0910080945230.3432@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Avi Kivity <avi@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Thu, 8 Oct 2009, Linus Torvalds wrote:
> On Thu, 8 Oct 2009, Peter Zijlstra wrote:
> > 
> > Right, so I did that full rename just so that people wouldn't get
> > confused or something, but if both you and Linus think it should remain:
> > kmap_atomic() and kunmap_atomic(), I can certainly undo that part.

I love the patch, Peter: thank you.  But agree with the others to
keep the old names, just let the change in prototype (vanishing
second arg) do the work of weeding out any stragglers.

> 
> I think the renaming probably helps find all the places (simple "grep -w" 
> shows the difference, and no fear of confusion with comma-expressions and 
> multi-line arguments etc). But once they've all been converted, you might 
> as well then do a search-and-replace-back on the patch, and make the end 
> result look like you just removed the (now pointless) argument.
> 
> In fact, I'd personally be inclined to split the patch into two patches:
> 
>  - one that just ignores the now redundant argument (but still keeps it), 
>    and fixes the cases that didn't nest
> 
>  - one that then removes the argument.
> 
> Why? The _bugs_ are going to be shown by the first patch, and it would be 
> nice to keep that patch small. When a bug shows up, it would be either 
> because there's something wrong in that (much smaller) patch, or because 
> some not-properly-nested casel wasn't fixed.
> 
> In contrast, the second patch would be large, but if done right, you could 
> then prove that it has no actual semantic changes (ie "binary is same 
> before and after"). That just sounds _much_ nicer from a debug standpoint. 
> Developers would look at the small and concentrated "real changes" patch, 
> rather than be distracted by all the trivial noise.

And I very much agree with Linus's two patch approach: it also makes
it much easier to review, separating the wheat of the interesting
changes from the chaff of eliminating the unnecessary arg.  It was
hard to find the interesting part in the patch as you sent it.

I wasn't really checking it, but think I noticed something called
swap_two_pages() somewhere, which wasn't doing the unnesting right:
you may need to swap two lines ;)

Hugh
