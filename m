Return-Path: <SRS0=06hN=5A=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:49936 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgCOKDE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 Mar 2020 06:03:04 -0400
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 00/26] Introduce common headers for vDSO
In-Reply-To: <693b6a61-b5f6-2744-1579-b356e6510547@gmail.com>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com> <693b6a61-b5f6-2744-1579-b356e6510547@gmail.com>
Date: Sun, 15 Mar 2020 11:02:45 +0100
Message-ID: <87fteadjga.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>
Message-ID: <20200315100245.3PskKXZhkDn_Nz5OkfLqxq5J6Z_KjMr6OAvZmCDoFb4@z>

Dmitry Safonov <0x7f454c46@gmail.com> writes:
> I like the idea, but I'm wondering if we could have less-grained
> headers? Like, AFAICS the patches create headers < 10 lines and even
> mostly < 5 lines.. I like that header's names perfectly describe what's
> inside, but I'm not sure how effective to have a lot of extra-small
> includes.

If that goes all into a big header then the headers from where the bits and
pieces are split out would have all to include this big header which
might result in other include dependency nightmares.

>>  create mode 100644 include/vdso/time.h
>>  create mode 100644 include/vdso/time32.h
>>  create mode 100644 include/vdso/time64.h
>
> Maybe we could made them less-grained?
>
> I.e, time32 + time64 + time.h => time.h?

Then you end up with ifdeffery. I like the clear separation.

Thanks,

        tglx
