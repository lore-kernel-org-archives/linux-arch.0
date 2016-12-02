From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] proc: mm: export PTE sizes directly in smaps (v3)
Date: Fri, 02 Dec 2016 21:13:19 +0530
Message-ID: <877f7ie3qg.fsf@linux.vnet.ibm.com>
References: <20161129201703.CE9D5054@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20161129201703.CE9D5054@viggo.jf.intel.com>
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave@sr71.net>, hch@lst.de, akpm@linux-foundation.org, dan.j.williams@intel.com, khandual@linux.vnet.ibm.com, vbabka@suse.cz, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Dave Hansen <dave@sr71.net> writes:

> Andrew, you can drop proc-mm-export-pte-sizes-directly-in-smaps-v2.patch,
> and replace it with this.
>
.....

> diff -puN mm/hugetlb.c~smaps-pte-sizes mm/hugetlb.c
> --- a/mm/hugetlb.c~smaps-pte-sizes	2016-11-28 14:21:37.555519365 -0800
> +++ b/mm/hugetlb.c	2016-11-28 14:28:49.186234688 -0800
> @@ -2763,6 +2763,17 @@ void __init hugetlb_add_hstate(unsigned
>  					huge_page_size(h)/1024);
>  
>  	parsed_hstate = h;
> +
> +	/*
> +	 * PGD_SIZE isn't widely made available by architecures,
> +	 * so use PUD_SIZE*PTRS_PER_PUD as a substitute.
> +	 *
> +	 * Check for sizes that might be mapped by a PGD.  There
> +	 * are none of these known today, but be on the lookout.
> +	 * If this trips, we will need to update the mss->rss_*
> +	 * code in fs/proc/task_mmu.c.
> +	 */
> +	WARN_ON_ONCE((PAGE_SIZE << order) >= PUD_SIZE * PTRS_PER_PUD);
>  }

This will trip for ppc64 16GB hugepage.

For ppc64 we have the 16G at pgd level.

-aneesh

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
