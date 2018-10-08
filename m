From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v3 5/6] parisc: wire up rseq system call
Date: Mon, 8 Oct 2018 14:25:16 +0530
Message-ID: <CALxhOnjEBFF8cnwm6MqNwZjpJbA8y_g8kQCrjMiALftcYJmjMQ@mail.gmail.com>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-6-git-send-email-firoz.khan@linaro.org> <feb53cb6-e20b-42c3-5b53-8b310c772545@gmx.de>
 <CALxhOnjjWQRi6G4N-o+GZzkqc_zAYNT3RaN+P6bdEXeE=uY6-g@mail.gmail.com>
 <22745bed-baf6-4f08-6801-3529021cf33e@gmx.de> <CALxhOniZQEMCOY-B1F5=MCdpCYMbeGQAJTtPXhVyJ5TxtOEA5A@mail.gmail.com>
 <CAMuHMdWOKmnn18yS_dHNjgT8rrVsUc3ipGpMTQbyEBujHuVE8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWOKmnn18yS_dHNjgT8rrVsUc3ipGpMTQbyEBujHuVE8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Geert,

On Mon, 8 Oct 2018 at 13:53, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Firoz,
>
> On Mon, Oct 8, 2018 at 8:49 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Mon, 8 Oct 2018 at 11:36, Helge Deller <deller@gmx.de> wrote:
> > > On 08.10.2018 07:52, Firoz Khan wrote:
> > > > On Mon, 8 Oct 2018 at 11:11, Helge Deller <deller@gmx.de> wrote:
> > > >> On 08.10.2018 07:16, Firoz Khan wrote:
> > > >>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > > >>> ---
> > > >>>  arch/parisc/kernel/syscalls/syscall.tbl | 3 ++-
> > > >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >>>
> > > >>> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> > > >>> index 4e85293..4334bb7 100644
> > > >>> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> > > >>> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> > > >>> @@ -349,4 +349,5 @@
> > > >>>  347     common  preadv2                         sys_preadv2                     compat_sys_preadv2
> > > >>>  348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
> > > >>>  349     common  statx                           sys_statx
> > > >>> -350  common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> > > >>> \ No newline at end of file
> > > >>> +350  common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> > > >>> +351  common  rseq                            sys_rseq                        compat_sys_rseq
> > > >>
> > > >> You can't add the rseq syscall for parisc yet.
> > > >> It needs additional code in the kernel for parisc which hasn't been tested yet.
> > > >> See my initial untested patch at https://patchwork.kernel.org/patch/10495209/
> > > >
> > > > Thanks for your update!
> > > >
> > > > When I compiled the kernel I got below warnings.
> > > >
> > > > <stdin>:696:2: warning: #warning syscall nfsservctl not implemented [-Wcpp]
> > > > <stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]
> > > >
> > > > I added an IGNORE entry nfsservctl in script/checksyscalls.sh because this
> > > > syscall is gone. But we definitely have to keep rseq entry on parisc
> > > > architecture.
> > >
> > > I prefer to keep the warning for rseq for now.
> >
> > I'm fine with this.
> >
> > > It reminds me that we still may want the rseq syscall.
> > > If the warning is a problem, you may simply add the __IGNORE_rseq define.
> >
> > But I still feel to keep an IGNORE entry, so once you test your patch; we can
> > remove IGNORE entry and update the syscall.tbl.
>
> If the warning is bogus (e.g. obsolete syscall), an IGNORE entry
> should be added.

nfsservctl  look like an obsolete one, so I added an IGNORE entry in
script/checksyscalls.h

> If the warning is due to a not-yet-implemented feature, IMHO it should not be
> silenced, as that would give the false impression that the feature is
> present and
> implemented.

Helge had done some implementation for rseq but not tested. So we
either add an IGNORE
entry or leave the warning as it is.

Thanks
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
