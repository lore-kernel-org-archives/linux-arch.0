From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 3/3] mm, thp: Do not loose dirty bit in
 __split_huge_pmd_locked()
Date: Wed, 14 Jun 2017 16:18:57 +0200
Message-ID: <20170614161857.69d54338@mschwideX1>
References: <20170614135143.25068-1-kirill.shutemov@linux.intel.com>
        <20170614135143.25068-4-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750721AbdFNOTF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Jun 2017 10:19:05 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5EEDvQw120580
        for <linux-arch@vger.kernel.org>; Wed, 14 Jun 2017 10:19:05 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2b34wwyapf-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 14 Jun 2017 10:19:04 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 14 Jun 2017 15:19:02 +0100
In-Reply-To: <20170614135143.25068-4-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Wed, 14 Jun 2017 16:51:43 +0300
"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> Until pmdp_invalidate() pmd entry is present and CPU can update it,
> setting dirty. Currently, we tranfer dirty bit to page too early and
> there is window when we can miss dirty bit.
> 
> Let's call SetPageDirty() after pmdp_invalidate().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ...
> @@ -2046,6 +2043,14 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  	 * pmd_populate.
>  	 */
>  	pmdp_invalidate(vma, haddr, pmd);
> +
> +	/*
> +	 * Transfer dirty bit to page after pmd invalidated, so CPU would not
> +	 * be able to set it under us.
> +	 */
> +	if (pmd_dirty(*pmd))
> +		SetPageDirty(page);
> +
>  	pmd_populate(mm, pmd, pgtable);
> 
>  	if (freeze) {

That won't work on s390. After pmdp_invalidate the pmd entry is gone,
it has been replaced with _SEGMENT_ENTRY_EMPTY. This includes the
dirty and referenced bits. The old scheme is

        entry = *pmd;
        pmdp_invalidate(vma, addr, pmd);
	if (pmd_dirty(entry))
		...

Could we change pmdp_invalidate to make it return the old pmd entry?
The pmdp_xchg_direct function already returns it, for s390 that would
be an easy change. The above code snippet would change like this:

	entry = pmdp_invalidate(vma, addr, pmd);
	if (pmd_dirty(entry))
		...

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
