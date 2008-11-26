From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RESEND:PATCH] [ARM] clearpage: provide our own
 clear_user_highpage()
Date: Thu, 27 Nov 2008 10:29:20 +1100
Message-ID: <20081127102920.660303a5.sfr@canb.auug.org.au>
References: <20081126171321.GA4719@dyn-67.arm.linux.org.uk>
	<1227719999.3387.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__27_Nov_2008_10_29_20_+1100_A_H1BS4hZ8UrVxla"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:43342 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755380AbYKZX3j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 Nov 2008 18:29:39 -0500
In-Reply-To: <1227719999.3387.0.camel@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-arch@vger.kernel.org, Linux Kernel List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org

--Signature=_Thu__27_Nov_2008_10_29_20_+1100_A_H1BS4hZ8UrVxla
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Russell,

On Wed, 26 Nov 2008 11:19:59 -0600 James Bottomley <James.Bottomley@HansenP=
artnership.com> wrote:
>
> We'd like to pull this trick on parisc as well (another VIPT
> architecture), so you can add my ack.

If this is going to be used by more than one architecture during the next
merge window, then maybe the change to include/linux/highmem.h could be
extracted to its own patch and sent to Linus for inclusion in 2.6.28.
This way we avoid some conflicts and the architectures can do their
updates independently.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__27_Nov_2008_10_29_20_+1100_A_H1BS4hZ8UrVxla
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkt29AACgkQjjKRsyhoI8xlNwCdGtzz8Xqry+Mfoeqsp2kwONKg
QngAmwXaEVGMYIhL6oXlTDd1UfEWjmu9
=nQwJ
-----END PGP SIGNATURE-----

--Signature=_Thu__27_Nov_2008_10_29_20_+1100_A_H1BS4hZ8UrVxla--
