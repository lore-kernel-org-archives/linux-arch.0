From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH v5 10/11] mm/Kconfig: Adds config option to track
 lockless pagetable walks
Date: Thu, 03 Oct 2019 16:08:45 -0300
Message-ID: <43648fe1bb12a7627a14a49405ec18289f3dbbe8.camel@linux.ibm.com>
References: <20191003013325.2614-11-leonardo@linux.ibm.com>
 <88228CE0-81B2-4F2F-8C1D-F3376DB25A16@lca.pw>
 <08c43176fcf46c768d474f7d3620e07f3f71b140.camel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-VybRhkfSRVywgfzTr45C"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <08c43176fcf46c768d474f7d3620e07f3f71b140.camel@linux.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Qian Cai <cai@lca.pw>
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Dmitry
 V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, Andrea
List-Id: linux-arch.vger.kernel.org


--=-VybRhkfSRVywgfzTr45C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-03 at 16:04 -0300, Leonardo Bras wrote:
> On Wed, 2019-10-02 at 22:08 -0400, Qian Cai wrote:
> > Can=E2=80=99t this name and all those new *lockless* function names be =
shorter?=20
> > There are many functions name with *_locked, so how about dropping=20
> > lockless at all, i.e., PAGE_TABLE_WALK_TRACKING blah blah?
>=20
> Thanks for the feedback!
>=20
> Well, in this case it only tracks the 'lockless pagetable walks'. In
> this approach, the 'locked pagetable walks' don't need to be tracked.

So, using PAGE_TABLE_WALK_TRACKING would not be very accurate (as said
before, there are the locked ones).

--=-VybRhkfSRVywgfzTr45C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2WRz0ACgkQlQYWtz9S
ttT+TA/1FSJfZVTq1e5fFW17J/V8Y4SiHa0K5xFAs/GWhR8M24yCyXUhMXz/liQT
IDOViKxoVkc1e1NwSBePEDZkaEvl0XtMPPsGMbZ5Jb1XIJglqGKhr5mBSFXzd8nt
XjImtXNN8JGR/Tx/2C9ThYfdcqmbDmntDsmSBZyIZXqOJUiICJmrpZHx6/ZPmCPb
k0fdWqC8GE8H8DbvbW72a5iOh176EogGVduOryjx/N+vD9+xYhxj28lIWimRs/+A
pesIWhFCE0ZuRDz6/Ud/WSun2aqad1x/fLgW0xMuSTA9/pies0PdZtAMS/89yrRY
b4YPZM3iL6y/stdTfRc7Eu3S+gdCnp4avKWE+84MlwnM1Zq0p8+MTClRyX+tJbc2
s1QcmkOW8T70VkqnsBqGKkSa3RqNDDUySpuCJZKe9nr3ZRqyXEuXRwJkFmESAR9a
xmsGrPIG0vSKCijHdPsANOc4iXPN63YfxZBR0iszJvBadcBqVgMBQ/w4HnXQo8pX
h1jZSPaxosfSTWo/UHP3fQAhYMFZpRlx/EK0/LyS1EbO0acl+ZLUkJ0Hcg3fm2BM
VEhDNmphdCspj/+XWFscz3iSnZAaofFRHvxN3GDtz6VW0gahUaEUjpDuCk2C4fhL
9qPLuxKZoGWQG5F2t4QGqxz17CsUEP4YCWsvt4DjW46qMhreVQ==
=8m6H
-----END PGP SIGNATURE-----

--=-VybRhkfSRVywgfzTr45C--
