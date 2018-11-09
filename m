From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/27] arm64: Substitute gettimeofday with C implementation
Date: Fri, 9 Nov 2018 17:13:29 +0100
Message-ID: <CAK8P3a1w=GBcYk2OaVNzfagMMeD_zdBK3G16BSYjFANKdSAezQ@mail.gmail.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-8-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181109123730.8743-8-vincenzo.frascino@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vincenzo.frascino@arm.com
Cc: linux-arch <linux-arch@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, salyzyn@android.com, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, pcc@google.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

> +
> +extern struct vdso_data _vdso_data;
> +
> +static __always_inline notrace int gettimeofday_fallback(struct timeval *_tv,
> +                                                        struct timezone *_tz)

I'm trying to get rid of the last users of 'struct timeval' in the kernel so
we can remove the definition (it will clash with future glibc implementations
in the uapi headers). Could you change this to use __kernel_old_timeval
instead?

> +static __always_inline notrace long clock_gettime_fallback(clockid_t _clkid,
> +                                                          struct timespec *_ts)

And this should be __kernel_timespec respectively on the kernel-user interface,
at least for 64-bit architectures.

On 32-bit, the corresponding type is 'struct old_timespec32'.

> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> index beca249bc2f3..9de0ffc369c5 100644
> --- a/arch/arm64/kernel/vdso/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> @@ -88,6 +88,7 @@ VERSION
>                 __kernel_gettimeofday;
>                 __kernel_clock_gettime;
>                 __kernel_clock_getres;
> +               __kernel_time;
>         local: *;
>         };
>  }

I would  prefer to not add any deprecated interfaces in the VDSO. If we
have the 64-bit version of clock_gettime, we don't need the 32-bit version
of it, and we don't need gettimeofday() or time() either. The C library
can easily implement those by calling into clock_gettime.

> +notrace int __kernel_clock_gettime(clockid_t clock, struct timespec *ts)
> +{
> +       return __cvdso_clock_gettime(clock, ts);
> +}
> +
> +notrace int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz)
> +{
> +       return __cvdso_gettimeofday(tv, tz);
> +}
> +
> +notrace time_t __kernel_time(time_t *time)
> +{
> +       return __cvdso_time(time);
> +}
> +
> +notrace int __kernel_clock_getres(clockid_t clock_id, struct timespec *res)
> +{
> +       return __cvdso_clock_getres(clock_id, res);
> +}
> +

These should use __kernel_old_timeval and __kernel_timespec again.

        Arnd
