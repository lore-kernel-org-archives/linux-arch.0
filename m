From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH v5 02/11] powerpc/mm: Adds counting method to monitor
 lockless pgtable walks
Date: Tue, 08 Oct 2019 14:13:55 -0300
Message-ID: <6e8877bff034603e75b35599797a39d9bc4840f1.camel@linux.ibm.com>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
 <20191003013325.2614-3-leonardo@linux.ibm.com>
 <alpine.DEB.2.21.1910081509070.1734@www.lameter.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-JXyt1yOsMJO5qRHMDgfG"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <alpine.DEB.2.21.1910081509070.1734@www.lameter.com>
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


--=-JXyt1yOsMJO5qRHMDgfG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-08 at 15:11 +0000, Christopher Lameter wrote:
>=20
> On Wed, 2 Oct 2019, Leonardo Bras wrote:
>=20
> > +
> > +inline unsigned long __begin_lockless_pgtbl_walk(struct mm_struct *mm,
> > +						 bool disable_irq)
> > +{
> > +	unsigned long irq_mask =3D 0;
> > +
> > +	if (IS_ENABLED(CONFIG_LOCKLESS_PAGE_TABLE_WALK_TRACKING))
> > +		atomic_inc(&mm->lockless_pgtbl_walkers);
> > +
>=20
> You are creating contention on a single exclusive cacheline. Doesnt this
> defeat the whole purpose of the lockless page table walk? Use mmap_sem or
> so should cause the same performance regression?

Sorry, I did not understand that question.
I mean, this is just a refcount and never causes a lock. =20


FYI: This function was updated as following, and will be in v6:

#ifdef CONFIG_LOCKLESS_PAGE_TABLE_WALK_TRACKING
	atomic_inc(&mm->lockless_pgtbl_walkers);
#endif
	smp_mb();

IS_ENABLED doesnt work fine if CONFIG_LOCKLESS_PAGE_TABLE_WALK_TRACKING
is not defined, causing an error: the mm member lockless_pgtbl_walkers
doesn't exist.

--=-JXyt1yOsMJO5qRHMDgfG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2cw9MACgkQlQYWtz9S
ttQJpQ/+NQnm5YZrjCiFby0X7Zf2c6QdSw96EfXRY6oxh//DMzzC+U3jhpEDpGKA
QjRsZiDRIdHhVHWVPkC9Oz76ThRYBaFSjhs7l06K7asP0KaXFDxv6XInJ2dlqqQW
GSHmRaqDBbr9ndUaJz3J4CbU05jsEwCrmku7O5BhBejtYoKAQBvHFuFVcO71A1YW
hH92tSFBR39N6SADoVVxDwpSd2ryeK3k0czeLxeekENyCxmRk6HgBUKHcwSMP0d3
rRDpJ+IVWqIja+43DjknTGYq4xGXYnfFzYfdQIaqhc+rNWyKJ3C07/5zhMteVJqk
ycMJ39kFL66uO/J24Cr0DKo9W2VcdwxEQ1a+W2/4FeayI8QT3IgN0WqcMXcnfG/K
ahVV6S/gliueptjZWgWy62jnEXMbWzHLtVMTlzjxYyLGzOe64Lsa6lt054VcIws5
DstylhjC6HOURSZ5c9IChKdavw5QOvRTjoq/stxswR1D05USHVWKrXxyCewY7eSo
7AEnUmOAXpWmem81q+VAFYq4UrOlkknz4gZkhotkUdcfHs+y6hwzTzfh4SzifFxq
QC8cXCtmkrurkVjRDLxSt/6vkemBBouw9ug2EExB8fDHdC5m8O2brErMC2iL5ppx
bG7LtF0rTIqLrfRxpgctebsZ8yRZBV0aMAjbxi/pPOu8egZzHeY=
=Nht8
-----END PGP SIGNATURE-----

--=-JXyt1yOsMJO5qRHMDgfG--
