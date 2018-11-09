Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46631 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeKJG42 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Nov 2018 01:56:28 -0500
Received: by mail-qk1-f193.google.com with SMTP id q1so4136806qkf.13
        for <linux-arch@vger.kernel.org>; Fri, 09 Nov 2018 13:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-8-vincenzo.frascino@arm.com> <CAK8P3a1w=GBcYk2OaVNzfagMMeD_zdBK3G16BSYjFANKdSAezQ@mail.gmail.com>
 <ef94c2cb-4573-211d-f69e-57bf90a80e6a@android.com>
In-Reply-To: <ef94c2cb-4573-211d-f69e-57bf90a80e6a@android.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 9 Nov 2018 22:13:50 +0100
Message-ID: <CAK8P3a0aPkbTUusK7=1Y49dSiM+X9hUkdbWZCTm3pmRx6N4rag@mail.gmail.com>
Subject: Re: [PATCH 07/27] arm64: Substitute gettimeofday with C implementation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: salyzyn@android.com
Cc: vincenzo.frascino@arm.com, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181109211350.mPo_aiHTv_LNbrM-HRUI6dwP-rYXcqV0aTutF-l48vo@z>

On Fri, Nov 9, 2018 at 6:23 PM Mark Salyzyn <salyzyn@android.com> wrote:
> On 11/09/2018 08:13 AM, Arnd Bergmann wrote:
> >> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> >> index beca249bc2f3..9de0ffc369c5 100644
> >> --- a/arch/arm64/kernel/vdso/vdso.lds.S
> >> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> >> @@ -88,6 +88,7 @@ VERSION
> >>                  __kernel_gettimeofday;
> >>                  __kernel_clock_gettime;
> >>                  __kernel_clock_getres;
> >> +               __kernel_time;
> >>          local: *;
> >>          };
> >>   }
> > I would  prefer to not add any deprecated interfaces in the VDSO. If we
> > have the 64-bit version of clock_gettime, we don't need the 32-bit version
> > of it, and we don't need gettimeofday() or time() either. The C library
> > can easily implement those by calling into clock_gettime.
>
> Alas time() calls are simple and in the order of get_res, the cost of
> which is a five fold improvement over the alternate higher resolution calls
> (clock_gettime or up to 100 fold on some architectures over gettimeofday).
>
> We could measure a small improvement in cpu utilization (and thus
>  battery life by extension) attributed to arm64 Android by calling
> __kernel_time over __kernel_clock_gettime with coarse resolution.
>
> A game of inches admittedly, but super KISS to add, and it is not as-if
> __kernel_time existence will cause an issue with deprecation of a system
> call entry point.

But wouldn't it be much better to fix the application in that case?
I can't see any reason why a user would call time() so often that
it shows up in CPU profiles, when the result only changes every
few billion CPU cycles.

Moreover, most architectures cannot return a time64_t from a
system call today, so we'd have to change the system call
entry points on all of those first to implement the slowpath
for a new time64() system call.

      Arnd
