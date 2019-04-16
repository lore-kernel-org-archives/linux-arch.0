Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfDPRJ3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Apr 2019 13:09:29 -0400
Date: Tue, 16 Apr 2019 18:09:23 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 1/5] arm64: Fix vDSO clock_getres()
Message-ID: <20190416170923.GD7342@fuggles.cambridge.arm.com>
References: <20190416161434.32691-1-vincenzo.frascino@arm.com>
 <20190416161434.32691-2-vincenzo.frascino@arm.com>
 <20190416162432.GI28994@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416162432.GI28994@arrakis.emea.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190416170923.50qxhAB1gejKnHIUJvzmAdv5IUBThKyfZnsRlIZlzlo@z>

On Tue, Apr 16, 2019 at 05:24:33PM +0100, Catalin Marinas wrote:
> On Tue, Apr 16, 2019 at 05:14:30PM +0100, Vincenzo Frascino wrote:
> > diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> > index 2d419006ad43..5f5759d51c33 100644
> > --- a/arch/arm64/kernel/vdso.c
> > +++ b/arch/arm64/kernel/vdso.c
> > @@ -245,6 +245,8 @@ void update_vsyscall(struct timekeeper *tk)
> >  		vdso_data->cs_shift		= tk->tkr_mono.shift;
> >  	}
> >  
> > +	vdso_data->hrtimer_res		= hrtimer_resolution;
> 
> This should be a WRITE_ONCE(), just in case.
> 
> > +
> >  	smp_wmb();
> >  	++vdso_data->tb_seq_count;
> >  }
> > diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
> > index c39872a7b03c..e2e9dfe9ba4a 100644
> > --- a/arch/arm64/kernel/vdso/gettimeofday.S
> > +++ b/arch/arm64/kernel/vdso/gettimeofday.S
> > @@ -296,32 +296,32 @@ ENDPROC(__kernel_clock_gettime)
> >  /* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
> >  ENTRY(__kernel_clock_getres)
> >  	.cfi_startproc
> > +	adr	vdso_data, _vdso_data
> >  	cmp	w0, #CLOCK_REALTIME
> >  	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
> >  	ccmp	w0, #CLOCK_MONOTONIC_RAW, #0x4, ne
> > -	b.ne	1f
> > +	b.ne	2f
> >  
> > -	ldr	x2, 5f
> > -	b	2f
> > -1:
> > +1:	/* Get hrtimer_res */
> > +	ldr	x2, [vdso_data, #CLOCK_REALTIME_RES]
> 
> And here we need an "ldr w2, ..." since hrtimer_res is u32.
> 
> With the above (which Will can fix up):
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Applied, with the above and a few extra cleanups.

Will
