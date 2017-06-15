From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [HELP-NEEDED, PATCH 0/3] Do not loose dirty bit on THP pages
Date: Thu, 15 Jun 2017 07:06:16 +0530
Message-ID: <694d801a-cc15-d871-7951-97a7d33dc285@linux.vnet.ibm.com>
References: <20170614135143.25068-1-kirill.shutemov@linux.intel.com>
 <eed279c6-bf61-f2f3-c9f2-d9a94568e2e3@linux.vnet.ibm.com>
 <20170614165513.GD17632@arm.com>
 <d589ad0a-d5d4-927a-597c-4b094285d4b1@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59011 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752101AbdFOBgh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Jun 2017 21:36:37 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5F1YIqS085393
        for <linux-arch@vger.kernel.org>; Wed, 14 Jun 2017 21:36:36 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2b3ek3c6up-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 14 Jun 2017 21:36:36 -0400
Received: from localhost
        by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Wed, 14 Jun 2017 19:36:35 -0600
In-Reply-To: <d589ad0a-d5d4-927a-597c-4b094285d4b1@suse.cz>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will.deacon@arm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com



On Wednesday 14 June 2017 10:30 PM, Vlastimil Babka wrote:
> On 06/14/2017 06:55 PM, Will Deacon wrote:
>>>
>>> May be we should relook at pmd PTE udpate interface. We really need an
>>> interface that can update pmd entries such that we don't clear it in
>>> between. IMHO, we can avoid the pmdp_invalidate() completely, if we can
>>> switch from a pmd PTE entry to a pointer to PTE page (pgtable_t). We also
>>> need this interface to avoid the madvise race fixed by
>>
>> There's a good chance I'm not following your suggestion here, but it's
>> probably worth me pointing out that swizzling a page table entry from a
>> block mapping (e.g. a huge page mapped at the PMD level) to a table entry
>> (e.g. a pointer to a page of PTEs) can lead to all sorts of horrible
>> problems on ARM, including amalgamation of TLB entries and fatal aborts.
> 
> AFAIK some AMD x86_64 CPU's had the same problem and generated MCE's,
> and on Intel there are some restrictions when you can do that. See the
> large comment in __split_huge_pmd_locked().
> 

I was wondering whether we can do pmdp_establish(pgtable); and document 
all quirks needed for that in the per arch implementation of 
pmdp_establish(). We could also then switch all the 
pmdp_clear/set_pmd_at() usage to pmdp_establish().

-aneesh
