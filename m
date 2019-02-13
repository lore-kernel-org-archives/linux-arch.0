Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57364 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733155AbfBMREW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Feb 2019 12:04:22 -0500
Date: Wed, 13 Feb 2019 17:04:14 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
Message-ID: <20190213170413.GE6346@brain-police>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
 <20181207175321.GA11430@edgewater-inn.cambridge.arm.com>
 <20190208173539.GD24375@fuggles.cambridge.arm.com>
 <alpine.DEB.2.21.1902081950260.1662@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1902082029240.1662@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902082029240.1662@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, marc.zyngier@arm.com
Message-ID: <20190213170414.5nKl3GoF2YMj6rG5OS4Ogc0iotza8UptT623MLivV2I@z>

[+Marc for the arch timer]

On Fri, Feb 08, 2019 at 08:30:25PM +0100, Thomas Gleixner wrote:
> On Fri, 8 Feb 2019, Thomas Gleixner wrote:
> > On Fri, 8 Feb 2019, Will Deacon wrote:
> > > On Fri, Dec 07, 2018 at 05:53:21PM +0000, Will Deacon wrote:
> > > > Anyway, moving the counter read into the protected region is a little fiddly
> > > > because the memory barriers we have in there won't give us the ordering we
> > > > need. We'll instead need to do something nasty, like create a dependency
> > > > from the counter read to the read of the seqlock:
> > > > 
> > > > Maybe the untested crufty hack below, although this will be a nightmare to
> > > > implement in C.
> 
> How is the in kernel ktime_get() correctness guaranteed then?

Luck.

I think we'll have to introduce a dummy dependent stack read into our
counter accessor so that it's ordered by the smp_rmb(). Example diff
below, which I'll roll into a proper patch series later on.

Will

--->8

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index f2a234d6516c..bd55b4373700 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -150,8 +150,24 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
 
 static inline u64 arch_counter_get_cntpct(void)
 {
+	u64 cnt, tmp;
+
 	isb();
-	return arch_timer_reg_read_stable(cntpct_el0);
+	cnt = arch_timer_reg_read_stable(cntpct_el0);
+
+	/*
+	 * This insanity brought to you by speculative, out-of-order system
+	 * register reads, sequence locks and Thomas Gleixner.
+	 *
+	 * http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/631195.html
+	 */
+	asm volatile("eor	%0, %1, %1\n"
+		     "add	%0, sp, %0\n"
+		     "ldr	xzr, [%0]"
+		     : "=r" (tmp)
+		     : "r" (cnt)
+		     : "memory");
+	return cnt;
 }
 
 static inline u64 arch_counter_get_cntvct(void)
