Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35004 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbfGTKNk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Jul 2019 06:13:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so33688400qto.2
        for <linux-arch@vger.kernel.org>; Sat, 20 Jul 2019 03:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de>
 <20190716170606.GA38406@archlinux-threadripper> <alpine.DEB.2.21.1907162059200.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907162135590.1767@nanos.tec.linutronix.de>
 <CAK7LNASBiaMX8ihnmhLGmYfHX=ZHZmVN91nxmFZe-OCaw6Px2w@mail.gmail.com>
 <alpine.DEB.2.21.1907170955250.1767@nanos.tec.linutronix.de>
 <CAHbf0-GyQzWcRg_BP2B5pVzEJoxSE_hX5xFypS--7Q5LSHxzWw@mail.gmail.com> <alpine.DEB.2.21.1907201133000.1782@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907201133000.1782@nanos.tec.linutronix.de>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Sat, 20 Jul 2019 11:13:27 +0100
Message-ID: <CAHbf0-FfD_tzRFfkYK=gWDOkB=+ecFuJPbZwPS3S3HJmDThPWw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Fail if gold linker is detected
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Nathan Chancellor <natechancellor@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, linux-arch@vger.kernel.org
Message-ID: <20190720101327.cCMP1SZ-uwK3rQcFxN3uhW5hZPRxRnigJCypy0q4WJQ@z>

On Sat, 20 Jul 2019 at 10:34, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, 20 Jul 2019, Mike Lothian wrote:
> > On Wed, 17 Jul 2019 at 08:57, Thomas Gleixner <tglx@linutronix.de> wrote:
> > I've done a bit more digging, I had a second machine that was building
> > Linus's tree just fine with ld.gold
> >
> > I tried forcing ld.bfd on the problem machine and got this:
> >
> > ld.bfd: arch/x86/boot/compressed/head_64.o: warning: relocation in
> > read-only section `.head.text'
> > ld.bfd: warning: creating a DT_TEXTREL in object
> >
> > I had a look at the differences in the kernel configs and noticed this:
> >
> > CONFIG_RANDOMIZE_BASE=y
> > CONFIG_X86_NEED_RELOCS=y
> > CONFIG_PHYSICAL_ALIGN=0x1000000
> > CONFIG_DYNAMIC_MEMORY_LAYOUT=y
> > CONFIG_RANDOMIZE_MEMORY=y
> > CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0
> >
> > Unsetting CONFIG_RANDOMIZE_BASE=y gets things working for me with ld.gold again
>
> Can you please provide the full config? I have the above set here and it
> builds just fine.
>
> > In light of this - can we drop this patch?
>
> No. I'm not going to deal with unsupported tools.
>
> Thanks,
>
>         tglx

Hi

Here is my config

https://github.com/FireBurn/KernelStuff/blob/9b7e96581598d50b266f9df258e7de764949147a/dot_config_tip

Regards

Mike
