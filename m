From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 5/6] parisc: wire up rseq system call
Date: Mon, 8 Oct 2018 11:11:44 +0200
Message-ID: <CAK8P3a2GpVjg+re19V5wkJe9MCfox7Dgr6Q54KcP+WQMC5Y2Qw@mail.gmail.com>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-6-git-send-email-firoz.khan@linaro.org> <feb53cb6-e20b-42c3-5b53-8b310c772545@gmx.de>
 <CALxhOnjjWQRi6G4N-o+GZzkqc_zAYNT3RaN+P6bdEXeE=uY6-g@mail.gmail.com>
 <22745bed-baf6-4f08-6801-3529021cf33e@gmx.de> <CALxhOniZQEMCOY-B1F5=MCdpCYMbeGQAJTtPXhVyJ5TxtOEA5A@mail.gmail.com>
 <CAMuHMdWOKmnn18yS_dHNjgT8rrVsUc3ipGpMTQbyEBujHuVE8w@mail.gmail.com>
 <CALxhOnjEBFF8cnwm6MqNwZjpJbA8y_g8kQCrjMiALftcYJmjMQ@mail.gmail.com> <CAMuHMdWPx_ZRt-60K9_4oaX0pGESb8WUE6t73Y5DAUF-t=Z5EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWPx_ZRt-60K9_4oaX0pGESb8WUE6t73Y5DAUF-t=Z5EQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Firoz Khan <firoz.khan@linaro.org>, Helge Deller <deller@gmx.de>, Parisc List <linux-parisc@vger.kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 8, 2018 at 10:58 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Oct 8, 2018 at 10:55 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Mon, 8 Oct 2018 at 13:53, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Mon, Oct 8, 2018 at 8:49 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > > If the warning is due to a not-yet-implemented feature, IMHO it should not be
> > > silenced, as that would give the false impression that the feature is
> > > present and
> > > implemented.
> >
> > Helge had done some implementation for rseq but not tested. So we
> > either add an IGNORE
> > entry or leave the warning as it is.
>
> Personally, I prefer keeping the warning, for the above reason.

Agreed, there is no need to patch this now if Helge is already working
on the correct fix. Same for the other architectures. If there are architectures
that have multiple missing syscalls, we could add a line with a comment
for rseq but not actually define it, like

 348     common  pwritev2                     sys_pwritev2
       compat_sys_pwritev2
 349     common  statx                           sys_statx
+350    common  io_pgetevents            sys_io_pgetevents
  compat_sys_io_pgetevents
+# rseq requires an arch specific implementation
+# 351    common  rseq                          sys_rseq
         compat_sys_rseq */
+352     common  open_tree                 sys_open_tree
+353     common  move_mount             sys_move_mount
+354     common  fsopen                       sys_fsopen

      Arnd
