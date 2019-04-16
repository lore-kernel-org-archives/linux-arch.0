Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729533AbfDPOXy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Apr 2019 10:23:54 -0400
Date: Tue, 16 Apr 2019 15:23:46 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/5] arm64: Fix vDSO clock_getres()
Message-ID: <20190416142346.GA3803@fuggles.cambridge.arm.com>
References: <20190401115152.32751-1-vincenzo.frascino@arm.com>
 <20190401115152.32751-2-vincenzo.frascino@arm.com>
 <20190415173521.GA901@arrakis.emea.arm.com>
 <efaafc72-79da-b25a-78b7-36424d9350ad@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efaafc72-79da-b25a-78b7-36424d9350ad@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190416142346.PDHrM6ZkLdFgepo1pmkbROccr7BhXyY2ec4Uft3q6yU@z>

On Tue, Apr 16, 2019 at 01:42:58PM +0100, Vincenzo Frascino wrote:
> On 15/04/2019 18:35, Catalin Marinas wrote:
> > On Mon, Apr 01, 2019 at 12:51:48PM +0100, Vincenzo Frascino wrote:
> >> +1:	/* Get hrtimer_res */
> >> +	seqcnt_acquire
> >> +	syscall_check fail=5f
> >> +	ldr	x2, [vdso_data, #CLOCK_REALTIME_RES]
> >> +	seqcnt_check fail=1b
> >> +	b	3f
> >> +2:
> > 
> > We talked briefly but I'm still confused why we need the fallback to the
> > syscall here if archdata.vdso_direct is false. Is it because if the
> > timer driver code sets vdso_direct to false, we don't don't support
> > highres timers? If my understanding is correct, you may want to move the
> > hrtimer_res setting in update_vsyscall() to the !use_syscall block.
> > 
> 
> Ok, so let me try to provide more details on what I mentioned yesterday:
> - clock_getres syscall follows the rules of what defined in posix-timers.c
> - based on the clock_id that, for this purpose, can be separated in coarse and
> non-coarse calls either posix_get_coarse_res() or posix_get_hrtimer_res().
> - if clock id is set to a coarse clock and posix_get_coarse_res() is invoked,
> happens what follows:
> 
> static int posix_get_coarse_res(const clockid_t which_clock,
> 				struct timespec64 *tp)
> {
> 	*tp = ktime_to_timespec64(KTIME_LOW_RES);
> 	return 0;
> }
> 
> Note that since CONFIG_1HZ seems not supported (jiffies.h) by the kernel in this
> case we do not need rounding in our vDSO implementation.
> 
> - if clock id is set to non-coarse and posix_get_hrtimer_res() is invoked,
> happens the following:
> 
> static int posix_get_hrtimer_res(clockid_t which_clock, struct timespec64 *tp)
> {
> 	tp->tv_sec = 0;
> 	tp->tv_nsec = hrtimer_resolution;
> 	return 0;
> }
> 
> hrtimer_resolution can be high res or low res depending on the call of
> hrtimer_switch_to_hres(). For us the only way to preserve the correct value is
> to keep it in the vdso data page.
> 
> - The assembly code mimics exactly the same behaviour detailed above, with one
> difference: the one related to the use_syscall parameter which is specific to arm64.
> The use_syscall parameter is set by arm_arch_timer and consumed by
> update_vsyscall(). To mirror what update_vsyscall does in update_vsyscall() I
> check "syscall_check fail=5f" in clock_getres vdso function.
> 
> Said that, even if functionally it is the same thing, I think it is logically
> more correct to have hrtimer_res setting inside the !use_syscall block, hence I
> am going to change it in the next iteration.
> 
> Please let me know your thoughts.

I think you can ignore the syscall_check, just like we seem to do for
CLOCK_REALTIME_COARSE and CLOCK_MONOTONIC_COARSE in clock_gettime().

Will
