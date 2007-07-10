Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from posthamster.phnxsoft.com ([195.227.45.4]:4783 "EHLO
	posthamster.phnxsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756870AbXGJIME (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jul 2007 04:12:04 -0400
Message-ID: <46933B71.6040906@imap.cc>
Date: Tue, 10 Jul 2007 09:55:29 +0200
From: Tilman Schmidt <tilman@imap.cc>
MIME-Version: 1.0
Subject: Re: [x86 setup 31/33] Use the new x86 setup code for i386
References: <11840359321823-git-send-email-hpa@zytor.com> <11840371953778-git-send-email-hpa@zytor.com> <11840373002601-git-send-email-hpa@zytor.com> <11840374052662-git-send-email-hpa@zytor.com> <1184037510289-git-send-email-hpa@zytor.com> <11840376162370-git-send-email-hpa@zytor.com> <11840377211519-git-send-email-hpa@zytor.com> <11840378261081-git-send-email-hpa@zytor.com> <11840379311574-git-send-email-hpa@zytor.com> <11840380363720-git-send-email-hpa@zytor.com> <11840381413065-git-send-email-hpa@zytor.com> <11840382473923-git-send-email-hpa@zytor.com> <11840383522914-git-send-email-hpa@zytor.com> <1184038457733-git-send-email-hpa@zytor.com> <1184038562864-git-send-email-hpa@zytor.com> <11840386682120-git-send-email-hpa@zytor.com> <11840387733386-git-send-email-hpa@zytor.com> <11840388782627-git-send-email-hpa@zytor.com> <11840389834063-git-send-email-hpa@zytor.com> <1184039088816-git-send-email-hpa@zytor.com> <1184039193417-git-send-email-hpa@zytor.com>
In-Reply-To: <1184039193417-git-send-email-hpa@zytor.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA5D6CB4207A99F1CB81AFE26"
Sender: linux-arch-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, andi@firstfloor.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA5D6CB4207A99F1CB81AFE26
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Minor nitpick:

> diff --git a/arch/i386/boot/tools/build.c b/arch/i386/boot/tools/build.=
c
> index 0579841..886f47d 100644
> --- a/arch/i386/boot/tools/build.c
> +++ b/arch/i386/boot/tools/build.c
> @@ -1,13 +1,12 @@
>  /*
>   *  Copyright (C) 1991, 1992  Linus Torvalds
>   *  Copyright (C) 1997 Martin Mares
> + *  Copyright (C) 2007 H. Peter Anvin
>   */
> =20
>  /*
>   * This file builds a disk-image from three different files:
                                         ~~~~~
                                         two
>   *
> - * - bootsect: compatibility mbr which prints an error message if
> - *             someone tries to boot the kernel directly.
>   * - setup: 8086 machine code, sets up system parm
>   * - system: 80386 code for actual system
>   *

--=20
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigA5D6CB4207A99F1CB81AFE26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGkztyMdB4Whm86/kRAnKSAJ9UsHn4CmQPCGwYQlBXEx6QpJ76RwCeLjh+
QTAU+Oby2K/Xu+d64ZqTQ90=
=n3za
-----END PGP SIGNATURE-----

--------------enigA5D6CB4207A99F1CB81AFE26--
