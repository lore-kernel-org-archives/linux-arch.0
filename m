Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41804 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUGB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 16:06:01 -0400
Subject: Re: [PATCH 0/3] eldie generated code for folded p4d/pud
References: <20191009222658.961-1-vgupta@synopsys.com>
 <20191010085609.xgwkrbzea253wmfg@black.fi.intel.com>
From: Vineet Gupta <vineetg76@gmail.com>
Message-ID: <8ba067a6-8b6a-2414-0f04-b251cd6bb47c@gmail.com>
Date: Thu, 10 Oct 2019 13:05:56 -0700
MIME-Version: 1.0
In-Reply-To: <20191010085609.xgwkrbzea253wmfg@black.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org, Nick Piggin <npiggin@gmail.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, linux-snps-arc@lists.infradead.org, Will Deacon <will@kernel.org>
Message-ID: <20191010200556.5lRTpVmQNlj9K0z8OcbAtau2lie9pJjfqp8LyVj9_-Q@z>


Hi Kirill,

On 10/10/19 1:56 AM, Kirill A. Shutemov wrote:
> On Wed, Oct 09, 2019 at 10:26:55PM +0000, Vineet Gupta wrote:
>>
>> This series elides extraneous generate code for folded p4d/pud.
>> This came up when trying to remove __ARCH_USE_5LEVEL_HACK from ARC port.
>> The code saving are not a while lot, but still worthwhile IMHO.
> 
> Agreed.

Thx.

So given we are folding pmd too, it seemed we could do the following as well.

+#ifndef __PAGETABLE_PMD_FOLDED
 void pmd_clear_bad(pmd_t *);
+#else
+#define pmd_clear_bad(pmd)        do { } while (0)
+#endif

+#ifndef __PAGETABLE_PMD_FOLDED
 void pmd_clear_bad(pmd_t *pmd)
 {
        pmd_ERROR(*pmd);
        pmd_clear(pmd);
 }
+#endif

I stared at generated code and it seems a bit wrong.
free_pgd_range() -> pgd_none_or_clear_bad() is no longer checking for unmapped pgd
entries as pgd_none/pgd_bad are all stubs returning 0.

This whole pmd folding is a bit confusing considering I only revisit it every few
years :-) Abstraction wise, __PAGETABLE_PMD_FOLDED only has pgd, pte but even in
this regime bunch of pmd macros are still valid

    pmd_set(pmdp, ptep) {
        *pmdp.pud.p4d.pgd = (unsigned long)ptep
    }

Is there a better way to make a mental model of this code folding.

In an ideal world pmd folded would have meant pmd_* routines just vanish - poof.
So in that sense I like your implementation under #[45]LEVEL_HACK where the level
simply vanishes by code like #define p4d_t pgd_t. Perhaps there is lot of historic
baggage, proliferated into arch code so hard to untangle.

Thx,
-Vineet
