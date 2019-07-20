Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33460 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfGTK7x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Jul 2019 06:59:53 -0400
Received: by mail-qk1-f195.google.com with SMTP id r6so25229548qkc.0
        for <linux-arch@vger.kernel.org>; Sat, 20 Jul 2019 03:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de>
 <20190716170606.GA38406@archlinux-threadripper> <alpine.DEB.2.21.1907162059200.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907162135590.1767@nanos.tec.linutronix.de>
 <CAK7LNASBiaMX8ihnmhLGmYfHX=ZHZmVN91nxmFZe-OCaw6Px2w@mail.gmail.com>
 <alpine.DEB.2.21.1907170955250.1767@nanos.tec.linutronix.de>
 <CAHbf0-GyQzWcRg_BP2B5pVzEJoxSE_hX5xFypS--7Q5LSHxzWw@mail.gmail.com>
 <alpine.DEB.2.21.1907201133000.1782@nanos.tec.linutronix.de>
 <CAHbf0-FfD_tzRFfkYK=gWDOkB=+ecFuJPbZwPS3S3HJmDThPWw@mail.gmail.com> <alpine.DEB.2.21.1907201253360.1782@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907201253360.1782@nanos.tec.linutronix.de>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Sat, 20 Jul 2019 11:59:41 +0100
Message-ID: <CAHbf0-GZySHLPMsR7NcyqpxD0DwK1Y44=A0sgA=pFzRMe2fXtw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Fail if gold linker is detected
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Nathan Chancellor <natechancellor@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, linux-arch@vger.kernel.org
Message-ID: <20190720105941.fwMU-mYJhkD6-hPjZW0agO5KmnLWD6tjJ5W8Gcbg4cY@z>

On Sat, 20 Jul 2019 at 11:54, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, 20 Jul 2019, Mike Lothian wrote:
> > Here is my config
> >
> > https://github.com/FireBurn/KernelStuff/blob/9b7e96581598d50b266f9df258e7de764949147a/dot_config_tip
> >
>
> Builds perfectly fine.

Sorry top posted from my phone

Are you using gold? And which versions of GCC & binutils are you using?
