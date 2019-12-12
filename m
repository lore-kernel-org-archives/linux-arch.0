Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38868 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfLLHmz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 02:42:55 -0500
Subject: Re: [PATCH v2 4/4] powerpc: Book3S 64-bit "heavyweight" KASAN support
References: <20191210044714.27265-1-dja@axtens.net>
 <20191210044714.27265-5-dja@axtens.net>
 <71751e27-e9c5-f685-7a13-ca2e007214bc@gmail.com>
 <875zincu8a.fsf@dja-thinkpad.axtens.net>
 <2e0f21e6-7552-815b-1bf3-b54b0fc5caa9@gmail.com>
 <87wob3aqis.fsf@dja-thinkpad.axtens.net>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <1bffad2d-db13-9808-afc9-5594f02dcf01@gmail.com>
Date: Thu, 12 Dec 2019 18:42:40 +1100
MIME-Version: 1.0
In-Reply-To: <87wob3aqis.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <20191212074240.RiQf-wzO7aD_94I7DkCoVr2V-v5KWSzgtGsmmJfXgLQ@z>



On 12/12/19 1:24 am, Daniel Axtens wrote:
> Hi Balbir,
> 
>>>>> +Discontiguous memory can occur when you have a machine with memory spread
>>>>> +across multiple nodes. For example, on a Talos II with 64GB of RAM:
>>>>> +
>>>>> + - 32GB runs from 0x0 to 0x0000_0008_0000_0000,
>>>>> + - then there's a gap,
>>>>> + - then the final 32GB runs from 0x0000_2000_0000_0000 to 0x0000_2008_0000_0000
>>>>> +
>>>>> +This can create _significant_ issues:
>>>>> +
>>>>> + - If we try to treat the machine as having 64GB of _contiguous_ RAM, we would
>>>>> +   assume that ran from 0x0 to 0x0000_0010_0000_0000. We'd then reserve the
>>>>> +   last 1/8th - 0x0000_000e_0000_0000 to 0x0000_0010_0000_0000 as the shadow
>>>>> +   region. But when we try to access any of that, we'll try to access pages
>>>>> +   that are not physically present.
>>>>> +
>>>>
>>>> If we reserved memory for KASAN from each node (discontig region), we might survive
>>>> this no? May be we need NUMA aware KASAN? That might be a generic change, just thinking
>>>> out loud.
>>>
>>> The challenge is that - AIUI - in inline instrumentation, the compiler
>>> doesn't generate calls to things like __asan_loadN and
>>> __asan_storeN. Instead it uses -fasan-shadow-offset to compute the
>>> checks, and only calls the __asan_report* family of functions if it
>>> detects an issue. This also matches what I can observe with objdump
>>> across outline and inline instrumentation settings.
>>>
>>> This means that for this sort of thing to work we would need to either
>>> drop back to out-of-line calls, or teach the compiler how to use a
>>> nonlinear, NUMA aware mem-to-shadow mapping.
>>
>> Yes, out of line is expensive, but seems to work well for all use cases.
> 
> I'm not sure this is true. Looking at scripts/Makefile.kasan, allocas,
> stacks and globals will only be instrumented if you can provide
> KASAN_SHADOW_OFFSET. In the case you're proposing, we can't provide a
> static offset. I _think_ this is a compiler limitation, where some of
> those instrumentations only work/make sense with a static offset, but
> perhaps that's not right? Dmitry and Andrey, can you shed some light on
> this?
> 
