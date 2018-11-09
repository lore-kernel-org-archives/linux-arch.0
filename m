From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 06/27] kernel: Define gettimeofday vdso common code
Date: Fri, 9 Nov 2018 17:05:31 +0100
Message-ID: <CAK8P3a3yu_ZOCxDhGvPnff45jEkEMcQ-KuX5Otqfzfi52kd+tA@mail.gmail.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-7-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181109123730.8743-7-vincenzo.frascino@arm.com>
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

On Fri, Nov 9, 2018 at 1:38 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> +/*
> + * To avoid performance issues __u_vdso (unsigned vdso type) depends
> + * on the architecture:
> + * 32 bit only __u_vdso is defined as __u32
> + * 64 bit plus compat __u_vdso is defined as __u64
> + */
> +#ifdef CONFIG_GENERIC_VDSO_32
> +typedef __u32 __u_vdso;
> +#else
> +typedef __u64 __u_vdso;
> +#endif /* CONFIG_GENERIC_VDSO_32 */
> +
>  struct vdso_data {
> -       __u64 cs_cycle_last;    /* Timebase at clocksource init */
> -       __u64 raw_time_sec;     /* Raw time */
> +       __u64 cs_cycle_last;            /* Timebase at clocksource init */
> +       __u_vdso raw_time_sec;          /* Raw time */
>         __u64 raw_time_nsec;
> -       __u64 xtime_clock_sec;  /* Kernel time */
> +       __u_vdso xtime_clock_sec;       /* Kernel time */
>         __u64 xtime_clock_nsec;
> -       __u64 xtime_coarse_sec; /* Coarse time */
> +       __u_vdso xtime_coarse_sec;      /* Coarse time */
>         __u64 xtime_coarse_nsec;
> -       __u64 wtm_clock_sec;    /* Wall to monotonic time */
> +       __u_vdso wtm_clock_sec;         /* Wall to monotonic time */

It looks like you change the layout in a way that makes it incompatible between
32-bit and 64-bit user space. Doesn't that break the compat-vdso code
for 32-bit?

It also seems like we need the seconds to be 64-bit wide, at least
for anything that counts in CLOCK_REALTIME or a related format,
otherwise we have to change it back for y2038 support.

      Arnd
