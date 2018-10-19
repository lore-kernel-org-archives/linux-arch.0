Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46864 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeJSXn0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Oct 2018 19:43:26 -0400
Received: by mail-yb1-f194.google.com with SMTP id o8-v6so13409406ybk.13
        for <linux-arch@vger.kernel.org>; Fri, 19 Oct 2018 08:36:49 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id j76-v6sm6950480ywj.5.2018.10.19.08.36.46
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 08:36:47 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id j202-v6so13329885ywa.13
        for <linux-arch@vger.kernel.org>; Fri, 19 Oct 2018 08:36:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181019112404.GD14246@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-8-kristina.martsenko@arm.com> <20181019111542.6wrvjguirglzg7vg@mbp>
 <20181019112404.GD14246@arm.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 19 Oct 2018 08:36:45 -0700
Message-ID: <CAGXu5j+2axuzPJji_eCvMZDiPvrPsP3kAnG0CY_rsL5c=uFQFA@mail.gmail.com>
Subject: Re: [PATCH v5 07/17] arm64: add basic pointer authentication support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Kristina Martsenko <kristina.martsenko@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Andrew Jones <drjones@redhat.com>, Jacob Bramley <jacob.bramley@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Adam Wallis <awallis@codeaurora.org>, "Suzuki K . Poulose" <suzuki.poulose@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>, Amit Kachhap <Amit.Kachhap@arm.com>, Dave P Martin <Dave.Martin@arm.com>, LKML <linux-kernel@vger.kernel.org>, Cyrill Gorcunov <gorcunov@openvz.org>
Message-ID: <20181019153645.sy1zKMDosUoZ32xfQKH_o1QVcIctU3rBf7kdxNtpzXs@z>

On Fri, Oct 19, 2018 at 4:24 AM, Will Deacon <will.deacon@arm.com> wrote:
> [+Cyrill Gorcunov for CRIU stuff]
>
> On Fri, Oct 19, 2018 at 12:15:43PM +0100, Catalin Marinas wrote:
>> On Fri, Oct 05, 2018 at 09:47:44AM +0100, Kristina Martsenko wrote:
>> > diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
>> > new file mode 100644
>> > index 000000000000..2aefedc31d9e
>> > --- /dev/null
>> > +++ b/arch/arm64/include/asm/pointer_auth.h
>> > @@ -0,0 +1,63 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +#ifndef __ASM_POINTER_AUTH_H
>> > +#define __ASM_POINTER_AUTH_H
>> > +
>> > +#include <linux/random.h>
>> > +
>> > +#include <asm/cpufeature.h>
>> > +#include <asm/sysreg.h>
>> > +
>> > +#ifdef CONFIG_ARM64_PTR_AUTH
>> > +/*
>> > + * Each key is a 128-bit quantity which is split across a pair of 64-bit
>> > + * registers (Lo and Hi).
>> > + */
>> > +struct ptrauth_key {
>> > +   unsigned long lo, hi;
>> > +};
>> > +
>> > +/*
>> > + * We give each process its own instruction A key (APIAKey), which is shared by
>> > + * all threads. This is inherited upon fork(), and reinitialised upon exec*().
>> > + * All other keys are currently unused, with APIBKey, APDAKey, and APBAKey
>> > + * instructions behaving as NOPs.
>> > + */
>>
>> I don't remember the past discussions but I assume the tools guys are ok
>> with a single key shared by multiple threads. Ramana, could you ack this
>> part, FTR?
>>
>> (and it would help if someone from the Android and Chrome camps can
>> confirm)
>
> FWIW: I think we should be entertaining a prctl() interface to use a new
> key on a per-thread basis. Obviously, this would need to be used with care
> (e.g. you'd fork(); use the prctl() and then you'd better not return from
> the calling function!).
>
> Assuming we want this (Kees -- I was under the impression that everything in
> Android would end up with the same key otherwise?), then the question is
> do we want:
>
>   - prctl() get/set operations for the key, or
>   - prctl() set_random_key operation, or
>   - both of the above?
>
> Part of the answer to that may lie in the requirements of CRIU, where I
> strongly suspect they need explicit get/set operations, although these
> could be gated on CONFIG_CHECKPOINT_RESTORE=y.

Oh CRIU. Yikes. I'd like the get/set to be gated by the CONFIG, yes.
No reason to allow explicit access to the key (and selected algo) if
we don't have to.

As for per-thread or not, having a "pick a new key now" prctl() sounds
good, but I'd like to have an eye toward having it just be "automatic"
on clone().

-Kees

-- 
Kees Cook
Pixel Security
