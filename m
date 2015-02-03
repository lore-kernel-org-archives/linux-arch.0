From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Add ARCH_MIGHT_HAVE_VGA_CONSOLE
Date: Tue, 3 Feb 2015 11:08:49 +1100
Message-ID: <20150203110849.7907f175@canb.auug.org.au>
References: <877fw093oa.wl-ysato@users.sourceforge.jp>
	<CAMuHMdV8hyDWwz8V5rvrthcV8NyNk4J+9Opmxt3opqi5rtQoJw@mail.gmail.com>
	<87pp9s48mz.wl-ysato@users.sourceforge.jp>
	<3429563.4px2PR9Zmy@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AcdG120SF4I+AR.wY9HDmwk"; protocol="application/pgp-signature"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:36645 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755313AbbBCAIz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Feb 2015 19:08:55 -0500
In-Reply-To: <3429563.4px2PR9Zmy@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

--Sig_/AcdG120SF4I+AR.wY9HDmwk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Mon, 02 Feb 2015 21:11:50 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tuesday 03 February 2015 00:48:20 Yoshinori Sato wrote:
>=20
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -76,6 +76,7 @@ config ARM
> >        select PERF_USE_VMALLOC
> >        select RTC_LIB
> >        select SYS_SUPPORTS_APM_EMULATION
> >+       select ARCH_MIGHT_HAVE_VGA_CONSOLE if ARCH_FOOTBRIDGE || ARCH_IN=
TEGRATOR || ARCH_NETWINDER
> >        # Above selects are sorted alphabetically; please add new ones
> >        # according to that.  Thanks.
> >        help
>=20
> You did not read the comment in the patch context: This list of selects is
> sorted alphabetically in order to avoid merge conflicts. Please keep it t=
his
> way.

Why would you not just put the "select ARCH_MIGHT_HAVE_VGA_CONSOLE"
under each of those other config symbols and further restrict the
possibility of conflicts?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/AcdG120SF4I+AR.wY9HDmwk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJU0BGVAAoJEMDTa8Ir7ZwVS8IP/RxbalUtrmQX6Rlh45qG23QV
21iWJLNv2/DigamYKnJoQxNEDZGdL1aCwpX/44+JgBPDYzUtRiWE7BxtjfhT/Ebq
9pjg+4zbdhqxhZmn3g//Kn6F8bWzqn96Zfdnulksw9Bmlgna+cPe4vN1/Ce/Inop
jiTr0hvmEGeG8HDH3BEwbT3DD1hKGYFAuyEDGnfI/tnJWtQQpSfQRSE6NqVNdOYW
XChOyWENn7Lo65R/mIhMsZ4mNKc8Ry7yN4Y5tBFxbtZRHK3M8n3k0xmbysZaSZab
nHP8ag2yU2Jmk1xi5Voq27HhfKkxmJE7FmpII/vcEJ5R2Xue3iCZPbs+Y5GAd1Wm
BXE5csJlQh9ssamQIaDlvuSIO2WjiFeN5CSwjRTDPbBjt7qwIw+QvI6kmevjZnZ/
16zSbBPnknEPm1ukNJDDlN0hBCFOYrL+mRvgd4gPuDZgwW9IjvS0eRfQUawUSMub
wFFwg/omYXE9yx+FJBLoELAuvxOKssuZLfmoJW7RSGOwXMIYQYNoV7eebkzDfuL3
otGqtjlkCHz5IUPVo7hT/hfZ5sN9jvFeqDmJAcrBMNeBqKqH+thHt6rNaAUNzYDW
cW1J52BbRqqWj8ARYSgVFiC0ToLEus6So/gHFgvSRauDGAheYE2MtUqgRwB5mRGz
9dKAvWCuEO86N3j/DAh1
=Nxmc
-----END PGP SIGNATURE-----

--Sig_/AcdG120SF4I+AR.wY9HDmwk--
