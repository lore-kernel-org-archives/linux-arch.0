From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] MIPS: set page access bit with pgprot on some MIPS
 platform
Date: Fri, 5 Jun 2020 18:08:03 -0700
Message-ID: <20200605180803.9ba58249ed681f4da9822f43@linux-foundation.org>
References: <1591348266-28392-1-git-send-email-maobibo@loongson.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-owner@vger.kernel.org>
In-Reply-To: <1591348266-28392-1-git-send-email-maobibo@loongson.cn>
Sender: linux-mips-owner@vger.kernel.org
To: Bibo Mao <maobibo@loongson.cn>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Burton <paulburton@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Fri,  5 Jun 2020 17:11:05 +0800 Bibo Mao <maobibo@loongson.cn> wrote:

> On MIPS system which has rixi hardware bit, page access bit is not
> set in pgrot. For memory reading, there will be one page fault to
> allocate physical page; however valid bit is not set, there will
> be the second fast tlb-miss fault handling to set valid/access bit.
> 
> This patch set page access/valid bit with pgrot if there is reading
> access privilege. It will reduce one tlb-miss handling for memory
> reading access.
> 
> The valid/access bit will be cleared in order to track memory
> accessing activity. If the page is accessed, tlb-miss fast handling
> will set valid/access bit, pte_sw_mkyoung is not necessary in slow
> page fault path. This patch removes pte_sw_mkyoung function which
> is defined as empty function except MIPS system.
> 
> ...
>
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2704,7 +2704,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  		}
>  		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
>  		entry = mk_pte(new_page, vma->vm_page_prot);
> -		entry = pte_sw_mkyoung(entry);
>  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>  		/*
>  		 * Clear the pte entry and flush it first, before updating the
> @@ -3379,7 +3378,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	__SetPageUptodate(page);
>  
>  	entry = mk_pte(page, vma->vm_page_prot);
> -	entry = pte_sw_mkyoung(entry);
>  	if (vma->vm_flags & VM_WRITE)
>  		entry = pte_mkwrite(pte_mkdirty(entry));
>  
> @@ -3662,7 +3660,6 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
>  
>  	flush_icache_page(vma, page);
>  	entry = mk_pte(page, vma->vm_page_prot);
> -	entry = pte_sw_mkyoung(entry);
>  	if (write)
>  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>  	/* copy-on-write page */

Only affects mips, so cheerily

Acked-by: Andrew Morton <akpm@linux-foundation.org>
