From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH v5 01/11] asm-generic/pgtable: Adds generic functions to
 monitor lockless pgtable walks
Date: Wed, 09 Oct 2019 15:09:41 -0300
Message-ID: <ebf5d7357f194debc3bd6e91e0a8da4202c87653.camel@linux.ibm.com>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
         <20191003013325.2614-2-leonardo@linux.ibm.com>
         <20191003071145.GM4536@hirez.programming.kicks-ass.net>
         <20191003115141.GJ4581@hirez.programming.kicks-ass.net>
         <c46ba8cec981ad28383bb7b23161fb83ccda4a60.camel@linux.ibm.com>
         <20191004112844.GC19463@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-lwxk+g4NX3v4aiRY1x8z"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191004112844.GC19463@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexey
List-Id: linux-arch.vger.kernel.org


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
