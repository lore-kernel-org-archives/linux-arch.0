From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 36/56] microblaze_v2: dma support
Date: Tue, 6 May 2008 17:36:16 +0200
Message-ID: <200805061736.18180.arnd@arndb.de>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <200805061324.06282.arnd@arndb.de> <48205B0D.70202@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:60066 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755992AbYEFPhB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 11:37:01 -0400
In-Reply-To: <48205B0D.70202@seznam.cz>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, John Williams <john.williams@petalogix.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca

On Tuesday 06 May 2008, Michal Simek wrote:
> here is proposed struct.
>=20
> struct scatterlist {
> =A0 =A0 =A0 dma_addr_t =A0 =A0 =A0=A0=A0dma_address;
> =A0 =A0 =A0 unsigned long=A0=A0=A0=A0=A0page_link;
> #ifdef CONFIG_DEBUG_SG
> =A0 =A0 =A0 unsigned long=A0=A0=A0=A0=A0sg_magic;
> #endif
> =A0 =A0 =A0 unsigned int =A0 =A0=A0=A0length;
> =A0 =A0 =A0 unsigned int =A0 =A0=A0=A0offset;
> };
>=20
> Is it OK now?

Everyone else has the sg_magic first, which makes sense for debugging.
Don't worry about it too much, just use the same code as avr32, h8300,
blackfin, fvr, mk68knommu, mn10300, sh, v850 and xtensa.

These are all the same, but I just saw that they also have

#define sg_dma_address(sg)      ((sg)->dma_address)
#define sg_dma_len(sg)          ((sg)->length)

which you probably want as well.

	Arnd <><
