Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726669AbfJCUmd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Oct 2019 16:42:33 -0400
Message-ID: <3598584cc4b829e9c290b6dab89fb148528e4f72.camel@linux.ibm.com>
Subject: Re: [PATCH v5 10/11] mm/Kconfig: Adds config option to track
 lockless pagetable walks
From: Leonardo Bras <leonardo@linux.ibm.com>
Date: Thu, 03 Oct 2019 17:40:11 -0300
In-Reply-To: <20191003074432.GO4536@hirez.programming.kicks-ass.net>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
         <20191003013325.2614-11-leonardo@linux.ibm.com>
         <20191003074432.GO4536@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-cFtUj1Ho01ANPCDPn5bA"
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, John Hubbard <jhubbard@nvidia.com>, Jesper Dangaard Brouer <brouer@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kvm-ppc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Reza Arbab <arbab@linux.ibm.com>, Allison Randal <allison@lohutok.net>, Christian Brauner <christian.brauner@ubuntu.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Souptick Joarder <jrdr.linux@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Roman Gushchin <guro@fb.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <20191003204011.qyVLFY6pbz8e7DfTb1FvTepwPtiuDEPqPvVn7JgWLAA@z>


--=-cFtUj1Ho01ANPCDPn5bA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-03 at 09:44 +0200, Peter Zijlstra wrote:
> This shouldn't be a user visible option at all. Either the arch needs
> it and selects it or not.

You are right. I will do that on v6.
Thanks for the feedback!

--=-cFtUj1Ho01ANPCDPn5bA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2WXKsACgkQlQYWtz9S
ttT0Rw/+O9ro3F+kPIMVu+zxDUbz2AsZH3nFxKIz+44t5QRLd0SVCWEZoL8sXxBl
szuekeDyKqOVi4Uxq0kFBYP79d+/4XthFa9AwDozRXNre5Q0DiNv0j0z9DT0Ng02
nSLeaiuIt8SlD/TRrFOrlt0yFmE0485uR2jQYklJ056mh+629wFa8XJ3NOuOlU3C
wst6saBjYMZXlDg2acZTrI6VY1tpXAzkD1q1yQoEFUoMaLuBNhvLff0kxjxKTm2A
WnfAyv+BNeD/BlUzi8ifmvz/V6tWyhJ3LGwOOPloAKVy+SyJkxhzQoNn0uToodx6
GqeglOW+cnrPkmn3vZpinpSVOoQDzyy1MrurMbpXtV1iiVBxGXflyK7GAa9bpI4l
E45jXUJHTnFB3LOon16oBweT/fM3jVa4RVzPzO7JFfdLQUhnNdWROxdglOVvQxH7
2ZSy6maWC/mwRerDZk23R+usHwJ3kRItE/XT6mfzWcgf16Ph0A0xuZTLYvKJgOX4
8mFMwRkitAKKI/AYeKZ5w1AsVzO6XcG95Fxv78yIHxau479a0LB8FQVbCUySWjlR
6hZvWhqKJpy28cRX9ojp9MEzhABgb3bp8/3N7IKSxC2Gxsf7tVFs6ioEGFyBk/mK
unZ51OqsQ9LvoN4l67gzt238uunxFlb/uQIH4AWX/eO/9iYv5lY=
=uZ4G
-----END PGP SIGNATURE-----

--=-cFtUj1Ho01ANPCDPn5bA--
