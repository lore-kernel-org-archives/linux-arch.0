Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932942AbeBVQ3M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Feb 2018 11:29:12 -0500
Date: Thu, 22 Feb 2018 16:28:46 +0000
From: James Hogan <jhogan@kernel.org>
Subject: Re: Removing architectures without upstream gcc support
Message-ID: <20180222162845.GC9891@saruman>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Arnd,

On Thu, Feb 22, 2018 at 04:45:06PM +0100, Arnd Bergmann wrote:
> * Meta was ImgTec's own architecture and they upstreamed the kernel
>   port just before they acquired MIPS. Apparently Meta was abandoned
>   shortly afterwards and disappeared from imgtec's website in 2014.
>   The maintainer is still fixing bugs in the port, but I could not find
>   any toolchain more recent than
>   https://github.com/img-meta/metag-buildroot/tree/metag-core/toolchain/gcc/4.2.4
>   Not sure about this one, I'd be interested in more background
>   from James Hogan, who probably has an opinion and might have
>   newer toolchain sources.

Interesting timing! Have you seen this (which I'll send for 4.17, and
leave 4.16 broken)?

https://marc.info/?l=linux-kernel&m=151925667323732&w=2

The Meta port is essentially unused and for a while I have only looked
at it when something went wrong. PURE's Linux based digital radios I
believe were never updated to 3.10. The fact that the GCC port wasn't
upstreamed before the MIPS acquisition meant it was always a ticking
time bomb (though binutils was upstreamed).

Sad really, given that at least 9 years of effort went into the port
before permission was finally given to upstream it, and within a week or
so of the first patchset the intention to acquire MIPS was announced.

FWIW, my experience was that upstreaming the port caught a whole lot of
issues (Al Viro's review of signal handling alone was tremendously
valuable), and drastically reduced the effort required to forward port
to each new kernel version. Updating an out of tree arch tends to result
in a lot of runtime failures that require digging, which reduced
drastically once the port was upstreamed.

Cheers
James

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqO77MACgkQbAtpk944
dnputhAAkfYLuJ/+pWL1ry5oy3Xk3TmlljAgerL+KGaVt2HV7L4hmW1S0DrUW+mw
urkx6QVecme6pgvwEkJHGMHts75MxdWLXVU89JzXO0P4d5e0yLZ1H+LDlNA6dVby
xRU5v0xFGcg+1TTSwfdBjMRpL2NEGbZneXIX/QXQMFMqAB9XEMBY/I9yhYgrIrO/
5nl9EVo66OJJKl0OEl0hFlYx4R3ecXOw5vfpgJ7zzLWhD+YIw2ubwwcyBp9jFwVS
16Kupg6pjMMIpUueUlTCS1ft/I4s+c4YQ50EfTx0Du7PKnZhp7Bc2iovKuEgTRce
XQxyvVkSweVeak1ox6pGN8HIk0C2NndUDu9INwMr7qhv2UyyUQEwadplwsUhOE/8
suZnFvH/dTbUYBAeZvPJML88hL3ulPUKIMjC43IDh6HA3/QS4SpH2+atH1aYFlio
p7RZN15inJim2Cjqw8d4AoEs7wS73PvzrPBRYLffelIrIvtE/c4rEiazgmaX/cBQ
RKeYQ6dc+GMfaF2sOymgo/VvSIaes8Bw1wix15z6bYgCR4eRDVdHQKd2rU3I1Ky4
14BDo/sqmVlRQUrvh6/S9xjF6Zh+UvoHWMNu2B0KKSyWSrCKq1xyJwt7itBg0stm
2kET580orfXMQ/qZIzBuPHQAGA4FNG0Qb99FesFMxjtX+sL9UUw=
=tawg
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
