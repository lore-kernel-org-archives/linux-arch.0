Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36390 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeJSP1L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Oct 2018 11:27:11 -0400
MIME-Version: 1.0
References: <20181017080201.10866-1-hch@lst.de> <CAMuHMdWMtxxu8iivcnT=uWTMHsp=iSq_QzXqDWQut5OHwTU8Sg@mail.gmail.com>
 <20181019070001.GA30556@lst.de> <CAMuHMdXLug_T4onn23JormmYZXDWVnEFYaoMzA90bpGFvk6Eow@mail.gmail.com>
 <20181019071057.GA31656@lst.de>
In-Reply-To: <20181019071057.GA31656@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Oct 2018 09:22:08 +0200
Message-ID: <CAMuHMdXqPNOwcjWVmH08YSfZopc0pWLUj-r0s6g=q0oUdqWhWw@mail.gmail.com>
Subject: Re: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/ v2
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Matt Porter <mporter@kernel.crashing.org>, Alex Bounine <alex.bou9@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20181019072208.nV30ZHOo-H0xz3JM5BbjceYFIKVrJ6jL1pcs8apUN2o@z>

Hi Christoph,

On Fri, Oct 19, 2018 at 9:10 AM Christoph Hellwig <hch@lst.de> wrote:
> On Fri, Oct 19, 2018 at 09:07:51AM +0200, Geert Uytterhoeven wrote:
> > Without this:
> >   - It's hard to visually match your untagged cover letter with the
> > actual patches,
> >   - Your individual patches lack the version info, so people cannot see which
> >     version review comments in an email reply apply to.
>
> All of that is trivially solved by mail threading.

You forgot to answer this question:

| Can you please clarify what exactly that would mess up?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
