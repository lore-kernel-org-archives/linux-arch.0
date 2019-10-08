From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH v5 02/11] powerpc/mm: Adds counting method to monitor
 lockless pgtable walks
Date: Tue, 08 Oct 2019 15:02:27 -0300
Message-ID: <c1676fb14313a8378ec6bb72d1a7b24f48b898b5.camel@linux.ibm.com>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
 <20191003013325.2614-3-leonardo@linux.ibm.com>
 <alpine.DEB.2.21.1910081509070.1734@www.lameter.com>
 <6e8877bff034603e75b35599797a39d9bc4840f1.camel@linux.ibm.com>
 <alpine.DEB.2.21.1910081741460.2923@www.lameter.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-uR24Id1SoXLfuKZlusT9"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <alpine.DEB.2.21.1910081741460.2923@www.lameter.com>
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
To: Christopher Lameter <cl@linux.com>
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christian Brauner <christian.brauner@ubuntu.com>, Ira Weiny <ira.weiny@intel.com>, Ingo Molnar <mingo@kernel.org>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar
 K.V" <aneesh.kumar@linux.ibm.com>, Jann Horn <jannh@google.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Allison Randal <allison@lohutok.net>, Jesper Dangaard Brouer <brouer@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrea
List-Id: linux-arch.vger.kernel.org


--=-uR24Id1SoXLfuKZlusT9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-08 at 17:43 +0000, Christopher Lameter wrote:
> On Tue, 8 Oct 2019, Leonardo Bras wrote:
>=20
> > > You are creating contention on a single exclusive cacheline. Doesnt t=
his
> > > defeat the whole purpose of the lockless page table walk? Use mmap_se=
m or
> > > so should cause the same performance regression?
> >=20
> > Sorry, I did not understand that question.
> > I mean, this is just a refcount and never causes a lock.
>=20
> Locks also use atomic operations like a refcount increment. Both require
> the cacheline to be in exclusive state. So the impact is very similar.

Thanks for explaining. :)

So you say that the performance impact of using my approach is the same
as using locks? (supposing that lock never waits)

So, there are 'lockless pagetable walks' only for the sake of better
performance?=20

I thought they existed to enable doing pagetable walks in states where
locking was not safe.

Is that right?

Thanks!
Leonardo Br=C3=A1s,


--=-uR24Id1SoXLfuKZlusT9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2czzMACgkQlQYWtz9S
ttTcBw//Q3V1Sh9/H9YgHRAZLNo4J0NXNOfZMB3Wuu6FYM2o1AdA8/+94ofzIS9s
b4H3QlO8XePM8lSosVaoR9hxIBJFAg7wcomI1tLbyVA9vxYvf+9HYpMsjcAs991F
FNrFFO3KtCH6ahjNVM/nIqrbZnVqtyqBuQZRhdnMnqzB9xxDLxRPAlhsmq8cfhkT
jjlvhnebjYX7lbzZ55vzRDeZNQb2Nd0wkeA2Ij/0ab9ii5WiNlYaSoi6BbyPL6m2
SYKorTyqqd/Ci92LzXGK4SkQxjeNK/JFmmtHWpWyuow4/8i1pjuVob+KyKF5QFjL
qMFHZGXk2Z/7PAjWz6HuWw2sRC3LTjRdD85zELkDnW8pHy6Tq0gWvmUn5zME0y+4
WNpFrqyLYgjlCXdCwB4WVMxl7OK71seolusrMfszomiAMMjZQBIdHZeep5dViH+9
4ICmwSuG1jLV1bpx3Eoq9rqLbhIN2GNnPLHav2w669z9iANw8A27DtKTUQii/t0L
FpBRbvYBBhAp1bmq894bzBK1DWch8ouoqh9b9e2ZbYv+fCav5lyHo7ikAc0lLU/0
lvNltSIBKQaYiDCP231JT6NowJUfeu6fCQsZjs1mMh1AHPlEy5l6/P/SrP4Q0wa8
0DTkCHMyGNrYnfqXFqeAMOvOjtEMMh/Sy01nq7n6w2gQiaUn+Lk=
=HxOw
-----END PGP SIGNATURE-----

--=-uR24Id1SoXLfuKZlusT9--
