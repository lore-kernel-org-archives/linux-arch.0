Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:58332 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbeIMTQN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Sep 2018 15:16:13 -0400
Date: Thu, 13 Sep 2018 16:06:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 05/11] asm-generic/tlb: Provide generic tlb_flush
Message-ID: <20180913140621.GY24124@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
 <20180913092812.132208484@infradead.org>
 <CAG48ez01-iQ5fyZjOJxQyOk9xRkra6bYyUAvUbVLheuABOQi8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez01-iQ5fyZjOJxQyOk9xRkra6bYyUAvUbVLheuABOQi8Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, npiggin@gmail.com, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, kernel list <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20180913140621.2XN4Ca0FYC-OtXacIqnzJpVzzCTES5bP3pm7gX6N1Go@z>

On Thu, Sep 13, 2018 at 03:09:47PM +0200, Jann Horn wrote:
> On Thu, Sep 13, 2018 at 3:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > Provide a generic tlb_flush() implementation that relies on
> > flush_tlb_range(). This is a little awkward because flush_tlb_range()
> > assumes a VMA for range invalidation, but we no longer have one.
> >
> > Audit of all flush_tlb_range() implementations shows only vma->vm_mm
> > and vma->vm_flags are used, and of the latter only VM_EXEC (I-TLB
> > invalidates) and VM_HUGETLB (large TLB invalidate) are used.
> >
> > Therefore, track VM_EXEC and VM_HUGETLB in two more bits, and create a
> > 'fake' VMA.
> >
> > This allows architectures that have a reasonably efficient
> > flush_tlb_range() to not require any additional effort.
> [...]
> > +#define tlb_flush tlb_flush
> > +static inline void tlb_flush(struct mmu_gather *tlb)
> > +{
> > +       if (tlb->fullmm || tlb->need_flush_all) {
> > +               flush_tlb_mm(tlb->mm);
> > +       } else {
> > +               struct vm_area_struct vma = {
> > +                       .vm_mm = tlb->mm,
> > +                       .vm_flags = tlb->vma_exec ? VM_EXEC    : 0 |
> > +                                   tlb->vma_huge ? VM_HUGETLB : 0,
> 
> This looks wrong to me. Bitwise OR has higher precedence than the
> ternary operator, so I think this code is equivalent to:
> 
> .vm_flags = tlb->vma_exec ? VM_EXEC    : (0 | tlb->vma_huge) ? VM_HUGETLB : 0
> 
> meaning that executable+huge mappings would only get VM_EXEC, but not
> VM_HUGETLB.

Bah. Fixed that. Thanks!

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -309,8 +309,8 @@ static inline void tlb_flush(struct mmu_
 	} else {
 		struct vm_area_struct vma = {
 			.vm_mm = tlb->mm,
-			.vm_flags = tlb->vma_exec ? VM_EXEC    : 0 |
-				    tlb->vma_huge ? VM_HUGETLB : 0,
+			.vm_flags = (tlb->vma_exec ? VM_EXEC    : 0) |
+				    (tlb->vma_huge ? VM_HUGETLB : 0),
 		};
 
 		flush_tlb_range(&vma, tlb->start, tlb->end);
