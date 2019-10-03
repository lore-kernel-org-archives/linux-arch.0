From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH v5 10/11] mm/Kconfig: Adds config option to track
 lockless pagetable walks
Date: Thu, 03 Oct 2019 16:04:02 -0300
Message-ID: <08c43176fcf46c768d474f7d3620e07f3f71b140.camel@linux.ibm.com>
References: <20191003013325.2614-11-leonardo@linux.ibm.com>
 <88228CE0-81B2-4F2F-8C1D-F3376DB25A16@lca.pw>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-6JwD3nS1I5bp6jdQjZJI"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <88228CE0-81B2-4F2F-8C1D-F3376DB25A16@lca.pw>
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


--=-6JwD3nS1I5bp6jdQjZJI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-02 at 22:08 -0400, Qian Cai wrote:
> Can=E2=80=99t this name and all those new *lockless* function names be sh=
orter?=20
> There are many functions name with *_locked, so how about dropping=20
> lockless at all, i.e., PAGE_TABLE_WALK_TRACKING blah blah?

Thanks for the feedback!

Well, in this case it only tracks the 'lockless pagetable walks'. In
this approach, the 'locked pagetable walks' don't need to be tracked.



--=-6JwD3nS1I5bp6jdQjZJI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2WRiIACgkQlQYWtz9S
ttTLPQ/5AadIHB7M8l0r2DhjP46ynmXH5IxgHEY7CjSTQZzcRJIAM9AMhlH9Ps+z
fjqBvZ0ZSOJAJQPbMP4nRi3kTdAdg7tyLtJj78BgcKpM+2Y3iKlq3O2HgqvqCZdH
zkuVaWtPdlYICGLA12Y39UaiYxnNEAwvm+W7vb9nk/fL6T8aTTZFZAZOT1SVQZty
a6YhEcj/10usw6lATrcmS3j4z8RV0aLP5L4gFQeexekfPZQu08Jaq8B3tWmC9nTc
eimFeMtGUaAybx9HJb//9GYYkSGGGGi8AkE1EpiIbQkoK88n0nPenGCcaBvJfD+V
w2hHUAmtfEOCYgDO4pHiQRCxl0sI5fuVJNPpAFJc317szxCW/MGhg+CxxrPjfDtA
S0Y0Iu9DZdXrHbBP7sfLuXv05bhL4yR7vS3/T6J+5CdzBSjnfMpYvL61Qj8vXb1R
g703mw25Ukm4FXbxTNoVvalohYjPM80J6IOiFpMr+MWjuZSzBpS8ooH8SKO3hoMd
wMwRtiJZD0vwLlj859memG7yhiufyG/TU6/lzAVydl9JZdb7xjhlSExGyutxCFCo
2Bnsd5rOYsT2pQNPnWuHm0r+MvPW7wYnm3qy7GoYhNsxB1hAhvNkFy+EXCzmcDKE
tTVoRqlRZXwvVjtmTVbmV7NzchhZicDLcJRPS38dfIm2PezXsno=
=6lYM
-----END PGP SIGNATURE-----

--=-6JwD3nS1I5bp6jdQjZJI--
