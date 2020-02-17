Return-Path: <leonardo@linux.ibm.com>
Message-ID: <d0789485cc353a99e19c2d2ca4b5a628a33a312d.camel@linux.ibm.com>
Subject: Re: [PATCH v6 02/11] mm/gup: Use functions to track lockless pgtbl
 walks on gup_pgd_range
From: Leonardo Bras <leonardo@linux.ibm.com>
Date: Mon, 17 Feb 2020 17:55:49 -0300
In-Reply-To: <0c2f5a89-4890-fd84-6a6d-e470ba110399@nvidia.com>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
	 <20200206030900.147032-3-leonardo@linux.ibm.com>
	 <760c238043196e0628c8c0eff48a8e938ef539ba.camel@linux.ibm.com>
	 <0c2f5a89-4890-fd84-6a6d-e470ba110399@nvidia.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-KK5vvDthaVYFFka5IIPv"
MIME-Version: 1.0
To: John Hubbard <jhubbard@nvidia.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200217205549.I1xqYPZ6SarsV8mBS-eCT2ktur-Iwl3Jx_BHet9I-1E@z>


--=-KK5vvDthaVYFFka5IIPv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello John, comments inline;

On Fri, 2020-02-07 at 14:54 -0800, John Hubbard wrote:
> On 2/5/20 7:25 PM, Leonardo Bras wrote:
> > On Thu, 2020-02-06 at 00:08 -0300, Leonardo Bras wrote:
> > >                 gup_pgd_range(addr, end, gup_flags, pages, &nr);
> > > -               local_irq_enable();
> > > +               end_lockless_pgtbl_walk(IRQS_ENABLED);
> > >                 ret =3D nr;
> > >         }
> > > =20
> >=20
> > Just noticed IRQS_ENABLED is not available on other archs than ppc64.
> > I will fix this for v7.
> >=20
>=20
> What's the fix going to look like, approximately?

I am not sure what is the best approach yet.=20

1. On irq_mask =3D=3D 0, always enable irq on end_lockless_pgtbl_walk().
   Not sure how bat would that affect other archs.

2. Add another function like end_lockless_pgtbl_walk_irqen() that
always enables IRQ.

3. Add another parameter in end_lockless_pgtbl_walk(), so that caller
can choose ii IRQ must be enabled.

Also, not sure if internal_get_user_pages_fast() can possibly be called
with IRQ disabled, and then return with it enabled. Maybe just
saving/restoring should be fine.

Other suggestions are welcome.

>=20
>=20
> thanks,

Best regards,

Leonardo Bras

--=-KK5vvDthaVYFFka5IIPv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl5K/dUACgkQlQYWtz9S
ttSomhAAti45bC0hpcyFr3ix4l0vnXi071xBs+ZLvF+V2qK1wpmBPe1ke3hfm45y
7rd5whdeNR8cPfsXPKwerT1oB7rJXhiGQa5Vt1pNlvFXVKs+IBZr+S7JAJjIFxW+
nPHLV4LaOnkRgg8p1tusLTJXXkPD/PYBqVu5vwWk4cI/uXmO6MjQ9ARPpc0bQYUY
Ds8v/GoaVuGn1kf2YVIUtJlQSF2gdKAxUnTh6hmUXcwpB0Ao3tKeE+4bESkipSRg
vlJ3aJpi72K160R3b+UwGjHLAixSsRr3pSvkqKU/B2lUEaJO99mu01NWR/X4OtVc
8h1+tgjwjZSiIa0DJfwn44beonO8oHFTE1VpmZMxpwVMoRxVUvzIrhuDaLfKlSIE
dlbKs43NjTvwQu5RScWqDR5u2w6q7LLXtCoLbq9JDDOf8kt9GX6SOp3NLopWqY4x
/BSh0UYIkBlBCAY/LXdNL1C0D8g/h8MpoOyxyKzsmZQmgLJPEtDq/Gqkdsf4jtBq
E3Ma6KYyl0wTfbQtp7iNERDukt0R2j8+meZ5ad2WUJ7GujVCp/S8ky+88jLB8eNx
o96tDhPvhT0VBcfIrGsnAnE1CyJFgFiBF4k7Xwi7To6z5teTWfhc5z6mDfBgVH1l
lhtHrLkT3aJxP48InKKPe7TMb2ghIzHMy9bSC1AaIgEW5zxzr8A=
=UpXg
-----END PGP SIGNATURE-----

--=-KK5vvDthaVYFFka5IIPv--
