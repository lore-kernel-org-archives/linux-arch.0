Return-Path: <leonardo@linux.ibm.com>
Message-ID: <760c238043196e0628c8c0eff48a8e938ef539ba.camel@linux.ibm.com>
Subject: Re: [PATCH v6 02/11] mm/gup: Use functions to track lockless pgtbl
 walks on gup_pgd_range
From: Leonardo Bras <leonardo@linux.ibm.com>
Date: Thu, 06 Feb 2020 00:25:18 -0300
In-Reply-To: <20200206030900.147032-3-leonardo@linux.ibm.com>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
	 <20200206030900.147032-3-leonardo@linux.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-5TGq9qc6jmgO8SfflYEA"
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar
 K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200206032518.16R3AJSUXJEFxhuvXi1MvOwhRjZQPj0x2cxZDwcGC4o@z>


--=-5TGq9qc6jmgO8SfflYEA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-02-06 at 00:08 -0300, Leonardo Bras wrote:
>                 gup_pgd_range(addr, end, gup_flags, pages, &nr);
> -               local_irq_enable();
> +               end_lockless_pgtbl_walk(IRQS_ENABLED);
>                 ret =3D nr;
>         }
> =20

Just noticed IRQS_ENABLED is not available on other archs than ppc64.
I will fix this for v7.

--=-5TGq9qc6jmgO8SfflYEA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl47hx4ACgkQlQYWtz9S
ttTS9w/9E7lK8J1xIstn8wQNOKb6Mpalq1gAoAMSwEKVsxtJCgv5GQoVzfi83uzh
s6Qq+5ydWu172eeRW66NmQaespclUattqesFf5qhvVnLGpwTbGSPlSF0IWzKr7s9
ofzcAbyqaDh6+DTOestPd3ADSlUZ4HWxOKc5XSi5TyHX0RP9JK/gu26hdvr9oHDI
ZU16OrdCAecYyE7/hKY0a+VGRsyZVab3VBWy/6EJdo9Z8bNc/aquHQQ+RkdaB3M/
VtA1A0NUOBcbu+tFKG3Q2yzPQb9/5Ob7m5uG2Oa2f3huyk8FOXySioH4qUHqZAuB
8bZIrD49y3YXZ9sFF4b4eqyDyeutnHAoMa/FBuMPmQW/diiFKhSIvLsiEz4gu1B9
jn04+n0wrnV8wXxe3xUEQ6ooxhCY6UmNSIjlXOewvk/j2E37mZIdaPY5Bx6GlDBM
MSXHfcN2LtpRH1FTqH8tZvwYf7JdkspVbbBipLrr8Ba8fGZ3fKcnfIIaOSRd1tvE
uTHEgfICZKnzXxPM/tpI3n5kx7PbB6hPFDdtvjA1Vyq3tuA295qNF5fkEmTkvzmg
swZfIo4OEGyw3Oh+jsK0PH646dK6jkD17Q7Fe81+BF7uYygxdxBptKUj/GJEnqfU
3ZEFP0bpEMV17eoArkTN5eP4CNvd1VRWagVtnNLWS44WlNvdOxc=
=i1Uf
-----END PGP SIGNATURE-----

--=-5TGq9qc6jmgO8SfflYEA--
