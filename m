Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389234AbfJCVkF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Oct 2019 17:40:05 -0400
Message-ID: <4e9e864856fc165b5dea8119eade871bc0e6f019.camel@linux.ibm.com>
Subject: Re: [PATCH v5 00/11] Introduces new count-based method for tracking
 lockless pagetable walks
From: Leonardo Bras <leonardo@linux.ibm.com>
Date: Thu, 03 Oct 2019 18:38:40 -0300
In-Reply-To: <99754d82-33c5-a54f-8607-b6bf151069d4@nvidia.com>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
         <20191003072952.GN4536@hirez.programming.kicks-ass.net>
         <c46d6c7301314a2d998cffc47d69b404f2c26ad3.camel@linux.ibm.com>
         <99754d82-33c5-a54f-8607-b6bf151069d4@nvidia.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+T6TWqK4ZitmnubF89r5"
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Hubbard <jhubbard@nvidia.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kvm-ppc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Reza Arbab <arbab@linux.ibm.com>, Allison Randal <allison@lohutok.net>, Christian Brauner <christian.brauner@ubuntu.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Souptick Joarder <jrdr.linux@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Roman Gushchin <guro@fb.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <20191003213840.aBsdsrL8btoP_nWq-Qgd__layyDxy0zEO8q2j_06gMU@z>


--=-+T6TWqK4ZitmnubF89r5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-03 at 13:49 -0700, John Hubbard wrote:
> Yes. And to clarify, I was assuming that the changes to mm/gup.c were=20
> required in order to accomplish your goals. Given that assumption, I=20
> wanted the generic code to be "proper", and that's what that feedback
> is about.

You assumed right. On my counting approach it's necessary count all
'lockless pagetable walks', including the ones in generic code.

And, I think even without the counting approach, it was a good way
focus this 'lockless pagetable walk' routine in a single place.

>=20
> Although the other questions about file-backed THP
> make it sound like some rethinking across the board is required now.

Yeap, I need to better understand how the file-backed THP problem
works.

Thanks,

Leonardo Br=C3=A1s

--=-+T6TWqK4ZitmnubF89r5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2WamAACgkQlQYWtz9S
ttT+5A//d6Der3cfKkY0anP/E6uyI6e77Kt+RWmN9+RuhxKKyMvN3vR0lOiAxvuE
mr0LmRnING4Jsvhz54FB9xPIJzEH+5tPXrX9TkHYOFqQfkyvDtx8LaCHf+gN+xQx
l2ukNHr6gqjA6Sb8eQEm0RKeiidLX6NPo03/OwiAWs44z+XofzyFuUa13VmE2+YE
oe27ZXb/UsLlrO8rB7cG+DyGuRBTlivjCpDp+JEDkdRH8tePICRaAtV0nR+YxeA7
4NiBcgM9ONQeJOKViKmWdqhC/2K2gVeSFE7WpidAUOrRUJR9FyFisZ7x8MKrW06f
GRSRrSisMdvHlgbZHcT+n0tqNPcRzmGmTnkZ/nlnoM7w5qKgsMGIBOBYH5CW2FPg
19xIRhUMX+ShhSPc8H8TIeaHxRmJrJYmnfib+MY4IZhrZmAUEqYDSnjzvypUSvFF
HUly+f6MpQlOv+RHgi4BV/zdyO8ucaaSCMh2yGREJ5FEuDAEKm5AHz6RwtRMtoY0
v8Y+7IEPVKPdV4sL8z5vfInKDeRU3FP0CPlKCKg6FcRvGNMGCEkP9ZtuzHxVb/Xs
JNa3VDiiijvnu/tDsdNS/6aHLtANNlLvaNGAuESrxAJRFzziLN92i+RXMLBaQCZo
/pZH9phCxN/HZly4uA7Ek1TbRKsNstB/CvsXTJBF91f6L7m0Awc=
=4hRX
-----END PGP SIGNATURE-----

--=-+T6TWqK4ZitmnubF89r5--
