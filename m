From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] arch, mm: introduce arch_tlb_gather_mmu_exit
Date: Tue, 28 Nov 2017 19:00:01 +0000
Message-ID: <20171128190001.GD8187@arm.com>
References: <20171123090236.18574-1-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751418AbdK1S77 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Nov 2017 13:59:59 -0500
Content-Disposition: inline
In-Reply-To: <20171123090236.18574-1-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>, Andrea Argangeli <andrea@kernel.org>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Michal Hocko <mhocko@suse.com>

On Thu, Nov 23, 2017 at 10:02:36AM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> 5a7862e83000 ("arm64: tlbflush: avoid flushing when fullmm == 1") has
> introduced an optimization to not flush tlb when we are tearing the
> whole address space down. Will goes on to explain
> 
> : Basically, we tag each address space with an ASID (PCID on x86) which
> : is resident in the TLB. This means we can elide TLB invalidation when
> : pulling down a full mm because we won't ever assign that ASID to
> : another mm without doing TLB invalidation elsewhere (which actually
> : just nukes the whole TLB).
> 
> This all is nice but tlb_gather users are not aware of that and this can
> actually cause some real problems. E.g. the oom_reaper tries to reap the
> whole address space but it might race with threads accessing the memory [1].
> It is possible that soft-dirty handling might suffer from the same
> problem [2] as soon as it starts supporting the feature.
> 
> Introduce an explicit exit variant tlb_gather_mmu_exit which allows the
> behavior arm64 implements for the fullmm case and replace it by an
> explicit exit flag in the mmu_gather structure. exit_mmap path is then
> turned into the explicit exit variant. Other architectures simply ignore
> the flag.
> 
> [1] http://lkml.kernel.org/r/20171106033651.172368-1-wangnan0@huawei.com
> [2] http://lkml.kernel.org/r/20171110001933.GA12421@bbox
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
> Hi,
> I am sending this as an RFC because I am not fully familiar with the tlb
> gather arch implications, espacially the semantic of fullmm. Therefore
> I might duplicate some of its functionality. I hope people on the CC
> list will help me to sort this out.
> 
> Comments? Objections?

I can't think of a case where we'd have exit set but not be doing the
fullmm, in which case I'd be inclined to remove the last two parameters
from tlb_gather_mmu_exit.

Will
