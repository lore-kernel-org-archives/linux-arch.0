Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbfGJJMx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jul 2019 05:12:53 -0400
Date: Wed, 10 Jul 2019 10:12:45 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v7 10/25] arm64: compat: Add vDSO
Message-ID: <20190710091245.zztm6cpbix4objlq@willie-the-truck>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-11-vincenzo.frascino@arm.com>
 <CALAqxLXxE5B+vVLj7NcW8S05nhDQ+XSKVn=_MNDci667JDFEhA@mail.gmail.com>
 <20190710082750.mvm3e6myzpqsurga@willie-the-truck>
 <alpine.DEB.2.21.1907101057190.1758@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907101057190.1758@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Andre Przywara <andre.przywara@arm.com>, Arnd Bergmann <arnd@arndb.de>, Huw Davies <huw@codeweavers.com>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shijith Thotton <sthotton@marvell.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20190710091245.IzHXKpA39fGCDDlECZi5R9BRXakR0-qRYWLOACSjQv0@z>

On Wed, Jul 10, 2019 at 10:58:25AM +0200, Thomas Gleixner wrote:
> On Wed, 10 Jul 2019, Will Deacon wrote:
> > On Tue, Jul 09, 2019 at 09:02:54PM -0700, John Stultz wrote:
> > > I tried to bisect things down a bit, but as some later fixes are
> > > required (at one point, date was returning the start epoch and never
> > > increasing), this hasn't worked too well. But I'm guessing since I
> > > see: "CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will
> > > not be built", and the system is half working, I'm guessing this is an
> > > issue with just the 32bit code failing.  While I can try to sort out
> > > the proper CROSS_COMPILE_COMPAT in my build environment, I assume
> > > userland shouldn't be crashing if that value isn't set.
> > > 
> > > Any chance this issue has already been raised?
> > 
> > First I've seen of it, although Vincenzo is likely to know better than me.
> > In the meantime, please can you share your .config?
> 
> I think the key is: CROSS_COMPILE_COMPAT not defined or empty. And then run
> 32bit userspace.

The part I was wondering about is whether the vectors page has been disabled
at the same time, since I'm fairly sure I've already been running with the
above (but I can easily double-check).

Will
