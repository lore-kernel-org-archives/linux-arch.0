Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:34593 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeLKIpb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Dec 2018 03:45:31 -0500
Received: by mail-it1-f195.google.com with SMTP id x124so10249265itd.1
        for <linux-arch@vger.kernel.org>; Tue, 11 Dec 2018 00:45:31 -0800 (PST)
MIME-Version: 1.0
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org> <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
In-Reply-To: <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Tue, 11 Dec 2018 14:15:19 +0530
Message-ID: <CALxhOng7EzAd2zHKAOj3ipEd6y=DpS2JGo34s4V_cWVgmLjPwg@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181211084519.gwmWCz2Ghc4qoP-V7RIPJybloVNdkjgyGqPHFkCsH80@z>

Hi Paul,

On Tue, 11 Dec 2018 at 01:21, Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Firoz,
>
> On Thu, Dec 06, 2018 at 10:48:24AM +0530, Firoz Khan wrote:
> > diff --git a/arch/mips/include/uapi/asm/sgidefs.h b/arch/mips/include/uapi/asm/sgidefs.h
> > index 26143e3..0364eec 100644
> > --- a/arch/mips/include/uapi/asm/sgidefs.h
> > +++ b/arch/mips/include/uapi/asm/sgidefs.h
> > @@ -40,6 +40,6 @@
> >   */
> >  #define _MIPS_SIM_ABI32              1
> >  #define _MIPS_SIM_NABI32     2
> > -#define _MIPS_SIM_ABI64              3
> > +#define _MIPS_SIM_ABIN64     3
>
> Whilst I agree with changing our own definitions & filenames to use n64,
> this macro actually reflects naming used by the toolchain. ie:
>
>     $ mips-linux-gcc -mips64 -mabi=64 -dM -E - </dev/null | grep ABI64
>     #define _ABI64 3
>     #define _MIPS_SIM _ABI64
>
> Our macro here is used to compare against _MIPS_SIM provided by the
> toolchain, so for consistency I think we should keep the same name for
> the macro that the toolchain uses.

Will this below change will help?

 #define _MIPS_SIM_ABI32              1
 #define _MIPS_SIM_NABI32            2
 #define _MIPS_SIM_ABI64              3
+#define _MIPS_SIM_ABIN64           _MIPS_SIM_ABI64

Thanks
Firoz

>
> And I realise that undoing that but keeping n64 in our own filenames &
> macros is another type of inconsistency, but something imperfect is
> unavoidable at this point given that the engineers way back when decided
> to use "ABI64" for n64.
>
> Thanks,
>     Paul
