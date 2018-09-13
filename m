From: Jann Horn <jannh@google.com>
Subject: Re: [RFC][PATCH 05/11] asm-generic/tlb: Provide generic tlb_flush
Date: Thu, 13 Sep 2018 15:09:47 +0200
Message-ID: <CAG48ez01-iQ5fyZjOJxQyOk9xRkra6bYyUAvUbVLheuABOQi8Q@mail.gmail.com>
References: <20180913092110.817204997@infradead.org> <20180913092812.132208484@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180913092812.132208484@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, npiggin@gmail.com, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, kernel list <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 13, 2018 at 3:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
> Provide a generic tlb_flush() implementation that relies on
> flush_tlb_range(). This is a little awkward because flush_tlb_range()
> assumes a VMA for range invalidation, but we no longer have one.
>
> Audit of all flush_tlb_range() implementations shows only vma->vm_mm
> and vma->vm_flags are used, and of the latter only VM_EXEC (I-TLB
> invalidates) and VM_HUGETLB (large TLB invalidate) are used.
>
> Therefore, track VM_EXEC and VM_HUGETLB in two more bits, and create a
> 'fake' VMA.
>
> This allows architectures that have a reasonably efficient
> flush_tlb_range() to not require any additional effort.
[...]
> +#define tlb_flush tlb_flush
> +static inline void tlb_flush(struct mmu_gather *tlb)
> +{
> +       if (tlb->fullmm || tlb->need_flush_all) {
> +               flush_tlb_mm(tlb->mm);
> +       } else {
> +               struct vm_area_struct vma = {
> +                       .vm_mm = tlb->mm,
> +                       .vm_flags = tlb->vma_exec ? VM_EXEC    : 0 |
> +                                   tlb->vma_huge ? VM_HUGETLB : 0,

This looks wrong to me. Bitwise OR has higher precedence than the
ternary operator, so I think this code is equivalent to:

.vm_flags = tlb->vma_exec ? VM_EXEC    : (0 | tlb->vma_huge) ? VM_HUGETLB : 0

meaning that executable+huge mappings would only get VM_EXEC, but not
VM_HUGETLB.

> +               };
> +
> +               flush_tlb_range(&vma, tlb->start, tlb->end);
> +       }
>  }
> +#endif
