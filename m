From: Michael Ellerman <michael-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
Subject: Re: [PATCH 1/2] Add thread_info_cache_init() to all archs
Date: Fri, 18 Apr 2008 14:38:55 +1000
Message-ID: <1208493535.9319.3.camel@concordia.ozlabs.ibm.com>
References: <20080410032354.90CB1DDF0F@ozlabs.org>
	 <20080413171953.bde5e9ac.akpm@linux-foundation.org>
	 <1208133506.6958.82.camel@pasglop>
	 <20080413191338.9776ebd0.akpm@linux-foundation.org>
	 <1208491086.6958.381.camel@pasglop>
	 <20080417211905.8ff769fa.akpm@linux-foundation.org>
Reply-To: michael-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FDPfa9rGsj0DdIbVrzKH"
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080417211905.8ff769fa.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
Cc: Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-m32r-rQhvJZKUsGBRYuoOT4C5/9i2O/JbrIOy@public.gmane.org, takata-TMSiXQfHlQjsTix1lMzHGQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>


--=-FDPfa9rGsj0DdIbVrzKH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-04-17 at 21:19 -0700, Andrew Morton wrote:
> On Fri, 18 Apr 2008 13:58:06 +1000 Benjamin Herrenschmidt <benh-mnsaURCQ41tQFI55V6+gNQ@public.gmane.org=
g> wrote:
>=20
> >=20
> > > > > otoh, if only one .c file will ever call this function then I thi=
nk that
> > > > > all problems are solved by
> > > > >=20
> > > > > a) moving the above ifdeffery into the .c file
> > > > > b) adding a comment explaining which arch file must provide the o=
verride
> > > > > c) directly including that file from within the .c file.
> > > >=20
> > > > I can definitely do that. I have no problem either way. I can add t=
o all
> > > > archs too, it's just that whatever way I choose, some people won't =
be
> > > > happy with it :-)
> > > >=20
> > > > Anyway, I'll move the ifdeferry to init/main.c then.
> > >=20
> > > Thanks ;)
> > >=20
> > > I'm still wounded by my recent encounter with set_softirq_pending()
> > > and or_softirq_pending().
> >=20
> > Well, looking there, I saw we already used weak symbols for that
>=20
> Yes, `weak' is a nice solution.  It does add a few bytes of text which we
> could avoid with compile-time trickery, but only a very few.
>=20
> Plus this is __init anyway, although I don't know how well the combinatio=
n
> of `weak' and __init works.
>=20
> > +void __init __attribute__((weak) thread_info_cache_init(void)
>=20
> s/weak)/weak))/

There's also a #define of this called "__weak" if you like, less typing
and less ugly.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-FDPfa9rGsj0DdIbVrzKH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBICCXfdSjSd0sB4dIRAhE1AJ9ZHfHcu3unHY6kSWfP0t+aNTPkKQCeI0zj
966HGDJEisppeO7PrUitiG8=
=RoAh
-----END PGP SIGNATURE-----

--=-FDPfa9rGsj0DdIbVrzKH--
