From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCHv4 09/12] x86/mm: Provide pmdp_establish() helper
Date: Wed, 13 Dec 2017 16:09:51 -0800
Message-ID: <20171213160951.249071f2aecdccb38b6bb646@linux-foundation.org>
References: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
        <20171213105756.69879-10-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56774 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbdLNAJx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Dec 2017 19:09:53 -0500
In-Reply-To: <20171213105756.69879-10-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Wed, 13 Dec 2017 13:57:53 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> We need an atomic way to setup pmd page table entry, avoiding races with
> CPU setting dirty/accessed bits. This is required to implement
> pmdp_invalidate() that doesn't lose these bits.
> 
> On PAE we can avoid expensive cmpxchg8b for cases when new page table
> entry is not present. If it's present, fallback to cpmxchg loop.
> 
> ...
>
> --- a/arch/x86/include/asm/pgtable-3level.h
> +++ b/arch/x86/include/asm/pgtable-3level.h
> @@ -158,7 +158,6 @@ static inline pte_t native_ptep_get_and_clear(pte_t *ptep)
>  #define native_ptep_get_and_clear(xp) native_local_ptep_get_and_clear(xp)
>  #endif
>  
> -#ifdef CONFIG_SMP
>  union split_pmd {
>  	struct {
>  		u32 pmd_low;
> @@ -166,6 +165,8 @@ union split_pmd {
>  	};
>  	pmd_t pmd;
>  };
> +
> +#ifdef CONFIG_SMP
>  static inline pmd_t native_pmdp_get_and_clear(pmd_t *pmdp)
>  {
>  	union split_pmd res, *orig = (union split_pmd *)pmdp;
> @@ -181,6 +182,40 @@ static inline pmd_t native_pmdp_get_and_clear(pmd_t *pmdp)
>  #define native_pmdp_get_and_clear(xp) native_local_pmdp_get_and_clear(xp)
>  #endif
>  
> +#ifndef pmdp_establish
> +#define pmdp_establish pmdp_establish
> +static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
> +		unsigned long address, pmd_t *pmdp, pmd_t pmd)
> +{
> +	pmd_t old;
> +
> +	/*
> +	 * If pmd has present bit cleared we can get away without expensive
> +	 * cmpxchg64: we can update pmdp half-by-half without racing with
> +	 * anybody.
> +	 */
> +	if (!(pmd_val(pmd) & _PAGE_PRESENT)) {
> +		union split_pmd old, new, *ptr;
> +
> +		ptr = (union split_pmd *)pmdp;
> +
> +		new.pmd = pmd;
> +
> +		/* xchg acts as a barrier before setting of the high bits */
> +		old.pmd_low = xchg(&ptr->pmd_low, new.pmd_low);
> +		old.pmd_high = ptr->pmd_high;
> +		ptr->pmd_high = new.pmd_high;
> +		return old.pmd;
> +	}
> +
> +	{
> +		old = *pmdp;
> +	} while (cmpxchg64(&pmdp->pmd, old.pmd, pmd.pmd) != old.pmd);

um, what happened here?

> +	return old;
> +}
> +#endif
