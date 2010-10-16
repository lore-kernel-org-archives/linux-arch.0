From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 22/22] bitops: remove minix bitops from asm/bitops.h
Date: Sat, 16 Oct 2010 22:47:49 +0900
Message-ID: <AANLkTimB77RRcJfNcX-w7E+mKiKmNzR661SrP8G09y7A@mail.gmail.com>
References: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com>
	<1287135981-17604-23-git-send-email-akinobu.mita@gmail.com>
	<201010151253.15653.arnd@arndb.de>
	<AANLkTi=cA=yf7NmPVKXaZdoTBYmwdmy_frk7b_feG-WG@mail.gmail.com>
	<m262x24j2y.fsf@igel.home>
	<AANLkTimHYYLZHOxgco3jotD7ikVhaPh8FVcSqeZwtrVc@mail.gmail.com>
	<AANLkTimtyW8AbOj+w=mjPbpP1j0LB9JXdo7cb=nQAXQ8@mail.gmail.com>
	<m2aamepa5s.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <m2aamepa5s.fsf@igel.home>
Sender: linux-m68k-owner@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linux/m68k <linux-m68k@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

2010/10/16 Andreas Schwab <schwab@linux-m68k.org>:
> Akinobu Mita <akinobu.mita@gmail.com> writes:
>
>> m68knommu is big-endian minixfs but m68k (mmu) is little-endian mini=
xfs
>> if I read arch/m68k/include/asm/bitops_{mm,no}.h correctly.
>
> Don't be confused by ^16, this is for the 16bit/32bit indexing
> correction. =A0The nommu version uses big-endian 32bit indexing which=
 yet
> another format.

Oh, I see. I misunderstood.

So we need a special handling for it to keep compatibility.
