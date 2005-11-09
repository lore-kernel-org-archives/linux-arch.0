Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 9 Nov 2005 15:30:23 +0200
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: irq-type-flags.patch
Message-ID: <20051109133023.GD17992@linux-sh.org>
References: <20051108191057.09f57114.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <20051108191057.09f57114.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2005 at 07:10:57PM -0800, Andrew Morton wrote:
> Is everyone OK with this?
>=20
Looks fine to me, especially if it gets that set_irq_type() stuff out of
some of the drivers.

> diff -puN arch/arm/kernel/irq.c~irq-type-flags arch/arm/kernel/irq.c
> --- devel/arch/arm/kernel/irq.c~irq-type-flags	2005-11-06 00:55:46.000000=
000 -0800
> +++ devel-akpm/arch/arm/kernel/irq.c	2005-11-06 00:55:46.000000000 -0800
> @@ -681,10 +681,16 @@ int setup_irq(unsigned int irq, struct i
>  	 */
>  	desc =3D irq_desc + irq;
>  	spin_lock_irqsave(&irq_controller_lock, flags);
> +#define SA_TRIGGER	(SA_TRIGGER_HIGH|SA_TRIGGER_LOW|\
> +			 SA_TRIGGER_RISING|SA_TRIGGER_FALLING)
>  	p =3D &desc->action;
>  	if ((old =3D *p) !=3D NULL) {
> -		/* Can't share interrupts unless both agree to */
> -		if (!(old->flags & new->flags & SA_SHIRQ)) {
> +		/*
> +		 * Can't share interrupts unless both agree to and are
> +		 * the same type.
> +		 */
> +		if (!(old->flags & new->flags & SA_SHIRQ) ||
> +		    (~old->flags & new->flags) & SA_TRIGGER) {
>  			spin_unlock_irqrestore(&irq_controller_lock, flags);
>  			return -EBUSY;
>  		}
> diff -puN include/linux/signal.h~irq-type-flags include/linux/signal.h
> --- devel/include/linux/signal.h~irq-type-flags	2005-11-06 00:55:46.00000=
0000 -0800
> +++ devel-akpm/include/linux/signal.h	2005-11-06 00:55:46.000000000 -0800
> @@ -18,6 +18,14 @@
>  #define SA_PROBE		SA_ONESHOT
>  #define SA_SAMPLE_RANDOM	SA_RESTART
>  #define SA_SHIRQ		0x04000000
> +/*
> + * As above, these correspond to the __IRQT defines in asm-arm/irq.h
> + * to select the interrupt line behaviour.
> + */
> +#define SA_TRIGGER_HIGH		0x00000008
> +#define SA_TRIGGER_LOW		0x00000004
> +#define SA_TRIGGER_RISING	0x00000002
> +#define SA_TRIGGER_FALLING	0x00000001
> =20
>  /*
>   * Real Time signals may be queued.
> _
It probably makes sense to move SA_TRIGGER here as well, as it's going to
be a pretty common mask. Otherwise everyone that plans to make use of
this will likely end up duplicating it.

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDcfnv1K+teJFxZ9wRAmrbAJ9ulOdhbMFmaz7XHHjASVPz4h0pVwCfWXXY
56l+nPwfZggtdfuoWHj2Mf0=
=JhO2
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
