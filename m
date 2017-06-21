From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v5 0/8] Support for contiguous pte hugepages
Date: Wed, 21 Jun 2017 13:32:02 +0100
Message-ID: <87fuety119.fsf@e105922-lin.cambridge.arm.com>
References: <20170619170145.25577-1-punit.agrawal@arm.com>
        <20170619150133.cb4173220e4e3abd02c6f6d0@linux-foundation.org>
        <871sqezsk2.fsf@e105922-lin.cambridge.arm.com>
        <20170620140831.6bd835649d475bcf30c3c434@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbdFUMcF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Jun 2017 08:32:05 -0400
In-Reply-To: <20170620140831.6bd835649d475bcf30c3c434@linux-foundation.org>
        (Andrew Morton's message of "Tue, 20 Jun 2017 14:08:31 -0700")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, n-horiguchi@ah.jp.nec.com, kirill.shutemov@linux.intel.com, mike.kravetz@oracle.com, steve.capper@arm.com, mark.rutland@arm.com, linux-arch@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com

Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue, 20 Jun 2017 14:39:57 +0100 Punit Agrawal <punit.agrawal@arm.com> wrote:
>
>> 
>> The architecture supports two flavours of hugepages -
>> 
>> * Block mappings at the pud/pmd level
>> 
>>   These are regular hugepages where a pmd or a pud page table entry
>>   points to a block of memory. Depending on the PAGE_SIZE in use the
>>   following size of block mappings are supported -
>> 
>>           PMD	PUD
>>           ---	---
>>   4K:      2M	 1G
>>   16K:    32M
>>   64K:   512M
>> 
>>   For certain applications/usecases such as HPC and large enterprise
>>   workloads, folks are using 64k page size but the minimum hugepage size
>>   of 512MB isn't very practical.
>> 
>> To overcome this ...
>> 
>> * Using the Contiguous bit
>> 
>>   The architecture provides a contiguous bit in the translation table
>>   entry which acts as a hint to the mmu to indicate that it is one of a
>>   contiguous set of entries that can be cached in a single TLB entry.
>> 
>>   We use the contiguous bit in Linux to increase the mapping size at the
>>   pmd and pte (last) level.
>> 
>>   The number of supported contiguous entries varies by page size and
>>   level of the page table.
>> 
>>   Using the contiguous bit allows additional hugepage sizes -
>> 
>>            CONT PTE    PMD    CONT PMD    PUD
>>            --------    ---    --------    ---
>>     4K:         64K     2M         32M     1G
>>     16K:         2M    32M          1G
>>     64K:         2M   512M         16G
>> 
>>   Of these, 64K with 4K and 2M with 64K pages have been explicitly
>>   requested by a few different users.
>> 
>> Entries with the contiguous bit set are required to be modified all
>> together - which makes things like memory poisoning and migration
>> impossible to do correctly without knowing the size of hugepage being
>> dealt with - the reason for adding size parameter to a few of the
>> hugepage helpers in this series.
>> 
>
> Thanks, I added the above to the 1/n changelog.  Perhaps it's worth
> adding something like this to Documentation/vm/hugetlbpage.txt.

Yes, it would be useful to have this documented.

I'll send a patch once the architecture bits for re-enabling contiguous
hugepages are merged.

Thanks,
Punit
