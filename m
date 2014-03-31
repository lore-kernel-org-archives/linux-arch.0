From: Behan Webster <behanw@converseincode.com>
Subject: Re: [PATCH] LLVMLinux: Remove warning about returning an uninitialized
 variable
Date: Mon, 31 Mar 2014 15:10:19 -0700
Message-ID: <5339E7CB.2080001@converseincode.com>
References: <1395470329-15065-1-git-send-email-behanw@converseincode.com> <5339D57A.4050504@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:41675 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaCaWKW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 31 Mar 2014 18:10:22 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so8850251pbc.20
        for <linux-arch@vger.kernel.org>; Mon, 31 Mar 2014 15:10:22 -0700 (PDT)
In-Reply-To: <5339D57A.4050504@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, arnd@arndb.de
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org, pageexec@freemail.hu, Mark Charlebois <charlebm@gmail.com>

On 03/31/14 13:52, H. Peter Anvin wrote:
> On 03/21/2014 11:38 PM, behanw@converseincode.com wrote:
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
>> index d8d4c89..4c41bb8 100644
>> --- a/include/asm-generic/cmpxchg-local.h
>> +++ b/include/asm-generic/cmpxchg-local.h
>> @@ -41,6 +41,7 @@ static inline unsigned long __cmpxchg_local_generic(volatile void *ptr,
>>   		break;
>>   	default:
>>   		wrong_size_cmpxchg(ptr);
>> +		prev = 0;
>>   	}
>>   	raw_local_irq_restore(flags);
>>   	return prev;
>>
> Shouldn't this be a build time assert (__compiletime_error())?
I changed it to a __noreturn on wrong_size_cmpxchg thanks to James 
Bottomley.

Which would be better?

Behan

-- 
Behan Webster
behanw@converseincode.com
