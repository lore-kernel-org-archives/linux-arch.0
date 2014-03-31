From: Behan Webster <behanw@converseincode.com>
Subject: Re: [PATCH] LLVMLinux: Remove warning about returning an uninitialized
 variable
Date: Mon, 31 Mar 2014 15:16:38 -0700
Message-ID: <5339E946.90903@converseincode.com>
References: <1395470329-15065-1-git-send-email-behanw@converseincode.com> <5339D57A.4050504@zytor.com> <5339E7CB.2080001@converseincode.com> <5339E81C.4010901@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:40490 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbaCaWQl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 31 Mar 2014 18:16:41 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so8843822pad.16
        for <linux-arch@vger.kernel.org>; Mon, 31 Mar 2014 15:16:40 -0700 (PDT)
In-Reply-To: <5339E81C.4010901@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, arnd@arndb.de
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org, pageexec@freemail.hu, Mark Charlebois <charlebm@gmail.com>

On 03/31/14 15:11, H. Peter Anvin wrote:
> On 03/31/2014 03:10 PM, Behan Webster wrote:
>>>> diff --git a/include/asm-generic/cmpxchg-local.h
>>>> b/include/asm-generic/cmpxchg-local.h
>>>> index d8d4c89..4c41bb8 100644
>>>> --- a/include/asm-generic/cmpxchg-local.h
>>>> +++ b/include/asm-generic/cmpxchg-local.h
>>>> @@ -41,6 +41,7 @@ static inline unsigned long
>>>> __cmpxchg_local_generic(volatile void *ptr,
>>>>            break;
>>>>        default:
>>>>            wrong_size_cmpxchg(ptr);
>>>> +        prev = 0;
>>>>        }
>>>>        raw_local_irq_restore(flags);
>>>>        return prev;
>>>>
>>> Shouldn't this be a build time assert (__compiletime_error())?
>> I changed it to a __noreturn on wrong_size_cmpxchg thanks to James
>> Bottomley.
>>
>> Which would be better?
>>
> __compiletime_error traps at compile time rather than link time, which
> is what you want.
The idea is to remove the compile time warning that the return code 
"prev" isn't initialized in the default case. Indicating that 
wrong_size_cmpxchg doesn't return fixes that false positive.

Behan

-- 
Behan Webster
behanw@converseincode.com
