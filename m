Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39488 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeIMSTj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Sep 2018 14:19:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id c12-v6so1152418otl.6
        for <linux-arch@vger.kernel.org>; Thu, 13 Sep 2018 06:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180913092110.817204997@infradead.org> <20180913092812.132208484@infradead.org>
In-Reply-To: <20180913092812.132208484@infradead.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 13 Sep 2018 15:09:47 +0200
Message-ID: <CAG48ez01-iQ5fyZjOJxQyOk9xRkra6bYyUAvUbVLheuABOQi8Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 05/11] asm-generic/tlb: Provide generic tlb_flush
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, npiggin@gmail.com, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, kernel list <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20180913130947.8M4d3GmWpSOVqaiN1weWxfvagnmSDXCUwstxhjG-oek@z>

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
