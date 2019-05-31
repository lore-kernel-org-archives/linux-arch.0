Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35926 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaIrB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 04:47:01 -0400
MIME-Version: 1.0
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
In-Reply-To: <20190530141531.43462-1-vincenzo.frascino@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 31 May 2019 10:46:43 +0200
Message-ID: <CAK8P3a11DE0sXteZoaP_N=mDhx3tXitGKddn1ogtFqJBYO-SCA@mail.gmail.com>
Subject: Re: [PATCH v6 00/19] Unify vDSOs across more architectures
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>
Message-ID: <20190531084643.ggxs_I4QVPAJ1zaYO6z9n_SySx6-Nr_8W7dKv6IWDsk@z>

On Thu, May 30, 2019 at 4:15 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> vDSO (virtual dynamic shared object) is a mechanism that the Linux
> kernel provides as an alternative to system calls to reduce where
> possible the costs in terms of cycles.
> This is possible because certain syscalls like gettimeofday() do
> not write any data and return one or more values that are stored
> in the kernel, which makes relatively safe calling them directly
> as a library function.

Hi Vincento,

I've very happy with how this turned out overall, and as far as I can
tell you have addressed all my previous comments. I had another
look through the series and only noticed a few very minor issues.

I hope Thomas can have another look soon, he probably also finds
a few things, and then it should be ready for inclusion in linux-next
and the coming merge window.

One open question I touched in my review is whether we want to
have a vdso version of clock_getres() in all architectures or not.
I'd prefer to leave it out because there is very little advantage to
it over the system call (the results don't change at runtime and
can easily be cached by libc if performance ever matters), and
it takes up a small amount of memory for the implementation.

We shouldn't just need it for consistency because all callers
would require implementing a fallback to the system call
anyway, to deal with old kernels.

If anyone comes up with a good reason why it should be added
after all, let me know and I'll stop mentioning it.

      Arnd
