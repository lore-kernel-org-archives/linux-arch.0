Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f66.google.com ([209.85.166.66]:37423 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeLMIxe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Dec 2018 03:53:34 -0500
Received: by mail-io1-f66.google.com with SMTP id f14so996341iol.4
        for <linux-arch@vger.kernel.org>; Thu, 13 Dec 2018 00:53:33 -0800 (PST)
MIME-Version: 1.0
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org> <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
 <CALxhOng7EzAd2zHKAOj3ipEd6y=DpS2JGo34s4V_cWVgmLjPwg@mail.gmail.com>
 <20181211185947.gnaachztyh3ils7o@pburton-laptop> <CALxhOngErLD7+CEhgSPwQUnGg7YEFTcH-v6dhR0j55SvEg1FoA@mail.gmail.com>
 <20181212222834.2zf3rb67fxfcmwuw@pburton-laptop>
In-Reply-To: <20181212222834.2zf3rb67fxfcmwuw@pburton-laptop>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Thu, 13 Dec 2018 14:23:21 +0530
Message-ID: <CALxhOnht8H6r38bwm7xqbHuJs6dvLB03GCKyws2cif1mEE+sKA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181213085321.3o3JWSOwStGmYoMRcCLpBwHZJ7ez9bnVaYh5SxSvTJM@z>

Hi Paul,

On Thu, 13 Dec 2018 at 03:58, Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Firoz,
>
> On Wed, Dec 12, 2018 at 10:04:47AM +0530, Firoz Khan wrote:
> >
> > Sure, I think '64' to 'n64' conversion must be remove it from this patch
> > series.I can send v5 without '64' to 'n64' conversion.
> >
> > If we rename '64' to 'n64' in half of the place and this _MIPS_SIM_ABI64
> > if we half to keep it in same looks not good (according to me).
> >
> > (FYI, This macro name - _MIPS_SIM_ABIN64 must be _MIPS_SIM_NABI64
> > and defintion will be:
> > +#define _MIPS_SIM_NABI64           _MIPS_SIM_ABI64)
> >
> > So If you confirm I can send v5 without '64' to 'n64' conversion (not just above
> > one, completely from this patch series). Or uou can take a call just
> > keep this macro -
> > _MIPS_SIM_ABI64 as it is and change it rest of the place.
>
> Let's just go ahead & leave everything as 64, and I'll do the 64 -> n64
> rename later. I hoped whilst you were adding n64-specific code this
> would be an easy change, but at this point let's just prioritize getting
> the series applied without the naming change so it can sit in -next for
> a while before the merge window.

I'll keep the macro - _MIPS_SIM_ABI64 same and will not change the rest
of the patch series. Unfortunately, reverting back to 64 from n64 has lots of
work.

Thanks
Firoz
