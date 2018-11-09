Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38914 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbeKJCFS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Nov 2018 21:05:18 -0500
Received: by mail-qk1-f196.google.com with SMTP id e4so2493969qkh.6
        for <linux-arch@vger.kernel.org>; Fri, 09 Nov 2018 08:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20181109123730.8743-1-vincenzo.frascino@arm.com> <20181109123730.8743-17-vincenzo.frascino@arm.com>
In-Reply-To: <20181109123730.8743-17-vincenzo.frascino@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 9 Nov 2018 17:23:45 +0100
Message-ID: <CAK8P3a3SHU7S0Ro-N2c-boOF=6W6WZLS7kBS2UXAUyV0VtaTOg@mail.gmail.com>
Subject: Re: [PATCH 16/27] arm64: compat: Add vDSO
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vincenzo.frascino@arm.com
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, salyzyn@android.com, pcc@google.com
Message-ID: <20181109162345.eSg3BQDT3xGuCabItthyEcFY48gjwiKMrbd1jFLw69Q@z>

On Fri, Nov 9, 2018 at 1:38 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> +
> +static __always_inline notrace int gettimeofday_fallback(struct timeval *_tv,
> +                                                        struct timezone *_tz)

Corresponding to what I said about the native syscalls, this should
eventually use 'old_timeval32' here.

> +static __always_inline notrace long clock_gettime_fallback(clockid_t _clkid,
> +                                                          struct timespec *_ts)

and 'old_timespec32' here.

We could do those changes as a follow-up, but since you change that code
already, we could just as well do it now.

Then there is the question about the replacement. I don't see a need for
64-bit versions of time, gettimeofday or clock_getres, but we definitely want
a new clock_gettime. This probably has to wait until we have assigned a
syscall number (for the fallback implementation), just mentioning it now
so we keep it in mind.

      Arnd
