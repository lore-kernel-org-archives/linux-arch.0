From: Trond Myklebust <Trond.Myklebust-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
Subject: Re: still nfs problems [Was: Linux 2.6.37-rc8]
Date: Mon, 10 Jan 2011 14:29:27 -0500
Message-ID: <1294687767.3349.28.camel@heimdal.trondhjem.org>
References: <AANLkTimusF4KCJ4vHPn+T1dUiKxapXaT0QTtFvh8Ykdd@mail.gmail.com>
	 <1294426405.2929.23.camel@heimdal.trondhjem.org>
	 <20110107190229.GX31708@n2100.arm.linux.org.uk>
	 <1294427467.4895.66.camel@mulgrave.site>
	 <1294505384.4181.14.camel@heimdal.trondhjem.org>
	 <1294528551.4181.19.camel@heimdal.trondhjem.org>
	 <20110110105019.GC24920@pengutronix.de>
	 <1294676734.3349.10.camel@heimdal.trondhjem.org>
	 <4D2B3D03.8050504@pengutronix.de>
	 <1294680035.3349.19.camel@heimdal.trondhjem.org>
	 <20110110192552.GG24920@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110110192552.GG24920-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Parisc List <linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, James Bottomley <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Marc Kleine-Budde <m.kleine-budde-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Mon, 2011-01-10 at 20:25 +0100, Uwe Kleine-K=C3=B6nig wrote:=20
> Hello Trond,
>=20
> On Mon, Jan 10, 2011 at 12:20:35PM -0500, Trond Myklebust wrote:
> > On Mon, 2011-01-10 at 18:08 +0100, Marc Kleine-Budde wrote:=20
> > > On 01/10/2011 05:25 PM, Trond Myklebust wrote:
> > > > On Mon, 2011-01-10 at 11:50 +0100, Uwe Kleine-K=C3=B6nig wrote:=
=20
> > > >> Hi Trond,
> > > >>
> > > >> On Sat, Jan 08, 2011 at 06:15:51PM -0500, Trond Myklebust wrot=
e:
> > > >>> -------------------------------------------------------------=
----------------------=20
> > > >> It would be great if you could add a "8<" in the line above ne=
xt time.
> > > >> Then git-am -c does the right thing (at least I think so).
> > > >=20
> > > > Sorry. I wasn't aware of that particular idiom. So something li=
ke
> > > >=20
> > > > 8<------------------------------------------------------------
> > > > From: Trond Myklebust <Trond.Myklebust-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
> > > > Subject: .....
> > >=20
> > > Yes.
> > >=20
> > > From "man git-mailinfo":
> > > "A line that mainly consists of scissors (either ">8" or "8<") an=
d
> > > perforation (dash "-")"
> > >=20
> > > BTW:
> > > Is this patch a candidate for stable?
> >=20
> > Yes. I'm planning on sending it to the stable list after Linus merg=
es it
> > into mainline.
> So there is another idiom for you:  just put
>=20
> 	Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
>=20
> in the S-o-b block and Greg will pick it off "automatically".  (Just =
in
> case you don't know, and if you do, maybe someone else learned
> something.)

I usually do this, but there is a slight problem with that approach:
Greg gets to do all the work of figuring out to which stable kernels
this particular patch applies. In this case, since we're only talking
about the 2.6.37 kernel, I prefer to use the mailing lists.

Cheers
  Trond
--=20
Trond Myklebust
Linux NFS client maintainer

NetApp
Trond.Myklebust-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org
www.netapp.com

--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
