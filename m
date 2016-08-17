From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH 17/18] arm64:ilp32: add vdso-ilp32 and use for signal return
Date: Wed, 17 Aug 2016 15:18:48 +0200
Message-ID: <mvmbn0rpm87.fsf@hawking.suse.de>
References: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
	<1471434403-25291-18-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41432 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802AbcHQNSw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Aug 2016 09:18:52 -0400
In-Reply-To: <1471434403-25291-18-git-send-email-ynorov@caviumnetworks.com>
	(Yury Norov's message of "Wed, 17 Aug 2016 14:46:42 +0300")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com

On Aug 17 2016, Yury Norov <ynorov@caviumnetworks.com> wrote:

> diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
> index e00b467..143b39e 100644
> --- a/arch/arm64/kernel/vdso/gettimeofday.S
> +++ b/arch/arm64/kernel/vdso/gettimeofday.S
> @@ -25,6 +25,16 @@
>  #define NSEC_PER_SEC_LO16	0xca00
>  #define NSEC_PER_SEC_HI16	0x3b9a
>  
> +#ifdef __LP64__
> +#define PTR_REG(n)	x##n
> +#define OFFSET(n)	n
> +#define DELOUSE(n)
> +#else
> +#define PTR_REG(n)	w##n
> +#define OFFSET(n)	COMPAT_##n
> +#define DELOUSE(n)	mov     w##n, w##n
> +#endif
> +
>  vdso_data	.req	x6
>  seqcnt		.req	w7
>  w_tmp		.req	w8
> @@ -136,6 +146,8 @@ x_tmp		.req	x8
>  /* int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz); */
>  ENTRY(__kernel_gettimeofday)
>  	.cfi_startproc
> +	DELOUSE(0)
> +	DELOUSE(1)
>  	adr	vdso_data, _vdso_data
>  	/* If tv is NULL, skip to the timezone code. */
>  	cbz	x0, 2f
> @@ -160,7 +172,7 @@ ENTRY(__kernel_gettimeofday)
>  	mov	x13, #1000
>  	lsl	x13, x13, x12
>  	udiv	x11, x11, x13
> -	stp	x10, x11, [x0, #TVAL_TV_SEC]
> +	stp	PTR_REG(10), PTR_REG(11), [x0, #OFFSET(TVAL_TV_SEC)]
>  2:
>  	/* If tz is NULL, return 0. */
>  	cbz	x1, 3f
> @@ -182,6 +194,7 @@ ENDPROC(__kernel_gettimeofday)
>  /* int __kernel_clock_gettime(clockid_t clock_id, struct timespec *tp); */
>  ENTRY(__kernel_clock_gettime)
>  	.cfi_startproc
> +	DELOUSE(1)
>  	cmp	w0, #JUMPSLOT_MAX
>  	b.hi	syscall
>  	adr	vdso_data, _vdso_data
> @@ -297,6 +310,7 @@ ENDPROC(__kernel_clock_gettime)
>  /* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
>  ENTRY(__kernel_clock_getres)
>  	.cfi_startproc
> +	DELOUSE(1)
>  	cmp	w0, #CLOCK_REALTIME
>  	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
>  	ccmp	w0, #CLOCK_MONOTONIC_RAW, #0x4, ne
> @@ -311,7 +325,7 @@ ENTRY(__kernel_clock_getres)
>  	ldr	x2, 6f
>  2:
>  	cbz	w1, 3f
> -	stp	xzr, x2, [x1]
> +	stp	PTR_REG(zr), PTR_REG(2), [x1]
>  
>  3:	/* res == NULL. */
>  	mov	w0, wzr

I think this is missing:

diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index 143b39e..b463c5a 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -129,7 +129,7 @@ x_tmp		.req	x8
 	.if \shift == 1
 	lsr	x11, x11, x12
 	.endif
-	stp	x10, x11, [x1, #TSPEC_TV_SEC]
+	stp	PTR_REG(10), PTR_REG(11), [x1, #OFFSET(TSPEC_TV_SEC)]
 	mov	x0, xzr
 	ret
 	.endm
-- 
2.9.3


Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
