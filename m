From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/5] mips: remove syscall table entries
Date: Tue, 20 Nov 2018 11:54:07 +0100
Message-ID: <CAK8P3a2o+jKd0EF81TezmJbTLBPRN9frCBf3wvxySa0sEbC+-A@mail.gmail.com>
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
 <1542262461-29024-4-git-send-email-firoz.khan@linaro.org> <20181119222924.ybnl7qe4hobud5fb@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119222924.ybnl7qe4hobud5fb@pburton-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@mips.com>
Cc: Firoz Khan <firoz.khan@linaro.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 19, 2018 at 11:29 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Firoz,
>
> On Thu, Nov 15, 2018 at 11:44:19AM +0530, Firoz Khan wrote:
> > diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
> > index a9b895f..4eee437 100644
> > --- a/arch/mips/kernel/scall32-o32.S
> > +++ b/arch/mips/kernel/scall32-o32.S
> > @@ -208,6 +208,18 @@ einval: li       v0, -ENOSYS
> >       jr      ra
> >       END(sys_syscall)
> >
> > +#ifdef CONFIG_MIPS_MT_FPAFF
> > +     /*
> > +      * For FPU affinity scheduling on MIPS MT processors, we need to
> > +      * intercept sys_sched_xxxaffinity() calls until we get a proper hook
> > +      * in kernel/sched/core.c.  Considered only temporary we only support
> > +      * these hooks for the 32-bit kernel - there is no MIPS64 MT processor
> > +      * atm.
> > +      */
> > +#define mipsmt_sys_sched_setaffinity sys_sched_setaffinity
> > +#define mipsmt_sys_sched_getaffinity sys_sched_getaffinity
>
> Is this backwards? ie. should it be:
>
>     #define sys_sched_setaffinity mipsmt_sys_sched_setaffinity
>     #define sys_sched_getaffinity mipsmt_sys_sched_getaffinity
>
> ?
>
> I don't see how the mipsmt_* functions will ever be used after this
> patch.

Good catch!

> > -      * atm.
> > -      */
> > -     PTR     mipsmt_sys_sched_setaffinity
> > -     PTR     mipsmt_sys_sched_getaffinity
> > -#else
> >       PTR     sys_sched_setaffinity
> >       PTR     sys_sched_getaffinity           /* 4240 */
> > -#endif /* CONFIG_MIPS_MT_FPAFF */
> >       PTR     sys_io_setup

My guess would be that he removed the wrong lines here instead,
and the first half was intentional.

       Arnd
