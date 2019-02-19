Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39622 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBSJEQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2019 04:04:16 -0500
MIME-Version: 1.0
References: <20190218210712.3503891-1-arnd@arndb.de> <20190218210712.3503891-8-arnd@arndb.de>
 <20190219021834.GA4495@guoren-Inspiron-7460>
In-Reply-To: <20190219021834.GA4495@guoren-Inspiron-7460>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 Feb 2019 10:03:57 +0100
Message-ID: <CAK8P3a0c6sNAPb_t2H9DbOi_antu4p5ncY76Vc6cFRZc=ZtiBg@mail.gmail.com>
Subject: Re: [PATCH 7/8] csky: Use latest system call ABI
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Mao Han <han_mao@c-sky.com>, y2038 Mailman List <y2038@lists.linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yury Norov <yury.norov@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, Stafford Horne <shorne@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Palmer Dabbelt <palmer@sifive.com>, Greentime Hu <green.hu@gmail.com>, linux-riscv@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>, Joseph Myers <joseph@codesourcery.com>
Message-ID: <20190219090357.6RdpTz94i56T6ddUhcCzPrYvTU42dTqgAh9JUCIrpu8@z>

On Mon, Feb 18, 2019 at 11:40 PM Joseph Myers <joseph@codesourcery.com> wrote:
>
> On Mon, 18 Feb 2019, Arnd Bergmann wrote:
>
> > We don't yet have an upstream glibc port for csky, so there is no user
>
> We do.  It's in 2.29.
...
On Tue, Feb 19, 2019 at 3:18 AM Guo Ren <guoren@kernel.org> wrote:
>
> Mao Han has merged csky port into glibc 2.29, so we should keep the
> __ARCH_WANT_TIME32_SYSCALLS.

My mistake. I've dropped patch 7/8 from this series now.

> > diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> > index 6959e0b1e956..398113c845f5 100644
> > --- a/arch/csky/Kconfig
> > +++ b/arch/csky/Kconfig
> > @@ -1,6 +1,5 @@
> >  config CSKY
> >       def_bool y
> > -     select ARCH_32BIT_OFF_T
> >       select ARCH_HAS_SYNC_DMA_FOR_CPU
> >       select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> >       select ARCH_USE_BUILTIN_BSWAP
> > diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
> > index ec60e49cea66..224c9a9ab45b 100644
> > --- a/arch/csky/include/uapi/asm/unistd.h
> > +++ b/arch/csky/include/uapi/asm/unistd.h
> > @@ -2,8 +2,6 @@
> >  // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> >
> >  #define __ARCH_WANT_SYS_CLONE
> > -#define __ARCH_WANT_SET_GET_RLIMIT
> Seems it's not related to y2038 issue. Is __ARCH_WANT_SET_GET_RLIMIT no
> use ?

In new architectures, we do not need to set CONFIG_ARCH_32BIT_OFF_T
or __ARCH_WANT_SET_GET_RLIMIT, since we can assume that user
space always uses a 64-bit off_t and a 'struct rlimit' matching the
kernel's rlimit64, with the prlimit64() system call replacing both getrlimit
and setrlimit on the kernel/user ABI side.

I don't know if glibc still uses the 32-bit off_t behavior or the old
getrlimit/setrlimit, but if we're not also changing the time32 interfaces,
the safest option seems to be to leave all three in place.

     Arnd
