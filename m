Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j1N5lqgJ030063
	for <linux-arch@vger.kernel.org>; Tue, 22 Feb 2005 23:47:53 -0600
Subject: Re: Changing  update_mmu_cache() or set_pte() ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1109136942.5412.198.camel@gaston>
References: <1109047997.5327.70.camel@gaston>
	 <1109136942.5412.198.camel@gaston>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 16:47:54 +1100
Message-Id: <1109137674.5412.207.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>


> Ok, the story gets more complicated... While digging around, I found an
> SMP race on ppc32 with the dcache/icache sync that could get a simple
> fix if set_pte() and update_mmu_cache could be made "atomic" (that is,
> if set_pte() was told "put that PTE in your cache too" in places where
> update_mmu_cache would normally be called just after set_pte).
> 
> What do you guys thing about this ? It's relatively trivial to fix
> everybody to add that argument to set_pte() ... It would be constant at
> compile time anyway, so totally optimized away (0 or 1 depending on the
> call site). And we would then kill update_mmu_cache() completely.
> 
> Or maybe the simpler is to define a set_pte_cache() that takes all 3
> arguments and is overridable by the architecture ? With a default in
> asm-generic that just does set_pte() and update_mmu_cache() ?
> 
> The only "special case" that prevents just changing set_pte() as is and
> be done with update_mmu_cache() completely is ptep_set_access_flags()
> which has an update_mmu_cache() right after it too. But I wonder...
> arches that do care about update_mmu_cache() could just have their own
> ptep_set_access_flags() that does the right thing..
> 
> Or somebody has a better idea ?

Hrm... ok, I may have an idea to fix it differently without touching
set_pte and update_mmu_cache() (well, my other need is still there, taht
is adding ptep argument).

Also, I have an idea to improve perfs of execute pages on some ppc64
like the G5 that would need keeping update_mmu_cache() around, and
adding another argument to it, passed all the way up from
do_page_fault(), indicating wether it's an execute access...

Nothing quite firm yet, but I'd like to change the "write_access"
argument of handle_mm_fault into some "access_type" which could be a
bitmask of "read", "execute" and "write". The current test of
"write_access" would just be if (access_type & MM_WRITE_FAULT) while
architectures who can't differenciate execute faults would just have
exec set all the time.

The idea here is that currently, on ppc64, we always map hardware PTEs
with the non-exec bit first.

Then, when taking a fault, we eventually allow execution _and_ flush the
cache appropriately.

Which means that upon a normal fault on paged code, we end up taking a
first hash fault, not finding the PTE, go to do_page_fault(), which the
PTE in, calls update_mmu_cache() which puts a (useless) read HPTE in the
hash, go back to userland, re-fault due to lack of execute permission,
flush the cache, fix the permission, go back to userland.

The only way I see to fix that properly to avoid this double fault is to
know either at set_pte() time or at update_mmu_cache() time (the later I
suppose is much simpler) wether we originate from an exec fault or not,
in which case it would do the cache cleaning before filling the HPTE
with the execute permission set.

I will prototype to measure the perf difference by using a thread flag
to "remember" weather we are coming from do_page_fault() as the result
of an execute fault and let you know if it makes a worthwhile
difference.

Ben.
