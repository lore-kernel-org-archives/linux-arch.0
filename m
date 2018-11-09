Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45187 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbeKJCIu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Nov 2018 21:08:50 -0500
Received: by mail-qk1-f194.google.com with SMTP id d135so2515318qkc.12
        for <linux-arch@vger.kernel.org>; Fri, 09 Nov 2018 08:27:33 -0800 (PST)
MIME-Version: 1.0
References: <20181109123730.8743-1-vincenzo.frascino@arm.com> <20181109123730.8743-24-vincenzo.frascino@arm.com>
In-Reply-To: <20181109123730.8743-24-vincenzo.frascino@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 9 Nov 2018 17:27:16 +0100
Message-ID: <CAK8P3a2B4g64XM5O6mEKA=pr73SzJGxk0VKCs8Hifn-aj6Uv9Q@mail.gmail.com>
Subject: Re: [PATCH 23/27] arm: Add support for generic vDSO
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vincenzo.frascino@arm.com
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, salyzyn@android.com, pcc@google.com
Message-ID: <20181109162716.UlNCPfU2eZZWsBnBWLN0wOZqw7vc8M1b5MxaBcrc_Z0@z>

On Fri, Nov 9, 2018 at 1:38 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> +
> +static __always_inline notrace int gettimeofday_fallback(struct timeval *_tv,
> +                                                        struct timezone *_tz)
> +{
>
> +
> +static __always_inline notrace long clock_gettime_fallback(clockid_t _clkid,
> +                                                          struct timespec *_ts)

Same as for the arm64 compat version, these could use old_timeval32
and old_timespec32 right away.

       Arnd
