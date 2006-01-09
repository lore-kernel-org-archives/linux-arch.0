Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:51367 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1751248AbWAIMAd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2006 07:00:33 -0500
Date: Mon, 9 Jan 2006 23:00:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Adding compat_ptrace_request
Message-Id: <20060109230017.6ca9aed6.sfr@canb.auug.org.au>
In-Reply-To: <20060109.010355.69867251.davem@davemloft.net>
References: <20060109065914.GS26499@krispykreme>
	<20060109.010355.69867251.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__9_Jan_2006_23_00_17_+1100_h3TwGJhQhw+5X6Rw"
Sender: linux-arch-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: anton@samba.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Mon__9_Jan_2006_23_00_17_+1100_h3TwGJhQhw+5X6Rw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 09 Jan 2006 01:03:55 -0800 (PST) "David S. Miller" <davem@davemloft=
.net> wrote:
>
> > +		return copy_siginfo_to_user32(data, &lastinfo);
>=20
> It would be nice to rename this copy_siginfo things to not
> have "32" and instead "compat" in their names.

I agree entirely.  Can I do that as a separate patch on top of this one?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__9_Jan_2006_23_00_17_+1100_h3TwGJhQhw+5X6Rw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDwlBYFdBgD/zoJvwRAl2+AJ4hJhhumx6N4q4V0UqkrWmNnYPulQCffcR4
TGNfliLwOiZX4WPZjI7RPT8=
=c/HL
-----END PGP SIGNATURE-----

--Signature=_Mon__9_Jan_2006_23_00_17_+1100_h3TwGJhQhw+5X6Rw--
