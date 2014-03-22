From: Behan Webster <behanw@converseincode.com>
Subject: Re: [PATCH v2] LLVMLinux: Remove warning about returning an uninitialized
 variable
Date: Sat, 22 Mar 2014 09:31:12 -0700
Message-ID: <532DBAD0.6030904@converseincode.com>
References: <201403221101.16961.arnd@arndb.de> <1395503299-15203-1-git-send-email-behanw@converseincode.com> <20140322162147.GA9034@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:55899 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbaCVQbW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 22 Mar 2014 12:31:22 -0400
Received: by mail-pd0-f175.google.com with SMTP id x10so3569932pdj.34
        for <linux-arch@vger.kernel.org>; Sat, 22 Mar 2014 09:31:22 -0700 (PDT)
In-Reply-To: <20140322162147.GA9034@ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org, pageexec@freemail.hu, Mark Charlebois <charlebm@gmail.com>

On 03/22/14 09:21, Sam Ravnborg wrote:
> On Sat, Mar 22, 2014 at 08:48:19AM -0700, behanw@converseincode.com wrote:
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
> It is unreachable() - see compiler.h
Oh I see.

Behan

-- 
Behan Webster
behanw@converseincode.com
