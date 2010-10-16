From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 22/22] bitops: remove minix bitops from asm/bitops.h
Date: Sat, 16 Oct 2010 13:35:47 +0200
Message-ID: <AANLkTimHYYLZHOxgco3jotD7ikVhaPh8FVcSqeZwtrVc@mail.gmail.com>
References: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com>
	<1287135981-17604-23-git-send-email-akinobu.mita@gmail.com>
	<201010151253.15653.arnd@arndb.de>
	<AANLkTi=cA=yf7NmPVKXaZdoTBYmwdmy_frk7b_feG-WG@mail.gmail.com>
	<m262x24j2y.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33322 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826Ab0JPLft convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 16 Oct 2010 07:35:49 -0400
In-Reply-To: <m262x24j2y.fsf@igel.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linux/m68k <linux-m68k@vger.kernel.org>

On Sat, Oct 16, 2010 at 10:50, Andreas Schwab <schwab@linux-m68k.org> w=
rote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
>> Funny, m68k uses the little endian minix file system?
>>
>> Perhaps this was due to minix using the ext2 accessors? And ext2 bei=
ng
>> switched from big to little endian ext2 on m68k, without anyone
>> noticing the impact
>> on minix?
>
> m68k has always used big-endian minixfs and the minix bitops were alw=
ays
> independent of the ext2 ones.

Thanks for confirming!

Hence "[PATCH 21/22] m68k: convert minix bitops to use little endian
bitops" is not correct?

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
