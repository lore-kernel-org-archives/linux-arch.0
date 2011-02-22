Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:52181 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab1BVPTH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Feb 2011 10:19:07 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2 06/11] unicore32 core architecture: mm related: generic codes
Date: Tue, 22 Feb 2011 16:18:56 +0100
References: <02ed01cbcb48$3e3781a0$baa684e0$@mprc.pku.edu.cn> <201102171828.15482.arnd@arndb.de> <018a01cbd29b$1ff4c590$5fde50b0$@mprc.pku.edu.cn>
In-Reply-To: <018a01cbd29b$1ff4c590$5fde50b0$@mprc.pku.edu.cn>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201102221618.56779.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 'Greg KH' <greg@kroah.com>
Message-ID: <20110222151856.xG0_ylX6xnk6c83BaXY4-GztU8OhnfEsdVAPyerbyDs@z>

On Tuesday 22 February 2011, Guan Xuetao wrote:
> > > +#ifdef __io
> > > +void __iomem *ioport_map(unsigned long port, unsigned int nr)
> > > +{
> > > +       /* we map PC lagcy 64K IO port to PCI IO space 0x80030000 */
> > > +       return (void __iomem *) (unsigned long)
> > > +                       io_p2v((port & 0xffff) + PKUNITY_PCILIO_BASE);
> > > +}
> > 
> > Interestingly, this function looks completely correct, but I don't see
> > the definition for __io, so I suspect that the function is not actually
> > getting used.
> When I want to use pci device driver,  I will define __io and use ioport_map for drivers.
> It is obviously a trick.

Ok, I see.

> And with your patch for asm-generic/io.h, these codes could be removed.

You'd still need to define ioport_map, but the definition could simply
become

static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
{
	return PCIO_BASE + port;
}

	ARnd
