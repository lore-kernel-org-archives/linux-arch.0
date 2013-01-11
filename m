From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v3 00/44] Meta Linux Kernel Port
Date: Sat, 12 Jan 2013 00:03:36 +1100
Message-ID: <20130112000336.1f24c42237fab4fe0c305ff6@canb.auug.org.au>
References: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com>
	<20130111103442.b80ddbfb11ef322ed28ca3b3@canb.auug.org.au>
	<50EFD824.3010502@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Sat__12_Jan_2013_00_03_36_+1100_88aUAhPAZ.vJ83S1"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from haggis.pcug.org.au ([203.10.76.10]:38362 "EHLO
	members.tip.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab3AKNDs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Jan 2013 08:03:48 -0500
In-Reply-To: <50EFD824.3010502@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

--Signature=_Sat__12_Jan_2013_00_03_36_+1100_88aUAhPAZ.vJ83S1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi James,

On Fri, 11 Jan 2013 09:15:16 +0000 James Hogan <james.hogan@imgtec.com> wro=
te:
>
> On 10/01/13 23:34, Stephen Rothwell wrote:
> > You really should not base development work on linux-next and before I
> > can include it there you will need to rebase it onto Linus' tree (or so=
me
> > other tree that does not rebase).  Its OK to test by doing a merge with
> > linux-next ...
>=20
> Thanks for the info Stephen. So I suppose if the patchset depended on
> things in -next the normal way to do it would be to merge in the
> individual trees I needed first?

Yep, but please let the maintainers of those trees know that you expect
their tree to not be rebased.  Or, if if they aren't really dependencies
just conflicts, then leave the other tree out and let me and Linus fix
the conflicts when we merge your tree.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Sat__12_Jan_2013_00_03_36_+1100_88aUAhPAZ.vJ83S1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQ8A2oAAoJEECxmPOUX5FEy0kP/0KXjBA9LnJ9I0fed4BdYHMM
RhldOvQWyOdqIzG4JwGvOdDeZxlv1lRE7hdeyyC5O+WSDR9XTjj3HcrvtOo0GhUU
30ulvxpQvhzHago7c0guAWfrxcPWGidWBU8K7W8HfeR4/le8MlrBSaRU+YmJFoFY
00QRWcMbyt/CobtwcklqxQb0HJYyN/WieHu7BOi3oskPZh+UA2UEov1CXJVlyT9G
lsx82U2e1OO77CBUurMLYKnGn8trP6YIVyEFTRu0/IyP7knBO7w4GOarCqhiXQ18
nedZzOKTNAps/Z3fukkzeLuZ0L8rHF17MaPvlOSRPnrhfmtQP0P1eyS02tcZDDCU
UZn8HMVWTgfJ+iGvioDpeUrB0Jh5MoiNELxcqHSZXsYvozpRdkRW6W5Xq/B61npr
jGk/VlKHKnDS8tQhw6i9EunmbsajZJNszO4Ondz6JTtNznrlB/OPfYGJa/4f5UEV
r6uS0YrloCHe+axo6Vmbk9A7yOzVlVhMIea39RRKz1N3v13nDpExB2+e48slz1qV
A37ESt6zE0yAX0Cs4G6N5ZhU4PPOGKO9DmlTKbirk0Sgt5geYlRFW+UWvXy9o5aG
5bLHwrMA5RXjWnfyI3IHklgEaWjGdnPsdsGzSFCPvpTdQpyOZ4P4hqLHBqQDpvUb
v2U++lfqxTmcXRT4NJLm
=Pszm
-----END PGP SIGNATURE-----

--Signature=_Sat__12_Jan_2013_00_03_36_+1100_88aUAhPAZ.vJ83S1--
