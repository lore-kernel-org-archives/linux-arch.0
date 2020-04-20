From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [RFC][Qusetion] the value of cleared_(ptes|pmds|puds|p4ds) in
 struct mmu_gather
Date: Mon, 20 Apr 2020 18:20:23 +0200
Message-ID: <20200420182023.6b8e143a@thinkpad>
References: <fbb00ac0-9104-8d25-f225-7b3d1b17a01f@huawei.com>
        <20200330121654.GL20696@hirez.programming.kicks-ass.net>
        <68affa6e-44cd-37e3-cdfc-8eec31c4097e@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <68affa6e-44cd-37e3-cdfc-8eec31c4097e@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Zhenyu Ye <yezhenyu2@huawei.com>, npiggin@gmail.com, will.deacon@arm.com, mingo@kernel.org, torvalds@linux-foundation.org, Vasily Gorbik <gor@linux.ibm.com>, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arm@kernel.org, xiexiangyou@huawei.com, linux-s390 <linux-s390@vger.kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Wed, 8 Apr 2020 10:51:59 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

[...]
> 
> adding Gerald and Vasily. Gerald can you have a look?
> 
> >>
> >>
> >> In my view, the cleared_(ptes|pmds|puds) and (pte|pmd|pud)_free_tlb
> >> correspond one-to-one.  So we should set cleared_ptes in pte_free_tlb(),
> >> then use it when needed.
> > 
> > So pte_free_tlb() clears a table of PTE entries, or a PMD level entity,
> > also see free_pte_range(). So the generic code makes sense to me. The
> > PTE level invalidations will have happened on tlb_remove_tlb_entry().
> > 
> >> I'm very confused about this. Which is wrong? Or is there something
> >> I understand wrong?
> > 
> > I agree the s390 case is puzzling, Martin does s390 need a PTE level
> > invalidate for removing a PTE table or was this a mistake?
> > 

Peter is right, the PTE level invalidations will happen before. For
s390, not exactly at the tlb_remove_tlb_entry() itself, since
__tlb_remove_tlb_entry() is not defined, but rather directly at the
preceding ptep_get_and_clear(). I think this also the reason why we
cannot easily optimize for larger granularity.

Anyway, pte_free_tlb() will then later only take care of freeing
the page table page, no further PTE level clearing/invalidation
needed. I see no reason why s390 should behave differently from
the generic code, wrt to cleared_pxds setting in pxd_free_tlb().

So I guess this was an "off-by-one" mistake in commit 9de7d833e3708
("s390/tlb: Convert to generic mmu_gather"), since the other
pxd_free_tlb() functions also show similar puzzling behavior.
Not consistently off-by-one though, as pmd_free_tlb() seems
to behave correctly, setting tlb->cleared_puds = 1, similar to
generic code.

That was a very nice catch, Zhenyu, thanks for reporting!
We are not yet making use of the tlb->cleared_pxds for s390, but
we would certainly have stumbled over this if we ever tried.
Will send a patch to make s390 behave like generic code here.

Regards,
Gerald
