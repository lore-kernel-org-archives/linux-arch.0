From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 08/11] mm,thp: reduce ifdef'ery for THP in generic code
Date: Wed, 16 Sep 2015 15:25:40 -0700
Message-ID: <20150916152540.b19aebc9f7a0889685867f1a@linux-foundation.org>
References: <1440666194-21478-1-git-send-email-vgupta@synopsys.com>
	<1440666194-21478-9-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1440666194-21478-9-git-send-email-vgupta@synopsys.com>
Sender: owner-linux-mm@kvack.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Mel Gorman <mgorman@suse.de>, Matthew Wilcox <matthew.r.wilcox@intel.com>, Minchan Kim <minchan@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, arc-linux-dev@synopsys.com
List-Id: linux-arch.vger.kernel.org

On Thu, 27 Aug 2015 14:33:11 +0530 Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:

> This is purely cosmetic, just makes code more readable
> 
> ...
>
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -30,9 +30,20 @@ extern int ptep_set_access_flags(struct vm_area_struct *vma,
>  #endif
>  
>  #ifndef __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  extern int pmdp_set_access_flags(struct vm_area_struct *vma,
>  				 unsigned long address, pmd_t *pmdp,
>  				 pmd_t entry, int dirty);
> +#else /* CONFIG_TRANSPARENT_HUGEPAGE */
> +static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
> +					unsigned long address, pmd_t *pmdp,
> +					pmd_t entry, int dirty)
> +{
> +	BUG();
> +	return 0;
> +}

Is it possible to simply leave this undefined?  So the kernel fails at
link time?

> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c

Good heavens that file is a mess.  Your patch does improve it.


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
