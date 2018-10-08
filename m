Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37664 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeJHN7C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Oct 2018 09:59:02 -0400
Received: by mail-yw1-f68.google.com with SMTP id y14-v6so7644442ywa.4
        for <linux-arch@vger.kernel.org>; Sun, 07 Oct 2018 23:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-6-git-send-email-firoz.khan@linaro.org> <feb53cb6-e20b-42c3-5b53-8b310c772545@gmx.de>
 <CALxhOnjjWQRi6G4N-o+GZzkqc_zAYNT3RaN+P6bdEXeE=uY6-g@mail.gmail.com> <22745bed-baf6-4f08-6801-3529021cf33e@gmx.de>
In-Reply-To: <22745bed-baf6-4f08-6801-3529021cf33e@gmx.de>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Mon, 8 Oct 2018 12:18:39 +0530
Message-ID: <CALxhOniZQEMCOY-B1F5=MCdpCYMbeGQAJTtPXhVyJ5TxtOEA5A@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] parisc: wire up rseq system call
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181008064839.LN1cqQ1lRXxwjWYd4qT0RLS-bSVCUf2N6ymDhXq6Ogs@z>

Hi Helge,

On Mon, 8 Oct 2018 at 11:36, Helge Deller <deller@gmx.de> wrote:
>
> On 08.10.2018 07:52, Firoz Khan wrote:
> > Hi Helge,
> >
> > On Mon, 8 Oct 2018 at 11:11, Helge Deller <deller@gmx.de> wrote:
> >>
> >> On 08.10.2018 07:16, Firoz Khan wrote:
> >>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> >>> ---
> >>>  arch/parisc/kernel/syscalls/syscall.tbl | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> >>> index 4e85293..4334bb7 100644
> >>> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> >>> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> >>> @@ -349,4 +349,5 @@
> >>>  347     common  preadv2                         sys_preadv2                     compat_sys_preadv2
> >>>  348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
> >>>  349     common  statx                           sys_statx
> >>> -350  common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> >>> \ No newline at end of file
> >>> +350  common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> >>> +351  common  rseq                            sys_rseq                        compat_sys_rseq
> >>
> >> You can't add the rseq syscall for parisc yet.
> >> It needs additional code in the kernel for parisc which hasn't been tested yet.
> >> See my initial untested patch at https://patchwork.kernel.org/patch/10495209/
> >
> > Thanks for your update!
> >
> > When I compiled the kernel I got below warnings.
> >
> > <stdin>:696:2: warning: #warning syscall nfsservctl not implemented [-Wcpp]
> > <stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]
> >
> > I added an IGNORE entry nfsservctl in script/checksyscalls.sh because this
> > syscall is gone. But we definitely have to keep rseq entry on parisc
> > architecture.
>
> I prefer to keep the warning for rseq for now.

I'm fine with this.

> It reminds me that we still may want the rseq syscall.
> If the warning is a problem, you may simply add the __IGNORE_rseq define.

But I still feel to keep an IGNORE entry, so once you test your patch; we can
remove IGNORE entry and update the syscall.tbl.

I would like you to take the call here :)

Thanks
Firoz

>
> > I can ignore this patch currently as your patch not yet tested.
> >
> > FYI, I have merged the system call table files based on our previous
> > discussions.
> > Please comment on that.
>
> I'll do after testing.
>
> Thanks!
> Helge
>
> > I would appreciate if you can perform a boot test without this patch
> > on the actual
> > platform.
> >
> > Firoz
> >
> >>
> >> Helge
>
