From: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH 15/21] mm: memmap_init: iterate over memblock regions
 rather that check each PFN
Date: Mon, 20 Apr 2020 10:26:06 -0400
Message-ID: <CF6E407F-17DC-427C-8203-21979FB882EF@lca.pw>
References: <20200412194859.12663-1-rppt@kernel.org>
 <20200412194859.12663-16-rppt@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200412194859.12663-16-rppt@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org, Brian Cain <bcain@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, Russell King <linux@armlinux.org.u>
List-Id: linux-arch.vger.kernel.org



> On Apr 12, 2020, at 3:48 PM, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> From: Baoquan He <bhe@redhat.com>
>=20
> When called during boot the memmap_init_zone() function checks if each =
PFN
> is valid and actually belongs to the node being initialized using
> early_pfn_valid() and early_pfn_in_nid().
>=20
> Each such check may cost up to O(log(n)) where n is the number of =
memory
> banks, so for large amount of memory overall time spent in =
early_pfn*()
> becomes substantial.
>=20
> Since the information is anyway present in memblock, we can iterate =
over
> memblock memory regions in memmap_init() and only call =
memmap_init_zone()
> for PFN ranges that are know to be valid and in the appropriate node.
>=20
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> mm/page_alloc.c | 26 ++++++++++++++++----------
> 1 file changed, 16 insertions(+), 10 deletions(-)
>=20
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7f6a3081edb8..c43ce8709457 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5995,14 +5995,6 @@ void __meminit memmap_init_zone(unsigned long =
size, int nid, unsigned long zone,
> 		 * function.  They do not exist on hotplugged memory.
> 		 */
> 		if (context =3D=3D MEMMAP_EARLY) {
> -			if (!early_pfn_valid(pfn)) {
> -				pfn =3D next_pfn(pfn);
> -				continue;
> -			}
> -			if (!early_pfn_in_nid(pfn, nid)) {
> -				pfn++;
> -				continue;
> -			}

This causes a compilation warning from Clang,

mm/page_alloc.c:5917:39: warning: unused function 'next_pfn' =
[-Wunused-function]
static inline __meminit unsigned long next_pfn(unsigned long pfn)

This should fix it,

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d469384c9ca7..b48336e20bdc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5912,23 +5912,6 @@ overlap_memmap_init(unsigned long zone, unsigned =
long *pfn)
 	return false;
 }
=20
-#ifdef CONFIG_SPARSEMEM
-/* Skip PFNs that belong to non-present sections */
-static inline __meminit unsigned long next_pfn(unsigned long pfn)
-{
-	const unsigned long section_nr =3D pfn_to_section_nr(++pfn);
-
-	if (present_section_nr(section_nr))
-		return pfn;
-	return section_nr_to_pfn(next_present_section_nr(section_nr));
-}
-#else
-static inline __meminit unsigned long next_pfn(unsigned long pfn)
-{
-	return pfn++;
-}
-#endif
-
 /*
  * Initially all pages are reserved - free ones are freed
  * up by memblock_free_all() once the early boot process is

> 			if (overlap_memmap_init(zone, &pfn))
> 				continue;
> 			if (defer_init(nid, pfn, end_pfn))
> @@ -6118,9 +6110,23 @@ static void __meminit =
zone_init_free_lists(struct zone *zone)
> }
>=20
> void __meminit __weak memmap_init(unsigned long size, int nid,
> -				  unsigned long zone, unsigned long =
start_pfn)
> +				  unsigned long zone,
> +				  unsigned long range_start_pfn)
> {
> -	memmap_init_zone(size, nid, zone, start_pfn, MEMMAP_EARLY, =
NULL);
> +	unsigned long start_pfn, end_pfn;
> +	unsigned long range_end_pfn =3D range_start_pfn + size;
> +	int i;
> +
> +	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> +		start_pfn =3D clamp(start_pfn, range_start_pfn, =
range_end_pfn);
> +		end_pfn =3D clamp(end_pfn, range_start_pfn, =
range_end_pfn);
> +
> +		if (end_pfn > start_pfn) {
> +			size =3D end_pfn - start_pfn;
> +			memmap_init_zone(size, nid, zone, start_pfn,
> +					 MEMMAP_EARLY, NULL);
> +		}
> +	}
> }
>=20
> static int zone_batchsize(struct zone *zone)
> --=20
> 2.25.1
>=20
>=20
