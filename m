Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:35147 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfFXHm1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 03:42:27 -0400
Date: Mon, 24 Jun 2019 09:42:19 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
In-Reply-To: <CALCETrV-suRS5=JqDjbouXciN_OPsguERjux7fQVFOKGmdrspA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1906240935430.32342@nanos.tec.linutronix.de>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com> <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de> <CALCETrV-suRS5=JqDjbouXciN_OPsguERjux7fQVFOKGmdrspA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch <linux-arch@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, Shijith Thotton <sthotton@marvell.com>, Andre Przywara <andre.przywara@arm.com>, Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@openvz.org>, Linus Torvalds <torvalds@linux-foundation.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <sashal@kernel.org>
Message-ID: <20190624074219.LNQfMmM98Uo7UdvoJ0CvBshcKRDMAzGKGkdz_hA0qAU@z>

On Sun, 23 Jun 2019, Andy Lutomirski wrote:

> On Sun, Jun 23, 2019 at 5:34 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > +GENERIC VDSO LIBRARY:
> > +M:     Andy Lutomirksy <luto@kernel.org>
> 
> Lutomirski, perhaps?

Ooops. Where did I copy that from?

> Although I do appreciate the opportunity to say "not me!" :)

You just gave me the perfect exit plan. I'll change my surname to Gleyxner
and head off to the goat farm :)

Thanks,

	tglx
