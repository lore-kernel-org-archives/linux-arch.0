From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 33/60] microblaze_v4: includes SHM*, msgbuf
Date: Thu, 26 Jun 2008 17:18:17 +0200
Message-ID: <200806261718.18006.arnd@arndb.de>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz> <1214483429-32360-33-git-send-email-monstr@seznam.cz> <1214483429-32360-34-git-send-email-monstr@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:59917 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbYFZPSW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jun 2008 11:18:22 -0400
In-Reply-To: <1214483429-32360-34-git-send-email-monstr@seznam.cz>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com, Michal Simek <monstr@monstr.eu>

On Thursday 26 June 2008, monstr@seznam.cz wrote:
> =A0include/asm-microblaze/msgbuf.h =A0 | =A0 39 +++++++++++++++++++++=
+++++++
> =A0include/asm-microblaze/shmbuf.h =A0 | =A0 50 +++++++++++++++++++++=
++++++++++++++++
> =A0include/asm-microblaze/shmparam.h | =A0 14 ++++++++++
> =A03 files changed, 103 insertions(+), 0 deletions(-)
> =A0create mode 100644 include/asm-microblaze/msgbuf.h
> =A0create mode 100644 include/asm-microblaze/shmbuf.h
> =A0create mode 100644 include/asm-microblaze/shmparam.h
>=20

These files are ok, but IMHO they should be in asm-generic, since there
are already many identical copies.

While the implementation of these three, as well as ipcbuf.h and sembuf=
=2Eh
could be better optimized for endianess and word size differences, I ha=
ve
come to the conclusion that there is no point for them to really be
different, and uClibc expects this exact layout by default anyway.

	Arnd <><
