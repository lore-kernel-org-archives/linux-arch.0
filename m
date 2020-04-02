From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH RESEND 3/4] drm/i915/gem: Replace user_access_begin by
 user_write_access_begin
Date: Thu, 2 Apr 2020 09:59:36 +0200
Message-ID: <e5e1ad22-e3b2-5779-2662-1bd464eae175@c-s.fr>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <6da6fa391c0d6344cc9ff99a69fcaa65666f3947.1585811416.git.christophe.leroy@c-s.fr>
 <202004020051.649C6B8@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:15715 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387482AbgDBH7o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Apr 2020 03:59:44 -0400
In-Reply-To: <202004020051.649C6B8@keescook>
Content-Language: fr
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie, daniel@ffwll.ch, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, hpa@zytor.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org



Le 02/04/2020 à 09:52, Kees Cook a écrit :
> On Thu, Apr 02, 2020 at 07:34:18AM +0000, Christophe Leroy wrote:
>> When i915_gem_execbuffer2_ioctl() is using user_access_begin(),
>> that's only to perform unsafe_put_user() so use
>> user_write_access_begin() in order to only open write access.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Why is this split from the other conversions?


I split it from the other because this one is in drivers while other 
ones are in core part of the kernel.

Is it better to squash it in the previous patch ?

Christophe

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> 
>> ---
>>   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
>> index 7643a30ba4cd..4be8205a70b6 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
>> @@ -1611,14 +1611,14 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
>>   		 * happened we would make the mistake of assuming that the
>>   		 * relocations were valid.
>>   		 */
>> -		if (!user_access_begin(urelocs, size))
>> +		if (!user_write_access_begin(urelocs, size))
>>   			goto end;
>>   
>>   		for (copied = 0; copied < nreloc; copied++)
>>   			unsafe_put_user(-1,
>>   					&urelocs[copied].presumed_offset,
>>   					end_user);
>> -		user_access_end();
>> +		user_write_access_end();
>>   
>>   		eb->exec[i].relocs_ptr = (uintptr_t)relocs;
>>   	}
>> @@ -1626,7 +1626,7 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
>>   	return 0;
>>   
>>   end_user:
>> -	user_access_end();
>> +	user_write_access_end();
>>   end:
>>   	kvfree(relocs);
>>   	err = -EFAULT;
>> @@ -2991,7 +2991,8 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
>>   		 * And this range already got effectively checked earlier
>>   		 * when we did the "copy_from_user()" above.
>>   		 */
>> -		if (!user_access_begin(user_exec_list, count * sizeof(*user_exec_list)))
>> +		if (!user_write_access_begin(user_exec_list,
>> +					     count * sizeof(*user_exec_list)))
>>   			goto end;
>>   
>>   		for (i = 0; i < args->buffer_count; i++) {
>> @@ -3005,7 +3006,7 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
>>   					end_user);
>>   		}
>>   end_user:
>> -		user_access_end();
>> +		user_write_access_end();
>>   end:;
>>   	}
>>   
>> -- 
>> 2.25.0
>>
> 
