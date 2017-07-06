From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 2/9] RISC-V: Atomic and Locking Code
Date: Thu, 6 Jul 2017 19:08:33 +0800
Message-ID: <20170706110833.fkq7axoz3tf655lz@tardis>
References: <20170704195102.3974-1-palmer@dabbelt.com>
 <20170704195102.3974-3-palmer@dabbelt.com>
 <20170705084321.hqy4qsm45mv772k4@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q3dwcrjsjsyfsy2u"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33241 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbdGFEMr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2017 00:12:47 -0400
Content-Disposition: inline
In-Reply-To: <20170705084321.hqy4qsm45mv772k4@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org


--q3dwcrjsjsyfsy2u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 10:43:21AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 04, 2017 at 12:50:55PM -0700, Palmer Dabbelt wrote:
> > +/*
> > + * FIXME: I could only find documentation that atomic_{add,sub,inc,dec=
} are
> > + * barrier-free.  I'm assuming that and/or/xor have the same constrain=
ts as the
> > + * others.
> > + */
>=20
> Yes.. we have new documentation in the work to which I would post a link
> but for some reason copy/paste stopped working again (Konsole does that
> at times and is #$%#$%#4# annoying).
>=20
> Ha, found it using google...
>=20
>   https://marc.info/?l=3Dlinux-kernel&m=3D14972790112580
>=20

The link is broken, you miss a tailing 1 ;-)

	https://marc.info/?l=3Dlinux-kernel&m=3D149727901125801

Regards,
Boqun

--q3dwcrjsjsyfsy2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlleGi0ACgkQSXnow7UH
+rhwZAf9H0VrHU8RmJVmTeZHFR/vOJ+bDZgjrIql1e6Czc3BNPsSse7hy+VZ9jBq
8IDtbAiOlkwV4XAaODDoNxORYTrsqDZnWrksQOXhNwyW/2+Lygj2VglLLuyh9pHa
tpZY90KzD+gLBa/9loJVGk+EfQicM/k6GyWu11i/V+BvyaKGfeHrJUanl91fdZwZ
9BNvCPB2yTeGcSXkXYXq1mthBlGBaX1ya/qftsYuj1HLK+YjSnXCkj5EvpyTXwZC
Zxm+TS7R0rPDut6ReVp22jywVKM3Y9OAvbz+DioS7sVRAhpTJ53Mbbp2gOEEEAa5
iCqVzUi0WS4RUTfDPK57X0VwHyFsUA==
=2fhb
-----END PGP SIGNATURE-----

--q3dwcrjsjsyfsy2u--
