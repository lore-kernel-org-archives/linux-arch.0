Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDBKGf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Apr 2019 06:06:35 -0400
Subject: Re: [PATCH 3/4] arm64: compat: Refactor aarch32_alloc_vdso_pages()
References: <20190401112025.40807-1-vincenzo.frascino@arm.com>
 <20190401112025.40807-4-vincenzo.frascino@arm.com>
 <20190401144355.GI14874@arrakis.emea.arm.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <5d16a629-d77a-2a98-6ea0-5a6d66dc8057@arm.com>
Date: Tue, 2 Apr 2019 11:06:32 +0100
MIME-Version: 1.0
In-Reply-To: <20190401144355.GI14874@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20190402100632.IHks-CzNq2h4V8LezhMwySpkYdmP7tPnFJdCAGwiqXM@z>


On 01/04/2019 15:43, Catalin Marinas wrote:
> On Mon, Apr 01, 2019 at 12:20:24PM +0100, Vincenzo Frascino wrote:
>> +static int __init aarch32_alloc_vdso_pages(void)
>> +{
>> +	return aarch32_alloc_kuser_vdso_page() &
>> +	       aarch32_alloc_sigreturn_vdso_page();
>>  }
>>  arch_initcall(aarch32_alloc_vdso_pages);
> 
> It probably doesn't matter much but I'd rather not bit-and two error
> codes. Just return the non-zero one or pick the first (your choice) if
> both are wrong.
> 
> (normally, if you want a non-zero random value if any of them failed,
> you'd use bit-or)
> 

Actually this is a good advice, I will change the code accordingly in v2.

-- 
Regards,
Vincenzo
