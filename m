Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:59677 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfBWKpT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 23 Feb 2019 05:45:19 -0500
Date: Sat, 23 Feb 2019 11:45:15 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 22/23] x86: Add support for generic vDSO
In-Reply-To: <20190222122430.21180-23-vincenzo.frascino@arm.com>
Message-ID: <alpine.DEB.2.21.1902231138130.1666@nanos.tec.linutronix.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com> <20190222122430.21180-23-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190223104515.yPGmHkeTVVs_SC05wZyFv_jLsInZE3XJD2jvISScoBs@z>

On Fri, 22 Feb 2019, Vincenzo Frascino wrote:
>  void update_vsyscall_tz(void)
>  {
> -	vsyscall_gtod_data.tz_minuteswest = sys_tz.tz_minuteswest;
> -	vsyscall_gtod_data.tz_dsttime = sys_tz.tz_dsttime;
> +	vdso_data.tz_minuteswest = sys_tz.tz_minuteswest;
> +	vdso_data.tz_dsttime = sys_tz.tz_dsttime;
>  }
>  
>  void update_vsyscall(struct timekeeper *tk)
>  {
>  	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
> -	struct vsyscall_gtod_data *vdata = &vsyscall_gtod_data;
> -	struct vgtod_ts *base;
> +	struct vdso_data *vdata = &vdso_data;
> +	struct vdso_timestamp *vdso_ts;
>  	u64 nsec;
>  
>  	/* Mark the new vclock used. */
>  	BUILD_BUG_ON(VCLOCK_MAX >= 32);
>  	WRITE_ONCE(vclocks_used, READ_ONCE(vclocks_used) | (1 << vclock_mode));
>  
> -	gtod_write_begin(vdata);
> +	vdso_write_begin(vdata);

This begs the question why this update code is still architecture
specific. The vdso data is now generic, so the whole update can be generic
as well. The only x86 specific thing is this perhaps:

  	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;

	vdata->clock_mode	= vclock_mode;

But either than can be made generic and mandatory or easily resolved with a
trivial arch_update_vsyscall() inline.

Thanks,

	tglx
