Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40675 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaIQt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 04:16:49 -0400
MIME-Version: 1.0
References: <20190530141531.43462-1-vincenzo.frascino@arm.com> <20190530141531.43462-2-vincenzo.frascino@arm.com>
In-Reply-To: <20190530141531.43462-2-vincenzo.frascino@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 31 May 2019 10:16:32 +0200
Message-ID: <CAK8P3a3EnvkLND2RJdZtEY64PhK5g0sbbuytQro=f0cPur2g9g@mail.gmail.com>
Subject: Re: [PATCH v6 01/19] kernel: Standardize vdso_datapage
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>
Message-ID: <20190531081632.dmzUZWr3OxYBK05N6P3T7bZ-Dcv7_lECVUL-1eXKHcI@z>

On Thu, May 30, 2019 at 4:15 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> + * vdso_data will be accessed by 64 bit and compat code at the same time
> + * so we should be careful before modifying this structure.
> + */
> +struct vdso_data {
> +       u32                     seq;
> +
> +       s32                     clock_mode;
> +       u64                     cycle_last;
> +       u64                     mask;
> +       u32                     mult;
> +       u32                     shift;
> +
> +       struct vdso_timestamp   basetime[VDSO_BASES];
> +
> +       s32                     tz_minuteswest;
> +       s32                     tz_dsttime;
> +       u32                     hrtimer_res;
> +};

The structure contains four padding bytes at the end, which is
something we try to avoid, at least if this ends up being used as
an ABI. Maybe add "u32 __unused" at the end?

     Arnd
