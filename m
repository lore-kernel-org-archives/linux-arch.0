From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH] asm-generic/io.h: Add default configuration for readX/writeX_relaxed
Date: Tue, 08 Apr 2014 20:07:59 +0200
Message-ID: <53443AFF.8060302@monstr.eu>
References: <35729b5d2bf080d3029f69af4bc638a268bf1a8f.1396941358.git.michal.simek@xilinx.com> <20140408175005.GA31890@ravnborg.org>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GLQNIV20oEFXTrxGlJfm65bRoAppdSIm7"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:60789 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932654AbaDHSIH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Apr 2014 14:08:07 -0400
Received: by mail-ee0-f51.google.com with SMTP id c13so983118eek.38
        for <linux-arch@vger.kernel.org>; Tue, 08 Apr 2014 11:08:06 -0700 (PDT)
In-Reply-To: <20140408175005.GA31890@ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, git@xilinx.com, wsa@the-dreams.de, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GLQNIV20oEFXTrxGlJfm65bRoAppdSIm7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

On 04/08/2014 07:50 PM, Sam Ravnborg wrote:
> On Tue, Apr 08, 2014 at 09:16:01AM +0200, Michal Simek wrote:
>> Define default readX/writeX_relaxed IO helper functions
>> for all archs which use asm-generic/io.h.
>> Using COMPILE_TEST, moving drivers out of arch/arm and
>> removing architecture dependencies in Kconfig is causing
>> that more and more drivers is using _relaxed IO helper
>> functions which is causing compilation failures on architectures
>> which don't define them.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>=20
> There is a potential cleanup patch for several architectures.

definitely yes.

> Those that already have similar defines can have them deleted as
> they are now provided by the generic version.
> Can you try to look into this too?

Yes. I wanted to send this out just to know opinion from others.
If this is acceptable, I will look at all archs.
One patch per arch seems to be the best way how to do it.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--GLQNIV20oEFXTrxGlJfm65bRoAppdSIm7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNEOv8ACgkQykllyylKDCGN2wCfZldFwXNhoK4CgT2kQgsk3vN5
zjQAn0B91CG0FmpR5yHoYwDnPniNr/g9
=bJ3P
-----END PGP SIGNATURE-----

--GLQNIV20oEFXTrxGlJfm65bRoAppdSIm7--
