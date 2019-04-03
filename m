Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:39245 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDCKG0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Apr 2019 06:06:26 -0400
Date: Wed, 3 Apr 2019 12:06:15 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/5] s390: Fix vDSO clock_getres()
In-Reply-To: <20190403113844.334a32d9@mschwideX1>
Message-ID: <alpine.DEB.2.21.1904031205460.1967@nanos.tec.linutronix.de>
References: <20190401115152.32751-1-vincenzo.frascino@arm.com>        <20190401115152.32751-4-vincenzo.frascino@arm.com> <20190403113844.334a32d9@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190403100615.zFeUDen3SB7NaMRCm8L301vzmTybDBFn2T1nVx5XEQY@z>

On Wed, 3 Apr 2019, Martin Schwidefsky wrote:

> On Mon,  1 Apr 2019 12:51:50 +0100
> Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
> 
> > clock_getres in the vDSO library has to preserve the same behaviour
> > of posix_get_hrtimer_res().
> > 
> > In particular, posix_get_hrtimer_res() does:
> >     sec = 0;
> >     ns = hrtimer_resolution;
> > and hrtimer_resolution depends on the enablement of the high
> > resolution timers that can happen either at compile or at run time.
> > 
> > Fix the s390 vdso implementation of clock_getres keeping a copy of
> > hrtimer_resolution in vdso data and using that directly.
> > 
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > ---
> >  arch/s390/include/asm/vdso.h           |  1 +
> >  arch/s390/kernel/asm-offsets.c         |  2 +-
> >  arch/s390/kernel/time.c                |  1 +
> >  arch/s390/kernel/vdso32/clock_getres.S | 17 ++++++++++++-----
> >  arch/s390/kernel/vdso64/clock_getres.S | 15 ++++++++++-----
> >  5 files changed, 25 insertions(+), 11 deletions(-)
> 
> I tried this patch and in principle this works. In that regard
> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> But I wonder if the loop to check the update counter is really
> necessary. The hrtimer_resolution value can only changes once with
> the first call to hrtimer_switch_to_hres(). With the TOD clock
> as the only clock available on s390 we always have the ability
> to do hrtimer. It then all depends on the highres=[on|off] kernel
> parameter what value we get with clock_getres().

Yes, it's not changing after boot anymore.

Thanks,

	tglx
