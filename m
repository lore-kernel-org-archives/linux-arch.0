From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 38/56] microblaze_v2: atomic.h bitops.h byteorder.h
Date: Sun, 4 May 2008 23:58:13 +0200
Message-ID: <200805042358.15131.arnd@arndb.de>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <4e20213f5f296268a24955df8c951f7fba279816.1209897266.git.monstr@monstr.eu> <49eccf3408b90a5ebb42635493bbeef3b584acb9.1209897266.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:51098 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbYEDV6h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 17:58:37 -0400
In-Reply-To: <49eccf3408b90a5ebb42635493bbeef3b584acb9.1209897266.git.monstr@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

On Sunday 04 May 2008, monstr@seznam.cz wrote:
> =A0include/asm-microblaze/atomic.h =A0 =A0| =A0108 ++++++++++++++++++=
++++++++++++++++++

It would be cool if you could introduce this file as=20
asm-generic/atomic-irqdisable.h or similar (can someone please
think of a better name?).

It looks like it could be shared with blackfin, h8300, m32r, m68k,
mn10300 and v850. Not important though, as this is not part of the
ABI.

	Arnd <><
