Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:45694 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbeGZUAx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jul 2018 16:00:53 -0400
Subject: Re: [PATCH v4 01/11] hugetlb: Harmonize hugetlb.h arch specific
 defines with pgtable.h
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180705110716.3919-2-alex@ghiti.fr>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1f95fdc7-378b-9c2a-15ae-da78578a27bf@oracle.com>
Date: Thu, 26 Jul 2018 11:40:49 -0700
MIME-Version: 1.0
In-Reply-To: <20180705110716.3919-2-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180726184049.GsG1n-CTQg-7mQJ1QED9WNdAl0yQP3DCuXKcS4vFMWk@z>

On 07/05/2018 04:07 AM, Alexandre Ghiti wrote:
> asm-generic/hugetlb.h proposes generic implementations of hugetlb
> related functions: use __HAVE_ARCH_HUGE* defines in order to make arch
> specific implementations of hugetlb functions consistent with pgtable.h
> scheme.
> 

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/arm64/include/asm/hugetlb.h | 2 +-
>  include/asm-generic/hugetlb.h    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index e73f68569624..3fcf14663dfa 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -81,9 +81,9 @@ extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  				    unsigned long addr, pte_t *ptep);
>  extern void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  				  unsigned long addr, pte_t *ptep);
> +#define __HAVE_ARCH_HUGE_PTE_CLEAR
>  extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>  			   pte_t *ptep, unsigned long sz);
> -#define huge_pte_clear huge_pte_clear
>  extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
>  				 pte_t *ptep, pte_t pte, unsigned long sz);
>  #define set_huge_swap_pte_at set_huge_swap_pte_at
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index 9d0cde8ab716..3da7cff52360 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -32,7 +32,7 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
>  	return pte_modify(pte, newprot);
>  }
>  
> -#ifndef huge_pte_clear
> +#ifndef __HAVE_ARCH_HUGE_PTE_CLEAR
>  static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>  		    pte_t *ptep, unsigned long sz)
>  {
> 
