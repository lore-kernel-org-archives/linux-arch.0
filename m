From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH v5 00/11] Introduces new count-based method for tracking
 lockless pagetable walks
Date: Thu, 03 Oct 2019 18:38:40 -0300
Message-ID: <4e9e864856fc165b5dea8119eade871bc0e6f019.camel@linux.ibm.com>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
         <20191003072952.GN4536@hirez.programming.kicks-ass.net>
         <c46d6c7301314a2d998cffc47d69b404f2c26ad3.camel@linux.ibm.com>
         <99754d82-33c5-a54f-8607-b6bf151069d4@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+T6TWqK4ZitmnubF89r5"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <99754d82-33c5-a54f-8607-b6bf151069d4@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Hubbard <jhubbard@nvidia.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexey
List-Id: linux-arch.vger.kernel.org


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
