From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v5 2/3] m68k: add system call table generation support
Date: Tue, 4 Dec 2018 14:09:01 +0530
Message-ID: <CALxhOngxJ6C7xLNa-7os79XLGhHoBsoZnWcNCpm-7_=S72t-uQ@mail.gmail.com>
References: <1542088829-19790-1-git-send-email-firoz.khan@linaro.org>
 <1542088829-19790-3-git-send-email-firoz.khan@linaro.org> <CAMuHMdVsBwL9vcqejfc47GN793wMXdQ=SwEsSUP1fbpMt-OoWw@mail.gmail.com>
 <CALxhOnggoJ8Ds-0AXxg5Tfa7QwccqjWExKuYRuNv+Km1FTVj1w@mail.gmail.com> <CAMuHMdUabwAN7uaSWopZAbHDGDRMPo3eLwZHEmcXes-sta_88Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUabwAN7uaSWopZAbHDGDRMPo3eLwZHEmcXes-sta_88Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Geert,

On Tue, 4 Dec 2018 at 13:26, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Firoz,
>
> On Tue, Dec 4, 2018 at 4:22 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Sun, 2 Dec 2018 at 19:27, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Nov 13, 2018 at 7:01 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > > > The system call tables are in different format in all
> > > > architecture and it will be difficult to manually add,
> > > > modify or delete the syscall table entries in the res-
> > > > pective files. To make it easy by keeping a script and
> > > > which will generate the uapi header and syscall table
> > > > file. This change will also help to unify the implemen-
> > > > tation across all architectures.
> > > >
> > > > The system call table generation script is added in
> > > > kernel/syscalls directory which contain the scripts to
> > > > generate both uapi header file and system call table
> > > > files. The syscall.tbl will be input for the scripts.
> > > >
> > > > syscall.tbl contains the list of available system calls
> > > > along with system call number and corresponding entry
> > > > point. Add a new system call in this architecture will
> > > > be possible by adding new entry in the syscall.tbl file.
> > > >
> > > > Adding a new table entry consisting of:
> > > >         - System call number.
> > > >         - ABI.
> > > >         - System call name.
> > > >         - Entry point name.
> > > >
> > > > syscallhdr.sh and syscalltbl.sh will generate uapi header
> > > > unistd_32.h and syscall_table.h files respectively. Both
> > > > .sh files will parse the content syscall.tbl to generate
> > > > the header and table files. unistd_32.h will be included
> > > > by uapi/asm/unistd.h and syscall_table.h is included by
> > > > kernel/syscall_table.S - the real system call table.
> > > >
> > > > ARM, s390 and x86 architecuture does have similar support.
> > > > I leverage their implementation to come up with a generic
> > > > solution.
> > > >
> > > > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > >
> > > Thanks for your patch!
> > >
> > > > --- /dev/null
> > > > +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
>
> > > > +       printf "#endif\n"
> > > > +       printf "\n"
> > > > +       printf "#endif /* %s */" "${fileguard}"
> > >
> > > The above line is lacking a "\n", causing:
> > >
> > >     ./arch/m68k/include/generated/uapi/asm/unistd_32.h:370:42:
> > > warning: no newline at end of file
> >
> > I was wondering, I haven't seen this warning when I compiled it.
>
> It seems to depend on the compiler version.
> One more thing found by my good old gcc-4.1 ;-)
> (which I plan to retire soon, as I need to revert too many "drop support
>  for old gcc" patches to keep it working :-(.
>
> > > Changing it to:
> > >
> > >     printf "#endif /* %s */\n" "${fileguard}"
> > >
> > > fixes this.
> >
> > Yes.
> >
> > > Interestingly, this issue seems to be present on powerpc, parisc, sparc,
> > > sh, xtensa (and probably more, I gave up looking), too?
> >
> > I kept the script to generate files *almost* identical. so this will be present
> > all 10 architecture.
> >
> > > Apart from that, it seems to work fine on m68k.
> >
> > I have three options here to fix this;
> > 1. I can send v6 by fixing this one.
> > 2. I can post a single patch which add \n in the script.
> > 3. Could you able to add \n in the script.
> >
> > Please choose one, I can act accordingly.
>
> So your plan is for me to apply your series to the m68k tree?

Yes.

> In that case there's no need to send a v6, I can incorporate the fix myself.

Sure, Another line - printf "\n" would be great. Thanks :)

Firoz

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
