From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] io: Fix return type of _inb and _inl
Date: Mon, 27 Jul 2020 10:04:49 +0200
Message-ID: <CAK8P3a0-wPsVi-fXPW4Dghn30cumrzvLujp7usio50EHmCHM=g@mail.gmail.com>
References: <20200726031154.1012044-1-shorne@gmail.com> <CAHp75VciC+gqkCZ9voNKHU3hrtiOVzeWBu9_YEagpCGdTME2yg@mail.gmail.com>
 <20200726125325.GC80756@lianli.shorne-pla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:56915 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgG0IFI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 04:05:08 -0400
In-Reply-To: <20200726125325.GC80756@lianli.shorne-pla.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stafford Horne <shorne@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Wei Xu <xuwei5@hisilicon.com>, John Garry <john.garry@huawei.com>, Linux-Arch <linux-arch@vger.kernel.org>

On Sun, Jul 26, 2020 at 2:53 PM Stafford Horne <shorne@gmail.com> wrote:
>
> On Sun, Jul 26, 2020 at 12:00:37PM +0300, Andy Shevchenko wrote:
> > On Sun, Jul 26, 2020 at 6:14 AM Stafford Horne <shorne@gmail.com> wrote:
> > >
> > > The return type of functions _inb, _inw and _inl are all u16 which looks
> > > wrong.  This patch makes them u8, u16 and u32 respectively.
> > >
> > > The original commit text for these does not indicate that these should
> > > be all forced to u16.
> >
> > Is it in alight with all architectures? that support this interface natively?
> >
> > (Return value is arch-dependent AFAIU, so it might actually return
> > 16-bit for byte read, but I agree that this is weird for 32-bit value.
> > I think you have elaborate more in the commit message)
>
> Well, this is the generic io code,  at least these api's appear to not be different
> for each architecture.  The output read by the architecture dependant code i.e.
> __raw_readb() below is getting is placed into a u8.  So I think the output of
> the function will be u8.
>
> static inline u8 _inb(unsigned long addr)
> {
>         u8 val;
>
>         __io_pbr();
>         val = __raw_readb(PCI_IOBASE + addr);
>         __io_par(val);
>         return val;
> }
>
> I can expand the commit text, but I would like to get some comments from the
> original author to confirm if this is an issue.

I think your original version is fine, this was clearly just a typo and I've
applied your fix now and will forward it to Linus in the next few days,
giving John the chance to add his Ack or further comments.

Thanks a lot for spotting it and sending a fix.

      Arnd
