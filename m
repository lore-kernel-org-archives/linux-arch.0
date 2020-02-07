From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH v6 07/11] powerpc/kvm/e500: Use functions to track
 lockless pgtbl walks
Date: Fri, 07 Feb 2020 00:10:02 -0300
Message-ID: <34c67571bf366886aa8298373f3887f476b811a2.camel@linux.ibm.com>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
         <20200206030900.147032-8-leonardo@linux.ibm.com>
         <fae235d5-78b6-87aa-ed3f-1a908d61abf4@c-s.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-XtWHJcJJjtE0nWIZHITR"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fae235d5-78b6-87aa-ed3f-1a908d61abf4@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org


--=-XtWHJcJJjtE0nWIZHITR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Christophe,=20

On Thu, 2020-02-06 at 07:18 +0100, Christophe Leroy wrote:
>=20
> I don't really like unbalanced begin/end.
>=20
> Something like the following would be cleaner:
>=20
>=20
> begin_lockless_pgtbl_walk()
> ptep =3D find()
> if (ptep) {
> 	pte =3D READ_ONCE()
> 	if (pte_present(pte))
> 		wing=3D
> 	else
> 		ret =3D -EINVAL;
> }
> end_lockless_pgtbl_walk()
>=20
> if (ret) {
> 	pr_err_rate...()
> 	goto out;
> }
>=20
>=20

Sure, looks better that way. I will change that for v7.

Thanks for the feedback,

Leonardo Bras

--=-XtWHJcJJjtE0nWIZHITR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl481QoACgkQlQYWtz9S
ttTcdA//Xke6/twgyWIan1bRF0vWJ3qSy+yFDyf4csKImVLRQqAa/asW4bIBwGZS
re3EzPV46Nuq6ZAg64yxwOokHEfwY1cdOmSCVmxZf0SUGViqZ2whL/CCED2H+f7f
Lt+hw1ibONlzz8AvDLtplxj18Uc58G9mrXOOxLEz2LzqXrsL1AU/15R+NiDPaK1N
lW5kxUsb8jHHzIOXem9B2aQRFDoCCx0uJzhNJn13ft30PZeaanSUNYqSuEa67tlA
7iFqrtoLCD7KKXLNbvAh+43w+lvpEqRf9MBt7SoCXJQWCVrIXhj4yI3dbRaePyf3
jY3vXrk/TapcfQQceptI47oaOtptRJ2MBntJYdh/kUYhLpy61px3q1mJvy4qZOrO
gm9Y2YfVGf23zkcc9/YzOfOm0t+tf5VKUQj4a0rCIuSj/EgHW2vj3pq85Vt2PUB/
aGp88Aosd2Wz3pqQ7aGsasy7vKlSc/nVOgItr/9Y8q51y3DdYkw+rUqqqZK4JH1h
4qRGpb4jp2mZZdzvxxCklhHdqXNwLdSW+d6ZBYEww0N6T5aNCPp1hAAY16I9ZmYF
AE/ZMZjVc9UNYqA9bHE29IETN0vuv8AIaREvwoK27Oip8cnhLpf8FA2uMWW80AcL
7yw4v3Cojj76UcRoZkMRNCutFnPeIr7EUc5Po2GqKSMXQAYLLu8=
=ZwdP
-----END PGP SIGNATURE-----

--=-XtWHJcJJjtE0nWIZHITR--
