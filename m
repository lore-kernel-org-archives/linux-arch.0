From: Nick Piggin <npiggin@suse.de>
Subject: Re: handle_mm_fault() calling convention cleanup..
Date: Mon, 6 Jul 2009 09:31:48 +0200
Message-ID: <20090706073148.GJ2714@wotan.suse.de>
References: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain> <1246664107.7551.11.camel@pasglop> <alpine.LFD.2.01.0907040937040.3210@localhost.localdomain> <1246741718.7551.22.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57361 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbZGFHbr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 6 Jul 2009 03:31:47 -0400
Content-Disposition: inline
In-Reply-To: <1246741718.7551.22.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Wu Fengguang <fengguang.wu@intel.com>, Ingo Molnar <mingo@elte.hu>

On Sun, Jul 05, 2009 at 07:08:38AM +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2009-07-04 at 09:44 -0700, Linus Torvalds wrote:
> 
> > Just a tiny word of warning: right now, the conversion I did pretty much 
> > depended on the fact that even if I missed a spot, it wouldn't actually 
> > make any difference. If somebody used "flags" as a binary value (ie like 
> > the old "write_access" kind of semantics), things would still all work, 
> > because it was still a "zero-vs-nonzero" issue wrt writes.
> 
>  .../...
> 
> Right. Oh well.. we'll see when I get to it. I have a few higher
> priority things on my pile at the moment.

I have no problems with that. I'd always intended to have flags
go further up the call chain like Linus did (since we'd discussed
perhaps making faults interruptible and requiring an extra flag
to distinguish get_user_pages callers that were not interruptible).

So yes adding more flags to improve code or make things simpler
is fine by me :)

Thanks,
Nick
