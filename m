Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50260 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfGJQ44 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jul 2019 12:56:56 -0400
Date: Wed, 10 Jul 2019 09:56:51 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] vsyscall: use __iter_div_u64_rem()
Message-ID: <20190710165651.GA29814@archlinux-threadripper>
References: <20190710130206.1670830-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710130206.1670830-1-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Message-ID: <20190710165651.Vq1Qaq5Jbu8o7DIrmmgAt2o5T9Z5VxFgben8Ba8FMWU@z>

On Wed, Jul 10, 2019 at 03:01:53PM +0200, Arnd Bergmann wrote:
> On 32-bit x86 when building with clang-9, the loop gets turned back into
> an inefficient division that causes a link error:
> 
> kernel/time/vsyscall.o: In function `update_vsyscall':
> vsyscall.c:(.text+0xe3): undefined reference to `__udivdi3'
> 
> Use the provided __iter_div_u64_rem() function that is meant to address
> the same case in other files.
> 
> Fixes: 44f57d788e7d ("timekeeping: Provide a generic update_vsyscall() implementation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/time/vsyscall.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
> index a80893180826..8cf3596a4ce6 100644
> --- a/kernel/time/vsyscall.c
> +++ b/kernel/time/vsyscall.c
> @@ -104,11 +104,7 @@ void update_vsyscall(struct timekeeper *tk)
>  	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
>  	nsec		= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
>  	nsec		= nsec + tk->wall_to_monotonic.tv_nsec;
> -	while (nsec >= NSEC_PER_SEC) {
> -		nsec = nsec - NSEC_PER_SEC;
> -		vdso_ts->sec++;
> -	}
> -	vdso_ts->nsec	= nsec;
> +	vdso_ts->sec	+= __iter_div_u64_rem(nsec, NSEC_PER_SEC, &vdso_ts->nsec);
>  
>  	if (__arch_use_vsyscall(vdata))
>  		update_vdso_data(vdata, tk);
> -- 
> 2.20.0
> 

What an interesting function. Looks good to me and I can confirm it
fixes the link error.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
