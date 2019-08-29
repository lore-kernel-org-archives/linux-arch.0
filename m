From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 4/7] lib: vdso: Remove VDSO_HAS_32BIT_FALLBACK
Date: Thu, 29 Aug 2019 08:25:02 -0700
Message-ID: <CALCETrVprrrR3TSVSAnHfLW4HDQG=gcVrdjmsk6ss6Z3+vKOBg@mail.gmail.com>
References: <20190829111843.41003-1-vincenzo.frascino@arm.com> <20190829111843.41003-5-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829111843.41003-5-vincenzo.frascino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrew Lutomirski <luto@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 29, 2019 at 4:19 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> VDSO_HAS_32BIT_FALLBACK was introduced to address a regression which
> caused seccomp to deny access to the applications to clock_gettime64()
> and clock_getres64() because they are not enabled in the existing
> filters.
>
> The purpose of VDSO_HAS_32BIT_FALLBACK was to simplify the conditional
> implementation of __cvdso_clock_get*time32() variants.
>
> Now that all the architectures that support the generic vDSO library
> have been converted to support the 32 bit fallbacks the conditional
> can be removed.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> CC: Andy Lutomirski <luto@kernel.org>
> References: c60a32ea4f45 ("lib/vdso/32: Provide legacy syscall fallbacks")
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  lib/vdso/gettimeofday.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> index a86e89e6dedc..2c4b311c226d 100644
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -126,13 +126,8 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
>
>         ret = __cvdso_clock_gettime_common(clock, &ts);
>
> -#ifdef VDSO_HAS_32BIT_FALLBACK
>         if (unlikely(ret))
>                 return clock_gettime32_fallback(clock, res);
> -#else
> -       if (unlikely(ret))
> -               ret = clock_gettime_fallback(clock, &ts);
> -#endif
>
>         if (likely(!ret)) {
>                 res->tv_sec = ts.tv_sec;

I think you could have a little follow-up patch to remove the if
statement -- by the time you get here, it's guaranteed that ret == 0.

--Andy
