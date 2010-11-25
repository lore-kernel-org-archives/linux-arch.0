From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH v3 06/22] m68knommu: introduce little-endian bitops
Date: Thu, 25 Nov 2010 17:46:01 +0900
Message-ID: <AANLkTiktTunH50a2aPCUeJEspEiOP3-fyCy1aWt4pXbZ@mail.gmail.com>
References: <1290519504-3958-1-git-send-email-akinobu.mita@gmail.com>
	<1290519504-3958-7-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47893 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab0KYIqD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Nov 2010 03:46:03 -0500
In-Reply-To: <1290519504-3958-7-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, Greg Ungerer <gerg@uclinux.org>

2010/11/23 Akinobu Mita <akinobu.mita@gmail.com>:
> Introduce little-endian bit operations by renaming native ext2 bit
> operations. The ext2 bit operations are kept as wrapper macros using
> little-endian bit operations to maintain bisectability until the
> conversions are finished.

This breaks the build on m68knommu.

lib/find_next_bit.c:190: error: conflicting types for 'find_next_zero_l=
e_bit'
/home/mita/scm/linux-2.6/arch/m68k/include/asm/bitops_no.h:286: error: =
previous
definition of 'find_next_zero_le_bit' was here

> @@ -271,10 +279,10 @@ static __inline__ int ext2_test_bit(int nr, con=
st volatile void * addr)
> =A0 =A0 =A0 =A0return retval;
> =A0}
>
> -#define ext2_find_first_zero_bit(addr, size) \
> - =A0 =A0 =A0 =A0ext2_find_next_zero_bit((addr), (size), 0)
> +#define find_first_zero_le_bit(addr, size) =A0 =A0 \
> + =A0 =A0 =A0 find_next_zero_le_bit((addr), (size), 0)
>
> -static __inline__ unsigned long ext2_find_next_zero_bit(void *addr, =
unsigned long size, unsigned long offset)
> +static inline unsigned long find_next_zero_le_bit(void *addr, unsign=
ed long size, unsigned long offset)
> =A0{
> =A0 =A0 =A0 =A0unsigned long *p =3D ((unsigned long *) addr) + (offse=
t >> 5);
> =A0 =A0 =A0 =A0unsigned long result =3D offset & ~31UL;

Because m68knommu selects CONFIG_GENERIC_FIND_NEXT_BIT, it redefines
find_next_zero_le_bit() in lib/find_next_bit.c.

I'm going to fix it by introducing new CONFIG_GENERIC_FIND_LE_BIT optio=
n.

CONFIG_GENERIC_FIND_LE_BIT tells whether to use generic implementation =
of
find_*_le_bit() in lib/find_next_bit.c or not.  It will not be selected=
 by
m68knommu to use the optimized find_next_zero_le_bit().
