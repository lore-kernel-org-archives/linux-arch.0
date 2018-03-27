Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57886 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeC0EiO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Mar 2018 00:38:14 -0400
Subject: Re: [PATCH v4 2/3] arm64: Implement page table free interfaces
References: <1521546314-31753-1-git-send-email-cpandya@codeaurora.org>
 <1521546314-31753-3-git-send-email-cpandya@codeaurora.org>
 <20180326095541.izogc4iak6d7nerm@lakrids.cambridge.arm.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <b5427cbd-28f8-e561-cfca-751006e60da1@codeaurora.org>
Date: Tue, 27 Mar 2018 10:08:02 +0530
MIME-Version: 1.0
In-Reply-To: <20180326095541.izogc4iak6d7nerm@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
Message-ID: <20180327043802.vtoOkJkRhJEVcPWTexqx6goGYKpVTt72X9Rr6kDYT5k@z>



On 3/26/2018 3:25 PM, Mark Rutland wrote:
> On Tue, Mar 20, 2018 at 05:15:13PM +0530, Chintan Pandya wrote:
>> +static int __pmd_free_pte_page(pmd_t *pmd, unsigned long addr, bool tlb_inv)
>> +{
>> +	pmd_t *table;
>> +
>> +	if (pmd_val(*pmd)) {
>> +		table = __va(pmd_val(*pmd));
>> +		pmd_clear(pmd);
>> +		/*
>> +		 * FIXME: __flush_tlb_pgtable(&init_mm, addr) is
>> +		 *        ideal candidate here, which exactly
>> +		 *        flushes intermediate pgtables. But,
>> +		 *        this is broken (evident from tests).
>> +		 *        So, use safe TLB op unless that is fixed.
>> +		 */
>> +		if (tlb_inv)
>> +			flush_tlb_kernel_range(addr, addr + PMD_SIZE);
> 
> I don't think that __flush_tlb_pgtable() is broken. It's only valid to
> call it for user page tables, since it doesn't affect all ASIDs.
> 
> We can add a simlar helper for kernel mappings, which affects all ASIDs,
> e.g.
> 
Okay. I will test it and update v5.

> static inline void __flush_tlb_kernel_pgtable(unsigned long addr)
> {
> 	addr >>= 12;
> 	__tlbi(vaae1is, addr);
> 	dsb(ish);
> }
> 
> Thanks,
> Mark.
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
