From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 22/22] bitops: remove minix bitops from asm/bitops.h
Date: Fri, 15 Oct 2010 14:53:16 -0400
Message-ID: <AANLkTimK__Z_KrZ+fEUQuu51cdrYviTAmXSfQ0jD_EvP@mail.gmail.com>
References: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com>
 <1287135981-17604-23-git-send-email-akinobu.mita@gmail.com> <201010151253.15653.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37986 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756529Ab0JOSxi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Oct 2010 14:53:38 -0400
In-Reply-To: <201010151253.15653.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>

On Fri, Oct 15, 2010 at 06:53, Arnd Bergmann wrote:
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

or at least make it so that this is the default, and you only have to
update Kconfig if you need to deviate from the default.  i dont like
having to add this minix option to every single arch Kconfig.
-mike
