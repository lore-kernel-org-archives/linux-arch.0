Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33729 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933691AbdEWNUR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2017 09:20:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id b84so23520550wmh.0
        for <linux-arch@vger.kernel.org>; Tue, 23 May 2017 06:20:16 -0700 (PDT)
Date: Tue, 23 May 2017 16:13:12 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 2/6] mm, gup: Ensure real head page is ref-counted
 when using hugepages
Message-ID: <20170523131312.aim6obne2t5sxtdr@node.shutemov.name>
References: <20170522133604.11392-1-punit.agrawal@arm.com>
 <20170522133604.11392-3-punit.agrawal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170522133604.11392-3-punit.agrawal@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, n-horiguchi@ah.jp.nec.com, kirill.shutemov@linux.intel.com, mike.kravetz@oracle.com, steve.capper@arm.com, mark.rutland@arm.com, hillf.zj@alibaba-inc.com, linux-arch@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com, Michal Hocko <mhocko@suse.com>
Message-ID: <20170523131312.k2HodYgUOANc7PC4w9twq1il1m9xOL2ak0A_5_0ZR2U@z>

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
