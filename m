From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] locking/refcounts, x86/asm: Use unique .text section for
 refcount exceptions
Date: Fri, 1 Sep 2017 19:58:12 -0700
Message-ID: <CAGXu5j+h+OCG+aJPi5YwkzWeiJGL3mxUkijD_-x4vtjzV0YkPA@mail.gmail.com>
References: <20170901202203.GA48925@beast> <CAKv+Gu88z=eNKmeaMcfDNjp4DGWSTdEfq9mfr6K+F86QL9WFug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:34642 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752475AbdIBC6O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2017 22:58:14 -0400
Received: by mail-io0-f171.google.com with SMTP id i200so8257527ioa.1
        for <linux-arch@vger.kernel.org>; Fri, 01 Sep 2017 19:58:14 -0700 (PDT)
In-Reply-To: <CAKv+Gu88z=eNKmeaMcfDNjp4DGWSTdEfq9mfr6K+F86QL9WFug@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Ingo Molnar <mingo@elte.hu>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Mike Galbraith <efault@gmx.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Reshetova, Elena" <elena.reshetova@intel.com>, Peter Zijlstra <peterz@infradead.org>

On Fri, Sep 1, 2017 at 2:43 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 1 September 2017 at 21:22, Kees Cook <keescook@chromium.org> wrote:
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
>>
>> Reported-by: Mike Galbraith <efault@gmx.de>
>> Fixes: 7a46ec0e2f48 ("locking/refcounts, x86/asm: Implement fast refcount overflow protection")
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  arch/x86/Kconfig                  | 2 +-
>>  arch/x86/include/asm/refcount.h   | 2 +-
>>  arch/x86/mm/extable.c             | 7 ++++++-
>>  include/asm-generic/vmlinux.lds.h | 1 +
>>  4 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index eaa8ff41f424..c6acdcdb3fc6 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -56,7 +56,7 @@ config X86
>>         select ARCH_HAS_MMIO_FLUSH
>>         select ARCH_HAS_PMEM_API                if X86_64
>>         # Causing hangs/crashes, see the commit that added this change for details.
>> -       select ARCH_HAS_REFCOUNT                if BROKEN
>> +       select ARCH_HAS_REFCOUNT
>>         select ARCH_HAS_UACCESS_FLUSHCACHE      if X86_64
>>         select ARCH_HAS_SET_MEMORY
>>         select ARCH_HAS_SG_CHAIN
>> diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
>> index ff871210b9f2..4e44250e7d0d 100644
>> --- a/arch/x86/include/asm/refcount.h
>> +++ b/arch/x86/include/asm/refcount.h
>> @@ -15,7 +15,7 @@
>>   * back to the regular execution flow in .text.
>>   */
>>  #define _REFCOUNT_EXCEPTION                            \
>> -       ".pushsection .text.unlikely\n"                 \
>> +       ".pushsection .text..refcount\n"                \
>
> You could also use a .subsection here: those are always emitted out of
> line, but into the same section.

I considered it (especially after looking to see how you handled it in
the arm64 port) but decided against it in favor of collecting them all
at the end with .text.unlikely.

-Kees

-- 
Kees Cook
Pixel Security
