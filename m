From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] arch/*/asm/include/bitops.h: api issue, find_*_bit()
 defination are different with each other
Date: Wed, 5 Jun 2013 09:19:15 +0200
Message-ID: <20130605071915.GK23140@pengutronix.de>
References: <51AE8FEF.1020809@asianux.com>
 <51AE903C.6010806@asianux.com>
 <51AE909D.9080006@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51AE909D.9080006@asianux.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Hello,

On Wed, Jun 05, 2013 at 09:13:01AM +0800, Chen Gang wrote:
>=20
> For arm and m68k, they customize find_*_bit(), but the API is differe=
nt
> with 'generic'.
>=20
> avr32, s390, and unicore32 also customize find_*_bit(), but the API i=
s
> the same with 'generic', and the left architectures all use 'generic'=
=2E
>=20
> So need change arm and m68k related API to match the 'generic', then
> all another modules can face same public API for various architecture=
s.
>=20
> Also beautify code and comments to pass "./scripts/checkpatch.pl"
>=20
>=20
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/include/asm/bitops.h  |   26 ++++++++++++++++++--------
>  arch/arm/lib/findbit.S         |   14 ++++++++++----
>  arch/m68k/include/asm/bitops.h |   25 ++++++++++++++-----------
>  3 files changed, 42 insertions(+), 23 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bit=
ops.h
> index e691ec9..10566c8 100644
> --- a/arch/arm/include/asm/bitops.h
> +++ b/arch/arm/include/asm/bitops.h
> @@ -161,18 +161,28 @@ extern int _test_and_change_bit(int nr, volatil=
e unsigned long * p);
>  /*
>   * Little endian assembly bitops.  nr =3D 0 -> byte 0 bit 0.
>   */
> -extern int _find_first_zero_bit_le(const void * p, unsigned size);
> -extern int _find_next_zero_bit_le(const void * p, int size, int offs=
et);
> -extern int _find_first_bit_le(const unsigned long *p, unsigned size)=
;
> -extern int _find_next_bit_le(const unsigned long *p, int size, int o=
ffset);
> +extern unsigned long  _find_first_zero_bit_le(const void *p,
doesn't checkpatch critizise the double space in the line above?

> +						unsigned long size);
> +extern unsigned long _find_next_zero_bit_le(const void *p, unsigned =
long size,
> +						unsigned long offset);
> +extern unsigned long _find_first_bit_le(const unsigned long *p,
> +						unsigned long size);
> +extern unsigned long _find_next_bit_le(const unsigned long *p,
> +						unsigned long size,
> +						unsigned long offset);
> =20
>  /*
>   * Big endian assembly bitops.  nr =3D 0 -> byte 3 bit 0.
>   */
> -extern int _find_first_zero_bit_be(const void * p, unsigned size);
> -extern int _find_next_zero_bit_be(const void * p, int size, int offs=
et);
> -extern int _find_first_bit_be(const unsigned long *p, unsigned size)=
;
> -extern int _find_next_bit_be(const unsigned long *p, int size, int o=
ffset);
> +extern unsigned long _find_first_zero_bit_be(const void *p,
> +						unsigned long size);
> +extern unsigned long _find_next_zero_bit_be(const void *p, unsigned =
long size,
> +						unsigned long offset);
> +extern unsigned long _find_first_bit_be(const unsigned long *p,
> +						unsigned long size);
> +extern unsigned long _find_next_bit_be(const unsigned long *p,
> +						unsigned long size,
> +						unsigned long offset);
> =20
>  #ifndef CONFIG_SMP
>  /*
> diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
> index 64f6bc1..9e3263a 100644
> --- a/arch/arm/lib/findbit.S
> +++ b/arch/arm/lib/findbit.S
> @@ -19,7 +19,8 @@
> =20
>  /*
>   * Purpose  : Find a 'zero' bit
> - * Prototype: int find_first_zero_bit(void *addr, unsigned int maxbi=
t);
> + * Prototype: unsigned long  find_first_zero_bit(const void *p,
here is another one.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
