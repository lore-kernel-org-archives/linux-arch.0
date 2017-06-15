From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [HELP-NEEDED, PATCH 0/3] Do not loose dirty bit on THP pages
Date: Thu, 15 Jun 2017 15:06:49 +0530
Message-ID: <2a54d607-6e46-3693-158b-5e8101010ce2@linux.vnet.ibm.com>
References: <20170614135143.25068-1-kirill.shutemov@linux.intel.com>
 <eed279c6-bf61-f2f3-c9f2-d9a94568e2e3@linux.vnet.ibm.com>
 <20170614165513.GD17632@arm.com>
 <548e33cb-e737-bb39-91a3-f66ee9211262@linux.vnet.ibm.com>
 <20170615084851.if6sntxo5tswhlk5@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752007AbdFOJhD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Jun 2017 05:37:03 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5F9XlnI004638
        for <linux-arch@vger.kernel.org>; Thu, 15 Jun 2017 05:37:02 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2b3gvq8qgt-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 15 Jun 2017 05:37:02 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Thu, 15 Jun 2017 03:37:01 -0600
In-Reply-To: <20170615084851.if6sntxo5tswhlk5@node.shutemov.name>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Will Deacon <will.deacon@arm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com



On Thursday 15 June 2017 02:18 PM, Kirill A. Shutemov wrote:
> O
>> I am not suggesting we don't do the invalidate (the need for that is
>> documented in __split_huge_pmd_locked(). I am suggesting we need a new
>> interface, something like Andrea suggested.
>>
>> old_pmd = pmdp_establish(pmd_mknotpresent());
>>
>> instead of pmdp_invalidate(). We can then use this in scenarios where we
>> want to update pmd PTE entries, where right now we go through a pmdp_clear
>> and set_pmd path. We should really not do that for THP entries.
> 
> Which cases are you talking about? When do we need to clear pmd and set
> later?
> 

With the latest upstream I am finding the usage when we mark pte clean 
page_mkclean_one . Also there is a similar usage in 
migrate_misplaced_transhuge_page(). I haven't really verified whether 
they do cause any race. But my suggestion is, we should avoid the usage 
of set_pmd_at() unless we are creating a new pmd PTE entry. If we can 
provide pmdp_establish() we can achieve that easily.

-aneesh
