From: Behan Webster <behanw@converseincode.com>
Subject: Re: [PATCH v2] LLVMLinux: Remove warning about returning an uninitialized
 variable
Date: Sat, 22 Mar 2014 09:37:36 -0700
Message-ID: <532DBC50.9040505@converseincode.com>
References: <201403221101.16961.arnd@arndb.de>	 <1395503299-15203-1-git-send-email-behanw@converseincode.com> <1395505786.2143.14.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46370 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbaCVQhk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 22 Mar 2014 12:37:40 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so3658479pbb.19
        for <linux-arch@vger.kernel.org>; Sat, 22 Mar 2014 09:37:39 -0700 (PDT)
In-Reply-To: <1395505786.2143.14.camel@dabdike.int.hansenpartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org, pageexec@freemail.hu, Mark Charlebois <charlebm@gmail.com>

On 03/22/14 09:29, James Bottomley wrote:
> On Sat, 2014-03-22 at 08:48 -0700, behanw@converseincode.com wrote:
>> From: Behan Webster <behanw@converseincode.com>
>>
>> Fix uninitialized return code in default case in cmpxchg-local.h
>>
>> This patch fixes the code to prevent an uninitialized return value that is detected
>> when compiling with clang. The bug produces numerous warnings when compiling the
>> Linux kernel with clang.
>>
>> Signed-off-by: Behan Webster <behanw@converseincode.com>
>> Signed-off-by: Mark Charlebois <charlebm@gmail.com>
>> ---
>>   include/asm-generic/cmpxchg-local.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/asm-generic/cmpxchg-local.h b/include/asm-generic/cmpxchg-local.h
>> index d8d4c89..9112111 100644
>> --- a/include/asm-generic/cmpxchg-local.h
>> +++ b/include/asm-generic/cmpxchg-local.h
>> @@ -41,6 +41,7 @@ static inline unsigned long __cmpxchg_local_generic(volatile void *ptr,
>>   		break;
>>   	default:
>>   		wrong_size_cmpxchg(ptr);
>> +		__builtin_unreachable();
> No, that's got to be unreachable() so that it works in all compilers,
> (__builtin_unreachable is a gcc-4 ism).
It is also supported by clang.

> Got to say this still looks wrong.  If wrong_size_cmpxchg() cannot
> return, the function should be annotated as such with __noreturn (like
> panic()) so the unreachable() should be superfluous.
Okay. I can try that instead.

Thanks,

Behan

-- 
Behan Webster
behanw@converseincode.com
