From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] asm-generic: simd: allow SIMD in process context with BH disabled
Date: Wed, 31 May 2017 16:18:04 +0000
Message-ID: <CAKv+Gu_2Htx2-abN_L6mLv5VzfrLxnmOGYeCqMuyeN5h8W2yow@mail.gmail.com>
References: <20170531125701.20717-1-ard.biesheuvel@linaro.org>
 <20170531153231.GC30160@e103592.cambridge.arm.com> <CAKv+Gu_Z40UAwOafVfvzw7vcvLZ_XqT9eJzqhwzadYfKDsTf7w@mail.gmail.com>
 <20170531161357.GD30160@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:37378 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbdEaQSG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2017 12:18:06 -0400
Received: by mail-it0-f47.google.com with SMTP id g126so14547352ith.0
        for <linux-arch@vger.kernel.org>; Wed, 31 May 2017 09:18:05 -0700 (PDT)
In-Reply-To: <20170531161357.GD30160@e103592.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 31 May 2017 at 16:13, Dave Martin <Dave.Martin@arm.com> wrote:
> On Wed, May 31, 2017 at 03:52:48PM +0000, Ard Biesheuvel wrote:
>> On 31 May 2017 at 15:32, Dave Martin <Dave.Martin@arm.com> wrote:
>> > On Wed, May 31, 2017 at 12:57:01PM +0000, Ard Biesheuvel wrote:
>> >> asm-generic supplies a header asm/simd.h which exports a single function
>> >> may_use_simd(), which conveys whether the current context allows the SIMD
>> >> register file or instructions to be used.
>> >>
>> >> This header is included by crypto code shared between x86 and ARM/arm64,
>> >> and which offloads SIMD processing to process context if required. The
>> >> generic asm/simd.h is shared between ARM and arm64 at the moment, while
>> >> x86 has its own implementation.
>> >>
>> >> On arm64, we currently mostly ignore may_use_simd(), because arm64 allows
>> >> kernel mode NEON in any context. However, this is due to change shortly
>> >> when support for SVE is merged, at which point we will introduce an arm64
>> >> specific implementation of asm/simd.h as well.
>> >>
>> >> That leaves ARM, which only allows kernel mode NEON in process context,
>> >> which makes the current generic implementation of may_use_simd() seem
>> >> appropriate. However, given that in_interrupt() will return true when
>> >> running in process context with bottom halves disabled, we may end up
>> >> falling back to less optimized code unnecessarily, given that kernel
>> >> mode NEON is perfectly usable in that case.
>> >>
>> >> So redefine may_use_simd() to disallow SIMD only when running in hardirq
>> >> or softirq context.
>> >>
>> >> While we're at it, add some missing header file decorations such as
>> >> a license header and include guards.
>> >>
>> >> Reported-by: "Jason A. Donenfeld" <Jason@zx2c4.com>
>> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >> ---
>> >>  include/asm-generic/simd.h | 23 ++++++++++++++++++++---
>> >>  1 file changed, 20 insertions(+), 3 deletions(-)
>> >>
>> >> diff --git a/include/asm-generic/simd.h b/include/asm-generic/simd.h
>> >> index f57eb7b5c23b..a3e5ebe6b2b2 100644
>> >> --- a/include/asm-generic/simd.h
>> >> +++ b/include/asm-generic/simd.h
>> >> @@ -1,14 +1,31 @@
>> >> +/*
>> >> + * Copyright (C) 2013 - 2017 Linaro Ltd. <ard.biesheuvel@linaro.org>
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or modify it
>> >> + * under the terms of the GNU General Public License version 2 as published
>> >> + * by the Free Software Foundation.
>> >> + */
>> >>
>> >> -#include <linux/hardirq.h>
>> >> +#ifndef __ASM_SIMD_H
>> >> +#define __ASM_SIMD_H
>> >> +
>> >> +#include <linux/types.h>
>> >> +#include <linux/preempt.h>
>
> Forgot to mention, should <linux/compiler.h> be included for
> __must_check?
>

Yes.

>> >> + * taking an interrupt, it is reasonable to define the default behavior
>> >> + * of 'may_use_simd()' to be 'SIMD is only allowed when not handling an
>> >> + * IRQ or softIRQ'. Since 'in_interrupt()' will also return true when
>> >> + * running in process context with bottom halves disabled, we have to
>> >> + * spell out that condition as shown.
>> >
>> > Minor nit: do we need the comment about in_interrupt() here?
>> >
>> > It makes more sense to explain the change in the commit message (which
>> > you do) than to explain in-line the behaviour of a function that the
>> > code doesn't use.
>> >
>> > <linux/preempt.h> already hints at the caveats of in_interrupt().
>> >
>>
>> Fair enough. I tend to err on the verbose side when it comes to
>> comments, but this could indeed be omitted.
>>
>> >
>> > For this comment block, it may be more helpful to note that SIMD is
>> > permitted in task context even if bottom halves are enabled.
>> >
>> >>   */
>> >>  static __must_check inline bool may_use_simd(void)
>> >>  {
>> >> -     return !in_interrupt();
>> >> +     return !in_irq() && !in_serving_softirq();
>> >
>> > Previously, in_nmi() implied !may_use_simd().
>> >
>> > Now, may_use_simd() can return true if in_nmi().
>> >
>> > Code in NMI context probably shouldn't be touching this interface at
>> > all, but we may want to close this hole by adding && !in_nmi()
>> > explicitly.  I did that in my kernel-mode-neon simplification series,
>> > but couldn't decide whether it was superfluous.
>> >
>> > Any thoughts?
>> >
>>
>> I agree. I will add that as well.
>
> OK, cheers
> ---Dave
