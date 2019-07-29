Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83]:46479 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfG2C2K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Jul 2019 22:28:10 -0400
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de>
 <20190716170606.GA38406@archlinux-threadripper> <alpine.DEB.2.21.1907162059200.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907162135590.1767@nanos.tec.linutronix.de>
 <CAK7LNASBiaMX8ihnmhLGmYfHX=ZHZmVN91nxmFZe-OCaw6Px2w@mail.gmail.com>
 <alpine.DEB.2.21.1907170955250.1767@nanos.tec.linutronix.de>
 <CAHbf0-GyQzWcRg_BP2B5pVzEJoxSE_hX5xFypS--7Q5LSHxzWw@mail.gmail.com>
 <CAK7LNATJGbSYyuxV7npC_bQiXQShb=7J7dcQcOaupnL5-GhADg@mail.gmail.com>
 <alpine.DEB.2.21.1907230837400.1659@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907231013340.1659@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907231013340.1659@nanos.tec.linutronix.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 29 Jul 2019 11:27:20 +0900
Message-ID: <CAK7LNATg38uFeY8JKnNPXudv8y4O1g=TPtvEbcBjrqFXSaKgdQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Fail if gold linker is detected
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mike Lothian <mike@fireburn.co.uk>, Nathan Chancellor <natechancellor@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190729022720.eTN8l8OfappQjAwT0qsNQgtLtfpke1KgzMan1QK-3GY@z>

On Tue, Jul 23, 2019 at 5:17 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 23 Jul 2019, Thomas Gleixner wrote:
> > On Tue, 23 Jul 2019, Masahiro Yamada wrote:
> > > Right.
> > > I was able to build with ld.gold
> > >
> > > So, we can use gold, depending on the kernel configuration.
> >
> > That's exactly the problem. It breaks with random kernel configurations
> > which is not acceptable except for people who know what they are doing.
> >
> > I'm tired of dealing with half baken fixes and 'regression' reports. Either
> > there is an effort to fix the issues with gold like the clang people fix
> > their issues or it needs to be disabled. We have a clear statement that
> > gold developers have other priorities.
>
> That said, I'm perfectly happy to move this to x86 and leave it alone for
> other architectures, but it does not make sense to me.


I did not see opposition from other arch maintainers.


> If the gold fans care enough, then we can add something like
> CONFIG_I_WANT_TO_USE_GOLD_AND_DEAL_WITH_THE_FALLOUT_MYSELF.

Let's apply this and see.

If somebody really wants to use gold by his risk,
I will consider such a config option.


Applied to linux-kbuild.
Thanks.


-- 
Best Regards
Masahiro Yamada
