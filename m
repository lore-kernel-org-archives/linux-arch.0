From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 46/56] microblaze_v2: headers files entry.h current.h mman.h registers.h sembuf.h
Date: Mon, 5 May 2008 11:54:27 +0200
Message-ID: <200805051154.28761.arnd@arndb.de>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <8e1d421649250f7a3f638cd552bc46e5f5845890.1209897267.git.monstr@monstr.eu> <5b1319d426b1f55e08402790b4bc16a33ec7c00c.1209897267.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:54294 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbYEEJye convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 May 2008 05:54:34 -0400
In-Reply-To: <5b1319d426b1f55e08402790b4bc16a33ec7c00c.1209897267.git.monstr@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

On Sunday 04 May 2008, monstr@seznam.cz wrote:
> +#ifndef _ASM_MICROBLAZE_MMAN_H
> +#define _ASM_MICROBLAZE_MMAN_H
> +
> +#include <asm-generic/mman.h>
> +
> +#define MAP_GROWSDOWN=A0=A00x0100 /* stack-like segment */
> +#define MAP_DENYWRITE=A0=A00x0800 /* ETXTBSY */
> +#define MAP_EXECUTABLE=A00x1000 /* mark it as an executable */
> +#define MAP_LOCKED=A0=A0=A0=A0=A00x2000 /* pages are locked */
> +#define MAP_NORESERVE=A0=A00x4000 /* don't check for reservations */
> +#define MAP_POPULATE=A0=A0=A00x8000 /* populate (prefault) pagetable=
s */
> +#define MAP_NONBLOCK=A0=A0=A00x10000 /* do not block on IO */
> +
> +#define MCL_CURRENT=A0=A0=A0=A01 /* lock all current mappings */
> +#define MCL_FUTURE=A0=A0=A0=A0=A02 /* lock all future mappings */
> +
> +#endif /* _ASM_MICROBLAZE_MMAN_H */

I think we should come up with a good way to fold these into the
asm-generic header, as half the architectures use the same values
for them, in addition to what is already shared.

	Arnd <><
