Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751013AbdFSFsO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Jun 2017 01:48:14 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5J5hwnZ083868
        for <linux-arch@vger.kernel.org>; Mon, 19 Jun 2017 01:48:13 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2b64r205k2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 19 Jun 2017 01:48:13 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 19 Jun 2017 06:48:11 +0100
Date: Mon, 19 Jun 2017 07:48:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCHv2 1/3] x86/mm: Provide pmdp_establish() helper
In-Reply-To: <20170615145224.66200-2-kirill.shutemov@linux.intel.com>
References: <20170615145224.66200-1-kirill.shutemov@linux.intel.com>
        <20170615145224.66200-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Message-ID: <20170619074801.18fa2a16@mschwideX1>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20170619054801.HrLEcLUbnCr40-cgs5MHxpJokcVvdALCsOeu1EiPuvg@z>

On Thu, 15 Jun 2017 17:52:22 +0300
"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> We need an atomic way to setup pmd page table entry, avoiding races with
> CPU setting dirty/accessed bits. This is required to implement
> pmdp_invalidate() that doesn't loose these bits.
> 
> On PAE we have to use cmpxchg8b as we cannot assume what is value of new pmd and
> setting it up half-by-half can expose broken corrupted entry to CPU.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/pgtable-3level.h | 18 ++++++++++++++++++
>  arch/x86/include/asm/pgtable.h        | 14 ++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index f5af95a0c6b8..a924fc6a96b9 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1092,6 +1092,20 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
>  	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
>  }
> 
> +#ifndef pmdp_establish
> +#define pmdp_establish pmdp_establish
> +static inline pmd_t pmdp_establish(pmd_t *pmdp, pmd_t pmd)
> +{
> +	if (IS_ENABLED(CONFIG_SMP)) {
> +		return xchg(pmdp, pmd);
> +	} else {
> +		pmd_t old = *pmdp;
> +		*pmdp = pmd;
> +		return old;
> +	}
> +}
> +#endif
> +
>  /*
>   * clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
>   *

For the s390 version of the pmdp_establish function we need the mm to be able
to do the TLB flush correctly. Can we please add a "struct vm_area_struct *vma"
argument to pmdp_establish analog to pmdp_invalidate?

The s390 patch would then look like this:
--
