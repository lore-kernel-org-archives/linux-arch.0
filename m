Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731686AbfI3O3P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Sep 2019 10:29:15 -0400
Message-ID: <5d3ad682f5ef3a7f16fdda9bcd30fbf53194b393.camel@linux.ibm.com>
Subject: Re: [PATCH v4 03/11] mm/gup: Applies counting method to monitor
 gup_pgd_range
From: Leonardo Bras <leonardo@linux.ibm.com>
Date: Mon, 30 Sep 2019 11:27:10 -0300
In-Reply-To: <20190930110927.nanq2wynvfmq7dhc@box>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
         <20190927234008.11513-4-leonardo@linux.ibm.com>
         <20190930110927.nanq2wynvfmq7dhc@box>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5QWWSZPLD+oFKjYyk88w"
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Nicholas Piggin <npiggin@gmail.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Mike Rapoport <rppt@linux.ibm.com>, YueHaibing <yuehaibing@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Keith Busch <keith.busch@intel.com>
Message-ID: <20190930142710.T4R5Z6rxSULClmuUhgDF2O1YegLu_lzrh5olWuoMK_Q@z>


--=-5QWWSZPLD+oFKjYyk88w
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-30 at 14:09 +0300, Kirill A. Shutemov wrote:
> On Fri, Sep 27, 2019 at 08:40:00PM -0300, Leonardo Bras wrote:
> > As decribed, gup_pgd_range is a lockless pagetable walk. So, in order t=
o
>      ^ typo
>=20
Fixed, thanks!

--=-5QWWSZPLD+oFKjYyk88w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2SEL4ACgkQlQYWtz9S
ttRgkRAAlYimCAeVA9cvc5HGNEVbfibfjFEgDVu7fY/HjI44ZGaauFSEvLDnnTcz
M4WLEbD8cZ/LBPDP06Q8FuNtSZi1Ov1xVCXB404DodiPDkJG/TyVfO5/E5MsT7tf
1qvSg8n53RfUxpN2WHNKg2eXLStcVwKmoS0otMxkIOPxTRGFk9PchNJ3F3QEQLYE
3JwfwBa8q1d79DY19qiJ2VyqQm5nAAojm1i5JcHEUdMcA/INJgamhRpa5R6vx6Ge
LZHOthO7x+H28Ip32KAmw5ISf8Q0AKEb0rLmIwkCUD0ecO0bp5D7F9KM/J5oBjKO
pkVyqy61ZSdeArRc1M5HoOdI+evIGKSNtDJglyKckC3/KiUfkALvrjNe/USc9j3s
DxvgKE2FNP+I6n2z0C2weHITU9EjKdqPSpVRzRBowUE8rw2o1d+oCurRiGI+Tgm8
z3NEGoIdJFEkmNIvmbDPrRsz6E9viESfOGju8U9Um2Cxr14FJ6xGjGCeGylfgDED
/L7nMZ12gv4DZoJp9UaLlau8hItsneS9ZVgvIEivPDWW+MmB3nN0SNhWjeP7VlMU
jfa8kXlgp+gtsUn+jdwqgSrWDmAN4K4QSrtl0QmWN5GjNSQMEWkm5Jdb3Dk2etmx
JgYiX4UH8m9pdwN6ILWOPT7RnqL1IuV39OvC5Uay30/nlL5roTM=
=65+f
-----END PGP SIGNATURE-----

--=-5QWWSZPLD+oFKjYyk88w--
