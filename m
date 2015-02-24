From: James Hogan <james.hogan@imgtec.com>
Subject: Re: semantics of KSTK_ESP and friends
Date: Tue, 24 Feb 2015 12:01:55 +0000
Message-ID: <54EC6833.6090709@imgtec.com>
References: <C2D7FE5348E1B147BCA15975FBA230756658D08C@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="jcHCMgJ5eg1AuU4CN65rcBPGJjlpGAmJB"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:9329 "EHLO
	imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750925AbbBXMCE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Feb 2015 07:02:04 -0500
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA230756658D08C@IN01WEMBXB.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, al Viro <viro@ZenIV.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>

--jcHCMgJ5eg1AuU4CN65rcBPGJjlpGAmJB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Vineet,

On 12/02/15 07:10, Vineet Gupta wrote:
> Hi,
>=20
> Is KSTK_ESP supposed to return the kernel mode SP of a sleeping task or=
 is it supposed to provide the user mode SP at the time of last kernel en=
try ?
>=20
> The 2 non arch users of the API expect the user mode SP semantics:
> * vm_is_stack_for_task() - to annotate /proc/<pid>/maps stack vma - whi=
ch is shere Alexey noted this.
> * do_task_stat()

Judging by both these uses, it would be the task's user mode SP that is
desired. Same for KSTK_EIP by the looks of it. Well spotted!

I'll look into fixing Metag.

Cheers
James

>=20
> ARC port uses these for unwinding the task of a sleeping task (hence ke=
rnel mode SP semantics).
> metag (from the looks of it) also seem to provide kernel mode value, wh=
ile most others seem to provide the user mode variant.
>=20
>  I can fix ARC to work with expectation of generic code, but wanted to =
understand anyways.
>=20
> Thx,
> -Vineet
>=20


--jcHCMgJ5eg1AuU4CN65rcBPGJjlpGAmJB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU7Gg6AAoJEGwLaZPeOHZ6PtQP/2fj/tBSnqcCaV4TUO++U42x
0NZFAjSUFuIwDvQfuH8CXScgZd2PzC0lA6qkmjHSb7TCrl6H94mcpoRfStce2qSj
bCqVdre733zO4QlRcjeBcBaS6JoNcZfo55YoFYRvJInl79BV0S2yh5/m1w4nRYOT
7zQNWO1qRCYkh+yqBV97riLG+3NKGfFCQtDVN6x3f10VbDa8TP4tOiL+Pya7X2c5
5gtWyV7GGpWWHFHVPhOY0szhW03574N3OoZCHEeBy2OFz7qqyAosjU+d8Y+rRQEB
z1IaZjMbEe2IqO1cZBPkBx7NycLaAYRG1kzKOh/5YfielGH/6tmeAU3zSoJgQTMq
+H/mXuZDMlJozJfk14LVZZbtF75vV9z9Tn+0A/5zPi9P/WEX11E5iPWTJHfx3cLq
0TNO9GDUiUmw9w9iL5g/kicv1KOoiTek6+Gt4JTflNwPMEVS0hc753bxevbbE5YR
b/CEri7dCBzLziPmyy6D6/dIxde4PxrMfhw7YKCygTTUppixq/kYdvA257+vXzPu
zpr+l+teH/6+acXiGIHAi/bpcgV2SeIuckgpGdbaKArOqKQ5nsVIz4WMK4Fgt8FT
Lqyhr+zlbG+lfOCHEiTX+atG1Q+qmtKuGeIQTo2rccoDYPORc9eD2S38nLNdQDua
17OQ0L+8Z+xSJwbM8pzQ
=lirB
-----END PGP SIGNATURE-----

--jcHCMgJ5eg1AuU4CN65rcBPGJjlpGAmJB--
