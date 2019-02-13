Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:47492 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfBMTfi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2019 14:35:38 -0500
Date: Wed, 13 Feb 2019 20:35:32 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
In-Reply-To: <20190213170413.GE6346@brain-police>
Message-ID: <alpine.DEB.2.21.1902132033270.1659@nanos.tec.linutronix.de>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com> <20181129170530.37789-7-vincenzo.frascino@arm.com> <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de> <20181207175321.GA11430@edgewater-inn.cambridge.arm.com>
 <20190208173539.GD24375@fuggles.cambridge.arm.com> <alpine.DEB.2.21.1902081950260.1662@nanos.tec.linutronix.de> <alpine.DEB.2.21.1902082029240.1662@nanos.tec.linutronix.de> <20190213170413.GE6346@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, marc.zyngier@arm.com
Message-ID: <20190213193532.CCwnf3PjsskASupIWzJdxqf9NTpoEnl_NFX5uuddTkE@z>

On Wed, 13 Feb 2019, Will Deacon wrote:
> On Fri, Feb 08, 2019 at 08:30:25PM +0100, Thomas Gleixner wrote:
> >
> > How is the in kernel ktime_get() correctness guaranteed then?
> 
> Luck.
> 
> I think we'll have to introduce a dummy dependent stack read into our
> counter accessor so that it's ordered by the smp_rmb(). Example diff
> below, which I'll roll into a proper patch series later on.

Yikes.

>  static inline u64 arch_counter_get_cntpct(void)
>  {
> +	u64 cnt, tmp;
> +
>  	isb();
> -	return arch_timer_reg_read_stable(cntpct_el0);
> +	cnt = arch_timer_reg_read_stable(cntpct_el0);
> +
> +	/*
> +	 * This insanity brought to you by speculative, out-of-order system
> +	 * register reads, sequence locks and Thomas Gleixner.

ROTFL
