Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:36239 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031273AbeBONaG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Feb 2018 08:30:06 -0500
From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH/RFC 6/6] Treewide: Remove depends on HAS_DMA in case of platform dependency
In-Reply-To: <1517912092-15470-7-git-send-email-geert@linux-m68k.org>
References: <1517912092-15470-1-git-send-email-geert@linux-m68k.org> <1517912092-15470-7-git-send-email-geert@linux-m68k.org>
Date: Thu, 15 Feb 2018 15:19:28 +0200
Message-ID: <87inay8k67.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180215131928.kPvtn5GhpGr-IcHMKvLe_ChAAgvvfXvK1wddB3_Fx74@z>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
>
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.
>
> This simplifies the dependencies, and allows to improve compile-testing.
>
> Notes:
>   - FSL_FMAN keeps its dependency on HAS_DMA, as it calls set_dma_ops(),
>     which does not exist if HAS_DMA=3Dn (Do we need a dummy? The use of
>     set_dma_ops() in this driver is questionable),
>   - SND_SOC_LPASS_IPQ806X and SND_SOC_LPASS_PLATFORM loose their
>     dependency on HAS_DMA, as they are selected from
>     SND_SOC_APQ8016_SBC.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

for drivers/usb/gadget/:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqFiOAACgkQzL64meEa
mQa2SxAAlW7lfUK0u4wYfEIEW/sDVDlt29tyJK/30ID1+B19bg9EdnpVFrWhOHj4
VdVg82aK/45YbuAxQKzlZIZcoR0eURUQRJqxFoBNkodNjwY8R90bhrFW4SaQc0zA
kjYCQAvRdA7qSEQay5sztWYaS+0GGotISvA33R0vvZVi8V+r6oOkLVPLH5B6UVPe
AR4pB3o+Fwis8tPxeRF6+nSFhoVCVPjSmGPiXDjm8MWdPs0gbzkfkANvIgt3G+Sd
lzCyf2wgnoKC1rOG7UuYH2179+7RlhezvXhcu4NCpm2wuq1CsU5mIR5CjyyuY6m3
M9q1/AS6+5e/GatadYanyCCy070sqls81cx66UEROgsMTXVw8wal/O39rjHp2+8L
rbAGQ7KmcxfSFi+Kk8+6G0eOrgWr7Q1ykego9Hd2PPIG0jD/Z/g2n97yTlUydCUo
0WR9PQO+QqjGJ1wku66da03oD7VuvZoDAKJeuriJo1Ipm9tiJVfsW6hAvfWzf5Md
SvX/jwxzMk6/ackrcvf9lSjNh50794AUurx3Rpz6QzJaaheXCfAhzGyaykQZuwSj
+wY0omxCN/ywb70XUPZNHhhCfoa7Fnq9EqlbW2HU1jodS7I0Tu2Lr69ZKN7vMlcN
0qCcIKPDR/xug7mpYXISyToppKjn+uCb8EUkSTb/IUVBER9h4ww=
=988a
-----END PGP SIGNATURE-----
--=-=-=--
