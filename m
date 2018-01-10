From: Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH 04/18] arm: implement nospec_ptr()
Date: Wed, 10 Jan 2018 09:24:48 -0800
Message-ID: <2db9ae03-833a-e9de-e95a-bb23b3c89e4a@redhat.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520101463.32271.9320376934909324865.stgit@dwillia2-desk3.amr.corp.intel.com>
 <32f6f9de-1f8f-f459-d9e4-c9a7044cf8af@redhat.com>
 <ad81ad1b-b960-4b24-e916-38459479e7f0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:37151 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeAJRYx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jan 2018 12:24:53 -0500
Received: by mail-ot0-f193.google.com with SMTP id a24so482248otd.4
        for <linux-arch@vger.kernel.org>; Wed, 10 Jan 2018 09:24:52 -0800 (PST)
In-Reply-To: <ad81ad1b-b960-4b24-e916-38459479e7f0@huawei.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hanjun Guo <guohanjun@huawei.com>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arch@vger.kernel.org, peterz@infradead.org, netdev@vger.kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de, torvalds@linux-foundation.org, alan@linux.intel.com, Justin Forbes <jforbes@redhat.com>

On 01/09/2018 11:40 PM, Hanjun Guo wrote:
> On 2018/1/10 10:04, Laura Abbott wrote:
>> On 01/05/2018 05:10 PM, Dan Williams wrote:
>>> From: Mark Rutland <mark.rutland@arm.com>
>>>
>>> This patch implements nospec_ptr() for arm, following the recommended
>>> architectural sequences for the arm and thumb instruction sets.
>>>
>> Fedora picked up the series and it fails on arm:
>>
>> In file included from ./include/linux/compiler.h:242:0,
>>                   from ./include/uapi/linux/swab.h:6,
>>                   from ./include/linux/swab.h:5,
>>                   from ./arch/arm/include/asm/opcodes.h:89,
>>                   from ./arch/arm/include/asm/bug.h:7,
>>                   from ./include/linux/bug.h:5,
>>                   from ./include/linux/mmdebug.h:5,
>>                   from ./include/linux/gfp.h:5,
>>                   from ./include/linux/slab.h:15,
>>                   from kernel/fork.c:14:
>> ./include/linux/fdtable.h: In function '__fcheck_files':
>> ./arch/arm/include/asm/barrier.h:112:41: error: expected declaration specifiers or '...' before numeric constant
>>    __load_no_speculate(&__np_ptr, lo, hi, 0, __np_ptr);  \
>>                                           ^
>> ./arch/arm/include/asm/barrier.h:68:32: note: in definition of macro '__load_no_speculate_n'
>>     (typeof(*ptr)(unsigned long)(failval));  \
>>                                  ^~~~~~~
>> ./arch/arm/include/asm/barrier.h:112:2: note: in expansion of macro '__load_no_speculate'
>>    __load_no_speculate(&__np_ptr, lo, hi, 0, __np_ptr);  \
>>    ^~~~~~~~~~~~~~~~~~~
>> ./include/asm-generic/barrier.h:122:2: note: in expansion of macro 'nospec_ptr'
>>    nospec_ptr(__arr + __idx, __arr, __arr + __sz);   \
>>    ^~~~~~~~~~
>> ./include/linux/fdtable.h:86:13: note: in expansion of macro 'nospec_array_ptr'
>>    if ((fdp = nospec_array_ptr(fdt->fd, fd, fdt->max_fds)))
>>               ^~~~~~~~~~~~~~~~
>> ./arch/arm/include/asm/barrier.h:112:41: error: expected declaration specifiers or '...' before numeric constant
>>    __load_no_speculate(&__np_ptr, lo, hi, 0, __np_ptr);  \
>>                                           ^
>> ./arch/arm/include/asm/barrier.h:68:32: note: in definition of macro '__load_no_speculate_n'
>>     (typeof(*ptr)(unsigned long)(failval));  \
>>                                  ^~~~~~~
>> ./arch/arm/include/asm/barrier.h:112:2: note: in expansion of macro '__load_no_speculate'
>>    __load_no_speculate(&__np_ptr, lo, hi, 0, __np_ptr);  \
>>    ^~~~~~~~~~~~~~~~~~~
>> ./include/asm-generic/barrier.h:122:2: note: in expansion of macro 'nospec_ptr'
>>    nospec_ptr(__arr + __idx, __arr, __arr + __sz);   \
>>    ^~~~~~~~~~
>> ./include/linux/fdtable.h:86:13: note: in expansion of macro 'nospec_array_ptr'
>>    if ((fdp = nospec_array_ptr(fdt->fd, fd, fdt->max_fds)))
>>               ^~~~~~~~~~~~~~~~
>> ./arch/arm/include/asm/barrier.h:112:41: error: expected declaration specifiers or '...' before numeric constant
>>    __load_no_speculate(&__np_ptr, lo, hi, 0, __np_ptr);  \
>>                                           ^
>> ./arch/arm/include/asm/barrier.h:68:32: note: in definition of macro '__load_no_speculate_n'
>>     (typeof(*ptr)(unsigned long)(failval));  \
>>                                  ^~~~~~~
>> ./arch/arm/include/asm/barrier.h:112:2: note: in expansion of macro '__load_no_speculate'
>>    __load_no_speculate(&__np_ptr, lo, hi, 0, __np_ptr);  \
>>    ^~~~~~~~~~~~~~~~~~~
>> ./include/asm-generic/barrier.h:122:2: note: in expansion of macro 'nospec_ptr'
>>    nospec_ptr(__arr + __idx, __arr, __arr + __sz);   \
>>    ^~~~~~~~~~
>> ./include/linux/fdtable.h:86:13: note: in expansion of macro 'nospec_array_ptr'
>>    if ((fdp = nospec_array_ptr(fdt->fd, fd, fdt->max_fds)))
>>
>> I can't puzzle out what exactly is the problem here, except that it really
>> does not seem to like that failval. Does the arm compiler not like doing
>> the typeof with the __arr + __idx?
> 
>>> +#define __load_no_speculate_n(ptr, lo, hi, failval, cmpptr, sz)    \
>>> +({                                \
>>> +    typeof(*ptr) __nln_val;                    \
>>> +    typeof(*ptr) __failval =                \
>>> +        (typeof(*ptr)(unsigned long)(failval));        \
> 
> Just typo,
> 
> -         (typeof(*ptr)(unsigned long)(failval));         \
> +         (typeof(*ptr))(unsigned long)(failval);             \
> 
> Please try it.
> 
> Thanks
> Hanjun
> 

Ah yeah, that's exactly it. I really missed the obvious.

Thanks,
Laura
