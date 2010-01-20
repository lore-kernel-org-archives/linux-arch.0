From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] asm-generic: dma: Add BUG_ON for uninitialized dma_ops
Date: Wed, 20 Jan 2010 12:00:31 +0100
Message-ID: <10f740e81001200300o217b955fqb79d5628b2e62731@mail.gmail.com>
References: <1263982111-24123-1-git-send-email-monstr@monstr.eu>
	 <1263982111-24123-2-git-send-email-monstr@monstr.eu>
	 <b6fcc0a1001200248x1a4b3cedoae90b4f1495d2358@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:34222 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab0ATLAb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2010 06:00:31 -0500
In-Reply-To: <b6fcc0a1001200248x1a4b3cedoae90b4f1495d2358@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: monstr@monstr.eu, linux-kernel@vger.kernel.org, michal.simek@petalogix.com, arnd@arndb.de, linux-arch@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp, akpm@linux-foundation.org, mingo@elte.hu, joerg.roedel@amd.com

On Wed, Jan 20, 2010 at 11:48, Alexey Dobriyan <adobriyan@gmail.com> wr=
ote:
> On Wed, Jan 20, 2010 at 12:08 PM, =C2=A0<monstr@monstr.eu> wrote:
>> From: Michal Simek <monstr@monstr.eu>
>>
>> Check that dma_ops are initialized correctly. Without this
>> checking you get kernel fault and you don't know where the problem i=
s.
>
> Oh, yes you do. PC will be of some small value.

And the backtrace will tell you where to look...

>> + =C2=A0 =C2=A0 =C2=A0 BUG_ON(!ops);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(!valid_dma_direction(dir));
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D ops->map_page(dev, virt_to_page(=
ptr),

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
