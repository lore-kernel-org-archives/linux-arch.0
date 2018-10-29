From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v4 0/4] m68k: system call table generation support
Date: Mon, 29 Oct 2018 09:08:00 +0530
Message-ID: <CALxhOng9DaF9ZkUGQW9=tzaPmoiG9NzhhaWXqPDr7RwUTf0c0A@mail.gmail.com>
References: <1540530377-3509-1-git-send-email-firoz.khan@linaro.org> <CAMuHMdXPR7WgPe5nPh3Lcc6FDxTNDYyOmV1oKU=BLcS2H7MPgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXPR7WgPe5nPh3Lcc6FDxTNDYyOmV1oKU=BLcS2H7MPgA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Geert,

On Sat, 27 Oct 2018 at 20:17, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Firoz,
>
> On Fri, Oct 26, 2018 at 7:06 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > The purpose of this patch series is, we can easily add/modify/delete
> > system call table support by changing entry in syscall.tbl file
> > instead of manually changing many files. The other goal is to unify
> > the system call table generation support implementation across all
> > the architectures.
> >
> > The system call tables are in different format in all architecture.
> > It will be difficult to manually add, modify or delete the system
> > calls in the respective files manually. To make it easy by keeping
> > a script and which'll generate uapi header file and syscall table
> > file.
> >
> > syscall.tbl contains the list of available system calls along with
> > system call number and corresponding entry point. Add a new system
> > call in this architecture will be possible by adding new entry in
> > the syscall.tbl file.
> >
> > Adding a new table entry consisting of:
> >         - System call number.
> >         - ABI.
> >         - System call name.
> >         - Entry point name.
> >
> > ARM, s390 and x86 architecuture does exist the similar support. I
> > leverage their implementation to come up with a generic solution.
> >
> > I have done the same support for work for alpha, ia64, microblaze,
> > mips, parisc, powerpc, sh, sparc, and xtensa. Below mentioned git
> > repository contains more details.
> > Git repo:- https://github.com/frzkhn/system_call_table_generator/
> >
> > Finally, this is the ground work to solve the Y2038 issue. We need
> > to add two dozen of system calls to solve Y2038 issue. So this patch
> > series will help to add new system calls easily by adding new entry
> > in the syscall.tbl.
>
> Thanks for the update!
>
> Can you please tell the audience what has been changed in v4?

Sure.
- I added the comments in syscall.tbl and solved mixed (space and tab)
  indentation.
- Modified the scripts (syscalltbl.sh and syscallhdr.sh) as per the feedback
  provided by Arnd, Finn Thain, Eugene Syromiatnikov and Rolf Eike Beer.

Eg:-
 - echo options are not portable; changed to printf
 - "let" is a bash extension; changed posix-conformant expression.
 - Finally I optimized the script and solved mixed indentation.

>
> When posting a new version of a patch or patch series, it is a good
> idea to include a changelog in the cover letter and/or patches.

Sure, will do!

Thanks
Firoz

>
> Thanks!
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
