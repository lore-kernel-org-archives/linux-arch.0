From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 2/2] fix SMP data race in pagetable setup vs walking
Date: Tue, 6 May 2008 07:53:23 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805060750430.32269@woody.linux-foundation.org>
References: <20080505112021.GC5018@wotan.suse.de> <20080505121240.GD5018@wotan.suse.de> <alpine.LFD.1.10.0805050828120.32269@woody.linux-foundation.org> <20080506095138.GE10141@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41861 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755139AbYEFOxs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 10:53:48 -0400
In-Reply-To: <20080506095138.GE10141@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, linux-arch@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>, Paul McKenney <paulmck@us.ibm.com>



On Tue, 6 May 2008, Nick Piggin wrote:
> 
> Right. As the comment says, the x86 stuff is kind of a "reference"
> implementation, although if you prefer it isn't there, then I I can
> easily just make it alpha only.

If there really was a point in teaching people about 
"read_barrier_depends()", I'd agree that it's probably good to have it as 
a reference in the x86 implementation.

But since alpha is the only one that needs it, and is likely to remain so, 
it's not like we ever want to copy that code to anything else, and it 
really is better to make it alpha-only if the code is so much uglier.

Maybe just a comment?

As to the ACCESS_ONCE() thing, thinking about it some more, I doubt it 
really matters. We're never going to change pgd anyway, so who cares if we 
access it once or a hundred times?

			Linus
