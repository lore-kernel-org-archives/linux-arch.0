Return-Path: <SRS0=zClU=5C=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:39076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgCQOij (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 10:38:39 -0400
Date: Tue, 17 Mar 2020 14:38:34 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 18/26] arm64: vdso32: Replace TASK_SIZE_32 check in
 vgettimeofday
Message-ID: <20200317143834.GC632169@arrakis.emea.arm.com>
References: <20200317122220.30393-1-vincenzo.frascino@arm.com>
 <20200317122220.30393-19-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317122220.30393-19-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, linux-mips@vger.kernel.org, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Will Deacon <will@kernel.org>
Message-ID: <20200317143834.7uV2e_CQpBeFNUWlPEo73ztTIX6IA-yizEe0sbLXYow@z>

On Tue, Mar 17, 2020 at 12:22:12PM +0000, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
> index 54fc1c2ce93f..91138077b073 100644
> --- a/arch/arm64/kernel/vdso32/vgettimeofday.c
> +++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
> @@ -8,11 +8,14 @@
>  #include <linux/time.h>
>  #include <linux/types.h>
>  
> +#define VALID_CLOCK_ID(x) \
> +	((x >= 0) && (x < VDSO_BASES))
> +
>  int __vdso_clock_gettime(clockid_t clock,
>  			 struct old_timespec32 *ts)
>  {
>  	/* The checks below are required for ABI consistency with arm */
> -	if ((u32)ts >= TASK_SIZE_32)
> +	if ((u32)ts > UINTPTR_MAX - sizeof(*ts) + 1)
>  		return -EFAULT;
>  
>  	return __cvdso_clock_gettime32(clock, ts);

I probably miss something but I can't find the TASK_SIZE check in the
arch/arm/vdso/vgettimeofday.c code. Is this done elsewhere?

> @@ -22,7 +25,7 @@ int __vdso_clock_gettime64(clockid_t clock,
>  			   struct __kernel_timespec *ts)
>  {
>  	/* The checks below are required for ABI consistency with arm */
> -	if ((u32)ts >= TASK_SIZE_32)
> +	if ((u32)ts > UINTPTR_MAX - sizeof(*ts) + 1)
>  		return -EFAULT;
>  
>  	return __cvdso_clock_gettime(clock, ts);
> @@ -38,9 +41,12 @@ int __vdso_clock_getres(clockid_t clock_id,
>  			struct old_timespec32 *res)
>  {
>  	/* The checks below are required for ABI consistency with arm */
> -	if ((u32)res >= TASK_SIZE_32)
> +	if ((u32)res > UINTPTR_MAX - sizeof(res) + 1)
>  		return -EFAULT;
>  
> +	if (!VALID_CLOCK_ID(clock_id) && res == NULL)
> +		return -EINVAL;

This last check needs an explanation. If the clock_id is invalid but res
is not NULL, we allow it. I don't see where the compatibility issue is,
arm32 doesn't have such check.

-- 
Catalin
