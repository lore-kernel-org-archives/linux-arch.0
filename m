Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f194.google.com ([209.85.166.194]:50266 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeK3PyB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Nov 2018 10:54:01 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so7415128iti.0
        for <linux-arch@vger.kernel.org>; Thu, 29 Nov 2018 20:46:00 -0800 (PST)
MIME-Version: 1.0
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
 <1543481016-18500-2-git-send-email-firoz.khan@linaro.org> <CAK8P3a1Pq=Y83p-cN9bf+m-2ZAmJdEYRaAY9FfEkVHvfSwNWNg@mail.gmail.com>
In-Reply-To: <CAK8P3a1Pq=Y83p-cN9bf+m-2ZAmJdEYRaAY9FfEkVHvfSwNWNg@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Fri, 30 Nov 2018 10:15:48 +0530
Message-ID: <CALxhOniC95bKe5vLvNFdjwrzLa+mWw6hMvzESXG3MkUfVsrOzA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mips: add __NR_syscalls along with __NR_Linux_syscalls
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181130044548.m8rIVipmhZPqmYoeSM876rqpEiIBzSHXkLzvK-DpX4g@z>

Hi Arnd,

Thanks for your email.

On Thu, 29 Nov 2018 at 19:41, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Nov 29, 2018 at 9:44 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> >  arch/mips/include/uapi/asm/unistd.h | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
> > index f25dd1d..6914be5 100644
> > --- a/arch/mips/include/uapi/asm/unistd.h
> > +++ b/arch/mips/include/uapi/asm/unistd.h
> > @@ -391,11 +391,14 @@
> >  #define __NR_rseq                      (__NR_Linux + 367)
> >  #define __NR_io_pgetevents             (__NR_Linux + 368)
> >
> > +#ifdef __KERNEL__
> > +#define __NR_syscalls                  368
> > +#endif
> >
> >  /*
> >   * Offset of the last Linux o32 flavoured syscall
> >   */
> > -#define __NR_Linux_syscalls            368
> > +#define __NR_Linux_syscalls            __NR_syscalls
>
> This seems odd: you define __NR_Linux_syscalls outside of
> #ifdef __KERNEL__, but the definition only works
> with __NR_syscalls being defined first, which it isn't in
> user space.
>
> Since the macros are completely unused as well as unusable
> now, how about removing them together with the other
> ones removed in patch 2?

Yes, good point, will update asap.

Firoz

>
>       Arnd
