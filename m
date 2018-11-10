Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45129 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeKKCTL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Nov 2018 21:19:11 -0500
Received: by mail-qk1-f193.google.com with SMTP id d135so6904161qkc.12
        for <linux-arch@vger.kernel.org>; Sat, 10 Nov 2018 08:33:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181109123730.8743-1-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 10 Nov 2018 17:33:34 +0100
Message-ID: <CAK8P3a1obPxkJROk5rN7OpL3AE-3Yifu-vUqepUUz+yO_HNd7g@mail.gmail.com>
Subject: Re: [PATCH 00/27] Unify vDSOs across more architectures
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181110163334.k9iyZ88DYajWMp9cbCURWYgjrVEZDczWnryKpxGX9uM@z>

On 11/9/18, Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
> vDSO (virtual dynamic shared object) is a mechanism that the Linux
> kernel provides as an alternative to system calls to reduce where
> possible the costs in terms of cycles.
> This is possible because certain syscalls like gettimeofday() do
> not write any data and return one or more values that are stored
> in the kernel, which makes relatively safe calling them directly
> as a library function.
>
> Even if the mechanism is pretty much standard, every architecture
> in the last few years ended up implementing their own vDSO library
> in the architectural code.
>
> The purpose of this patch-set is to identify the commonalities in
> between the architectures and try to consolidate the common code
> paths, starting with gettimeofday().

I'm very happy to see the generalization overall, as this is going
to make it much easier to add the 64-bit time_t on the 32-bit
vdso implementations, as well as other extensions we may want
in the future.

> This implementation contains the following design choices:
>  * Every architecture defines the arch specific code in an header in
>    "asm/vdso/".
>  * The generic implementation includes the arch specific one and lives
>    in "lib/vdso".

Makes sense.

>  * The arch specific code for gettimeofday lives in
>    "<arch path>/vdso/gettimeofday.c" and includes the generic code only.
>  * This approach allows to consolidate the common code in a single place
>    with the benefit of avoiding code duplication.

I would prefer to have that named clock_gettime.c and only implement
that one system call there. We can easily have the gettimeofday(),
time() and clock_getres() in the common code where that is needed
for backwards compatibility. As I already mentioned in my comment
for one of the patches, we won't have time() or gettimeofday() system
calls on new architectures, and 32-bit architectures won't have them
with 64-bit time_t.

I suppose we can have the time() and gettimeofday() calls
implemented in the generic vdso for everyone, but then
only hook those up on architectures that already had
them. The implementation of course is trivial based on
clock_gettime() with CLOCK_REALTIME or CLOCK_REALTIME_COARSE
respectively.

> This implementation contains the portings to the common library for: arm64,
> compat mode for arm64, arm and mips.
>
> The mips porting has been tested on qemu for mips32el. A configuration to
> repeat the tests can be found at [4].

Ah, I missed the fact that you didn't do this for x86, so I assumed that
this work was triggered by Thomas' recent cleanup of the x86 clock_gettime
vdso code. I think it would be best to get x86 to use the same code and
get the recent improvements ported to the others as well that way.

      Arnd
