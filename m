Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49962 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfCKHqF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Mar 2019 03:46:05 -0400
Subject: Re: [PATCH v3 1/3] arm64: mm: use appropriate ctors for page tables
References: <20190218231319.178224-1-yuzhao@google.com>
 <20190310011906.254635-1-yuzhao@google.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b0ae4f65-aa0f-148a-eced-0d9831a7bf01@arm.com>
Date: Mon, 11 Mar 2019 13:15:55 +0530
MIME-Version: 1.0
In-Reply-To: <20190310011906.254635-1-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu Zhao <yuzhao@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Chintan Pandya <cpandya@codeaurora.org>, Jun Yao <yaojun8558363@gmail.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20190311074555.WYVEsPmd-hPvTDVZXEsliIM4vuSAEz08SBUdW-KmUjs@z>

Hello Yu,

We had some disagreements over this series last time around after which I had
posted the following series [1] which tried to enable ARCH_ENABLE_SPLIT_PMD_PTLOCK
after doing some pgtable accounting changes. After some thoughts and deliberations
I figure that its better not to do pgtable alloc changes on arm64 creating a brand
new semantics which ideally should be first debated and agreed upon in generic MM.

Though I still see value in a changed generic pgtable page allocation semantics
for user and kernel space that should not stop us from enabling more granular
PMD level locks through ARCH_ENABLE_SPLIT_PMD_PTLOCK right now.

[1] https://www.spinics.net/lists/arm-kernel/msg709917.html

Having said that this series attempts to enable ARCH_ENABLE_SPLIT_PMD_PTLOCK with
some minimal changes to existing kernel pgtable page allocation code. Hence just
trying to re-evaluate the series in that isolation.

On 03/10/2019 06:49 AM, Yu Zhao wrote:

> For pte page, use pgtable_page_ctor(); for pmd page, use
> pgtable_pmd_page_ctor(); and for the rest (pud, p4d and pgd),
> don't use any.

This is semantics change. Hence the question is why ? Should not we wait until a
generic MM agreement in place in this regard ? Can we avoid this ? Is the change
really required to enable ARCH_ENABLE_SPLIT_PMD_PTLOCK for user space THP which
this series originally intended to achieve ?

> 
> For now, we don't select ARCH_ENABLE_SPLIT_PMD_PTLOCK and
> pgtable_pmd_page_ctor() is a nop. When we do in patch 3, we
> make sure pmd is not folded so we won't mistakenly call
> pgtable_pmd_page_ctor() on pud or p4d.

This makes sense from code perspective but I still dont understand the need to
change kernel pgtable page allocation semantics without any real benefit or fix at
the moment. Cant we keep kernel page table page allocation unchanged for now and
just enable ARCH_ENABLE_SPLIT_PMD_PTLOCK for user space THP benefits ? Do you see
any concern with that.
