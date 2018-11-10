Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44247 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeKKCDg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Nov 2018 21:03:36 -0500
Received: by mail-qk1-f194.google.com with SMTP id n12so6867098qkh.11
        for <linux-arch@vger.kernel.org>; Sat, 10 Nov 2018 08:18:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181109123730.8743-7-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com> <20181109123730.8743-7-vincenzo.frascino@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 10 Nov 2018 17:18:03 +0100
Message-ID: <CAK8P3a0QSfzsM-h9Kf36Pzr2WvXbyi0_RQG0+Nsp+1RoTRq7Ww@mail.gmail.com>
Subject: Re: [PATCH 06/27] kernel: Define gettimeofday vdso common code
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181110161803.-P_XEWoPYRQWU51_vdtqBMnEsbETbsuauxcny5Y5uwU@z>

On 11/9/18, Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
> In the last few years we assisted to an explosion of vdso
> implementations that mostly share similar code.
>
> This patch tries to unify the gettimeofday vdso implementation
> introducing lib/vdso. The code contained in this library can
> ideally be reused by all the architectures avoiding, where
> possible, code duplication.
>
> In doing so, tries to maintain the performances using inlining as much
> as possible and consequently reduces the surface for ROP type of attacks.
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

I just noticed that this new version misses some of the cleanups
that Thomas recently did in the x86 version, e.g. f3e839384164
("x86/vdso: Replace the clockid switch case").

I haven't looked at all the details, but I'd suggest using the latest
x86 code as a base.

        Arnd
