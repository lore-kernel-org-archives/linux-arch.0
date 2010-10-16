From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 22/22] bitops: remove minix bitops from asm/bitops.h
Date: Sat, 16 Oct 2010 21:40:03 +0900
Message-ID: <AANLkTimtyW8AbOj+w=mjPbpP1j0LB9JXdo7cb=nQAXQ8@mail.gmail.com>
References: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com>
	<1287135981-17604-23-git-send-email-akinobu.mita@gmail.com>
	<201010151253.15653.arnd@arndb.de>
	<AANLkTi=cA=yf7NmPVKXaZdoTBYmwdmy_frk7b_feG-WG@mail.gmail.com>
	<m262x24j2y.fsf@igel.home>
	<AANLkTimHYYLZHOxgco3jotD7ikVhaPh8FVcSqeZwtrVc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:51917 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300Ab0JPMkE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 16 Oct 2010 08:40:04 -0400
In-Reply-To: <AANLkTimHYYLZHOxgco3jotD7ikVhaPh8FVcSqeZwtrVc@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linux/m68k <linux-m68k@vger.kernel.org>

2010/10/16 Geert Uytterhoeven <geert@linux-m68k.org>:
> On Sat, Oct 16, 2010 at 10:50, Andreas Schwab <schwab@linux-m68k.org> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>
>>> Funny, m68k uses the little endian minix file system?
>>>
>>> Perhaps this was due to minix using the ext2 accessors? And ext2 being
>>> switched from big to little endian ext2 on m68k, without anyone
>>> noticing the impact
>>> on minix?
>>
>> m68k has always used big-endian minixfs and the minix bitops were always
>> independent of the ext2 ones.
>
> Thanks for confirming!

m68knommu is big-endian minixfs but m68k (mmu) is little-endian minixfs
if I read arch/m68k/include/asm/bitops_{mm,no}.h correctly.
