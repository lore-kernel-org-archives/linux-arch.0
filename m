From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [RESEND PATCH v2 6/9] drm/mgag200: Constify ioreadX() iomem
 argument (as in generic implementation)
Date: Thu, 12 Mar 2020 11:49:05 +0100
Message-ID: <90baef2d-25fe-fac4-6a7e-b103b4b6721e__45928.1001518079$1584010164$gmane$org@suse.de>
References: <20200219175007.13627-1-krzk@kernel.org>
 <20200219175007.13627-7-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8zb502i0uNK5UHJJl43MN65Z2VSqAtFfM"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgCLKtR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Mar 2020 06:49:17 -0400
In-Reply-To: <20200219175007.13627-7-krzk@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Vineet Gupta <vgupta@synopsys.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jiri Slaby <jirislaby@gmail.com>, Nick

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8zb502i0uNK5UHJJl43MN65Z2VSqAtFfM
Content-Type: multipart/mixed; boundary="UnbV06xuRFGsh6csSeVcRA5al48ja8xJK";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Krzysztof Kozlowski <krzk@kernel.org>, Richard Henderson
 <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>,
 Vineet Gupta <vgupta@synopsys.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Jiri Slaby
 <jirislaby@gmail.com>, Nick Kossifidis <mickflemm@gmail.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Kalle Valo <kvalo@codeaurora.org>,
 "David S. Miller" <davem@davemloft.net>, Dave Jiang <dave.jiang@intel.com>,
 Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-ntb@googlegroups.com, virtualization@lists.linux-foundation.org,
 linux-arch@vger.kernel.org
Message-ID: <90baef2d-25fe-fac4-6a7e-b103b4b6721e@suse.de>
Subject: Re: [RESEND PATCH v2 6/9] drm/mgag200: Constify ioreadX() iomem
 argument (as in generic implementation)
References: <20200219175007.13627-1-krzk@kernel.org>
 <20200219175007.13627-7-krzk@kernel.org>
In-Reply-To: <20200219175007.13627-7-krzk@kernel.org>

--UnbV06xuRFGsh6csSeVcRA5al48ja8xJK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

I just received a resend email from 3 weeks ago :/

Do you want me to merge the mgag200 patch into drm-misc-next?

Best regards
Thomas

Am 19.02.20 um 18:50 schrieb Krzysztof Kozlowski:
> The ioreadX() helpers have inconsistent interface.  On some architectur=
es
> void *__iomem address argument is a pointer to const, on some not.
>=20
> Implementations of ioreadX() do not modify the memory under the address=

> so they can be converted to a "const" version for const-safety and
> consistency among architectures.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>=20
> ---
>=20
> Changes since v1:
> 1. Add Thomas' review.
> ---
>  drivers/gpu/drm/mgag200/mgag200_drv.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.h b/drivers/gpu/drm/mg=
ag200/mgag200_drv.h
> index aa32aad222c2..6512b3af4fb7 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_drv.h
> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.h
> @@ -34,9 +34,9 @@
> =20
>  #define MGAG200FB_CONN_LIMIT 1
> =20
> -#define RREG8(reg) ioread8(((void __iomem *)mdev->rmmio) + (reg))
> +#define RREG8(reg) ioread8(((const void __iomem *)mdev->rmmio) + (reg)=
)
>  #define WREG8(reg, v) iowrite8(v, ((void __iomem *)mdev->rmmio) + (reg=
))
> -#define RREG32(reg) ioread32(((void __iomem *)mdev->rmmio) + (reg))
> +#define RREG32(reg) ioread32(((const void __iomem *)mdev->rmmio) + (re=
g))
>  #define WREG32(reg, v) iowrite32(v, ((void __iomem *)mdev->rmmio) + (r=
eg))
> =20
>  #define ATTR_INDEX 0x1fc0
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--UnbV06xuRFGsh6csSeVcRA5al48ja8xJK--

--8zb502i0uNK5UHJJl43MN65Z2VSqAtFfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl5qE6QACgkQaA3BHVML
eiOp7Af/Z24gM/vp7wuoDOu1s9VJhDHNRqfYcrpjv+SeE5E7jsj4gBCwwLJxuyKf
5DIzeOH97Mrv5fgfIx97Af8C372d1sRW46TwvSXFm8ywyTvigM4cWdRapf9cXozZ
AiQUCqkrkGEL6FhofMuHqZ2arL+6NooRluvXmoeX9bXA+itrwOhU4YhoIUwTJnUc
7UrcNFXhCKIZrEGfkHGZrnbC/Lr9g+tBLcEcQJf69SUMc56aboUZf47aOcpw67lj
3TpHOqEJwqnxnQlKSO0cL4BgwEzZWt3ahVqFdDlM+QfSlJO65N7Y6s8CismBxubN
bGiOW37w7Bmi4mVHO5RWa3uelcwjoA==
=D9Sa
-----END PGP SIGNATURE-----

--8zb502i0uNK5UHJJl43MN65Z2VSqAtFfM--
