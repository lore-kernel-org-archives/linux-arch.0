From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 06/27] score: create head files delay.h device.h div64.h dma-mapping.h dma.h
Date: Sun, 14 Jun 2009 00:31:54 +0200
Message-ID: <200906140031.55091.arnd@arndb.de>
References: <OF676F75F6.AE51CF2E-ON482575D4.00241202-482575D4.0024AEE4@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:60609 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbZFMWch (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 13 Jun 2009 18:32:37 -0400
In-Reply-To: <OF676F75F6.AE51CF2E-ON482575D4.00241202-482575D4.0024AEE4@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

On Saturday 13 June 2009, liqin.chen@sunplusct.com wrote:
> Arnd Bergmann <arnd@arndb.de> =D0=B4=D3=DA 2009-06-10 01:18:20:
>=20
> > On Tuesday 09 June 2009, liqin.chen@sunplusct.com wrote:
> >=20
> > Having a working udelay() function is required for many
> > drivers that are sensitive to timing, you should probably
> > implement that at some point in the future.
>=20
> Add udelay() implement in code.

so you use=20

static inline void __delay(unsigned long loops)
{
        __asm__ __volatile__ (
                "1:\tsubi\t%0,1\n\t"
                "cmpz.c\t%0\n\t"
                "bne\t1b\n\t"
                : "=3Dr" (loops)
                : "0" (loops));
}

static inline void __udelay(unsigned long usecs)
{
        __delay(usecs);
}


This is much better than before, but is far from exact in the __udelay(=
)
case. Please take a look at init/calibrate.c and how other architecture=
s
use loops_per_jiffy if you don't have an exact time source you can use.

If you have a time source with microsecond resolution or better, just l=
oop
until the amount of microseconds has expired.

	Arnd <><
