From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/27] arm64: Substitute gettimeofday with C implementation
Date: Fri, 23 Nov 2018 12:14:07 +0100
Message-ID: <CAK8P3a0niPB4pzBB9_+28LxZJw0jY_HLnzaE2jRy5COc7ZLK_w@mail.gmail.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-8-vincenzo.frascino@arm.com>
 <CAK8P3a1w=GBcYk2OaVNzfagMMeD_zdBK3G16BSYjFANKdSAezQ@mail.gmail.com>
 <8e306faf-6261-8363-3f18-70e754fa3a9d@arm.com>
 <CAK8P3a0ht6TjXubYiWaLh96hOGy3FH_K=JJVhQrYV3D+z-JqBA@mail.gmail.com>
 <f283de36-b620-03f0-b97b-fd63900e33ce@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f283de36-b620-03f0-b97b-fd63900e33ce@arm.com>
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

On Fri, Nov 23, 2018 at 11:48 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> On 11/14/18 5:47 PM, Arnd Bergmann wrote:
> > On Tue, Nov 13, 2018 at 2:58 AM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >>
> >> On 09/11/2018 16:13, Arnd Bergmann wrote:
> >> I am not familiar with the development plans of the various C libraries, but looking at
> >> bionic libc currently seems using all the vdso exposed functions [1].
> >>
> >> [1] https://github.com/aosp-mirror/platform_bionic/blob/master/libc/bionic/vdso.cpp
> >
> > It looks like this implementation checks for each one of them to be present
> > first and then uses a fallback implementation if it does not exist. This would
> > clearly let us remove the handlers we don't want to support, but there
> > are two possible downsides:
> >> - some other libc might be lacking that fallback path
> > - the fallback might be much slower, e.g. time() should fallback to
> >   the vdso version of clock_gettime(CLOCK_REALTIME_COARSE) for
> >   best performance, rather than the time() syscall or CLOCK_REALTIME.
> >
> > So I'd argue that if an architecture already has a time() vdso implementation,
> > we probably want to keep that entry point but make it point to the best
> > generic implementation (i.e. clock_gettime CLOCK_REALTIME_COARSE).
>
> What I was trying to point out here is that if the symbol is present in the vdso
> library the C library implementation tends to prefer to use it.
>
> Said that, I agree with what you are saying and in this first iteration I will
> make sure that we do not add new symbols for the architectures that did not
> support them previously, but I will keep the library the most generic possible,
>
> I would prefer though to introduce the redirection for gettimeofday() and time()
> to the best performing clock_gettime() at a later stage (and with a separate
> patchset) because it would involve some cleanup in the vdso.c of the
> architectures that would use the library (i.e. update_vsyscall_tz() not required
> anymore) and because based on what I measured with a quick test the performance
> difference seems small with the current implementation of the library.

Ok, makes sense.

Thanks,

      Arnd
