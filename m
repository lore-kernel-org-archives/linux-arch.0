From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 1/7] m68knommu: fix build error due to the lack of find_next_bit_le()
Date: Tue, 3 May 2011 11:12:58 +0200
Message-ID: <BANLkTinkEHjrBW1GJSJhBnbgxXm5Vtw7BQ@mail.gmail.com>
References: <1303910411-15793-1-git-send-email-akinobu.mita@gmail.com>
	<1303910411-15793-2-git-send-email-akinobu.mita@gmail.com>
	<4DBFA78F.9060001@snapgear.com>
	<BANLkTi=CmYOisOqMejU2qVGnB4c6Z7yHsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43794 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab1ECJM7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 May 2011 05:12:59 -0400
In-Reply-To: <BANLkTi=CmYOisOqMejU2qVGnB4c6Z7yHsA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de, Greg Ungerer <gerg@uclinux.org>

On Tue, May 3, 2011 at 11:11, Akinobu Mita <akinobu.mita@gmail.com> wro=
te:
> 2011/5/3, Greg Ungerer <gerg@snapgear.com>:
>> Hi Akinobu,
>>
>> On 27/04/11 23:20, Akinobu Mita wrote:
>>> m68knommu can't build ext4, udf, and ocfs2 due to the lack of
>>> find_next_bit_le().
>>>
>>> This implements find_next_bit_le() on m68knommu by duplicating the
>>> generic find_next_bit_le() in lib/find_next_bit.c.
>>
>> Wouldn't the m68k specific implementation of this in
>> arch/m68k/include/asm/bitops_mm.h be better?
>
> find_next_bit_le() in bitops_mm.h has a bug
> (Please see https://lkml.org/lkml/2011/4/3/43) and it is not fixed
> in mainline yet. So I decided to use generic one for the safety.

Yeah, I still have to create a for-2.6.40 branch and add it there.

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
