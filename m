Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:51424 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956AbYD2Flg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Apr 2008 01:41:36 -0400
Date: Tue, 29 Apr 2008 07:41:35 +0200
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc] data race in page table setup/walking?
Message-ID: <20080429054135.GD21795@wotan.suse.de>
References: <20080429050054.GC21795@wotan.suse.de> <1209445724.18023.136.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1209445724.18023.136.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Hugh Dickins <hugh@veritas.com>, linux-arch@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>
Message-ID: <20080429054135._w82D_4NcsXJpzPf5MyxcmJqRNXiPyKXIlNhoNdju60@z>

On Tue, Apr 29, 2008 at 03:08:44PM +1000, Benjamin Herrenschmidt wrote:
> 
> On Tue, 2008-04-29 at 07:00 +0200, Nick Piggin wrote:
> > 
> > At this point, the spinlock is not guaranteed to have ordered the previous
> > stores to initialize the pte page with the subsequent store to put it in the
> > page tables. So another Linux page table walker might be walking down (without
> > any locks, because we have split-leaf-ptls), and find that new pte we've
> > inserted. It might try to take the spinlock before the store from the other
> > CPU initializes it. And subsequently it might read a pte_t out before stores
> > from the other CPU have cleared the memory.
> 
> Funny, we used to have a similar race where the zeros for clearing a
> newly allocated anonymous pages end up reaching the coherency domain
> after the new PTE in set_pte, causing memory corruption on threaded
> apps. I think back then we fixed that with an explicit smp_wmb() before
> a set_pte().

Yep, I remember that one. We had the same problem with inserting pages
into the pagecache radix-tree, so I recently changed the fix to encompass
both problems: the barriers are now in SetPageUptodate and (Test)PageUptodate.


> Maybe we need that also when setting the higher levels.

That is my reading of the situation, yes.

