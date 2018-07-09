Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:46068 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752894AbeGIHHZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 03:07:25 -0400
MIME-Version: 1.0
References: <20180709044444.6397-1-abrodkin@synopsys.com> <20180709054842.GB7618@kroah.com>
In-Reply-To: <20180709054842.GB7618@kroah.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Jul 2018 09:07:13 +0200
Message-ID: <CAMuHMdVBBu6gho_JVQTiOHxVFHqX2MUxS_c-6-x50OEu4OqpRQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Linux-Arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, stable <stable@vger.kernel.org>
Message-ID: <20180709070713.Vpd_J9KT2ZUoJcsFDtYI73oeVlabnocHZBCPKfCDS-o@z>

On Mon, Jul 9, 2018 at 7:49 AM Greg KH <greg@kroah.com> wrote:
> On Mon, Jul 09, 2018 at 07:44:44AM +0300, Alexey Brodkin wrote:
> > Depending on ABI "long long" type of a particular 32-bit CPU
> > might be aligned by either word (32-bits) or double word (64-bits).

Or even 16-bit (on e.g. m68k).

> > --- a/drivers/base/devres.c
> > +++ b/drivers/base/devres.c
> > @@ -24,8 +24,12 @@ struct devres_node {
> >
> >  struct devres {
> >       struct devres_node              node;
> > -     /* -- 3 pointers */
> > -     unsigned long long              data[]; /* guarantee ull alignment */
> > +     /*
> > +      * Depending on ABI "long long" type of a particular 32-bit CPU
> > +      * might be aligned by either word (32-bits) or double word (64-bits).

or even 16-bit (on e.g. m68k).

> > +      * Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> > +      */
> > +     unsigned long long              data[] __aligned(sizeof(unsigned long long));
> >  };
>
> Does this change the padding today for any other arches?  If so, does
> the increased memory usage cause any noticable issues?

Yes it does. struct devres_node contains an odd number of pointers, so
there will be a hole between node and data on all 32-bit architectures.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
