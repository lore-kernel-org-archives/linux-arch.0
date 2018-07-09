Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:37641 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeGIHxI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 03:53:08 -0400
MIME-Version: 1.0
References: <20180709044444.6397-1-abrodkin@synopsys.com> <20180709054842.GB7618@kroah.com>
 <CAMuHMdVBBu6gho_JVQTiOHxVFHqX2MUxS_c-6-x50OEu4OqpRQ@mail.gmail.com> <71dfb71de86ebe365897b2069bec0cb40b376928.camel@synopsys.com>
In-Reply-To: <71dfb71de86ebe365897b2069bec0cb40b376928.camel@synopsys.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Jul 2018 09:52:56 +0200
Message-ID: <CAMuHMdULgdLsETpZ9+RC6d2ZoARPs72Fn=SRboM-8Xm7t1Qd2g@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, stable <stable@vger.kernel.org>, Greg KH <greg@kroah.com>, arcml <linux-snps-arc@lists.infradead.org>
Message-ID: <20180709075256.g-M4n3ZAMY0OOZIio0Gp-kcwKv4SJt9lDfklIN_DUFc@z>

Hi Alexey,

On Mon, Jul 9, 2018 at 9:22 AM Alexey Brodkin
<Alexey.Brodkin@synopsys.com> wrote:
> On Mon, 2018-07-09 at 09:07 +0200, Geert Uytterhoeven wrote:
> > On Mon, Jul 9, 2018 at 7:49 AM Greg KH <greg@kroah.com> wrote:
> > > On Mon, Jul 09, 2018 at 07:44:44AM +0300, Alexey Brodkin wrote:
> > > > Depending on ABI "long long" type of a particular 32-bit CPU
> > > > might be aligned by either word (32-bits) or double word (64-bits).
> >
> > Or even 16-bit (on e.g. m68k).
>
> Indeed, thanks for the note!
> Will add this in my v3.

Note that in this particular case, the field will probably always be
aligned to 4 bytes,
as the struct will be allocated using *alloc().

> For ARC I'd like this fix to be back-ported starting
> from v4.8 where we added support of "native" atomic64_t, see commit
> ce6365270ecd (" ARCv2: Implement atomic64 based on LLOCKD/SCONDD instructions").
>
> What about m68k, do you have any preference of earliest kernel version
> where this fix might be useful?

Given m68k is 32-bit, it will access atomic64_t variables while
holding a spinlock,
so it should still be safe without this change.

Not to mention no one will try etnaviv on m68k ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
