Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbfJAR5E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 13:57:04 -0400
Message-ID: <2cebe169221ae9270963d4bc4fd8e43066745f98.camel@linux.ibm.com>
Subject: Re: [PATCH v4 03/11] mm/gup: Applies counting method to monitor
 gup_pgd_range
From: Leonardo Bras <leonardo@linux.ibm.com>
Date: Tue, 01 Oct 2019 14:56:19 -0300
In-Reply-To: <ce0a4110-9f83-36db-dc85-6a727d30d030@nvidia.com>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
         <20190927234008.11513-4-leonardo@linux.ibm.com>
         <ce0a4110-9f83-36db-dc85-6a727d30d030@nvidia.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-WOdEGhITyKTGCaqMIiwf"
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Hubbard <jhubbard@nvidia.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Keith Busch <keith.busch@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, YueHaibing <yuehaibing@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Paul Mackerras <paulus@samba.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Allison Randal <allison@lohutok.net>
Message-ID: <20191001175619.wmb35aWvfOzcfn4cr658OgQUY6oAVmkWbh464lhlKRU@z>


--=-WOdEGhITyKTGCaqMIiwf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-30 at 14:51 -0700, John Hubbard wrote:
> On 9/27/19 4:40 PM, Leonardo Bras wrote:
> > As decribed, gup_pgd_range is a lockless pagetable walk. So, in order t=
o
> > monitor against THP split/collapse with the couting method, it's necess=
ary
>=20
> s/couting/counting/
>=20

Thanks, fixed for v5.

> > to bound it with {start,end}_lockless_pgtbl_walk.
> >=20
> > There are dummy functions, so it is not going to add any overhead on ar=
chs
> > that don't use this method.
> >=20
> > Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> > ---
> >  mm/gup.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 98f13ab37bac..7105c829cf44 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2325,6 +2325,7 @@ static bool gup_fast_permitted(unsigned long star=
t, unsigned long end)
> >  int __get_user_pages_fast(unsigned long start, int nr_pages, int write=
,
> >  			  struct page **pages)
> >  {
> > +	struct mm_struct *mm;
>=20
> I don't think that this local variable adds any value, so let's not use i=
t.
> Similar point in a few other patches too.

It avoids 1 deference of current->mm, it's a little performance gain.

>=20
> >  	unsigned long len, end;
> >  	unsigned long flags;
> >  	int nr =3D 0;
> > @@ -2352,9 +2353,12 @@ int __get_user_pages_fast(unsigned long start, i=
nt nr_pages, int write,
> > =20
> >  	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
> >  	    gup_fast_permitted(start, end)) {
> > +		mm =3D current->mm;
> > +		start_lockless_pgtbl_walk(mm);
> >  		local_irq_save(flags);
> >  		gup_pgd_range(start, end, write ? FOLL_WRITE : 0, pages, &nr);
> >  		local_irq_restore(flags);
> > +		end_lockless_pgtbl_walk(mm);
> >  	}
> > =20
> >  	return nr;
> > @@ -2404,6 +2408,7 @@ int get_user_pages_fast(unsigned long start, int =
nr_pages,
> >  			unsigned int gup_flags, struct page **pages)
> >  {
> >  	unsigned long addr, len, end;
> > +	struct mm_struct *mm;
>=20
> Same here.
>=20
> >  	int nr =3D 0, ret =3D 0;
> > =20
> >  	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM)))
> > @@ -2421,9 +2426,12 @@ int get_user_pages_fast(unsigned long start, int=
 nr_pages,
> > =20
> >  	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
> >  	    gup_fast_permitted(start, end)) {
> > +		mm =3D current->mm;
> > +		start_lockless_pgtbl_walk(mm);
>=20
> Minor: I'd like to rename this register_lockless_pgtable_walker().
>=20
> >  		local_irq_disable();
> >  		gup_pgd_range(addr, end, gup_flags, pages, &nr);
> >  		local_irq_enable();
> > +		end_lockless_pgtbl_walk(mm);
>=20
> ...and deregister_lockless_pgtable_walker().
>=20

I have no problem changing the name, but I don't register/deregister
are good terms for this.=20

I would rather use start/finish, begin/end, and so on. Register sounds
like something more complicated than what we are trying to achieve
here.=20

>=20
> thanks,

Thank you!

--=-WOdEGhITyKTGCaqMIiwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2Tk0MACgkQlQYWtz9S
ttSDXw//YSv3GiwCNDmsVJYOkdVFcj9OsgYOCNmhsQY5guIaKQj+/1//EG97F9yt
PVnM+822c/fwYhTZgA9SQQRA0BYZ4LwU4eBiSjPemSX10vLznjt32E9JvACZkvFN
mhkmdooGndyVd4pEJsYjJ8bMwGYHf4BXliXCOgGR0GfbXBvIe/GWV+pYRsrd9jnx
Q1R8k4bCO9O2FKwtEOpCPNFQPn/4D+mxLwcOuKliFMe/XHCUjv7RIrJMV41N3epk
H3O5S7ML1m7A4i496+vDJvWb3zBFdWb0nqHQ7sp4gM5x2RzIZODtayIBRFs8Dgvy
602F5XVDxsSY3irS27+OTtRGhV2aE3lhdZeWIeJMWY7b00vZJASO8fZd9mkatBeS
Dj56JTFDmKVtqh//4kJwSDZKz5+y3LRfqONXgeIL5M0Rthc5tm+3XRztOxSDKZw/
N9wxJBmeVOonSR1ngdQVnKu3B5gyQDNrJCQdCBcqLTOVIVCMjHjyf6l/jZu7VNH5
wESlZ/gwBZ2iJ4CG0YeF6ObMC7/UjsjVRdvH39oA+KwErMOWjMZi6CbdEdzUnFI9
Jo4f1nZ3/1bVGbCxlaaDoQxtfThRPCk9CJiMoyTG19HB2T0mUImtOt0VIH5Y/bQu
T7wDnek8r9G1HwB++kVRFYELvmzfP4YSiUPAEDTNPlHFup2phZQ=
=JHbX
-----END PGP SIGNATURE-----

--=-WOdEGhITyKTGCaqMIiwf--
