Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:37706 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfFNMQF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jun 2019 08:16:05 -0400
Date: Fri, 14 Jun 2019 14:16:00 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 00/19] Unify vDSOs across more architectures
In-Reply-To: <d96667d5-e43b-d33a-fbd0-5acfb4904316@arm.com>
Message-ID: <alpine.DEB.2.21.1906141413070.1722@nanos.tec.linutronix.de>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com> <CAK8P3a11DE0sXteZoaP_N=mDhx3tXitGKddn1ogtFqJBYO-SCA@mail.gmail.com> <d96667d5-e43b-d33a-fbd0-5acfb4904316@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>
Message-ID: <20190614121600.A-jpTQ2V2wuauLEUt4tp6Qr-pYWJ_KG51CNLEBlHzkc@z>

On Tue, 4 Jun 2019, Vincenzo Frascino wrote:
> On 31/05/2019 09:46, Arnd Bergmann wrote:
> > One open question I touched in my review is whether we want to
> > have a vdso version of clock_getres() in all architectures or not.
> > I'd prefer to leave it out because there is very little advantage to
> > it over the system call (the results don't change at runtime and
> > can easily be cached by libc if performance ever matters), and
> > it takes up a small amount of memory for the implementation.
> > 
> 
> I thought about it and I ended up with what proposed in this patchset mainly for
> symmetry across all the architectures since in the end they use the same common
> code.
> 
> It seems also that there is some performance impact (i.e.):
> 
> clock-getres-monotonic:    libc(system call): 296 nsec/call
> clock-getres-monotonic:    libc(vdso): 5 nsec/call

clock_getres() is usually not a hot path operation.

> I agree with you though when you say that caching it in the libc is a
> possibility to overcome the performance impact.
> 
> > We shouldn't just need it for consistency because all callers
> > would require implementing a fallback to the system call
> > anyway, to deal with old kernels.

libc has the fallback already. Let's aim for 1:1 replacement of the
architecture code first and then add the extra bits in separate patches.

Thanks,

	tglx
