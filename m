Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j1N5ZegJ029957
	for <linux-arch@vger.kernel.org>; Tue, 22 Feb 2005 23:35:41 -0600
Subject: Re: Changing  update_mmu_cache() or set_pte() ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1109047997.5327.70.camel@gaston>
References: <1109047997.5327.70.camel@gaston>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 16:35:42 +1100
Message-Id: <1109136942.5412.198.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2005-02-22 at 15:53 +1100, Benjamin Herrenschmidt wrote:
> Hi !
> 
> I'm doing some work on the ppc32 MMU stuff and I'm faced to a problem
> related to HIGHMEM, and more specifically to PTE pages in HIGHMEM: 
> 
> update_mmu_cache() currently doesn't take the pte pointer. This means it
> has to look it up on ppc, and eventually map the pte page (gack !). But
> if you look at all the call sites for update_mmu_cache, they all have
> the pte pointer and the PTE page already kmap'ed either just before or
> around the call to update_mmu_cache().
> .../...

Ok, the story gets more complicated... While digging around, I found an
SMP race on ppc32 with the dcache/icache sync that could get a simple
fix if set_pte() and update_mmu_cache could be made "atomic" (that is,
if set_pte() was told "put that PTE in your cache too" in places where
update_mmu_cache would normally be called just after set_pte).

What do you guys thing about this ? It's relatively trivial to fix
everybody to add that argument to set_pte() ... It would be constant at
compile time anyway, so totally optimized away (0 or 1 depending on the
call site). And we would then kill update_mmu_cache() completely.

Or maybe the simpler is to define a set_pte_cache() that takes all 3
arguments and is overridable by the architecture ? With a default in
asm-generic that just does set_pte() and update_mmu_cache() ?

The only "special case" that prevents just changing set_pte() as is and
be done with update_mmu_cache() completely is ptep_set_access_flags()
which has an update_mmu_cache() right after it too. But I wonder...
arches that do care about update_mmu_cache() could just have their own
ptep_set_access_flags() that does the right thing..

Or somebody has a better idea ?

(There _is_ a complicated fix which is to do the dcache/icache flush
from the hash fault handler, thus impacting the performance of all hash
faults, and it's all in asm etc..., but I've always disliked the
set_pte/update_mmu_cache separation so ...)

Ben.
