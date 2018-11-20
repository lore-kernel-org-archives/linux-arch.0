From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v2 1/5] mips: add __NR_syscalls along with __NR_Linux_syscalls
Date: Tue, 20 Nov 2018 12:12:08 +0530
Message-ID: <CALxhOnjrXLjWNqrAtChw+k5vv5iu39wqAJNqJ9xDdzdv=xihhA@mail.gmail.com>
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
 <1542262461-29024-2-git-send-email-firoz.khan@linaro.org> <CAK8P3a2CuryCoZKaOXz=nH_WTAZ7VneNoUYHkKFDLQNQvrkWUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2CuryCoZKaOXz=nH_WTAZ7VneNoUYHkKFDLQNQvrkWUg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Arnd,

On Mon, 19 Nov 2018 at 21:22, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Nov 15, 2018 at 7:14 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > The 2nd option will be the recommended one. For that, I
> > added the __NR_syscalls macro in uapi/asm/unistd.h along
> > with __NR_Linux_syscalls. The macro __NR_syscalls also
> > added for making the name convention same across all
> > architecture. While __NR_syscalls isn't strictly part of
> > the uapi, having it as part of the generated header to
> > simplifies the implementation. We also need to enclose
> > this macro with #ifdef __KERNEL__ to avoid side effects.
>
> I fear this doesn't work the way you hoped:
>
> > --- a/arch/mips/include/uapi/asm/unistd.h
> > +++ b/arch/mips/include/uapi/asm/unistd.h
> > @@ -391,16 +391,19 @@
> >  #define __NR_rseq                      (__NR_Linux + 367)
> >  #define __NR_io_pgetevents             (__NR_Linux + 368)
> >
> > +#ifdef __KERNEL__
> > +#define __NR_syscalls                  368
> > +#endif
>
> We now have three different definitions of __NR_syscalls,
> one for each ABI. User space previously saw the correct
> one (now it doesn't see any, but that's ok).
>
> >  /*
> >   * Offset of the last Linux o32 flavoured syscall
> >   */
> > -#define __NR_Linux_syscalls            368
> > +#define __NR_Linux_syscalls            __NR_syscalls
>
> so this part part again is ok.
>
> >  #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
> >
> >  #define __NR_O32_Linux                 4000
> > -#define __NR_O32_Linux_syscalls                368
> > +#define __NR_O32_Linux_syscalls                __NR_syscalls
>
> but this part is not: Now __NR_O32_Linux_syscalls is defined
> to __NR_syscalls, which may be one of the three values.
> Any usage of __NR_O32_Linux_syscalls in a 64-bit kernel
> is then clearly wrong.
>
> >  #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
> >
> >  #define __NR_N32_Linux                 6000
> > -#define __NR_N32_Linux_syscalls                332
> > +#define __NR_N32_Linux_syscalls                __NR_syscalls
>
> Same for this one.

Thanks for the feedback. Will address all the comments.

Firoz

>
>        Arnd
