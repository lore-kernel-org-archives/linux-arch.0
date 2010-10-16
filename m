From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 22/22] bitops: remove minix bitops from asm/bitops.h
Date: Sat, 16 Oct 2010 17:58:50 +0200
Message-ID: <m2wrpinn7p.fsf@igel.home>
References: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com>
	<1287135981-17604-23-git-send-email-akinobu.mita@gmail.com>
	<201010151253.15653.arnd@arndb.de>
	<AANLkTi=cA=yf7NmPVKXaZdoTBYmwdmy_frk7b_feG-WG@mail.gmail.com>
	<m262x24j2y.fsf@igel.home>
	<AANLkTimHYYLZHOxgco3jotD7ikVhaPh8FVcSqeZwtrVc@mail.gmail.com>
	<AANLkTimtyW8AbOj+w=mjPbpP1j0LB9JXdo7cb=nQAXQ8@mail.gmail.com>
	<m2aamepa5s.fsf@igel.home>
	<AANLkTimB77RRcJfNcX-w7E+mKiKmNzR661SrP8G09y7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:60857 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab0JPP6x (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 16 Oct 2010 11:58:53 -0400
In-Reply-To: <AANLkTimB77RRcJfNcX-w7E+mKiKmNzR661SrP8G09y7A@mail.gmail.com>
	(Akinobu Mita's message of "Sat, 16 Oct 2010 22:47:49 +0900")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linux/m68k <linux-m68k@vger.kernel.org>

Akinobu Mita <akinobu.mita@gmail.com> writes:

> 2010/10/16 Andreas Schwab <schwab@linux-m68k.org>:
>> Akinobu Mita <akinobu.mita@gmail.com> writes:
>>
>>> m68knommu is big-endian minixfs but m68k (mmu) is little-endian min=
ixfs
>>> if I read arch/m68k/include/asm/bitops_{mm,no}.h correctly.
>>
>> Don't be confused by ^16, this is for the 16bit/32bit indexing
>> correction. =C2=A0The nommu version uses big-endian 32bit indexing w=
hich yet
>> another format.
>
> Oh, I see. I misunderstood.
>
> So we need a special handling for it to keep compatibility.

IMHO we only need two versions: big-endian filesystem with big-endian
16bit indexed bitmaps and little-endian filesystem with little-endian
bitmaps.  The rest is just the result of careless copying.  Note that
the minix filesystem does no byte swapping, so native byte order is the
only sensible mode.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
