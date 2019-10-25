Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35962 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730125AbfJYLm1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Oct 2019 07:42:27 -0400
MIME-Version: 1.0
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906241613280.32342@nanos.tec.linutronix.de>
 <20190624142346.pxljv3m4npatdiyk@shell.armlinux.org.uk> <20190624144924.GE29120@arrakis.emea.arm.com>
In-Reply-To: <20190624144924.GE29120@arrakis.emea.arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 25 Oct 2019 13:42:14 +0200
Message-ID: <CAMuHMdX_KzP9n=H4vL4J9ijT=2GYy9X1BBpAdomkchoxnCcjfA@mail.gmail.com>
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andy Lutomirski <luto@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Will Deacon <will.deacon@arm.com>, linux-mips@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Dmitry Safonov <dima@arista.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andre Przywara <andre.przywara@arm.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Michael Kelley <mikelley@microsoft.com>, Peter Collingbourne <pcc@google.com>, LAK <linux-arm-kernel@lists.infradead.org>, Andrei Vagin <avagin@openvz.org>, Huw Davies <huw@codeweavers.com>, LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Shijith Thotton <sthotton@marvell.com>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20191025114214.UTmFwuxSDVu7NrXnPRDiKgljSpXzKFxPF7Yxyqtjkc4@z>

Hi Catalin,

On Mon, Jun 24, 2019 at 4:51 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Jun 24, 2019 at 03:23:46PM +0100, Russell King wrote:
> > On Mon, Jun 24, 2019 at 04:18:28PM +0200, Thomas Gleixner wrote:
> > > I talked to Russell King and he suggested to file the ARM parts into his
> > > patch system and he'll pick them up after 5.3-rc1.
> > >
> > >    https://www.arm.linux.org.uk/developer/patches/
> > >
> > > I paged out how to deal with it, but you'll surely manage :)
> >
> > Easy way: ask git to add the "KernelVersion" tag as a header to the
> > email using --add-header to e.g. git format-patch, and just mail them
> > to patches@armlinux.org.uk
>
> Although I haven't send patches to Russell in a while, I still have a
> git alias in my .gitconfig (only works with one patch at a time IIRC,
> sending multiple patches may arrive in a different order):
>
> [alias]
>         send-rmk-email = !git send-email --add-header=\"KernelVersion: $(git describe --abbrev=0)\" --no-thread --suppress-cc=all --to="patches@arm.linux.org.uk"

Doesn't seem to work: no header was added, and my patch was rejected.
There does seem to be a "--add-header" option for git-format-patch, but
it adds the header at the top, just below the "Subject:"-header, instead
of below the "---", so that needs manual editing, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
