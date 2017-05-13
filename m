From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 22:32:31 +0200
Message-ID: <CAMuHMdWOFci-VY6nAdgmRs+U92aoAdNakHzBNC2NBEY_W7uX6Q@mail.gmail.com>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk> <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk> <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
 <20170513170056.GX390@ZenIV.linux.org.uk> <CA+55aFwD+qC7MqSJVt4q91YEJ7CSzAZazWAJ-NpSz=B1k95AuA@mail.gmail.com>
 <20170513180413.GZ390@ZenIV.linux.org.uk> <CA+55aFw8RHphGi7kAZdot_PikJGaB=FthHn8Q=1EuCVz=0gd_g@mail.gmail.com>
 <20170513195659.GE390@ZenIV.linux.org.uk> <20170513200816.GF390@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36316 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbdEMUcd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 16:32:33 -0400
In-Reply-To: <20170513200816.GF390@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

Hi Al,

On Sat, May 13, 2017 at 10:08 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sat, May 13, 2017 at 08:56:59PM +0100, Al Viro wrote:
>
>> FWIW, just this cycle (this one I remembered off-hand, there might be
>> more):
>
> And looking through my queue (will be pushed to -next as soon as -rc1 goes
> out):
>
> commit 87fb4c8c103a4cdf17fead4aba58e96940a19a09
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Thu Apr 20 15:47:34 2017 -0400
>
>     spidev: quit messing with access_ok()
>
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index 9e2e099baf8c..8dd22de5e3b5 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c

You better run that one through linux-spi, to avoid conflicts, cfr.
https://patchwork.kernel.org/patch/9714993/

Gr{oetje,eeting}s,

                        Geert
