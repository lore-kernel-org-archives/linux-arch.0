Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38334 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503648AbeKWV6W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Nov 2018 16:58:22 -0500
Received: by mail-qt1-f196.google.com with SMTP id p17so10099798qtl.5
        for <linux-arch@vger.kernel.org>; Fri, 23 Nov 2018 03:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-8-vincenzo.frascino@arm.com> <CAK8P3a1w=GBcYk2OaVNzfagMMeD_zdBK3G16BSYjFANKdSAezQ@mail.gmail.com>
 <8e306faf-6261-8363-3f18-70e754fa3a9d@arm.com> <CAK8P3a0ht6TjXubYiWaLh96hOGy3FH_K=JJVhQrYV3D+z-JqBA@mail.gmail.com>
 <f283de36-b620-03f0-b97b-fd63900e33ce@arm.com>
In-Reply-To: <f283de36-b620-03f0-b97b-fd63900e33ce@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 23 Nov 2018 12:14:07 +0100
Message-ID: <CAK8P3a0niPB4pzBB9_+28LxZJw0jY_HLnzaE2jRy5COc7ZLK_w@mail.gmail.com>
Subject: Re: [PATCH 07/27] arm64: Substitute gettimeofday with C implementation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181123111407.uaet21cqsjV7dE3Xd5fN0eoZwWM46D-d2lQzmZI0Bnc@z>

On Fri, Nov 23, 2018 at 11:48 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> On 11/14/18 5:47 PM, Arnd Bergmann wrote:
> > On Tue, Nov 13, 2018 at 2:58 AM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >>
> >> On 09/11/2018 16:13, Arnd Bergmann wrote:
> >> I am not familiar with the development plans of the various C libraries, but looking at
> >> bionic libc currently seems using all the vdso exposed functions [1].
> >>
> >> [1] https://github.com/aosp-mirror/platform_bionic/blob/master/libc/bionic/vdso.cpp
> >
> > It looks like this implementation checks for each one of them to be present
> > first and then uses a fallback implementation if it does not exist. This would
> > clearly let us remove the handlers we don't want to support, but there
> > are two possible downsides:
> >> - some other libc might be lacking that fallback path
> > - the fallback might be much slower, e.g. time() should fallback to
> >   the vdso version of clock_gettime(CLOCK_REALTIME_COARSE) for
> >   best performance, rather than the time() syscall or CLOCK_REALTIME.
> >
> > So I'd argue that if an architecture already has a time() vdso implementation,
> > we probably want to keep that entry point but make it point to the best
> > generic implementation (i.e. clock_gettime CLOCK_REALTIME_COARSE).
>
> What I was trying to point out here is that if the symbol is present in the vdso
> library the C library implementation tends to prefer to use it.
>
> Said that, I agree with what you are saying and in this first iteration I will
> make sure that we do not add new symbols for the architectures that did not
> support them previously, but I will keep the library the most generic possible,
>
> I would prefer though to introduce the redirection for gettimeofday() and time()
> to the best performing clock_gettime() at a later stage (and with a separate
> patchset) because it would involve some cleanup in the vdso.c of the
> architectures that would use the library (i.e. update_vsyscall_tz() not required
> anymore) and because based on what I measured with a quick test the performance
> difference seems small with the current implementation of the library.

Ok, makes sense.

Thanks,

      Arnd
