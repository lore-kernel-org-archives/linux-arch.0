From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 2/6] mm, gup: Ensure real head page is ref-counted
 when using hugepages
Date: Tue, 23 May 2017 16:13:12 +0300
Message-ID: <20170523131312.aim6obne2t5sxtdr@node.shutemov.name>
References: <20170522133604.11392-1-punit.agrawal@arm.com>
 <20170522133604.11392-3-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170522133604.11392-3-punit.agrawal@arm.com>
Sender: owner-linux-mm@kvack.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, n-horiguchi@ah.jp.nec.com, kirill.shutemov@linux.intel.com, mike.kravetz@oracle.com, steve.capper@arm.com, mark.rutland@arm.com, hillf.zj@alibaba-inc.com, linux-arch@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com, Michal Hocko <mhocko@suse.com>
List-Id: linux-arch.vger.kernel.org

On Mon, May 22, 2017 at 02:36:00PM +0100, Punit Agrawal wrote:
> When speculatively taking references to a hugepage using
> page_cache_add_speculative() in gup_huge_pmd(), it is assumed that the
> page returned by pmd_page() is the head page. Although normally true,
> this assumption doesn't hold when the hugepage comprises of successive
> page table entries such as when using contiguous bit on arm64 at PTE or
> PMD levels.
> 
> This can be addressed by ensuring that the page passed to
> page_cache_add_speculative() is the real head or by de-referencing the
> head page within the function.
> 
> We take the first approach to keep the usage pattern aligned with
> page_cache_get_speculative() where users already pass the appropriate
> page, i.e., the de-referenced head.
> 
> Apply the same logic to fix gup_huge_[pud|pgd]() as well.

Hm. Okay. But I'm kinda surprise that this is the only place that need to
be adjusted.

Have you validated all other pmd_page() use-cases?

-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
