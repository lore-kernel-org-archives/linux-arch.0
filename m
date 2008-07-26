From: Andrea Arcangeli <andrea@qumranet.com>
Subject: Re: MMU notifiers review and some proposals
Date: Sat, 26 Jul 2008 15:16:51 +0200
Message-ID: <20080726131651.GB9598@duo.random>
References: <20080724143949.GB12897@wotan.suse.de> <20080725214552.GB21150@duo.random> <20080726030810.GA18896@wotan.suse.de> <20080726113813.GD21150@duo.random> <20080726130406.GA21820@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:57261
	"EHLO mx.cpushare.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbYGZNQx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 26 Jul 2008 09:16:53 -0400
Content-Disposition: inline
In-Reply-To: <20080726130406.GA21820@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org, steiner@sgi.com, cl@linux-foundation.org

On Sat, Jul 26, 2008 at 03:04:06PM +0200, Nick Piggin wrote:
> On Sat, Jul 26, 2008 at 01:38:13PM +0200, Andrea Arcangeli wrote:
> > 
> > 1) absolute minimal intrusion into the kernel common code, and
> >    absolute minimum number of branches added to the kernel fast
> >    paths. Kernel is faster than your "minimal" type of notifiers when
> >    they're disarmed.
> 
> BTW. is this really significant? Having one branch per pte
> I don't think is necessarily slower than 2 branches per unmap.
> 
> The 2 branches will use more icache and more branch history. One
> branch even once per pte in the unmapping loop is going to remain
> hot in icache and branch history isn't it?

Even if branch-predicted and icached, it's still more executable to
compute in a tight loop. Even if quick it'll accumulate cycles. Said
that perhaps you're right that my point 1 wasn't that important or not
a tangible positive, but surely doing a secondary mmu invalidate for
each pte zapped isn't ideal... that's the whole point of the
tlb-gather logic, nobody wants to do that not even for the primary
tlb, and surely not for the secondary-mmu that may not even be as fast
as the primary-tlb at invalidating. Hence the very simple patch is
clearly inferior when they're armed (if only equivalent when they're
disarmed)...

I think we can argue once you've reduced the frequency of the
secondary mmu invalidates of a factor of 500 by mangling over the tlb
gather logic per-arch.
