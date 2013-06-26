From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v2 2/3] drivers/block/xsysace - use "_rep" accessors with
 CPU endianess for data
Date: Wed, 26 Jun 2013 11:30:23 +0200
Message-ID: <51CAB4AF.7040407@monstr.eu>
References: <1372062364-25861-1-git-send-email-abrodkin@synopsys.com> <1372062364-25861-3-git-send-email-abrodkin@synopsys.com> <51C93117.3090809@monstr.eu> <4881796E12491D4BB15146FE0209CE643F60030B@DE02WEMBXB.internal.synopsys.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2UQHATATFHVUGGPMBVJJO"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:63569 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab3FZJa5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jun 2013 05:30:57 -0400
Received: by mail-ea0-f175.google.com with SMTP id z7so7385661eaf.34
        for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2013 02:30:56 -0700 (PDT)
In-Reply-To: <4881796E12491D4BB15146FE0209CE643F60030B@DE02WEMBXB.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Mischa Jonker <Mischa.Jonker@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2UQHATATFHVUGGPMBVJJO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/25/2013 08:32 AM, Alexey Brodkin wrote:
> On 06/25/2013 09:58 AM, Michal Simek wrote:
>> On 06/24/2013 10:26 AM, Alexey Brodkin wrote:
>>> Initially different data accessors were used for LE abd BE CPUs:
>>> "ioread16" in "ace_datain_be16" and "ioread16be" in "ace_datain_le16"=
=2E
>>> The same with writes.
>>>
>>> While it worked in some cases (for example on BE PPC) it didn't work =
in
>>> others (LE ARC).
>>
>> I am not sure about this. It seems to me that what you need to do
>> is swapped wires in your hw design to use the same configuration
>> as is used on ppc and microblaze for data access.
>  >
>>> Mentioned functions access data (by 16-bit chunks) from storage (i.e.=

>>> CompactFlash card) via DATABUFREG of Xilinx SystemACE CF controller.
>>> And to interpret data properly CPU needs to access data in DATABUFREG=

>>> with native endianess.
>>
>> I have had a lot of discussions about using native endianess.
>> This driver supports endian detection on register side
>> but not on data side.
>> Is this soft IP? If yes then just swapped wires on bus and use
>> standard configuration.
>=20
> I don't think there's a wiring problem.
> For starters "Xilinx SystemACE CF controller" (at least the one I'm=20
> dealing with on "Xilinx ML-509" board) is a real hardware IC (with part=
=20
> number XCCACE-TQ144I).
>=20
> And what about your HW? Is your SystemACE controller is a soft-IP?

bus-> sysace soft IP -> connetion to the real chip(MPD below) -> chip -> =
CF

In xilinx mhs file there are MPD pins which are data pins
and they are wired like this for 16bit mode
PORT fpga_0_SysACE_CompactFlash_SysACE_MPD_pin =3D fpga_0_SysACE_CompactF=
lash_SysACE_MPD_pin, DIR =3D IO, VEC =3D [15:0]
and like this for 8bit mode.
PORT SysACE_MPD =3D SysACE_MPD, DIR =3D IO, VEC =3D [7:0]

I am not sure about configuration but if you have something similar
what xilinx has then you should be simple able to change data pins
and this will reflect linux driver.

what configuration do you use?

>=20
> As described in corresponding datasheet=20
> (http://www.xilinx.com/support/documentation/data_sheets/ds080.pdf)=20
> CF-card is connected to this IC directly - so CPU itself doesn't have=20
> any connection to CF.

I am not talking about connection between system ace chip and CF.
xilinx configuration is done as I have described above where
we can setup data lines order. I haven't done any experiment with it
but seems to me straight forward to do it.

> CPU only can access (read/write) SystemACE's registers and by these act=
ions:
> 1. Config SystemACE or read its configuration and status (registers=20
> 0x00-0x1d).
> 2. Read/write data from/to CF-card (register 0x40).
>=20
> And as long as configuration/status registers access is proven to work =
I=20
> expect access to data via just reads/writes from/to another same=20
> register should work as well.
>
>> Grant is driver owner and he has to decide if this is acceptable
>> or not.
>=20
> As far as I may see from latest MAINTAINERS file grant is no longer=20
> maintains it. So who may take any decision now? Arnd?

I should probably assign it to my me as the part of my microblaze
responsibility. And xilinx virtex as part of my work for xilinx.

MAINTAINERS: Update Grant's email address and maintainership
sha1: 19624236cce1b33a5d43895a92e3a9d438dc36e2


>> I can test it on microblaze hw.
>=20
> Would be very nice and helpful if you give it a shot on Microblaze HW.
> BTW what is an endianess of this HW? Only BE or both BE/LE?

8bit BE/LE 16bit BE. I have one 16bit LE configuration too
but before I do testing on real HW let's clear your connection.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



------enig2UQHATATFHVUGGPMBVJJO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlHKtK8ACgkQykllyylKDCGukQCeJ9nxIalCINSn8yz+mBOXCt/r
2uAAn1BllI61DH25pBZzZJTi3/nUyjJg
=cdol
-----END PGP SIGNATURE-----

------enig2UQHATATFHVUGGPMBVJJO--
