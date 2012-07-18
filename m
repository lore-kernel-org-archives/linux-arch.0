From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] Make most arch asm/module.h files use asm-generic/module.h
Date: Wed, 18 Jul 2012 09:56:47 -0400
Message-ID: <201207180956.49573.vapier@gentoo.org>
References: <32350.1342615619@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2173222.vg99vfy2e6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:50050 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753202Ab2GRN4a (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jul 2012 09:56:30 -0400
In-Reply-To: <32350.1342615619@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>

--nextPart2173222.vg99vfy2e6
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 July 2012 08:46:59 David Howells wrote:
> --- a/arch/blackfin/Kconfig
> +++ b/arch/blackfin/Kconfig
> @@ -40,6 +40,7 @@ config BLACKFIN
>  	select HAVE_NMI_WATCHDOG if NMI_WATCHDOG
>  	select GENERIC_SMP_IDLE_THREAD
>  	select ARCH_USES_GETTIMEOFFSET if !GENERIC_CLOCKEVENTS
> +	select HAVE_MOD_ARCH_SPECIFIC
>=20
>  config GENERIC_CSUM
>  	def_bool y
> --- a/arch/blackfin/include/asm/module.h
> +++ b/arch/blackfin/include/asm/module.h
> @@ -7,9 +7,7 @@
>  #ifndef _ASM_BFIN_MODULE_H
>  #define _ASM_BFIN_MODULE_H
>=20
> -#define Elf_Shdr        Elf32_Shdr
> -#define Elf_Sym         Elf32_Sym
> -#define Elf_Ehdr        Elf32_Ehdr
> +#include <asm-generic/module.h>
>=20
>  struct mod_arch_specific {
>  	Elf_Shdr	*text_l1;

looks sane to me
=2Dmike

--nextPart2173222.vg99vfy2e6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQBsChAAoJEEFjO5/oN/WBCH4QAKjPsZqhxA3Ky8XLR3O0e4fA
a0pU6DaFIqvv+yrx0bZDo3Ko62ka0elqXBZIYeBjA7jhteKPI7MlAYUgAbAdOQOA
wi+Zvps24XaIywLOtJl8wmxFTx1RPDn4bbEox1RmE/eBNrthKjeQcrAfT92pKbIE
B266sRqkqQNLkxeY/I9Ocd1m4/AKSGQvPYzyDbjfnSWr+n3bHEYeXcHu9tg/ZItq
H1fV7Z8ejSkhTtS/eo4rQ2eteA8cEbnzs5W8QjUoLD9VThn6nAgH3pdBxJrzQ53Z
7Umux7XHluBgovKY57u4MUit+0FpsKfsokxJz2VXnruP2o6LPXIiQX1N1ZY0dpyh
0/yuirIl6G/BbGJcZjxs5AYQ5Q3XYkTm4IwTGRr2F47PZt9IefsDFYH03aUY7Lu3
UFKb1RMOpcAnGgrEEJFScHSd3uDhEK1KKRtClTPmznp0UjF+4/gPX6EHnHEBOmsz
Np8ZUZRTkKJX4Oc0TqNb+6nPTYH28eHt8DsUpbHuM1nL7uV7IQ0Y6VvurLB7RrDj
D66/HKSDzevzUuYbsQP3Lp4UrW/k+y/5nLJJ4HdGSP9LOT52XdEtDZ7NlYiqb5Eu
foYGqo+jyXwJ7aNeH/RSixYsrlP64l4HLbxwPQPN0yOk58iw/886GLgHiWz+Y49S
/Sumam1y54ZJjoOIviyK
=iS8d
-----END PGP SIGNATURE-----

--nextPart2173222.vg99vfy2e6--
