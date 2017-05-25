From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v4 8/8] mm: rmap: Use correct helper when poisoning hugepages
Date: Thu, 25 May 2017 18:22:04 +0100
Message-ID: <878tlkets3.fsf@e105922-lin.cambridge.arm.com>
References: <201705250342.fHpDVCsZ%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753595AbdEYRWG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 May 2017 13:22:06 -0400
In-Reply-To: <201705250342.fHpDVCsZ%fengguang.wu@intel.com> (kbuild test
        robot's message of "Thu, 25 May 2017 03:20:35 +0800")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, n-horiguchi@ah.jp.nec.com, kirill.shutemov@linux.intel.com, mike.kravetz@oracle.com, steve.capper@arm.com, mark.rutland@arm.com, linux-arch@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com

kbuild test robot <lkp@intel.com> writes:

> Hi Punit,
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.12-rc2 next-20170524]
> [cannot apply to mmotm/master]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Punit-Agrawal/Support-for-contiguous-pte-hugepages/20170524-221905
> config: x86_64-kexec (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
>
> All errors (new ones prefixed by >>):
>
>    mm/rmap.c: In function 'try_to_unmap_one':
>>> mm/rmap.c:1386:5: error: implicit declaration of function 'set_huge_swap_pte_at' [-Werror=implicit-function-declaration]
>         set_huge_swap_pte_at(mm, address,
>         ^~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
>
> vim +/set_huge_swap_pte_at +1386 mm/rmap.c
>
>   1380	
>   1381			if (PageHWPoison(page) && !(flags & TTU_IGNORE_HWPOISON)) {
>   1382				pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
>   1383				if (PageHuge(page)) {
>   1384					int nr = 1 << compound_order(page);
>   1385					hugetlb_count_sub(nr, mm);
>> 1386					set_huge_swap_pte_at(mm, address,
>   1387							     pvmw.pte, pteval,
>   1388							     vma_mmu_pagesize(vma));
>   1389				} else {
>

Thanks for the report. The build failure is caused due to missing
function definition for set_huge_swap_pte_at() when CONFIG_HUGETLB_PAGE
is disabled. I've posted an update to Patch 7 where the function is
introduced to fix this issue.

> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
