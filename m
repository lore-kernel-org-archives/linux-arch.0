From: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Subject: Re: [PATCH] All Arch: remove linkage for sys_nfsservctl system call
Date: Tue, 30 Aug 2011 08:57:52 +1000
Message-ID: <20110830085752.6db1ffa600f4c82135b3f3eb@canb.auug.org.au>
References: <1312810169.2591.1153.camel@deadeye>
	<20110808155538.GB904@fieldses.org>
	<20110808180658.GC29924@decadent.org.uk>
	<20110826220311.GA18140@fieldses.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__30_Aug_2011_08_57_52_+1000_Uw9KG.Cbr6Myuj=k"
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110826220311.GA18140-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>, Neil Brown <neilb-l3A5Bk7waGM@public.gmane.org>, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

--Signature=_Tue__30_Aug_2011_08_57_52_+1000_Uw9KG.Cbr6Myuj=k
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bruce,

On Fri, 26 Aug 2011 18:03:11 -0400 "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>=
 wrote:
>
> From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
>=20
> The nfsservctl system call is now gone, so we should remove all
> linkage for it.
>=20
> Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
> Signed-off-by: J. Bruce Fields <bfields-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>=20
> I don't normally have to deal with this kind of cross-architecture
> patch; is this the right etiquette for it?

It turns out (with hindsight) that my reaction to this patch should have
been:

If you haven't built this on all architectures (an noone expects you to
actually do that), then it should spend a day or two in linux-next before
being sent to Linus.

--=20
Cheers,
Stephen Rothwell                    sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__30_Aug_2011_08_57_52_+1000_Uw9KG.Cbr6Myuj=k
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOXBlwAAoJEDMEi1NhKgbssnMH/0Bb99IHgDTSfYa3/mtwN+Rg
JFZiEYu/kaqLwT9lBx2xElHwjRBb+Moi+GHdFcQYV2YtOKldJqeVptEFHLQScuHK
i2T3bYz2WjIRkfYjp58smmLk6pByLMDJBjO1E+x3MCiENvvze501nqooyrbd4eA0
Oa7dwrIKosmZBNImuZfpBIdmOELQo6n5ewqyXqKFB+g/YRAiifhj2Pq1pMuawPxa
JiEFywkrJuOSs8F6bk/p2WLydH70piIzdJsHxKisE0Pqvy1shHXS782gv/LTDWZp
UjaQ2e+CdmmHmm/6lMCoemwOfYX13O0lmXdJa2kPKuBukadH/SsBsrpFv0UghVY=
=zdQQ
-----END PGP SIGNATURE-----

--Signature=_Tue__30_Aug_2011_08_57_52_+1000_Uw9KG.Cbr6Myuj=k--
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
