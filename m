From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 22/22] bitops: remove minix bitops from asm/bitops.h
Date: Sat, 16 Oct 2010 09:59:24 +0200
Message-ID: <AANLkTi=cA=yf7NmPVKXaZdoTBYmwdmy_frk7b_feG-WG@mail.gmail.com>
References: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com>
	<1287135981-17604-23-git-send-email-akinobu.mita@gmail.com>
	<201010151253.15653.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <201010151253.15653.arnd@arndb.de>
Sender: linux-m68k-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linux/m68k <linux-m68k@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 15, 2010 at 12:53, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 15 October 2010, Akinobu Mita wrote:
>> minix bit operations are only used by minix filesystem and useless
>> by other modules.
>
> Right.
>
>> This provides new config option CONFIG_MINIX_FS_LITTLE_ENDIAN and
>> CONFIG_MINIX_FS_NATIVE_ENDIAN that each architecture selects one of =
which.
>> Then we can remove minix bit operations from asm/bitops.h from all
>> architectures by making them minix filesystem local macros.
>
> I would say that any architecture that defines minix bitops as
> little-endian is broken and we should not even need the #define.
>
> You have defined these as "native endian":
>
> always LE:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0alpha, blackfin, ia64, score, tile, x86
>
> always BE:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0h8300, microblaze, s390, sparc
>
> configurable:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0m32r, mips, sh, xtensa
>
> The only ones among these that possibly ever cared about mounting min=
ix
> file systems on a big-endian kernel are really old sparc and mips sys=
tems,
> everyone else probably never noticed their mistake.
>
> I'd say let's define the minix bitops as always LE and be done with i=
t.

=46unny, m68k uses the little endian minix file system?

Perhaps this was due to minix using the ext2 accessors? And ext2 being
switched from big to little endian ext2 on m68k, without anyone
noticing the impact
on minix?

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
