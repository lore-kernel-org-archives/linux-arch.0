Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:19157 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753426AbdCXSqI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Mar 2017 14:46:08 -0400
Subject: Re: [PATCH v6 2/4] mm: Add functions to support extra actions on swap
 in/out
References: <cover.1488232591.git.khalid.aziz@oracle.com>
 <4c4da87ff45b98e236cdfef66055b876074dabfb.1488232597.git.khalid.aziz@oracle.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <8665482b-f808-e995-cda1-99011be6ee34@linux.intel.com>
Date: Fri, 24 Mar 2017 11:45:55 -0700
MIME-Version: 1.0
In-Reply-To: <4c4da87ff45b98e236cdfef66055b876074dabfb.1488232597.git.khalid.aziz@oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org, davem@davemloft.net, arnd@arndb.de
Cc: kirill.shutemov@linux.intel.com, mhocko@suse.com, jmarchan@redhat.com, vbabka@suse.cz, dan.j.williams@intel.com, lstoakes@gmail.com, hannes@cmpxchg.org, mgorman@suse.de, hughd@google.com, vdavydov.dev@gmail.com, minchan@kernel.org, namit@vmware.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
Message-ID: <20170324184555.wjL0jBEcKW2DWyPNCBbPYtOaPV3NOoJON2NxoGSVc94@z>

On 02/28/2017 10:35 AM, Khalid Aziz wrote:
> diff --git a/mm/memory.c b/mm/memory.c
> index 6bf2b47..b086c76 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2658,6 +2658,7 @@ int do_swap_page(struct vm_fault *vmf)
>  	if (pte_swp_soft_dirty(vmf->orig_pte))
>  		pte = pte_mksoft_dirty(pte);
>  	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> +	arch_do_swap_page(vma->vm_mm, vmf->address, pte, vmf->orig_pte);
>  	vmf->orig_pte = pte;
>  	if (page == swapcache) {
>  		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 91619fd..192c41a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1538,6 +1538,7 @@ static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  		swp_pte = swp_entry_to_pte(entry);
>  		if (pte_soft_dirty(pteval))
>  			swp_pte = pte_swp_mksoft_dirty(swp_pte);
> +		arch_unmap_one(mm, address, swp_pte, pteval);
>  		set_pte_at(mm, address, pte, swp_pte);
>  	} else if (PageAnon(page)) {
>  		swp_entry_t entry = { .val = page_private(page) };
> @@ -1571,6 +1572,7 @@ static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  		swp_pte = swp_entry_to_pte(entry);
>  		if (pte_soft_dirty(pteval))
>  			swp_pte = pte_swp_mksoft_dirty(swp_pte);
> +		arch_unmap_one(mm, address, swp_pte, pteval);
>  		set_pte_at(mm, address, pte, swp_pte);
>  	} else
>  		dec_mm_counter(mm, mm_counter_file(page));
