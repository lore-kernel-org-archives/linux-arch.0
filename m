Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:33100 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNFvK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Dec 2018 00:51:10 -0500
Received: by mail-it1-f196.google.com with SMTP id m8so18146195itk.0
        for <linux-arch@vger.kernel.org>; Thu, 13 Dec 2018 21:51:10 -0800 (PST)
MIME-Version: 1.0
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org> <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
 <CALxhOng7EzAd2zHKAOj3ipEd6y=DpS2JGo34s4V_cWVgmLjPwg@mail.gmail.com>
 <20181211185947.gnaachztyh3ils7o@pburton-laptop> <CALxhOngErLD7+CEhgSPwQUnGg7YEFTcH-v6dhR0j55SvEg1FoA@mail.gmail.com>
 <20181212222834.2zf3rb67fxfcmwuw@pburton-laptop> <CALxhOnht8H6r38bwm7xqbHuJs6dvLB03GCKyws2cif1mEE+sKA@mail.gmail.com>
 <20181213201540.ae6pxtm2xmrxnaaa@pburton-laptop>
In-Reply-To: <20181213201540.ae6pxtm2xmrxnaaa@pburton-laptop>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Fri, 14 Dec 2018 11:20:58 +0530
Message-ID: <CALxhOnhAP0TRSH=otZNHdLJgy7=Q=hWOXZSNYBvWAuAzEeBzhw@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181214055058.Wvp_oh_HHivAVgUouYE0V4KsOEjvdX5Jh0C_maK3QDw@z>

Hi Paul,

On Fri, 14 Dec 2018 at 01:45, Paul Burton <paul.burton@mips.com> wrote:
> I've applied v5 but undone the change from __NR_64_* to __NR_N64_*
> because it's part of the UAPI & a github code search showed that it's
> actually used.
>
> Could you take a look at this branch & check that you're OK with it
> before I push it to mips-next?
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git test-syscalls
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/?h=test-syscalls

This looks good to me. Please push to mips-next.

Thanks
Firoz
