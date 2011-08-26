From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] mm: convert k{un}map_atomic(p, KM_type) to
 k{un}map_atomic(p)
Date: Fri, 26 Aug 2011 10:58:16 +0200
Message-ID: <1314349096.26922.21.camel@twins>
References: <1314346676.6486.25.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1314346676.6486.25.camel@minggr.sh.intel.com>
Sender: owner-linux-mm@kvack.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, 2011-08-26 at 16:17 +0800, Lin Ming wrote:
>=20
> The KM_type parameter for kmap_atomic/kunmap_atomic is not used anymore
> since commit 3e4d3af(mm: stack based kmap_atomic()).
>=20
> So convert k{un}map_atomic(p, KM_type) to k{un}map_atomic(p).
> Most conversion are done by below commands. Some are done by hand.
>=20
> find . -type f | xargs sed -i 's/\(kmap_atomic(.*\),\ .*)/\1)/'
> find . -type f | xargs sed -i 's/\(kunmap_atomic(.*\),\ .*)/\1)/'
>=20
> Build and tested on 32/64bit x86 kernel(allyesconfig) with 3G memory.
>=20
> ARM, MIPS, PowerPc and Sparc are build tested only with
> CONFIG_HIGHMEM=3Dy and CONFIG_HIGHMEM=3Dn.
> I don't have cross-compiler for other arches.=20

yet-another-massive patch.. (you're the third or fourth to do so) if
Andrew wants to take this one I won't mind, however previously he didn't
want flag day patches..

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
