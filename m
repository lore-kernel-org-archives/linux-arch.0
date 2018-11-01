Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42421 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbeKAOuC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Nov 2018 10:50:02 -0400
Date: Thu, 1 Nov 2018 06:48:31 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/9] PCI: consolidate PCI config entry in drivers/pci
Message-ID: <20181101054831.GA4589@lst.de>
References: <20181019120952.32763-1-hch@lst.de> <20181019120952.32763-7-hch@lst.de> <20181019122228.GJ30658@n2100.armlinux.org.uk> <CAK7LNATZ8LagrTrTae_QCQbSuTW7_y6sDrdTHfTyONPrsYDs4A@mail.gmail.com> <CAK7LNASUArREw1AWUzcOoQCe5=4jyifbs+x2CdCK+qXJ+woAdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASUArREw1AWUzcOoQCe5=4jyifbs+x2CdCK+qXJ+woAdw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-pci@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Alex Bounine <alex.bou9@gmail.com>, mporter@kernel.crashing.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Russell King <linux@armlinux.org.uk>
Message-ID: <20181101054831.B4tvT4TWMp3KYkaEWubYAv4T0wGo1S7PvqPbKyWKzVI@z>

On Thu, Nov 01, 2018 at 01:05:26AM +0900, Masahiro Yamada wrote:
> > How about letting CONFIG_ARM to select HAVE_PCI ?
> >
> 
> 
> I applied 1/9, 3/9, 4/9, 5/9.
> (I think 2/9 should be squashed to 9/9)
> 
> As Russell pointed out, we need to avoid
> the unmet dependency.

Yes, I think the HAVE_PCI is probably the nicest way, but we'll
need to wait what Russell as the maintainer wants.

> Are you planning to send
> the updated version for 6/9 through - 9/9 ?
> 
> If so, could you please rebase 6/9
> so that it is cleanly applicable ?

Will do once I find some time after rc1.
