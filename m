Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35687 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755258AbbJHJSZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2015 05:18:25 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH V4 2/3] arm64: support initrd outside kernel linear map
From: yalin wang <yalin.wang2010@gmail.com>
In-Reply-To: <20151008084953.GA20114@cbox>
Date: Thu, 8 Oct 2015 17:18:14 +0800
Content-Transfer-Encoding: 8BIT
Message-ID: <FC378C09-F140-4A62-9FFA-09293E65E866@gmail.com>
References: <1439830867-14935-1-git-send-email-msalter@redhat.com> <1439830867-14935-3-git-send-email-msalter@redhat.com> <20150908113113.GA20562@leverpostej> <20151006171140.GE26433@leverpostej> <1444151812.10788.14.camel@redhat.com> <20151008084953.GA20114@cbox>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Mark Salter <msalter@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "x86@kernel.org" <x86@kernel.org>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20151008091814.2PhYUli-dET2uNngoq7SSpshu9UI6db-TWUxDDhboto@z>


> On Oct 8, 2015, at 16:49, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> 
> On Tue, Oct 06, 2015 at 01:16:52PM -0400, Mark Salter wrote:
>> On Tue, 2015-10-06 at 18:11 +0100, Mark Rutland wrote:
>>> On Tue, Sep 08, 2015 at 12:31:13PM +0100, Mark Rutland wrote:
>>>> Hi Mark,
>>>> 
>>>> On Mon, Aug 17, 2015 at 06:01:06PM +0100, Mark Salter wrote:
>>>>> The use of mem= could leave part or all of the initrd outside of
>>>>> the kernel linear map. This will lead to an error when unpacking
>>>>> the initrd and a probable failure to boot. This patch catches that
>>>>> situation and relocates the initrd to be fully within the linear
>>>>> map.
>>>> 
>>>> With next-20150908, this patch results in a confusing message at boot when not
>>>> using an initrd:
>>>> 
>>>> Moving initrd from [4080000000-407fffffff] to [9fff49000-9fff48fff]
>>>> 
>>>> I think that can be solved by folding in the diff below.
>>> 
>>> Mark, it looks like this fell by the wayside.
>>> 
>>> Do you have any objection to this? I'll promote this to it's own patch
>>> if not.
>>> 
>>> Mark.
>>> 
>>>> 
>>>> Thanks,
>>>> Mark.
>>>> 
>>>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>>>> index 6bab21f..2322479 100644
>>>> --- a/arch/arm64/kernel/setup.c
>>>> +++ b/arch/arm64/kernel/setup.c
>>>> @@ -364,6 +364,8 @@ static void __init relocate_initrd(void)
>>>>                to_free = ram_end - orig_start;
>>>> 
>>>>        size = orig_end - orig_start;
>>>> +       if (!size)
>>>> +               return;
>>>> 
>>>>        /* initrd needs to be relocated completely inside linear mapping */
>>>>        new_start = memblock_find_in_range(0, PFN_PHYS(max_pfn),
>> 
>> Sorry, no. That looks perfectly good to me.
>> 
is it also possible to implement it on ARM platforms?
ARM64 platform don’t have HIGH_MEM zone .
but ARM platform have .
i remember boot loader must put init rd  into low memory region,
so if some boot loader put init rd into HIGH men zone
we can also relocate it to low men region ?
then boot loader don’t need care about this ,
and since vmalloc= boot option will change HIGH mem region size,
if we can relocate init rd , boot loader don’t need care about init rd load address,
when change vmalloc= boot options .


Thanks









