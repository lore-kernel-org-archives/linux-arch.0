From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2 03/11] of/fdt: add of_fdt_machine_is_compatible
 function
Date: Tue, 20 Aug 2019 19:27:50 +0200
Message-ID: <ef3eaf8ea03ae8dc86a1a2f293087ff5c2f56b7a.camel@suse.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
         <20190820145821.27214-4-nsaenzjulienne@suse.de>
         <CAL_JsqJT3UNVKpAt+3g-tosy=uCZTosUxD4RfVYjMJ-gpGmPiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Cm+dM0aB2YImXVa0ovlW"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJT3UNVKpAt+3g-tosy=uCZTosUxD4RfVYjMJ-gpGmPiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org, "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, Florian Fainelli <f.fainelli@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Frank Rowand <frowand.list@gmail.com>, Eric Anholt <eric@anholt.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Linux IOMMU <iommu@lists.linux-foundation.org>, Matthias Brugger <mbrugger@suse.com>, Stefan Wahren <wahrenst@gmx.net>, linux-riscv@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robi>
List-Id: linux-arch.vger.kernel.org


--=-Cm+dM0aB2YImXVa0ovlW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,
thanks for the rewiew.

On Tue, 2019-08-20 at 12:16 -0500, Rob Herring wrote:
> On Tue, Aug 20, 2019 at 9:58 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > Provides the same functionality as of_machine_is_compatible.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >=20
> > Changes in v2: None
> >=20
> >  drivers/of/fdt.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 9cdf14b9aaab..06ffbd39d9af 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -802,6 +802,13 @@ const char * __init of_flat_dt_get_machine_name(vo=
id)
> >         return name;
> >  }
> >=20
> > +static const int __init of_fdt_machine_is_compatible(char *name)
>=20
> No point in const return (though name could possibly be const), and
> the return could be bool instead.

Sorry, I completely missed that const, shouldn't have been there to begin w=
ith.

I'll add a const to the name argument and return a bool on the next version=
.

Regards,
Nicolas



--=-Cm+dM0aB2YImXVa0ovlW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl1cLZYACgkQlfZmHno8
x/4DowgAjoLUq0qUOWOtkTx0OcxyQrKy++gIvChR7IajK1yXJKyT8kA/QNZrERqj
nvLlebXPhJG0y4uUTzEVmzsgUFS4vopZAzL+H7TGfXsL8pQbGjnO+l62gc1oqTVd
U+IrQWs0BPZ/MeCxUXUtKlYdMMuf9Ld8z16siDZPj5pYY6IHq8HtS1WseTvTti6S
pHpXyK+XiPpxzupgUjNm6Lzsm8FO0P2tw5IKD3vRLS+4vLaYUPieCLdMvkf1lMU6
DkQ71pEENpt35eBer1lLK/meYuisvK4V+tnwrWSDGZCuywbhi1fpvAyh3CRicE3t
rvLGmR2JEXsldgQeodOoEyKoeWSAgQ==
=hgaN
-----END PGP SIGNATURE-----

--=-Cm+dM0aB2YImXVa0ovlW--
