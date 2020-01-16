From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v4 3/9] asm-generic/tlb: Avoid potential double flush
Date: Thu, 16 Jan 2020 12:19:59 +0530
Message-ID: <c12bb139-9eda-74a9-b4de-b147a88ed1b0@linux.ibm.com>
References: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
 <20200116064531.483522-4-aneesh.kumar@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726160AbgAPGuJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Jan 2020 01:50:09 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00G6mUIn118871
        for <linux-arch@vger.kernel.org>; Thu, 16 Jan 2020 01:50:08 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xhgs7h6gm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 16 Jan 2020 01:50:08 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Thu, 16 Jan 2020 06:50:06 -0000
In-Reply-To: <20200116064531.483522-4-aneesh.kumar@linux.ibm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, peterz@infradead.org, will@kernel.org, mpe@ellerman.id.au
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 1/16/20 12:15 PM, Aneesh Kumar K.V wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Aneesh reported that:
> 
> 	tlb_flush_mmu()
> 	  tlb_flush_mmu_tlbonly()
> 	    tlb_flush()			<-- #1
> 	  tlb_flush_mmu_free()
> 	    tlb_table_flush()
> 	      tlb_table_invalidate()
> 		tlb_flush_mmu_tlbonly()
> 		  tlb_flush()		<-- #2
> 
> does two TLBIs when tlb->fullmm, because __tlb_reset_range() will not
> clear tlb->end in that case.
> 
> Observe that any caller to __tlb_adjust_range() also sets at least one
> of the tlb->freed_tables || tlb->cleared_p* bits, and those are
> unconditionally cleared by __tlb_reset_range().
> 
> Change the condition for actually issuing TLBI to having one of those
> bits set, as opposed to having tlb->end != 0.
> 


We should possibly get this to stable too along with the first two 
patches. I am not quiet sure if this will qualify for a stable backport. 
Hence avoided adding Cc:stable@kernel.org


> Reported-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>   include/asm-generic/tlb.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 9e22ac369d1d..b36b3bef5661 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -402,7 +402,12 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
>   
>   static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
>   {
> -	if (!tlb->end)
> +	/*
> +	 * Anything calling __tlb_adjust_range() also sets at least one of
> +	 * these bits.
> +	 */
> +	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
> +	      tlb->cleared_puds || tlb->cleared_p4ds))
>   		return;
>   
>   	tlb_flush(tlb);
> 
