From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v2 2/3] drivers/block/xsysace - use "_rep" accessors with
 CPU endianess for data
Date: Tue, 25 Jun 2013 07:56:39 +0200
Message-ID: <51C93117.3090809@monstr.eu>
References: <1372062364-25861-1-git-send-email-abrodkin@synopsys.com> <1372062364-25861-3-git-send-email-abrodkin@synopsys.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2XJMXQBCLBSKRWVHBOFUE"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:44758 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab3FYF6j (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2013 01:58:39 -0400
Received: by mail-ea0-f169.google.com with SMTP id h15so6510772eak.14
        for <linux-arch@vger.kernel.org>; Mon, 24 Jun 2013 22:58:38 -0700 (PDT)
In-Reply-To: <1372062364-25861-3-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Mischa Jonker <Mischa.Jonker@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2XJMXQBCLBSKRWVHBOFUE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/24/2013 10:26 AM, Alexey Brodkin wrote:
> Initially different data accessors were used for LE abd BE CPUs:
> "ioread16" in "ace_datain_be16" and "ioread16be" in "ace_datain_le16".
> The same with writes.
>=20
> While it worked in some cases (for example on BE PPC) it didn't work in=

> others (LE ARC).

I am not sure about this. It seems to me that what you need to do
is swapped wires in your hw design to use the same configuration
as is used on ppc and microblaze for data access.


> Mentioned functions access data (by 16-bit chunks) from storage (i.e.
> CompactFlash card) via DATABUFREG of Xilinx SystemACE CF controller.
> And to interpret data properly CPU needs to access data in DATABUFREG
> with native endianess.

I have had a lot of discussions about using native endianess.
This driver supports endian detection on register side
but not on data side.
Is this soft IP? If yes then just swapped wires on bus and use
standard configuration.

Grant is driver owner and he has to decide if this is acceptable
or not.
I can test it on microblaze hw.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



------enig2XJMXQBCLBSKRWVHBOFUE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlHJMRcACgkQykllyylKDCHKEgCfTIC/Pe1Hc1qjKswEDPHsBJUl
cVgAn1Ybr2GnwPZVpd4hl7tkw2quzPMz
=FKMj
-----END PGP SIGNATURE-----

------enig2XJMXQBCLBSKRWVHBOFUE--
