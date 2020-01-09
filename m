Return-Path: <SRS0=HEsX=26=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgAIGEs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Jan 2020 01:04:48 -0500
Subject: Re: [PATCH v2 6/9] drm/mgag200: Constify ioreadX() iomem argument (as
 in generic implementation)
References: <20200108200528.4614-1-krzk@kernel.org>
 <20200108200528.4614-7-krzk@kernel.org>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <ff03b149-b825-47f3-f92e-100899bb05fd@suse.de>
Date: Thu, 9 Jan 2020 07:04:36 +0100
MIME-Version: 1.0
In-Reply-To: <20200108200528.4614-7-krzk@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3rd3nqEKmviIlgYXLgxkt4GDz8CFTZqke"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Vineet Gupta <vgupta@synopsys.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jiri Slaby <jirislaby@gmail.com>, Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, linux-media@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-ntb@googlegroups.com, virtualization@lists.linux-foundation.org, linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3rd3nqEKmviIlgYXLgxkt4GDz8CFTZqke
Content-Type: multipart/mixed; boundary="EqxkoMtfePcRgHH0AtAZfgeT52t9h5L9b";
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
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-ntb@googlegroups.com, virtualization@lists.linux-foundation.org,
 linux-arch@vger.kernel.org
Message-ID: <ff03b149-b825-47f3-f92e-100899bb05fd@suse.de>
Subject: Re: [PATCH v2 6/9] drm/mgag200: Constify ioreadX() iomem argument (as
 in generic implementation)
References: <20200108200528.4614-1-krzk@kernel.org>
 <20200108200528.4614-7-krzk@kernel.org>
In-Reply-To: <20200108200528.4614-7-krzk@kernel.org>

--EqxkoMtfePcRgHH0AtAZfgeT52t9h5L9b
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 08.01.20 um 21:05 schrieb Krzysztof Kozlowski:
> The ioreadX() helpers have inconsistent interface.  On some architectur=
es
> void *__iomem address argument is a pointer to const, on some not.
>=20
> Implementations of ioreadX() do not modify the memory under the address=

> so they can be converted to a "const" version for const-safety and
> consistency among architectures.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

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


--EqxkoMtfePcRgHH0AtAZfgeT52t9h5L9b--

--3rd3nqEKmviIlgYXLgxkt4GDz8CFTZqke
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl4WwngACgkQaA3BHVML
eiOKNgf/dNIJuZ1NzHHcf9BEmT/BV7QlRe6/FHHA4aiJdqTNYEZ4xQWzoZBT3FUD
+t1ZzbPtJWF3dx/Bi2AyeI9UK9D5lqSqMPpjgfAgMdT60DkhStpiz4k80WtBG7NY
dDcotCOrSeaYxImtCFAchwYcIw0l/cAD/ohiQYTfXx3FRj2Sb2hRIKx2h5Mr7k6G
3lSOqlEt69S2/G/Xlb37VeI2f07RsVR+b89pQPgS5WWUyITa5ukgxWrI5sc7Sn5U
ogamIdJCPT06fCNVF1JRsOBlI4qw+LNh5Z63REuA8V0qPytUKOW9kdxMwUlhkZJ/
bQNkg8ibheQ3Xn8Bq6EjM/UUSS7XyQ==
=C0TM
-----END PGP SIGNATURE-----

--3rd3nqEKmviIlgYXLgxkt4GDz8CFTZqke--
