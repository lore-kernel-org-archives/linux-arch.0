From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] locking/refcounts, x86/asm: Use unique .text section for
 refcount exceptions
Date: Sat, 2 Sep 2017 00:30:22 -0700
Message-ID: <CAGXu5j+sy-JZAh_Nm+NmdXqCGxru6pKg-nBd9ApueA6C829eFA@mail.gmail.com>
References: <20170901202203.GA48925@beast> <1504324991.6011.7.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:34971 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdIBHaX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Sep 2017 03:30:23 -0400
Received: by mail-io0-f170.google.com with SMTP id z67so8858431iof.2
        for <linux-arch@vger.kernel.org>; Sat, 02 Sep 2017 00:30:23 -0700 (PDT)
In-Reply-To: <1504324991.6011.7.camel@gmx.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, "x86@kernel.org" <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Reshetova, Elena" <elena.reshetova@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On Fri, Sep 1, 2017 at 9:03 PM, Mike Galbraith <efault@gmx.de> wrote:
> On Fri, 2017-09-01 at 13:22 -0700, Kees Cook wrote:
>> Using .text.unlikely for refcount exceptions isn't safe because gcc may
>> move entire functions into .text.unlikely (e.g. in6_dev_get()), which
>> would cause any uses of a protected refcount_t function to stay inline
>> with the function, triggering the protection unconditionally:
>>
>>         .section        .text.unlikely,"ax",@progbits
>>         .type   in6_dev_get, @function
>> in6_dev_getx:
>> .LFB4673:
>>         .loc 2 4128 0
>>         .cfi_startproc
>> ...
>>         lock; incl 480(%rbx)
>>         js 111f
>>         .pushsection .text.unlikely
>> 111:    lea 480(%rbx), %rcx
>> 112:    .byte 0x0f, 0xff
>> .popsection
>> 113:
>>
>> This creates a unique .text section and adds an additional test to the
>> exception handler to WARN in the case of having none of OF, SF, nor ZF
>> set so we can see things like this more easily in the future.
>
> Closure: gcc-4.8.5 now builds a functional kernel as well, so that
> aspect of this bug was just a larger a dose of the same toxin.

Okay, excellent. Thanks for checking!

>
> Question below.
>
> diff --git a/arch/x86/include/asm/refcount.h
> b/arch/x86/include/asm/refcount.h
>> index ff871210b9f2..4e44250e7d0d 100644
>> --- a/arch/x86/include/asm/refcount.h
>> +++ b/arch/x86/include/asm/refcount.h
>> @@ -15,7 +15,7 @@
>>   * back to the regular execution flow in .text.
>>   */
>>  #define _REFCOUNT_EXCEPTION                          \
>> -     ".pushsection .text.unlikely\n"                 \
>> +     ".pushsection .text..refcount\n"                \
>
> Why two dots? (.text.refcount_ex?)

A dot keeps it out of the TEXT_MAIN macro namespace (see cb87481ee89db
in -next, which is function names: [a-zA-Z0-9_]) to avoid collisions
and so it can be put at the end with text.unlikely to keep the cold
code together.

-Kees

-- 
Kees Cook
Pixel Security
