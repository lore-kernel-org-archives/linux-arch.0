Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:45379 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfBHTa2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2019 14:30:28 -0500
Date: Fri, 8 Feb 2019 20:30:25 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
In-Reply-To: <alpine.DEB.2.21.1902081950260.1662@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1902082029240.1662@nanos.tec.linutronix.de>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com> <20181129170530.37789-7-vincenzo.frascino@arm.com> <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de> <20181207175321.GA11430@edgewater-inn.cambridge.arm.com>
 <20190208173539.GD24375@fuggles.cambridge.arm.com> <alpine.DEB.2.21.1902081950260.1662@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20190208193025.P-KrWzBzBwnxg9qWSZw5uwfwS1y9WgVx1Ml-bHSgSMc@z>

On Fri, 8 Feb 2019, Thomas Gleixner wrote:
> Will,
> 
> On Fri, 8 Feb 2019, Will Deacon wrote:
> > On Fri, Dec 07, 2018 at 05:53:21PM +0000, Will Deacon wrote:
> > > Anyway, moving the counter read into the protected region is a little fiddly
> > > because the memory barriers we have in there won't give us the ordering we
> > > need. We'll instead need to do something nasty, like create a dependency
> > > from the counter read to the read of the seqlock:
> > > 
> > > Maybe the untested crufty hack below, although this will be a nightmare to
> > > implement in C.

How is the in kernel ktime_get() correctness guaranteed then?

Thanks,

	tglx
