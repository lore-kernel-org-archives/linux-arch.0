From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v5 4/8] mm: tlb: Pass struct mmu_gather to
 flush_pmd_tlb_range
Date: Thu, 2 Apr 2020 18:38:49 +0200
Message-ID: <20200402163849.GM20713@hirez.programming.kicks-ass.net>
References: <20200331142927.1237-1-yezhenyu2@huawei.com>
 <20200331142927.1237-5-yezhenyu2@huawei.com>
 <20200331151331.GS20730@hirez.programming.kicks-ass.net>
 <fe12101e-8efe-22ad-0258-e6aeafc798cc@huawei.com>
 <20200401122004.GE20713@hirez.programming.kicks-ass.net>
 <53675fb9-21c7-5309-07b8-1bbc1e775f9b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <53675fb9-21c7-5309-07b8-1bbc1e775f9b@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, linux-mm@kvack.org, guohanjun@huawei.com, will@kernel.org, linux-arch@vger.kernel.org, yuzhao@google.com, corbet@lwn.net, maz@kernel.org, steven.price@arm.com, arm@kernel.org, Dave.Martin@arm.com, arnd@arndb.de, suzuki.poulose@arm.com, npiggin@gmail.com, zhangshaokun@hisilicon.com, broonie@kernel.org, rostedt@goodmis.org, prime.zeng@hisilicon.com, kuhn.chenqun@huawei.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, xiexiangyou@huawei.com, tony.luck@intel.com, vgupta@synopsys.com, linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

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
