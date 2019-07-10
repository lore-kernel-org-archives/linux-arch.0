Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:47130 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfGJI6d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jul 2019 04:58:33 -0400
Date: Wed, 10 Jul 2019 10:58:25 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 10/25] arm64: compat: Add vDSO
In-Reply-To: <20190710082750.mvm3e6myzpqsurga@willie-the-truck>
Message-ID: <alpine.DEB.2.21.1907101057190.1758@nanos.tec.linutronix.de>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com> <20190621095252.32307-11-vincenzo.frascino@arm.com> <CALAqxLXxE5B+vVLj7NcW8S05nhDQ+XSKVn=_MNDci667JDFEhA@mail.gmail.com> <20190710082750.mvm3e6myzpqsurga@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Andre Przywara <andre.przywara@arm.com>, Arnd Bergmann <arnd@arndb.de>, Huw Davies <huw@codeweavers.com>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shijith Thotton <sthotton@marvell.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20190710085825.9gNOPC6TyKOw43_BJnUJTNnhvbZc9SNGKI8UgbBuxp4@z>

On Wed, 10 Jul 2019, Will Deacon wrote:
> On Tue, Jul 09, 2019 at 09:02:54PM -0700, John Stultz wrote:
> > I tried to bisect things down a bit, but as some later fixes are
> > required (at one point, date was returning the start epoch and never
> > increasing), this hasn't worked too well. But I'm guessing since I
> > see: "CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will
> > not be built", and the system is half working, I'm guessing this is an
> > issue with just the 32bit code failing.  While I can try to sort out
> > the proper CROSS_COMPILE_COMPAT in my build environment, I assume
> > userland shouldn't be crashing if that value isn't set.
> > 
> > Any chance this issue has already been raised?
> 
> First I've seen of it, although Vincenzo is likely to know better than me.
> In the meantime, please can you share your .config?

I think the key is: CROSS_COMPILE_COMPAT not defined or empty. And then run
32bit userspace.

Thanks,

	tglx
