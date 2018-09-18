Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42567 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeIRRZX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 13:25:23 -0400
Received: by mail-yw1-f68.google.com with SMTP id n207-v6so632431ywn.9
        for <linux-arch@vger.kernel.org>; Tue, 18 Sep 2018 04:53:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1JCnSPi+D+CozhqL0dS9WwXtONDHp4=Kg5kCHrpdYwrw@mail.gmail.com>
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
 <1536036087-15260-2-git-send-email-firoz.khan@linaro.org> <CAK8P3a1JCnSPi+D+CozhqL0dS9WwXtONDHp4=Kg5kCHrpdYwrw@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Tue, 18 Sep 2018 17:23:07 +0530
Message-ID: <CALxhOngCL4DEcMD7NaxbUiksByzoxaaozzZGPmB0JFziFEWojw@mail.gmail.com>
Subject: Re: [PATCH 1/4] sparc: Move __IGNORE* entries to non uapi header
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Miller <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20180918115307.6v6c4cyre-O-VZ2yY7Re2XTaMA3oxbj_NJaGPGN-Jlo@z>

On 6 September 2018 at 20:58, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
>> +++ b/arch/sparc/include/uapi/asm/unistd.h
>> @@ -15,12 +15,6 @@
>>  #ifndef _UAPI_SPARC_UNISTD_H
>>  #define _UAPI_SPARC_UNISTD_H
>>
>> -#ifndef __32bit_syscall_numbers__
>> -#ifndef __arch64__
>> -#define __32bit_syscall_numbers__
>> -#endif
>> -#endif
>
> This is certainly required in the uapi header as of this patch,
> without it all the numbers are wrong when you include the
> file from user space.
>
> I suppose it can be removed later once the header is replaced
> with the two generated versions,

The script will generate 2 versions, ie, unistd_32.h and unistd_64.h.
Please give few more pointer here.

>
>> -/* Bitmask values returned from kern_features system call.  */
>> -#define KERN_FEATURE_MIXED_MODE_STACK  0x00000001
>
> I'm fairly sure this also needs to remain in the uapi/asm/unistd.h header
> as a start, so that user space can call the sys_kern_features() system
> call and interpret its result when only the first patch is applied.

Sure. I'll update in the next patch series. Thanks!

>
>> -#ifdef __32bit_syscall_numbers__
>> -/* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
>> - * it never had the plain ones and there is no value to adding those
>> - * old versions into the syscall table.
>> - */
>> -#define __IGNORE_setresuid
>> -#define __IGNORE_getresuid
>> -#define __IGNORE_setresgid
>> -#define __IGNORE_getresgid
>> -#endif
>> -
>> -/* Sparc doesn't have protection keys. */
>> -#define __IGNORE_pkey_mprotect
>> -#define __IGNORE_pkey_alloc
>> -#define __IGNORE_pkey_free
>> -
>
> This part is fine.
>
>       Arnd
