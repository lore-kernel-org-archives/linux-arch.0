Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from b.ns.miles-group.at ([95.130.255.144]:1660 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754399AbaEOJhN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 May 2014 05:37:13 -0400
Message-ID: <53748AC3.9080709@nod.at>
Date: Thu, 15 May 2014 11:37:07 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Subject: Re: [PATCH 01/27] arm64: Override defaults from generic/tlb.h
References: <1400093999-18703-1-git-send-email-richard@nod.at> <1400093999-18703-2-git-send-email-richard@nod.at> <20140515093430.GE11117@localhost>
In-Reply-To: <20140515093430.GE11117@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Steve Capper <steve.capper@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20140515093707.YUr1dYGSJyi5y7NrDTSO5ZdF9IaTITpmZD5mPoegc8g@z>

Am 15.05.2014 11:34, schrieb Catalin Marinas:
> On Wed, May 14, 2014 at 07:59:33PM +0100, Richard Weinberger wrote:
>> --- a/arch/arm64/include/asm/tlb.h
>> +++ b/arch/arm64/include/asm/tlb.h
>> @@ -19,7 +19,14 @@
>>  #ifndef __ASM_TLB_H
>>  #define __ASM_TLB_H
>>  
>> +/* These defines are needed to override the defaults from asm-generic/tlb.h */
>>  #define  __tlb_remove_pmd_tlb_entry __tlb_remove_pmd_tlb_entry
>> +#define tlb_start_vma tlb_start_vma
>> +#define tlb_end_vma tlb_end_vma
>> +#define __tlb_remove_tlb_entry __tlb_remove_tlb_entry
>> +#define tlb_flush tlb_flush
>> +#define __pte_free_tlb __pte_free_tlb
>> +#define __pmd_free_tlb __pmd_free_tlb
>>  
>>  #include <asm-generic/tlb.h>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> I hope subsequent series would consolidate some more of the above (for
> example tlb_start_vma() is not really arm64 specific.

Yes, peterz pointed me to a not jet merged series which consolidates
much more.
I'll revive it.

Thanks,
//richard
