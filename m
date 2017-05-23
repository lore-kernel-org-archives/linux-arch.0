From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v3 2/6] mm, gup: Ensure real head page is ref-counted when using hugepages
Date: Tue, 23 May 2017 16:43:50 +0100
Message-ID: <874lwbh93d.fsf@e105922-lin.cambridge.arm.com>
References: <20170522133604.11392-1-punit.agrawal@arm.com>
        <20170522133604.11392-3-punit.agrawal@arm.com>
        <20170523131312.aim6obne2t5sxtdr@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758470AbdEWPnw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 May 2017 11:43:52 -0400
In-Reply-To: <20170523131312.aim6obne2t5sxtdr@node.shutemov.name> (Kirill
        A. Shutemov's message of "Tue, 23 May 2017 16:13:12 +0300")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, n-horiguchi@ah.jp.nec.com, kirill.shutemov@linux.intel.com, mike.kravetz@oracle.com, steve.capper@arm.com, mark.rutland@arm.com, hillf.zj@alibaba-inc.com, linux-arch@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com, Michal Hocko <mhocko@suse.com>

"Kirill A. Shutemov" <kirill@shutemov.name> writes:

> On Mon, May 22, 2017 at 02:36:00PM +0100, Punit Agrawal wrote:
>> When speculatively taking references to a hugepage using
>> page_cache_add_speculative() in gup_huge_pmd(), it is assumed that the
>> page returned by pmd_page() is the head page. Although normally true,
>> this assumption doesn't hold when the hugepage comprises of successive
>> page table entries such as when using contiguous bit on arm64 at PTE or
>> PMD levels.
>> 
>> This can be addressed by ensuring that the page passed to
>> page_cache_add_speculative() is the real head or by de-referencing the
>> head page within the function.
>> 
>> We take the first approach to keep the usage pattern aligned with
>> page_cache_get_speculative() where users already pass the appropriate
>> page, i.e., the de-referenced head.
>> 
>> Apply the same logic to fix gup_huge_[pud|pgd]() as well.
>
> Hm. Okay. But I'm kinda surprise that this is the only place that need to
> be adjusted.
>
> Have you validated all other pmd_page() use-cases?

I came across the gup issues were found while investigating a failing
test from mce-tests.

I think the problem here is not due to the use of pmd_page() but because
page_cache_[add|get]_speculative() don't ensure they ref-count the head
page as is done in get_page().

Having said that, I had a quick look at the other uses of pmd_page() -

Quite a few of them are followed by an explicit BUG_ON() to check that
the page returned is a head page. All other instances seem to be dealing
with transparent hugepages where contiguous hugepages are not supported.

I don't see any call sites that ring alarm bells.

Did you have any particular part of the code in mind where pmd_page()
usage might be a problem?

Thanks,
Punit
