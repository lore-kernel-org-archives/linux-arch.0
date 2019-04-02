Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47818 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728710AbfDBKIm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Apr 2019 06:08:42 -0400
Subject: Re: [PATCH 1/4] arm64: compat: Alloc separate pages for vectors and
 sigpage
References: <20190401112025.40807-1-vincenzo.frascino@arm.com>
 <20190401112025.40807-2-vincenzo.frascino@arm.com>
 <20190401142754.GF14874@arrakis.emea.arm.com>
 <6c43e9f9-3500-b828-3cf9-1917b9de256a@arm.com>
 <20190402100657.tkvdkqtx2xjjixma@mbp>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <36e96791-9892-d161-c72c-d4489fc95c25@arm.com>
Date: Tue, 2 Apr 2019 11:08:39 +0100
MIME-Version: 1.0
In-Reply-To: <20190402100657.tkvdkqtx2xjjixma@mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20190402100839.LmkQUEA4P4M-w95dHN57ZzlLufGd5cmUV_lLrdvVpqI@z>

On 02/04/2019 11:06, Catalin Marinas wrote:
> On Tue, Apr 02, 2019 at 11:01:04AM +0100, Vincenzo Frascino wrote:
>> On 01/04/2019 15:27, Catalin Marinas wrote:
>>> On Mon, Apr 01, 2019 at 12:20:22PM +0100, Vincenzo Frascino wrote:
>>>> +static int aarch32_sigreturn_setup(struct mm_struct *mm)
>>>> +{
>>>> +	unsigned long addr;
>>>>  	void *ret;
>>>>  
>>>> -	if (down_write_killable(&mm->mmap_sem))
>>>> -		return -EINTR;
>>>> -	current->mm->context.vdso = (void *)addr;
>>>> +	addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
>>>> +	if (IS_ERR_VALUE(addr)) {
>>>> +		ret = ERR_PTR(addr);
>>>> +		goto out;
>>>> +	}
>>>>  
>>>> -	/* Map vectors page at the high address. */
>>>>  	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
>>>> -				       VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC,
>>>> -				       &spec);
>>>> +				       VM_READ | VM_EXEC | VM_MAYREAD |
>>>> +				       VM_MAYWRITE | VM_MAYEXEC,
>>>> +				       &aarch32_vdso_spec[1]);
>>>
>>> Any reason for setting VM_MAYWRITE here?
>>
>> VM_MAYWRITE is required to allow gdb to Copy-on-Write and set breakpoints.
> 
> Thanks. Please add a comment to the code so I don't ask again ;).
> 

No problem, my bad for not adding it in the first place ;).

-- 
Regards,
Vincenzo
