From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 2/2] fix SMP data race in pagetable setup vs walking
Date: Tue, 13 May 2008 17:55:50 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805131753150.3019@woody.linux-foundation.org>
References: <20080505112021.GC5018@wotan.suse.de> <20080505121240.GD5018@wotan.suse.de> <alpine.LFD.1.10.0805050828120.32269@woody.linux-foundation.org> <20080506095138.GE10141@wotan.suse.de> <alpine.LFD.1.10.0805060750430.32269@woody.linux-foundation.org>
 <20080513080143.GB19870@wotan.suse.de> <alpine.LFD.1.10.0805130844000.3019@woody.linux-foundation.org> <20080514003417.GA24516@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50905 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761206AbYENA4m (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2008 20:56:42 -0400
In-Reply-To: <20080514003417.GA24516@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, linux-arch@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>, Paul McKenney <paulmck@us.ibm.com>



On Wed, 14 May 2008, Nick Piggin wrote:
> 
> Uh, I don't follow your logic. The "reference" Linux memory model
> requires it, so I don't see how you can justify saying it is wrong
> just because a *specific* architecture doesn't need it.

You're thinking about it the wrong way.

NO specific architecture requires it except for alpha, and alpha already 
has it.

Nobody else is *ever* likely to want it ever again.

In other words, it's not a "reference model". It's an "alpha hack". We do 
not want to copy it in code that doesn't need or want it.

And that's especially true when it's not needed at all, and adding it just 
makes a really simple macro much more complex and totally unreadable.

If it was about adding something to a function that was already a real 
function, it would be different.

If you coudl write it as a nice inline function, it would be different.

But when that alpha hack turns a regular (simple) #define into a thing of 
horror, the downside is much *much* bigger than any (non-existent) upside.

		Linus
