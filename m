Return-Path: <SRS0=ubji=BP=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45523 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgHES7p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Aug 2020 14:59:45 -0400
MIME-Version: 1.0
References: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
 <20200805172629.GA1040@bug>
In-Reply-To: <20200805172629.GA1040@bug>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 5 Aug 2020 20:50:43 +0200
Message-ID: <CAMuHMdV20tZSu5gGsjf8h334+0xr1f=N9NvOoxHQGq42GYsj4g@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [TECH TOPIC] Planning code obsolescence
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ksummit <ksummit-discuss@lists.linuxfoundation.org>
Message-ID: <20200805185043.05isZKfimh7oDrj4pnkCTODv6nPK1OaXfb9OgS4bSlc@z>

Hi Pavel,

On Wed, Aug 5, 2020 at 7:26 PM Pavel Machek <pavel@ucw.cz> wrote:
> > I have submitted the below as a topic for the linux/arch/* MC that Mike
> > and I run, but I suppose it also makes sense to discuss it on the
> > ksummit-discuss mailing list (cross-posted to linux-arch and lkml) as well
> > even if we don't discuss it at the main ksummit track.
>
> > * Latest kernel in which it was known to have worked
>
> For some old hardware, I started collecting kernel version, .config and dmesg from
> successful boots. github.com/pavelmachek, click on "missy".

You mean your complete hardware collection doesn't boot v5.8? ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
