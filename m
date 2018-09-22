Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f67.google.com ([209.85.161.67]:47082 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbeIVRa1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 22 Sep 2018 13:30:27 -0400
Received: by mail-yw1-f67.google.com with SMTP id j131-v6so6210006ywc.13
        for <linux-arch@vger.kernel.org>; Sat, 22 Sep 2018 04:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
 <1537455973-12468-2-git-send-email-firoz.khan@linaro.org> <20180921054850.GA13343@frolo.macqel>
In-Reply-To: <20180921054850.GA13343@frolo.macqel>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Sat, 22 Sep 2018 17:06:59 +0530
Message-ID: <CALxhOnhWMf3Zq73nMYkv4JwQUWVKiD6YepcVOFhL8AC5fggvdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] m68k: Rename system call table file name
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: phdm@macq.eu
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20180922113659.eZebW4rCOPU0q8IScrvMzuuER9eL7GjQOpF8efXyIN8@z>

Hi Phillippe,

On Fri, 21 Sep 2018 at 11:18, Philippe De Muyter <phdm@macq.eu> wrote:
>
> On Thu, Sep 20, 2018 at 08:36:09PM +0530, Firoz Khan wrote:
> > The system call table entries are present in syscalltable.S. One of
> > the patch in this patch series will auto-generate the system call
> > table entries using the system call table generation script and
> > which'll replace the existig table file.
> >
> > In order to come up with a common naming convention across all
> > architecture, we need to change the file name to syscall_table.S.
>
> That file was probably called that way to be able to distinguish it
> from syscalltable.s and syscalltable.o in a file system with a 14
> characters limit in file names (in sysV unix systems).
>
> > This change will unify the implementation across all architecture.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > ---
> >  arch/m68k/kernel/Makefile        |   2 +-
> >  arch/m68k/kernel/syscall_table.S | 403 +++++++++++++++++++++++++++++++++++++++
> >  arch/m68k/kernel/syscalltable.S  | 403 ---------------------------------------
>
> You should generate your patch with the '-M' or '--find-renames' option.

Sure. Thanks!
Firoz

>
> Philippe
>
> --
> Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
