Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51493 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfBLK1Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Feb 2019 05:27:24 -0500
Subject: Re: [PATCH v7 05/28] x86/asm/entry: annotate THUNKs
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-6-jslaby@suse.cz> <20190209112551.GA5089@zn.tnic>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <b75f2a0d-974a-c63b-64f8-8f333991e826@suse.cz>
Date: Tue, 12 Feb 2019 11:27:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190209112551.GA5089@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Message-ID: <20190212102719.pizglOZkxdbSVuh6EYcXQjuRVbTKw56-WUcJkk7s5Vs@z>

On 09. 02. 19, 12:25, Borislav Petkov wrote:
>> @@ -57,7 +56,7 @@
>>  #if defined(CONFIG_TRACE_IRQFLAGS) \
>>   || defined(CONFIG_DEBUG_LOCK_ALLOC) \
>>   || defined(CONFIG_PREEMPT)
>> -.L_restore:
>> +SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
>>  	popq %r11
>>  	popq %r10
>>  	popq %r9
>> @@ -70,4 +69,5 @@
>>  	popq %rbp
>>  	ret
>>  	_ASM_NOKPROBE(.L_restore)
>> +SYM_CODE_END(.L_restore)
> 
> That local label doesn't even land in the symbol table:
> 
> $ readelf -a  arch/x86/entry/thunk_64.o | grep restore
> $
> 
> so no need to touch it, AFAICT. And all local labels, for that matter.

Yes, they do not end up in the symbol table. But the macros make clear
where is the start of the function and especially where is the end
(something like closing bracket '}' in C). If you prefer not annotating
local symbols, I can of course drop it from everywhere. But to me it
looks more readable to see "here it starts" and "here it ends", still
without generating anything to the symbol table.

thanks,
-- 
js
suse labs
