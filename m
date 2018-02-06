Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54852 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752901AbeBFMBQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Feb 2018 07:01:16 -0500
Date: Tue, 6 Feb 2018 12:01:02 +0000
From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH/RFC 0/6] Allow compile-testing NO_DMA
Message-ID: <20180206120102.GD5681@sirena.org.uk>
References: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180206120102.b-R0jLtzzx2pUHcw57zimOvU-8j1jXbj7Jb9R5qk-ak@z>


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2018 at 11:14:46AM +0100, Geert Uytterhoeven wrote:

> The intention of this is twofold:
>   1. To catch users of the DMA API on systems that do no support the DMA
>      mapping API,
>   2. To avoid building drivers that cannot work on such systems anyway.
>=20
> However, the disadvantage is that we have to keep on adding dependencies
> on HAS_DMA all over the place.

> Thanks to the COMPILE_TEST symbol, lots of drivers now depend on one or
> more platform dependencies (that imply HAS_DMA) || COMPILE_TEST, thus
> already covering intention #2.  Having to add an explicit dependency on
> HAS_DMA here is cumbersome, and hinders compile-testing.

Thanks for doing this, hopefully it'll make everyone's life easier!

Reviwed-by: Mark Brown <broonie@kernel.org>

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp5mP4ACgkQJNaLcl1U
h9DQHwf/XBpyddbvSIv1fVAWYehY0CxC/MJFXBMtwxQlvO/iNmeq8zu68qIQR8ZV
kgzNy45Ru21rYhgFakUF/Evu564Xl9KLhdYSHanizj6vj4beEnw8PETfGSqdScfK
Qs7IbU5yIFJ6dzXqSLTaNK2qEn7qclRI7Zk1JQxUzpGVGRhWQd6ezIKJOy/5xlSE
Fn3QdQMMu/yWFZdxS1HIIlG6F5/ZExZWHxz9nvpG6MrexN85o4IPgcdXsd1Xaiai
zsDBsurAlRY/vfSewSSpAWuSAbwwKMNco5r1RjDzhI+cwPHGEFwCMDNFTMKF+Q21
ZQVVVljyBt8WnK2LmofdtryHy/61XQ==
=g5tK
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
