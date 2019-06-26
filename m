From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] lib/vdso: Delay mask application in do_hres()
Date: Wed, 26 Jun 2019 08:38:48 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1906260832470.32342@nanos.tec.linutronix.de>
References: <20190624133607.GI29497@fuggles.cambridge.arm.com> <20190625161804.38713-1-vincenzo.frascino@arm.com> <alpine.DEB.2.21.1906251851350.32342@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1906251851350.32342@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, LAK <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux@armlinux.org.uk, Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com, Daniel Lezcano <daniel.lezcano@linaro.org>, salyzyn@android.com, pcc@google.com, shuah@kernel.org, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk, huw@codeweavers.com, sthotton@marvell.com, andre.przywara@arm.com, Andy Lutomirski <luto@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, 25 Jun 2019, Thomas Gleixner wrote:
> On Tue, 25 Jun 2019, Vincenzo Frascino wrote:
> > do_hres() in the vDSO generic library masks the hw counter value
> > immediately after reading it.
> > 
> > Postpone the mask application after checking if the syscall fallback is
> > enabled, in order to be able to detect a possible fallback for the
> > architectures that have masks smaller than ULLONG_MAX.
> 
> Right. This only worked on x86 because the mask is there ULLONG_MAX for all
> VDSO capable clocksources, i.e. that ever worked just by chance.

But it's actually worse than that:

> > +		cycles &= vd->mask;
> >  		if (cycles > last)
> >  			ns += (cycles - last) * vd->mult;
> >  		ns >>= vd->shift;

This is broken for any clocksource which can legitimately wrap around. The
core timekeeping does the right thing:

     		 (cycles - last) & mask

That makes sure that a wraparound is correctly handled. With the above the
wrap around would be ignored due to

     	    if (cycles > last)

Stupid me. I should have added big fat comments to the x86 vdso why this
all works correctly and only correctly for the x86 crud. That was part of
squeezing the last cycles out of the vdso.

Sorry for not noticing earlier. Working on a fix.

Thanks,

	tglx
