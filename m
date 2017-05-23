From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 1/6] mm, gup: Remove broken VM_BUG_ON_PAGE compound
 check for hugepages
Date: Tue, 23 May 2017 16:09:47 +0300
Message-ID: <20170523130947.cv3bbjxa2l4ifj55@node.shutemov.name>
References: <20170522133604.11392-1-punit.agrawal@arm.com>
 <20170522133604.11392-2-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170522133604.11392-2-punit.agrawal@arm.com>
Sender: owner-linux-mm@kvack.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: akpm@linux-foundation.org, Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, n-horiguchi@ah.jp.nec.com, kirill.shutemov@linux.intel.com, mike.kravetz@oracle.com, steve.capper@arm.com, mark.rutland@arm.com, hillf.zj@alibaba-inc.com, linux-arch@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

On Mon, May 22, 2017 at 02:35:59PM +0100, Punit Agrawal wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> When operating on hugepages with DEBUG_VM enabled, the GUP code checks the
> compound head for each tail page prior to calling page_cache_add_speculative.
> This is broken, because on the fast-GUP path (where we don't hold any page
> table locks) we can be racing with a concurrent invocation of
> split_huge_page_to_list.
> 
> split_huge_page_to_list deals with this race by using page_ref_freeze to
> freeze the page and force concurrent GUPs to fail whilst the component
> pages are modified. This modification includes clearing the compound_head
> field for the tail pages, so checking this prior to a successful call
> to page_cache_add_speculative can lead to false positives: In fact,
> page_cache_add_speculative *already* has this check once the page refcount
> has been successfully updated, so we can simply remove the broken calls
> to VM_BUG_ON_PAGE.
> 
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>

Looks reasonable to me:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
