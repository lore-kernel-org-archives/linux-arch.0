Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-01.nifty.com ([210.131.2.80]:32304 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJOOXJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2018 10:23:09 -0400
MIME-Version: 1.0
References: <20181013151016.31674-1-hch@lst.de>
In-Reply-To: <20181013151016.31674-1-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 15 Oct 2018 15:38:18 +0900
Message-ID: <CAK7LNAQ3SNStaA6-tOWhm0QHWpNczO07x9T2F7gMcusduMS7GA@mail.gmail.com>
Subject: Re: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: mporter@kernel.crashing.org, alex.bou9@gmail.com, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-pci@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20181015063818.dJ-DFzWXNJS8kNXU0JLhiSAywmA17_5wFcSWog11l34@z>

On Sun, Oct 14, 2018 at 12:10 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> currently every architecture that wants to provide on of the common
> periphal busses needs to add some boilerplate code and include the
> right Kconfig files.   This series instead just selects the presence
> (when needed) and then handles everything in the bus-specific
> Kconfig file under drivers/.
>

Thanks for great work again.

However, I suspect some breakages
(not testing yet, just quick review by my eyes.)

I left some comments in individual patches.



--
Best Regards
Masahiro Yamada
