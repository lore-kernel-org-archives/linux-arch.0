Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42855 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfAOP3l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jan 2019 10:29:41 -0500
Date: Tue, 15 Jan 2019 16:29:38 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 01/24] kernel: Standardize vdso_datapage
In-Reply-To: <7b0c86a9-b22b-ec89-436e-c8a6a69146b6@arm.com>
Message-ID: <alpine.DEB.2.21.1901151627560.1561@nanos.tec.linutronix.de>
References: <20190115135539.24762-1-vincenzo.frascino@arm.com> <20190115135539.24762-2-vincenzo.frascino@arm.com> <alpine.DEB.2.21.1901151554260.1561@nanos.tec.linutronix.de> <7b0c86a9-b22b-ec89-436e-c8a6a69146b6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20190115152938.5e1uhGNFn7FVQRim0fvhPwrApSzk5cV4Jm1SZvbsWII@z>

On Tue, 15 Jan 2019, Vincenzo Frascino wrote:
> On 15/01/2019 14:57, Thomas Gleixner wrote:
> >> +	u64 mask;		/* Clocksource mask (mono = raw) */
> > 
> > mono = raw? This is broken. The VDSO cannot define time different from the
> > regular syscall interfaces.
> > 
> 
> On v2 of this series I had the masks for mono and raw separate, but based on
> your comment (the core timekeeper has them duplicated purely for access pattern
> optimization and simplicity). I unified them. Could you please provide more
> details on what should be done in this case?

The mask is the same, but the mult is different. I'm not seing how this is
implemented. Both MONO and MONO_RAW invoke do_hres() and use the common
mult/shift pair.

Thanks,

	tglx
