Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:48300 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbaENIeR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 May 2014 04:34:17 -0400
Received: by mail-yh0-f42.google.com with SMTP id t59so1392459yho.29
        for <linux-arch@vger.kernel.org>; Wed, 14 May 2014 01:34:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53723ACC.7020500@codeaurora.org>
References: <1399390209-1756-1-git-send-email-steve.capper@linaro.org>
	<1399390209-1756-5-git-send-email-steve.capper@linaro.org>
	<53723ACC.7020500@codeaurora.org>
Date: Wed, 14 May 2014 09:34:16 +0100
Message-ID: <CAPvkgC1ORGyfKf5AEUfHeHrvZtNt5bWT1B5XvrBFbZmSNtBFWg@mail.gmail.com>
Subject: Re: [RFC PATCH V5 4/6] arm: mm: Enable RCU fast_gup
From: Steve Capper <steve.capper@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christopher Covington <cov@codeaurora.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Anders Roxell <anders.roxell@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Gary Robertson <gary.robertson@linaro.org>, Will Deacon <will.deacon@arm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Christoffer Dall <christoffer.dall@linaro.org>
Message-ID: <20140514083416.WSizXrh07tJBgROaaevcS0AvTzj3B2kLuW5CThrZ4lw@z>

On 13 May 2014 16:31, Christopher Covington <cov@codeaurora.org> wrote:
> Hi Steve,
>
> On 05/06/2014 11:30 AM, Steve Capper wrote:
>> Activate the RCU fast_gup for ARM. We also need to force THP splits to
>> broadcast an IPI s.t. we block in the fast_gup page walker. As THP
>> splits are comparatively rare, this should not lead to a noticeable
>> performance degradation.
>
>> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
>> index 3387e60..91a2b59 100644
>> --- a/arch/arm/mm/flush.c
>> +++ b/arch/arm/mm/flush.c
>> @@ -377,3 +377,22 @@ void __flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned l
>>        */
>>       __cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
>>  }
>> +
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +#ifdef CONFIG_HAVE_RCU_TABLE_FREE
>
> This is trivia, but I for one find the form #if defined(a) && defined(b)
> easier to read. (Applies to the A64 version as well).
>

Thank you Christopher, I agree that looks nicer.

Cheers,
-- 
Steve

> Christopher
>
> --
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by the Linux Foundation.
