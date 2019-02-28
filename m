From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
Date: Thu, 28 Feb 2019 10:29:50 +0100
Message-ID: <CAK8P3a2D44CDXbcKB-WtphYY9E74ovFPs+e4Ti3fUqRL77AYhw@mail.gmail.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com>
 <CAK8P3a1ssUdsqk7YW-tjD-dihEAP-voKLOEGO-W=TL7Lb8E7vw@mail.gmail.com>
 <1f9b21cd-81f5-dfa9-70fb-af8228195cb4@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1f9b21cd-81f5-dfa9-70fb-af8228195cb4@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 27, 2019 at 3:52 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> On 22/02/2019 13:49, Arnd Bergmann wrote:
> > On Fri, Feb 22, 2019 at 1:25 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >
> >> +/*
> >> + * The definitions below are required to overcome the limitations
> >> + * of time_t on 32 bit architectures, which overflows in 2038.
> >> + * The new code should use the replacements based on time64_t and
> >> + * timespec64.
> >> + *
> >> + * The abstraction below will be updated once the migration to
> >> + * time64_t is complete.
> >> + */
> >> +#ifdef CONFIG_GENERIC_VDSO_32
> >> +#define __vdso_timespec                old_timespec32
> >> +#define __vdso_timeval         old_timeval32
> >> +#else
> >> +#ifdef ENABLE_COMPAT_VDSO
> >> +#define __vdso_timespec                old_timespec32
> >> +#define __vdso_timeval         old_timeval32
> >> +#else
> >> +#define __vdso_timespec                __kernel_timespec
> >> +#define __vdso_timeval         __kernel_old_timeval
> >> +#endif /* CONFIG_COMPAT_VDSO */
> >> +#endif /* CONFIG_GENERIC_VDSO_32 */

> > For __vdso_timespec, I see how you ended up with this
> > redefinition, and it makes the current version of your patches
> > easier, but I fear it will in turn make it harder to add the
> > __kernel_old_timeval based variant.
> >
>
> What is __kernel_old_timespec (based on you next email)? Why do you think it
> will make harder to add the new variants?

I mean you should ideally use the types that you have listed above
directly, without the abstraction.

In the long run I want one set of functions using __kernel_timespec that
implements the 64-bit time interfaces on both 32-bit and 64-bit kernels,
including the compat vdso, and another set using old_timespec32 for
just the native 32-bit and compat version.

This would match what we do in the normal system calls (in linux-5.1+),
where we always have the regular implementation use 64-bit types
only, and have an optional _time32 version that is used for existing
32-bit user space, on both native 32 bit kernels and compat syscalls
on 64-bit.

       Arnd
