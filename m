Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37827 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKVlU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Dec 2018 16:41:20 -0500
Received: by mail-qk1-f193.google.com with SMTP id 131so9551563qkd.4
        for <linux-arch@vger.kernel.org>; Tue, 11 Dec 2018 13:41:19 -0800 (PST)
MIME-Version: 1.0
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com> <CAK8P3a1njNBWiMExBevqbT+AuUHdU4T2sc1o1rRTn+Ji=y2SbA@mail.gmail.com>
 <64ff3b50-ce55-ff69-ac3a-61f221299895@arm.com>
In-Reply-To: <64ff3b50-ce55-ff69-ac3a-61f221299895@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Dec 2018 22:41:01 +0100
Message-ID: <CAK8P3a0LgFuv_s4xiC_rD0X7-GxHRWfzmdDcxJ7vvHrEETApRw@mail.gmail.com>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181211214101.bu83MxjzlIU7YzIeGGLpTWJ3X7VHNiC0T2MGM5TF6dI@z>

On Tue, Dec 11, 2018 at 2:39 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> On 29/11/2018 20:42, Arnd Bergmann wrote:
> > On Thu, Nov 29, 2018 at 6:06 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >
> >> +/*
> >> + * The definitions below are required to overcome the limitations
> >> + * of time_t on 32 bit architectures, which overflows in 2038.
> >> + * The new code should use the replacements based on time64_t and
> >> + * timespec64.
> >> + *
> >> + * The abstraction below will be updated once the migration to
> >> + * time64_t is complete.
> >> + */
> >> +#ifdef CONFIG_GENERIC_VDSO_32
> >> +#define __vdso_timespec                old_timespec32
> >> +#define __vdso_timeval         old_timeval32
> >> +#else
> >> +#ifdef ENABLE_COMPAT_VDSO
> >> +#define __vdso_timespec                old_timespec32
> >> +#define __vdso_timeval         old_timeval32
> >> +#else
> >> +#define __vdso_timespec                __kernel_timespec
> >> +#define __vdso_timeval         __kernel_old_timeval
> >> +#endif /* CONFIG_COMPAT_VDSO */
> >> +#endif /* CONFIG_GENERIC_VDSO_32 */
> >>
> >
> > Have you considered doing this in the reverse way, by including
> > the common parts from multiple implementations (32 and 64
> > bit), instead of compiling the same source file multiple
> > times with different macros set? I think that would make it
> > easier to understand.
> >
>
> The common code is never compiled as standalone. It includes arch specific code
> (for the fallbacks) and it is included in the arch specific vdso library (for
> both 32 and 64 bit where it makes sense). Hence it is built once or twice.
>
> If I understand correctly your question, seems inline with what I am doing.

The result is very similar, it's just a question of which file includes which
other file. If I understand your current method right, you use Makefile
logic to build multiple object files from a single source file, and setting
ENABLE_COMPAT_VDSO on one of them, right?

My preference would be to keep that Makefile simpler and have one
source file per object file, but have each one define a set of macros
before including the common source file, similarly to how we deal
with fs/compat_binfmt_elf.c. If that turns out to be worse than what
you have here, I'm not overly attached to that solution since including
C files is still ugly, but I think it's worth trying if that lets you end
up with more easily understandable source code.

       Arnd
