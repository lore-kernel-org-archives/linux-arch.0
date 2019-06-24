Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:38153 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfFXOSg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 10:18:36 -0400
Date: Mon, 24 Jun 2019 16:18:28 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
In-Reply-To: <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1906241613280.32342@nanos.tec.linutronix.de>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com> <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, LAK <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, Shijith Thotton <sthotton@marvell.com>, Andre Przywara <andre.przywara@arm.com>, Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@openvz.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <sashal@kernel.org>
Message-ID: <20190624141828.ujG9lA75ewQjDGEoL3bLBJULL7qaH7VPA5TnpqGI848@z>

Vincenzo,

On Mon, 24 Jun 2019, Thomas Gleixner wrote:

> I did not merge the ARM and MIPS parts as they lack any form of
> acknowlegment from their maintainers. Please talk to those folks. If they
> ack/review the changes then I can pick them up and they go into 5.3 or they
> have to go in a later cycle. Nevertheless it was well worth the trouble to
> have those conversions done to confirm that the new common library fits a
> bunch of different architectures.

I talked to Russell King and he suggested to file the ARM parts into his
patch system and he'll pick them up after 5.3-rc1.

   https://www.arm.linux.org.uk/developer/patches/

I paged out how to deal with it, but you'll surely manage :)

Thanks,

	tglx
