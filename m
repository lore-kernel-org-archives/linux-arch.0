Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-06.nifty.com ([210.131.2.91]:39005 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeKWNT1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Nov 2018 08:19:27 -0500
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de> <CAK7LNARL8yZexzXiEaT77U_rdwhr5uENXbSaSTGHU33HbSmW6g@mail.gmail.com>
In-Reply-To: <CAK7LNARL8yZexzXiEaT77U_rdwhr5uENXbSaSTGHU33HbSmW6g@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Nov 2018 11:36:07 +0900
Message-ID: <CAK7LNARA-wbDDh_T2HghAUGizY-bF28O_8cjLmp9DMHaoxZPNw@mail.gmail.com>
Subject: Re: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/ v4
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: mporter@kernel.crashing.org, Alex Bounine <alex.bou9@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pci@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-alpha@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>
Message-ID: <20181123023607.g-55JNVcfsb6O8JqZEZN1oyq6gflQO9PIuRquQdopQ4@z>

On Fri, Nov 23, 2018 at 11:32 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Christoph,
>
>
> On Fri, Nov 16, 2018 at 4:08 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Hi all,
> >
> > currently every architecture that wants to provide on of the common
> > periphal busses needs to add some boilerplate code and include the
> > right Kconfig files.   This series instead just selects the presence
> > (when needed) and then handles everything in the bus-specific
> > Kconfig file under drivers/.
>
>
> Thanks for this work!
>
>
> I applied this series, and it is available at
>
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
> kconfig2


BTW, if you find questionable parts,
please let me know.

We still have plenty of time by the next MW.

Thanks.



-- 
Best Regards
Masahiro Yamada
