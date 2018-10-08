From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 5/6] parisc: wire up rseq system call
Date: Mon, 8 Oct 2018 10:58:33 +0200
Message-ID: <CAMuHMdWPx_ZRt-60K9_4oaX0pGESb8WUE6t73Y5DAUF-t=Z5EQ@mail.gmail.com>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-6-git-send-email-firoz.khan@linaro.org> <feb53cb6-e20b-42c3-5b53-8b310c772545@gmx.de>
 <CALxhOnjjWQRi6G4N-o+GZzkqc_zAYNT3RaN+P6bdEXeE=uY6-g@mail.gmail.com>
 <22745bed-baf6-4f08-6801-3529021cf33e@gmx.de> <CALxhOniZQEMCOY-B1F5=MCdpCYMbeGQAJTtPXhVyJ5TxtOEA5A@mail.gmail.com>
 <CAMuHMdWOKmnn18yS_dHNjgT8rrVsUc3ipGpMTQbyEBujHuVE8w@mail.gmail.com> <CALxhOnjEBFF8cnwm6MqNwZjpJbA8y_g8kQCrjMiALftcYJmjMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALxhOnjEBFF8cnwm6MqNwZjpJbA8y_g8kQCrjMiALftcYJmjMQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: firoz.khan@linaro.org
Cc: Helge Deller <deller@gmx.de>, Parisc List <linux-parisc@vger.kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

Hi Firoz,

On Mon, Oct 8, 2018 at 10:55 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Mon, 8 Oct 2018 at 13:53, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Oct 8, 2018 at 8:49 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > > On Mon, 8 Oct 2018 at 11:36, Helge Deller <deller@gmx.de> wrote:
> > > > On 08.10.2018 07:52, Firoz Khan wrote:
> > > > > <stdin>:696:2: warning: #warning syscall nfsservctl not implemented [-Wcpp]
> > > > > <stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]
> > > > >
> > > > > I added an IGNORE entry nfsservctl in script/checksyscalls.sh because this
> > > > > syscall is gone. But we definitely have to keep rseq entry on parisc
> > > > > architecture.
> > > >
> > > > I prefer to keep the warning for rseq for now.
> > >
> > > I'm fine with this.
> > >
> > > > It reminds me that we still may want the rseq syscall.
> > > > If the warning is a problem, you may simply add the __IGNORE_rseq define.
> > >
> > > But I still feel to keep an IGNORE entry, so once you test your patch; we can
> > > remove IGNORE entry and update the syscall.tbl.
> >
> > If the warning is bogus (e.g. obsolete syscall), an IGNORE entry
> > should be added.
>
> nfsservctl  look like an obsolete one, so I added an IGNORE entry in
> script/checksyscalls.h

Yes it is.

> > If the warning is due to a not-yet-implemented feature, IMHO it should not be
> > silenced, as that would give the false impression that the feature is
> > present and
> > implemented.
>
> Helge had done some implementation for rseq but not tested. So we
> either add an IGNORE
> entry or leave the warning as it is.

Personally, I prefer keeping the warning, for the above reason.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
