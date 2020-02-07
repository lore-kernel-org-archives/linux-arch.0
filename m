Return-Path: <leonardo@linux.ibm.com>
Message-ID: <e7f183cc19815ed07822707508d0caf4f7530216.camel@linux.ibm.com>
Subject: Re: [PATCH v6 01/11] asm-generic/pgtable: Adds generic functions to
 track lockless pgtable walks
From: Leonardo Bras <leonardo@linux.ibm.com>
Date: Thu, 06 Feb 2020 23:19:45 -0300
In-Reply-To: <f55e593c-27d5-df12-602f-ea217f62c5a1@c-s.fr>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
	 <20200206030900.147032-2-leonardo@linux.ibm.com>
	 <f55e593c-27d5-df12-602f-ea217f62c5a1@c-s.fr>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-A/nJhzVPw0FwclUgBET/"
MIME-Version: 1.0
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200207021945.5R_XnERUqVFZp9c5FdL9JfVRNQW6gc4soTO2Xgm_xz8@z>


--=-A/nJhzVPw0FwclUgBET/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Christophe, thanks for the feedback!

On Thu, 2020-02-06 at 06:54 +0100, Christophe Leroy wrote:
> > A memory barrier was also added just to make sure there is no speculati=
ve
> > read outside the interrupt disabled area. Other than that, it is not
> > supposed to have any change of behavior from current code.
>=20
> Is that speculative barrier necessary for all architectures ? Does it=20
> impact performance ? Shouldn't this be another patch ?

It makes sense, better keep the code as much as possible as it was. If
any arch finds this barrier needed, it can implement it's own version
of this function (or another patch to add this to generic, if proved to
be needed in every arch).

> > +#ifndef __HAVE_ARCH_LOCKLESS_PGTBL_WALK_CONTROL
> > +/*
> > + * begin_lockless_pgtbl_walk: Must be inserted before a function call =
that does
> > + *   lockless pagetable walks, such as __find_linux_pte()
> > + */
> > +static inline
> > +unsigned long begin_lockless_pgtbl_walk(void)
>=20
> What about keeping the same syntax as local_irq_save(), something like:
>=20
> #define begin_lockless_pgtbl_walk(flags) \
> do {
> 	local_irq_save(flags);
> 	smp_mb();
> } while (0)
>=20

Makes sense. But wouldn't inlining have the same code output?=20

Best regards,
Leonardo Bras


--=-A/nJhzVPw0FwclUgBET/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl48yUEACgkQlQYWtz9S
ttRXxxAAhPXA0Cd48ZAtBfcOadiRsa1Amc03sprshQLV/+pQx2/U47Nl7YqtozUl
pxTnysv8mkdxPHoYnQk5XDRSxTLewF+w3F9hTFAfOM6F3UIA2bUsby0SPIR/04a0
1enrJ6U1qElB8wk/8Ncur2YVPzFgKmgpQI+i1n7NrGIuN2mHmmzrM3OLZf3H0BpL
3jKzZWwIoa3waO81mtVyij8gctwpk2bzoUJGs6XsvBKZMCbZdiZVyWedn5kEpM5m
an0wmHQdta85iK9XysKm55Oe0PYhmm0K9pH4sNYFWuMcC2oKtyizbiV3wq3sjpau
XSg/9koTmUowiQzTIUoCYut0UxuLjD0WfzzoR1EKcb07dFCMwkjn9jDHOQW9eSMo
9PhMEgZ2i1n463YUxhpUYXbZkqML+IQ6VLc4ZgyJdj7c+RVJSbT4GOwxBABnN58p
iEFNVDmoS1+CVUq3Ysvsw2KtM2oGxsn7sx/69KesxEHXiytgs7afyOYacGV0fx5R
OXuNlW3g5ODGdayMcXbEXY0C492e07CnMvTZvbMhwGs7YeIZUb+JfMwFpQAeSP1w
XOYl4h9YxS1sgB2gUSZc0ETfXDeeOxB9RZ1j817ySEMfn/XCUjyexOnsqBnNGbpM
AcWwHPwmdCYOKyWFTcej/u/8fxGkYgYZldd/GxcYTGaFy8IudyM=
=E/z0
-----END PGP SIGNATURE-----

--=-A/nJhzVPw0FwclUgBET/--
