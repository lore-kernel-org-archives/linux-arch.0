Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728804AbfJISLW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 14:11:22 -0400
Message-ID: <ebf5d7357f194debc3bd6e91e0a8da4202c87653.camel@linux.ibm.com>
Subject: Re: [PATCH v5 01/11] asm-generic/pgtable: Adds generic functions to
 monitor lockless pgtable walks
From: Leonardo Bras <leonardo@linux.ibm.com>
Date: Wed, 09 Oct 2019 15:09:41 -0300
In-Reply-To: <20191004112844.GC19463@hirez.programming.kicks-ass.net>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
         <20191003013325.2614-2-leonardo@linux.ibm.com>
         <20191003071145.GM4536@hirez.programming.kicks-ass.net>
         <20191003115141.GJ4581@hirez.programming.kicks-ass.net>
         <c46ba8cec981ad28383bb7b23161fb83ccda4a60.camel@linux.ibm.com>
         <20191004112844.GC19463@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-lwxk+g4NX3v4aiRY1x8z"
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, John Hubbard <jhubbard@nvidia.com>, Jesper Dangaard Brouer <brouer@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kvm-ppc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Reza Arbab <arbab@linux.ibm.com>, Allison Randal <allison@lohutok.net>, Christian Brauner <christian.brauner@ubuntu.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Souptick Joarder <jrdr.linux@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Roman Gushchin <guro@fb.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <20191009180941.VUSNxEe8O9GXWrUn9lus7a3JLV6xMOstGJ2ECUoe6ig@z>


--=-lwxk+g4NX3v4aiRY1x8z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-10-04 at 13:28 +0200, Peter Zijlstra wrote:
> > Could you please explain it?
> > I mean, why this breaks tmpfs-thp?
> > Also, why mm_cpumask() is also broken?
>=20
> Because shared pages are not bound by a mm; or does it not share the thp
> state between mappings?

By what I could understand, even though the memory is shared, the
mapping may differ for different processes (i.e. the same physical
memory that is mapped as a hugepage in process A can be mapped as a lot
of smallpages in process B).

Did I miss something here? =20

> And once you (re)figure it out, please write it down. It is a crucial
> bit of the puzzle and needs to be part of the Changelogs.

I am still investing time studying this. More on this later :)

Thanks!

--=-lwxk+g4NX3v4aiRY1x8z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2eImUACgkQlQYWtz9S
ttRfWhAA4tFyyNfL3tzIUMnu8uw6K7QisutRwYllutuFzPwBZqnh8+20uDzo8fp0
eA/nbsP+kFkkBEjmx/jugDsXJnT3dpXW+E48iqr0HJpRBDbARAY6WA1qx26ETJHz
c+MiB+agAJ2rfYAkE3FUEKVNZgyybhBhIlTuYhLvi1UWtqFIqncT5CA5OsgXFIU5
vpJWMCFzDr/ZMWivf2bH06LlCTOIq85q+MzrPEKdxknUiG3U8nXKWgmbLeiqK/zt
9soJaF83cDkrYCkko8vTAadVOS7KDgn+iwucU0DTsvB7NoJbrIJsSRl2+33DWoz1
bD1cyw6yks+h+qFUjlq19Q6n6aVBy0em2uiIr7HNoYff5YIulrfsdcneNcwnp0Jv
tzKOaCvajRE9PfH0bNyoWI9BSXNbY4RqcWnnwOWM2uPRNGUIUpoIJbWKl7VRKRuC
t3ojliLkUWGvNkTMdFzg3XJl2+ZU05/o8UdXJ21pwhArJDkb6DmKZU4dMz9YQ9fc
B38gZY1N8rthws2UgK1frOgHjUtzHuAkoo89aAnkQwVyQ6e61JfKTgxkb/0dabDs
Gsn+Yd/b36oQK6jOxhsef+zTzawX0pWrq49dJzmB2wD4oyQl10I5JWFiSdboGGJs
uItrX4TN3i1fvlsyVE0b4ZwM5Nwzzd8yC+cTXHTQJOAm8PWh5Vk=
=xgUX
-----END PGP SIGNATURE-----

--=-lwxk+g4NX3v4aiRY1x8z--
