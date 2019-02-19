Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40144 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfBSEVJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Feb 2019 23:21:09 -0500
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
Date: Tue, 19 Feb 2019 09:51:01 +0530
MIME-Version: 1.0
In-Reply-To: <20190218231319.178224-1-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu Zhao <yuzhao@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Chintan Pandya <cpandya@codeaurora.org>, Jun Yao <yaojun8558363@gmail.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20190219042101.D72yHhsAKGa-2TjpE3SLKp6wLjYET6sNeEBPGqkfgTs@z>



On 02/19/2019 04:43 AM, Yu Zhao wrote:
> For pte page, use pgtable_page_ctor(); for pmd page, use
> pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
> p4d and pgd), don't use any.
pgtable_page_ctor()/dtor() is not optional for any level page table page
as it determines the struct page state and zone statistics. We should not
skip it for any page table page. As stated before pgtable_pmd_page_ctor()
is not a replacement for pgtable_page_ctor().
