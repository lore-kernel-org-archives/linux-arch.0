Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35536 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfFXOYB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 10:24:01 -0400
Date: Mon, 24 Jun 2019 15:23:46 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
Message-ID: <20190624142346.pxljv3m4npatdiyk@shell.armlinux.org.uk>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906241613280.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906241613280.32342@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, Andy Lutomirski <luto@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, linux-arch@vger.kernel.org, Dmitry Safonov <dima@arista.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andre Przywara <andre.przywara@arm.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Michael Kelley <mikelley@microsoft.com>, Peter Collingbourne <pcc@google.com>, LAK <linux-arm-kernel@lists.infradead.org>, Andrei Vagin <avagin@openvz.org>, Huw Davies <huw@codeweavers.com>, LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Shijith Thotton <sthotton@marvell.com>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20190624142346.0XieCMeubNuz-iF3MmST509FtOFkz-gHfsPUpRqL7K8@z>

On Mon, Jun 24, 2019 at 04:18:28PM +0200, Thomas Gleixner wrote:
> Vincenzo,
> 
> On Mon, 24 Jun 2019, Thomas Gleixner wrote:
> 
> > I did not merge the ARM and MIPS parts as they lack any form of
> > acknowlegment from their maintainers. Please talk to those folks. If they
> > ack/review the changes then I can pick them up and they go into 5.3 or they
> > have to go in a later cycle. Nevertheless it was well worth the trouble to
> > have those conversions done to confirm that the new common library fits a
> > bunch of different architectures.
> 
> I talked to Russell King and he suggested to file the ARM parts into his
> patch system and he'll pick them up after 5.3-rc1.
> 
>    https://www.arm.linux.org.uk/developer/patches/
> 
> I paged out how to deal with it, but you'll surely manage :)

Easy way: ask git to add the "KernelVersion" tag as a header to the
email using --add-header to e.g. git format-patch, and just mail them
to patches@armlinux.org.uk

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
