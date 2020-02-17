Return-Path: <leonardo@linux.ibm.com>
Message-ID: <e09b8921d1aade7b9d2aace43fc357bdcd1001bd.camel@linux.ibm.com>
Subject: Re: [PATCH v6 03/11] powerpc/mm: Adds arch-specificic functions to
 track lockless pgtable walks
From: Leonardo Bras <leonardo@linux.ibm.com>
Date: Mon, 17 Feb 2020 17:32:33 -0300
In-Reply-To: <efcf780cee767d0f4b06b56e216725c6bd8d60d4.camel@linux.ibm.com>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
	 <20200206030900.147032-4-leonardo@linux.ibm.com>
	 <1311ce1c-7e5a-f7c4-2ab2-c03e124ca1c1@c-s.fr>
	 <efcf780cee767d0f4b06b56e216725c6bd8d60d4.camel@linux.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-rjDDfaEpQyTkTpCEQ2uL"
MIME-Version: 1.0
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200217203233.CB0_KvtBe4i-3p9BwlUS4o-8_Omjz2OvY-cOyRnzeFc@z>


--=-rjDDfaEpQyTkTpCEQ2uL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-02-07 at 01:38 -0300, Leonardo Bras wrote:
> > Why not make them static inline just like the generic ones ?
> >=20
>=20
> Sure, can be done.  It would save some function calls.
> For that I will define the per-cpu variable in .c and declare it in .h
> All new function can be moved to .h, while changing adding the inline
> modifier.

Just tried doing that, but percpu stuff relies in paca definitions, and
this ends up creating some cyclic dependencies.

I could try to change that, but the amount of change is big and
probably should be dealt in another patchset.

--=-rjDDfaEpQyTkTpCEQ2uL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl5K+GEACgkQlQYWtz9S
ttRsOg//QbdkYtnYqYavQzv828W7A3KiHEHqK77HtlTbJXOE5Vj9aU05HPZJp9XT
ck/HXYupAIcMq+qJ8tNQKbu0zHCHxQ4dk7BPRM8RP4dp/bDOGGXqmvJG0toVtumX
mTiJKUSaq7JeacS8xsx7hNZvLvHea/zagFha49BvLj6QajY+GU+CrpMJoaX1o/pc
2mWKJfpLvacLQBQGfKC+t81VKHZC2K2BWpGyS7/MLEw120/n+KQHqaekMcgSaqVU
lngRVDm4dHEZUZbOXjM3tyceMCTp5xTNv9+pS2friqkfXTomMS5ZuSW1O0i/A28m
0TBWXC+kcQq+Bi1IxIqEPYQ3xab6/Xoba11GWD1qzBiUwd/3Xg30bAB9LYJXMwiD
outVyh5BO6w8oSp1q5iHmt3raJLNTYYlG/SZzZCsCKXHr3EALNZvByETJ2j/oGdJ
dbpPDOxmE2jbWMtIBhdjRFBmfmAGCTgRLpCq0hngNPm2sdQTmr9+B5UcWNzJjuks
j1lDiMHOle78bT7GTYifJjVZrgBiB/JuToqBVzBIEgOBcGXiUXGUaDHgpNjKtH9d
MtbmDODl9st9czyK/edN39eHlz4jfK+Z87ZJQVZz93bEjaRI6pRbqgiTVudWGdMN
TISNtFVMgBbLWmgi8HOfs0zz4naMfcorqOhsTIi95qM8ygfs98s=
=rEX5
-----END PGP SIGNATURE-----

--=-rjDDfaEpQyTkTpCEQ2uL--
