From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/27] arm64: Substitute gettimeofday with C implementation
Date: Wed, 14 Nov 2018 09:47:24 -0800
Message-ID: <CAK8P3a0ht6TjXubYiWaLh96hOGy3FH_K=JJVhQrYV3D+z-JqBA@mail.gmail.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-8-vincenzo.frascino@arm.com>
 <CAK8P3a1w=GBcYk2OaVNzfagMMeD_zdBK3G16BSYjFANKdSAezQ@mail.gmail.com>
 <8e306faf-6261-8363-3f18-70e754fa3a9d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <8e306faf-6261-8363-3f18-70e754fa3a9d@arm.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 13, 2018 at 2:58 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> On 09/11/2018 16:13, Arnd Bergmann wrote:

> >> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> >> index beca249bc2f3..9de0ffc369c5 100644
> >> --- a/arch/arm64/kernel/vdso/vdso.lds.S
> >> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> >> @@ -88,6 +88,7 @@ VERSION
> >>                 __kernel_gettimeofday;
> >>                 __kernel_clock_gettime;
> >>                 __kernel_clock_getres;
> >> +               __kernel_time;
> >>         local: *;
> >>         };
> >>  }
> >
> > I would  prefer to not add any deprecated interfaces in the VDSO. If we
> > have the 64-bit version of clock_gettime, we don't need the 32-bit version
> > of it, and we don't need gettimeofday() or time() either. The C library
> > can easily implement those by calling into clock_gettime.
> >
>
> I like the idea, this would make the vdso lib code more simple and more maintainable.
>
> In this patchset I tried to cover the widest possible scenario making things configurable: each architecture can select and enable exactly what it needs from the vdso common code.
>
> Based on what you are proposing, once the C library will implement things in this way, it will be easy to deprecate and remove the unused code.

Just to clarify: we can never remove interfaces that an older version of the
C library was using. What I'm asking is that we don't introduce any of the
unnecessary ones for architectures that don't already have them.

> I am not familiar with the development plans of the various C libraries, but looking at
> bionic libc currently seems using all the vdso exposed functions [1].
>
> [1] https://github.com/aosp-mirror/platform_bionic/blob/master/libc/bionic/vdso.cpp

It looks like this implementation checks for each one of them to be present
first and then uses a fallback implementation if it does not exist. This would
clearly let us remove the handlers we don't want to support, but there
are two possible downsides:

- some other libc might be lacking that fallback path
- the fallback might be much slower, e.g. time() should fallback to
  the vdso version of clock_gettime(CLOCK_REALTIME_COARSE) for
  best performance, rather than the time() syscall or CLOCK_REALTIME.

So I'd argue that if an architecture already has a time() vdso implementation,
we probably want to keep that entry point but make it point to the best
generic implementation (i.e. clock_gettime CLOCK_REALTIME_COARSE).

      Arnd
