From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 11/15] s390: NR_syscalls fix
Date: Fri, 11 Apr 2014 13:52:08 +0200
Message-ID: <CAJfpegvqoiZ6ZDF78ptvDLdav4AAcLfYpji6c-_rqu4-BoGXTg@mail.gmail.com>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
	<1397211951-20549-12-git-send-email-miklos@szeredi.hu>
	<20140411132412.2ef89a3b@mschwide>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:58909 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256AbaDKLwT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Apr 2014 07:52:19 -0400
Received: by mail-qg0-f49.google.com with SMTP id j107so387307qga.36
        for <linux-arch@vger.kernel.org>; Fri, 11 Apr 2014 04:52:18 -0700 (PDT)
In-Reply-To: <20140411132412.2ef89a3b@mschwide>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Miklos Szeredi <mszeredi@suse.cz>

On Fri, Apr 11, 2014 at 1:24 PM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
> On Fri, 11 Apr 2014 12:25:47 +0200
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
>> From: Miklos Szeredi <mszeredi@suse.cz>
>>
>> Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> ---
>>  arch/s390/include/uapi/asm/unistd.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/include/uapi/asm/unistd.h b/arch/s390/include/uapi/asm/unistd.h
>> index 5eb5c9ddb120..57194268fe63 100644
>> --- a/arch/s390/include/uapi/asm/unistd.h
>> +++ b/arch/s390/include/uapi/asm/unistd.h
>> @@ -282,7 +282,7 @@
>>  #define __NR_finit_module    344
>>  #define __NR_sched_setattr   345
>>  #define __NR_sched_getattr   346
>> -#define NR_syscalls 345
>> +#define NR_syscalls 347
>>
>>  /*
>>   * There are some system calls that are not present on 64 bit, some
>
> Is this patch part of a patch series that does upstream directly?
> I am asking because Heiko already created a patch for this and we have
> added it to the linux-s390:fixes branch for upstream integration.

No, I don't mean to upstream directly.   So you can just drop my submission...

Thanks,
Miklos
