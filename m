From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 17/56] microblaze_v2: checksum support
Date: Sun, 4 May 2008 21:59:53 +0200
Message-ID: <200805042159.55077.arnd@arndb.de>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <625ef466cf121d655539eedc919dd39166087e0c.1209897266.git.monstr@monstr.eu> <b5067a1846075ddd1035966ea1edc908579e2e88.1209897266.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:65378 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202AbYEDUAK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 16:00:10 -0400
In-Reply-To: <b5067a1846075ddd1035966ea1edc908579e2e88.1209897266.git.monstr@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

On Sunday 04 May 2008, monstr@seznam.cz wrote:
> + *
> + * INET=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0An implementa=
tion of the TCP/IP protocol suite for the LINUX
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0operating system. =A0INET i=
s implemented using the =A0BSD Socket
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0interface as the means of c=
ommunication with the user level.
> + *
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0IP/TCP/UDP checksumming rou=
tines
> + *
> + * Authors:=A0=A0=A0=A0Jorge Cwik, <jorge@laser.satlink.net>
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0Arnt Gulbrandsen, <agulbra@=
nvg.unit.no>
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0Tom May, <ftom@netcom.com>
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0Andreas Schwab, <schwab@iss=
an.informatik.uni-dortmund.de>
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0Lots of code moved from tcp=
=2Ec and ip.c; see those files
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0for more names.

This is a pretty generic implementation, and you copied it from another
architecture. How about moving it from arch/microblaze/lib/ to lib/?
I'd suggest building it conditionally under CONFIG_GENERIC_CSUM,
which you def_bool in your architecture Kconfig.

	Arnd <><
