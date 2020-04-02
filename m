Return-Path: <SRS0=V2YN=5S=kvack.org=owner-linux-mm@kernel.org>
Date: Thu, 2 Apr 2020 18:38:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v5 4/8] mm: tlb: Pass struct mmu_gather to
 flush_pmd_tlb_range
Message-ID: <20200402163849.GM20713@hirez.programming.kicks-ass.net>
References: <20200331142927.1237-1-yezhenyu2@huawei.com>
 <20200331142927.1237-5-yezhenyu2@huawei.com>
 <20200331151331.GS20730@hirez.programming.kicks-ass.net>
 <fe12101e-8efe-22ad-0258-e6aeafc798cc@huawei.com>
 <20200401122004.GE20713@hirez.programming.kicks-ass.net>
 <53675fb9-21c7-5309-07b8-1bbc1e775f9b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53675fb9-21c7-5309-07b8-1bbc1e775f9b@huawei.com>
Sender: owner-linux-mm@kvack.org
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, corbet@lwn.net, vgupta@synopsys.com, tony.luck@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200402163849.8PaLnsXpUNKYw7MZw9UXHchyP0AkWxaXitTymXHD4ug@z>

On Thu, Apr 02, 2020 at 07:24:04PM +0800, Zhenyu Ye wrote:
> Thanks for your detailed explanation.  I notice that you used
> `tlb_end_vma` replace `flush_tlb_range`, which will call `tlb_flush`,
> then finally call `flush_tlb_range` in generic code.  However, some
> architectures define tlb_end_vma|tlb_flush|flush_tlb_range themselves,
> so this may cause problems.
> 
> For example, in s390, it defines:
> 
> #define tlb_end_vma(tlb, vma)			do { } while (0)
> 
> And it doesn't define it's own flush_pmd_tlb_range().  So there will be
> a mistake if we changed flush_pmd_tlb_range() using tlb_end_vma().
> 
> Is this really a problem or something I understand wrong ?

If tlb_end_vma() is a no-op, then tlb_finish_mmu() will do:
tlb_flush_mmu() -> tlb_flush_mmu_tlbonly() -> tlb_flush()

And s390 has tlb_flush().

If tlb_end_vma() is not a no-op and it calls tlb_flush_mmu_tlbonly(),
then tlb_finish_mmu()'s invocation of tlb_flush_mmu_tlbonly() will
terniate early due o no flags set.

IOW, it should all just work.


FYI the whole tlb_{start,end}_vma() thing is a only needed when the
architecture doesn't implement tlb_flush() and instead default to using
flush_tlb_range(), at which point we need to provide a 'fake' vma.

At the time I audited all architectures and they only look at VM_EXEC
(to do $I invalidation) and VM_HUGETLB (for pmd level invalidations),
but I forgot which architectures that were.

But that is all legacy code; eventually we'll get all archs a native
tlb_flush() and this can go away.
