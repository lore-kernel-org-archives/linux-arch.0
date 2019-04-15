Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbfDORf2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Apr 2019 13:35:28 -0400
Date: Mon, 15 Apr 2019 18:35:22 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/5] arm64: Fix vDSO clock_getres()
Message-ID: <20190415173521.GA901@arrakis.emea.arm.com>
References: <20190401115152.32751-1-vincenzo.frascino@arm.com>
 <20190401115152.32751-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401115152.32751-2-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190415173522.uBo9SpVl36EaS6xOE_VvTG5l1UJvTbTHQEgN9PkEiaI@z>

On Mon, Apr 01, 2019 at 12:51:48PM +0100, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 2d419006ad43..47ba72345739 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -245,6 +245,8 @@ void update_vsyscall(struct timekeeper *tk)
>  		vdso_data->cs_shift		= tk->tkr_mono.shift;
>  	}
>  
> +	vdso_data->hrtimer_res			= hrtimer_resolution;
> +
>  	smp_wmb();
>  	++vdso_data->tb_seq_count;
>  }
> diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
> index c39872a7b03c..7a2cd2f8e13a 100644
> --- a/arch/arm64/kernel/vdso/gettimeofday.S
> +++ b/arch/arm64/kernel/vdso/gettimeofday.S
> @@ -296,32 +296,35 @@ ENDPROC(__kernel_clock_gettime)
>  /* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
>  ENTRY(__kernel_clock_getres)
>  	.cfi_startproc
> +	adr	vdso_data, _vdso_data
>  	cmp	w0, #CLOCK_REALTIME
>  	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
>  	ccmp	w0, #CLOCK_MONOTONIC_RAW, #0x4, ne
> -	b.ne	1f
> +	b.ne	2f
>  
> -	ldr	x2, 5f
> -	b	2f
> -1:
> +1:	/* Get hrtimer_res */
> +	seqcnt_acquire
> +	syscall_check fail=5f
> +	ldr	x2, [vdso_data, #CLOCK_REALTIME_RES]
> +	seqcnt_check fail=1b
> +	b	3f
> +2:

We talked briefly but I'm still confused why we need the fallback to the
syscall here if archdata.vdso_direct is false. Is it because if the
timer driver code sets vdso_direct to false, we don't don't support
highres timers? If my understanding is correct, you may want to move the
hrtimer_res setting in update_vsyscall() to the !use_syscall block.

-- 
Catalin
