From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 36/56] microblaze_v2: dma support
Date: Tue, 6 May 2008 13:24:04 +0200
Message-ID: <200805061324.06282.arnd@arndb.de>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <48202AB6.4010201@seznam.cz> <Pine.LNX.4.64.0805061317120.10091@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60464 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbYEFLZA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 07:25:00 -0400
In-Reply-To: <Pine.LNX.4.64.0805061317120.10091@anakin>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michal Simek <monstr@seznam.cz>, John Williams <john.williams@petalogix.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

On Tuesday 06 May 2008, Geert Uytterhoeven wrote:
> > struct scatterlist {
> > =A0=A0=A0=A0=A0=A0unsigned long page_link;
> > =A0=A0=A0=A0=A0=A0unsigned int=A0=A0=A0=A0offset;
> > =A0=A0=A0=A0=A0=A0unsigned int=A0=A0=A0=A0length;
> > =A0=A0=A0=A0=A0=A0dma_addr_t=A0=A0=A0=A0=A0=A0dma_address;
> > };
>=20
> If unsigned long is 32-bit but dma_addr_t is 64-bit, there may be a g=
ap
> between length and dma_address.
>=20

But moving dma_address to the front only has the effect to create impli=
cit
padding at the end of struct scatterlist, so you don't gain anything
either way.

It's only an internal definition that can be changed at any time withou=
t
breaking applications, so I wouldn't worry about it, and better leave
it identical to the other architectures.

The one thing that should indeed be changed is the addition of
'unsigned long sg_magic' that is needed for CONFIG_DEBUG_SG.

	Arnd <><
