Return-Path: <SRS0=WjNt=46=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36061 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgCMQTc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Mar 2020 12:19:32 -0400
Subject: Re: [PATCH v3 00/26] Introduce common headers for vDSO
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <693b6a61-b5f6-2744-1579-b356e6510547@gmail.com>
Date: Fri, 13 Mar 2020 16:19:23 +0000
MIME-Version: 1.0
In-Reply-To: <20200313154345.56760-1-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>
Message-ID: <20200313161923.e3jPoOy5-3RyOGMfjcVbJ4IrDZFtGJMpZAZ8zwTssfk@z>

Hi Vincenzo, all

I like the idea, but I'm wondering if we could have less-grained
headers? Like, AFAICS the patches create headers < 10 lines and even
mostly < 5 lines.. I like that header's names perfectly describe what's
inside, but I'm not sure how effective to have a lot of extra-small
includes.

Or maybe there's a plan to grow the code in them?

On 3/13/20 3:43 PM, Vincenzo Frascino wrote:
[..]
>  create mode 100644 arch/arm/include/asm/vdso/clocksource.h
>  create mode 100644 arch/arm/include/asm/vdso/cp15.h
>  create mode 100644 arch/arm/include/asm/vdso/processor.h
>  create mode 100644 arch/arm64/include/asm/vdso/arch_timer.h
>  create mode 100644 arch/arm64/include/asm/vdso/clocksource.h
>  create mode 100644 arch/arm64/include/asm/vdso/processor.h
>  create mode 100644 arch/mips/include/asm/vdso/clocksource.h
>  create mode 100644 arch/mips/include/asm/vdso/processor.h
>  create mode 100644 arch/x86/include/asm/vdso/clocksource.h
>  create mode 100644 arch/x86/include/asm/vdso/processor.h
>  create mode 100644 include/vdso/bits.h
>  create mode 100644 include/vdso/clocksource.h
>  create mode 100644 include/vdso/const.h
>  create mode 100644 include/vdso/jiffies.h
>  create mode 100644 include/vdso/ktime.h
>  create mode 100644 include/vdso/limits.h
>  create mode 100644 include/vdso/math64.h
>  create mode 100644 include/vdso/processor.h
>  create mode 100644 include/vdso/time.h
>  create mode 100644 include/vdso/time32.h
>  create mode 100644 include/vdso/time64.h

Maybe we could made them less-grained?

I.e, time32 + time64 + time.h => time.h?

Thanks for Cc,
          Dmitry
