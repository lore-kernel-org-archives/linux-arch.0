Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbfBHRfo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:44 -0500
Date: Fri, 8 Feb 2019 17:35:39 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
Message-ID: <20190208173539.GD24375@fuggles.cambridge.arm.com>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
 <20181207175321.GA11430@edgewater-inn.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207175321.GA11430@edgewater-inn.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20190208173539.gk8KIW3jKCSwj1qGmCmdA0k8ZwkVYjpKEHKL-k3VqFQ@z>

Hi Thomas,

On Fri, Dec 07, 2018 at 05:53:21PM +0000, Will Deacon wrote:
> On Thu, Nov 29, 2018 at 11:11:52PM +0100, Thomas Gleixner wrote:
> > On Thu, 29 Nov 2018, Vincenzo Frascino wrote:
> > > +static __always_inline notrace int __do_realtime_or_tai(
> > > +		const struct vdso_data *vd,
> > > +		struct __vdso_timespec *ts,
> > > +		bool is_tai)
> > > +{
> > > +	u32 seq, cs_mono_mult, cs_shift;
> > > +	u64 ns, sec;
> > > +	u64 cycle_last, cs_mono_mask;
> > > +
> > > +	if (vd->use_syscall)
> > > +		return -1;
> > > +repeat:
> > > +	seq = vdso_read_begin(vd);
> > > +	cycle_last = vd->cs_cycle_last;
> > > +	cs_mono_mult = vd->cs_mono_mult;
> > > +	cs_shift = vd->cs_shift;
> > > +	cs_mono_mask = vd->cs_mono_mask;
> > > +
> > > +	if (is_tai)
> > > +		sec = vd->tai_sec;
> > > +	else
> > > +		sec = vd->xtime_clock_sec;
> > > +	ns = vd->xtime_clock_nsec;
> > > +
> > > +	if (unlikely(vdso_read_retry(vd, seq)))
> > > +		goto repeat;
> > > +
> > > +	ns += get_clock_shifted_nsec(cycle_last, cs_mono_mult, cs_mono_mask);
> > 
> > This is broken. You cannot read the counter outside the seq count protected
> > region. Please tell the ARM64 folks that their VDSO asm maze is broken.
> 
> We'll fix the maze, but could you explain a bit about the brokenness,
> please? The write side in update_vsyscall() is only touching the data page,
> so I think we've got those fields covered correctly with the seqlock. We'd
> only have to worry about protecting the counter if it could be written
> somehow.
> 
> Is your concern to do with migrating between systems, where the new system
> has a counter with a different offset? If so, what does the program flow
> look like when migrating in? I guess somehow we ensure that update_vsyscall()
> is invoked before userspace can resume.
> 
> Anyway, moving the counter read into the protected region is a little fiddly
> because the memory barriers we have in there won't give us the ordering we
> need. We'll instead need to do something nasty, like create a dependency
> from the counter read to the read of the seqlock:
> 
> Maybe the untested crufty hack below, although this will be a nightmare to
> implement in C.

We discussed this in person this week, but you couldn't recall the details
off the top of your head so I'm replying here. Please could you clarify what
your concern was with the existing code, and whether or not I've got the
wrong end of the stick?

Cheers,

Will

> --->8
> 
> diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
> index c39872a7b03c..2d1dfecae76b 100644
> --- a/arch/arm64/kernel/vdso/gettimeofday.S
> +++ b/arch/arm64/kernel/vdso/gettimeofday.S
> @@ -73,6 +73,8 @@ x_tmp		.req	x8
>  	movn	x_tmp, #0xff00, lsl #48
>  	and	\res, x_tmp, \res
>  	mul	\res, \res, \mult
> +	and	x_tmp, x_tmp, xzr
> +	add	vdso_data, vdso_data, x_tmp
>  	.endm
>  
>  	/*
> @@ -147,12 +149,12 @@ ENTRY(__kernel_gettimeofday)
>  	/* w11 = cs_mono_mult, w12 = cs_shift */
>  	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
>  	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
> -	seqcnt_check fail=1b
>  
>  	get_nsec_per_sec res=x9
>  	lsl	x9, x9, x12
>  
>  	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
> +	seqcnt_check fail=1b
>  	get_ts_realtime res_sec=x10, res_nsec=x11, \
>  		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
>  
> @@ -211,13 +213,13 @@ realtime:
>  	/* w11 = cs_mono_mult, w12 = cs_shift */
>  	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
>  	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
> -	seqcnt_check fail=realtime
>  
>  	/* All computations are done with left-shifted nsecs. */
>  	get_nsec_per_sec res=x9
>  	lsl	x9, x9, x12
>  
>  	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
> +	seqcnt_check fail=realtime
>  	get_ts_realtime res_sec=x10, res_nsec=x11, \
>  		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
>  	clock_gettime_return, shift=1
> @@ -231,7 +233,6 @@ monotonic:
>  	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
>  	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
>  	ldp	x3, x4, [vdso_data, #VDSO_WTM_CLK_SEC]
> -	seqcnt_check fail=monotonic
>  
>  	/* All computations are done with left-shifted nsecs. */
>  	lsl	x4, x4, x12
> @@ -239,6 +240,7 @@ monotonic:
>  	lsl	x9, x9, x12
>  
>  	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
> +	seqcnt_check fail=monotonic
>  	get_ts_realtime res_sec=x10, res_nsec=x11, \
>  		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
>  
> @@ -253,13 +255,13 @@ monotonic_raw:
>  	/* w11 = cs_raw_mult, w12 = cs_shift */
>  	ldp	w12, w11, [vdso_data, #VDSO_CS_SHIFT]
>  	ldp	x13, x14, [vdso_data, #VDSO_RAW_TIME_SEC]
> -	seqcnt_check fail=monotonic_raw
>  
>  	/* All computations are done with left-shifted nsecs. */
>  	get_nsec_per_sec res=x9
>  	lsl	x9, x9, x12
>  
>  	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
> +	seqcnt_check fail=monotonic_raw
>  	get_ts_clock_raw res_sec=x10, res_nsec=x11, \
>  		clock_nsec=x15, nsec_to_sec=x9
>  
