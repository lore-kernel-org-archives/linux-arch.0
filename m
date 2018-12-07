From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
Date: Fri, 7 Dec 2018 17:53:22 +0000
Message-ID: <20181207175321.GA11430@edgewater-inn.cambridge.arm.com>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Hi Thomas,

You got me at this bit:

On Thu, Nov 29, 2018 at 11:11:52PM +0100, Thomas Gleixner wrote:
> On Thu, 29 Nov 2018, Vincenzo Frascino wrote:
> > +static __always_inline notrace int __do_realtime_or_tai(
> > +		const struct vdso_data *vd,
> > +		struct __vdso_timespec *ts,
> > +		bool is_tai)
> > +{
> > +	u32 seq, cs_mono_mult, cs_shift;
> > +	u64 ns, sec;
> > +	u64 cycle_last, cs_mono_mask;
> > +
> > +	if (vd->use_syscall)
> > +		return -1;
> > +repeat:
> > +	seq = vdso_read_begin(vd);
> > +	cycle_last = vd->cs_cycle_last;
> > +	cs_mono_mult = vd->cs_mono_mult;
> > +	cs_shift = vd->cs_shift;
> > +	cs_mono_mask = vd->cs_mono_mask;
> > +
> > +	if (is_tai)
> > +		sec = vd->tai_sec;
> > +	else
> > +		sec = vd->xtime_clock_sec;
> > +	ns = vd->xtime_clock_nsec;
> > +
> > +	if (unlikely(vdso_read_retry(vd, seq)))
> > +		goto repeat;
> > +
> > +	ns += get_clock_shifted_nsec(cycle_last, cs_mono_mult, cs_mono_mask);
> 
> This is broken. You cannot read the counter outside the seq count protected
> region. Please tell the ARM64 folks that their VDSO asm maze is broken.

We'll fix the maze, but could you explain a bit about the brokenness,
please? The write side in update_vsyscall() is only touching the data page,
so I think we've got those fields covered correctly with the seqlock. We'd
only have to worry about protecting the counter if it could be written
somehow.

Is your concern to do with migrating between systems, where the new system
has a counter with a different offset? If so, what does the program flow
look like when migrating in? I guess somehow we ensure that update_vsyscall()
is invoked before userspace can resume.

Anyway, moving the counter read into the protected region is a little fiddly
because the memory barriers we have in there won't give us the ordering we
need. We'll instead need to do something nasty, like create a dependency
from the counter read to the read of the seqlock:

Maybe the untested crufty hack below, although this will be a nightmare to
implement in C.

Will

--->8

diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index c39872a7b03c..2d1dfecae76b 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -73,6 +73,8 @@ x_tmp		.req	x8
 	movn	x_tmp, #0xff00, lsl #48
 	and	\res, x_tmp, \res
 	mul	\res, \res, \mult
+	and	x_tmp, x_tmp, xzr
+	add	vdso_data, vdso_data, x_tmp
 	.endm
 
 	/*
@@ -147,12 +149,12 @@ ENTRY(__kernel_gettimeofday)
 	/* w11 = cs_mono_mult, w12 = cs_shift */
 	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
 	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	seqcnt_check fail=1b
 
 	get_nsec_per_sec res=x9
 	lsl	x9, x9, x12
 
 	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
+	seqcnt_check fail=1b
 	get_ts_realtime res_sec=x10, res_nsec=x11, \
 		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
 
@@ -211,13 +213,13 @@ realtime:
 	/* w11 = cs_mono_mult, w12 = cs_shift */
 	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
 	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	seqcnt_check fail=realtime
 
 	/* All computations are done with left-shifted nsecs. */
 	get_nsec_per_sec res=x9
 	lsl	x9, x9, x12
 
 	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
+	seqcnt_check fail=realtime
 	get_ts_realtime res_sec=x10, res_nsec=x11, \
 		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
 	clock_gettime_return, shift=1
@@ -231,7 +233,6 @@ monotonic:
 	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
 	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
 	ldp	x3, x4, [vdso_data, #VDSO_WTM_CLK_SEC]
-	seqcnt_check fail=monotonic
 
 	/* All computations are done with left-shifted nsecs. */
 	lsl	x4, x4, x12
@@ -239,6 +240,7 @@ monotonic:
 	lsl	x9, x9, x12
 
 	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
+	seqcnt_check fail=monotonic
 	get_ts_realtime res_sec=x10, res_nsec=x11, \
 		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
 
@@ -253,13 +255,13 @@ monotonic_raw:
 	/* w11 = cs_raw_mult, w12 = cs_shift */
 	ldp	w12, w11, [vdso_data, #VDSO_CS_SHIFT]
 	ldp	x13, x14, [vdso_data, #VDSO_RAW_TIME_SEC]
-	seqcnt_check fail=monotonic_raw
 
 	/* All computations are done with left-shifted nsecs. */
 	get_nsec_per_sec res=x9
 	lsl	x9, x9, x12
 
 	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
+	seqcnt_check fail=monotonic_raw
 	get_ts_clock_raw res_sec=x10, res_nsec=x11, \
 		clock_nsec=x15, nsec_to_sec=x9
