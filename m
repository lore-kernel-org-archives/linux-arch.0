From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v2 2/5] parisc: add __NR_Linux_syscalls macro with __NR_syscalls
Date: Mon, 1 Oct 2018 19:36:44 +0530
Message-ID: <CALxhOnjrmfiPbSXf_ba3+5OyqZA6xuZue8PV4Pu7f3z+h-kUZg@mail.gmail.com>
References: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org>
 <1538058267-3765-3-git-send-email-firoz.khan@linaro.org> <CAK8P3a3ZOC-V0uOD6uD=Hg-AoN8mkJynD6ubpaTppevUvQ54qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3ZOC-V0uOD6uD=Hg-AoN8mkJynD6ubpaTppevUvQ54qw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Arnd,

On Fri, 28 Sep 2018 at 17:44, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Sep 27, 2018 at 4:25 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > 1. Update __NR_Linux_syscalls in uapi/asm/unistd.h manually
> >    by counting the no.of system calls. No need to update
> >    __NR_Linux_syscalls until we either add a new system call
> >    or delete an existing system call.
> >
> > 2. We can keep this feature it above mentioned script, that
> >    will count the number of syscalls and keep it in a gener-
> >    ated file. In this case we don't need to explicitly update
> >    __NR_Linux_syscalls in asm/unistd.h file.
> >
> > The 2nd option will be the recommended one. For that, I moved
> > the __NR_Linux_syscalls macro from uapi/asm/unistd.h to asm/
> > unistd.h. The macro __NR_syscalls also added for making the
> > name convention same across all architecture. While __NR_sys-
> > calls isn't strictly part of the uapi, having it as part of
> > the generated header to simplifies the implementation. We also
> > need to enclose this macro with #ifdef __KERNEL__ to avoid side
> > effects.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > ---
> >  arch/parisc/include/uapi/asm/unistd.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
> > index bb52e12..255c62a 100644
> > --- a/arch/parisc/include/uapi/asm/unistd.h
> > +++ b/arch/parisc/include/uapi/asm/unistd.h
> > @@ -366,7 +366,11 @@
> >  #define __NR_statx             (__NR_Linux + 349)
> >  #define __NR_io_pgetevents     (__NR_Linux + 350)
> >
> > -#define __NR_Linux_syscalls    (__NR_io_pgetevents + 1)
> > +#ifdef __KERNEL__
> > +#define __NR_syscalls           351
> > +#endif
> > +
> > +#define __NR_Linux_syscalls     __NR_syscalls
> >
>
> Hmm, now you have a __NR_Linux_syscalls macro that is defined in user
> space to a another macro that is not visible there. How about moving
> __NR_Linux_syscalls into arch/parisc/include/asm/unistd.h or
> replacing its users with __NR_syscalls instead?

Something went wrong when I created this patch series. Yes, this must be
reside in asm/unistd.h instead of uapi/asm/unistd.h. I would update this
change asap.

I would appreciate if some can perform boot test on actual platform.
Hopefully the above change doesn't make any problem.

Thanks
Firoz

>
>        Arnd
