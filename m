From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 52/60] microblaze_v4: fcntl.h sockios.h ucontext.h
Date: Thu, 26 Jun 2008 17:43:09 +0200
Message-ID: <200806261743.10441.arnd@arndb.de>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz> <1214483429-32360-52-git-send-email-monstr@seznam.cz> <1214483429-32360-53-git-send-email-monstr@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:55486 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbYFZPnN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jun 2008 11:43:13 -0400
In-Reply-To: <1214483429-32360-53-git-send-email-monstr@seznam.cz>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com, Michal Simek <monstr@monstr.eu>

On Thursday 26 June 2008, monstr@seznam.cz wrote:
> =A0include/asm-generic/sockios.h =A0 =A0 | =A0 23 +++++++++++++++++++=
++++
> =A0include/asm-generic/ucontext.h =A0 =A0| =A0 24 +++++++++++++++++++=
+++++
> =A0include/asm-microblaze/fcntl.h =A0 =A0| =A0 =A01 +
> =A0include/asm-microblaze/sockios.h =A0| =A0 23 +++++++++++++++++++++=
++
> =A0include/asm-microblaze/ucontext.h | =A0 =A01 +

The grouping of files seems rather arbitrary here. What would be really
good here is if you had all the new asm-generic files as separate patch=
es,
i.e. as a series adding them independent of the microblaze patches so
that the other arch maintainers could look at them and start using
the same files, and then add all your trivial wrappers in a single
patch.

Also, the sockios file here looks like it should be in asm-generic.

The contents of the files in this patch all look good, they are
identical to the majority of the other architectures.

	Arnd <><
