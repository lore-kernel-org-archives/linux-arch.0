Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 27 Feb 2005 20:55:37 +0200
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: Changing  update_mmu_cache()
Message-ID: <20050227185537.GB32383@linux-sh.org>
References: <1109047997.5327.70.camel@gaston> <20050222090741.B16786@flint.arm.linux.org.uk> <20050222100858.27d05a86.davem@davemloft.net> <20050225201538.B27842@flint.arm.linux.org.uk> <20050225170905.4d98d934.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20050225170905.4d98d934.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 25, 2005 at 05:09:05PM -0800, David S. Miller wrote:
> I also enhanced SH platform so that the cache-sh4.c code no
> longer calculates the physical address by hand for flush_cache_page(),
> it's there now via pfn << PAGE_SHIFT.
>=20
Looks good, thanks. flush_icache_user_range() needed one minor change:

--- orig/arch/sh/mm/cache-sh4.c
+++ mod/arch/sh/mm/cache-sh4.c
@@ -377,6 +357,6 @@
 void flush_icache_user_range(struct vm_area_struct *vma,
 			     struct page *page, unsigned long addr, int len)
 {
-	__flush_cache_page(vma, addr, PHYSADDR(page_address(page)));
+	flush_cache_page(vma, addr, page_to_pfn(page));
 }
=20
> I'll push this off to Linus when 2.6.12 opens up.  If folks could
> build test this against current 2.6.x and report any failures that
> need fixing, I would appreciate that.
>=20
You missed fs/binfmt_elf.c, this gets it working..

=3D=3D=3D=3D=3D fs/binfmt_elf.c 1.102 vs edited =3D=3D=3D=3D=3D
--- 1.102/fs/binfmt_elf.c	2005-02-06 13:29:02 +02:00
+++ edited/fs/binfmt_elf.c	2005-02-27 20:31:54 +02:00
@@ -1584,7 +1584,7 @@
 					DUMP_SEEK (file->f_pos + PAGE_SIZE);
 				} else {
 					void *kaddr;
-					flush_cache_page(vma, addr);
+					flush_cache_page(vma, addr, page_to_pfn(page));
 					kaddr =3D kmap(page);
 					if ((size +=3D PAGE_SIZE) > limit ||
 					    !dump_write(file, kaddr,


On another note, for sh64 we don't need to actually keep
sh64_dcache_purge_virt_page() around for anything after this change..
flush_cache_page() was the only user of it anyways, so it makes more
sense to just have it call sh64_dcache_purge_phy_page() directly.

Here's a patch for arch/sh64/mm/cache.c that you can use in-place of the
one you have now, builds and boots.

--- orig/arch/sh64/mm/cache.c
+++ mod/arch/sh64/mm/cache.c
@@ -584,31 +584,6 @@
 	}
 }
=20
-static void sh64_dcache_purge_virt_page(struct mm_struct *mm, unsigned lon=
g eaddr)
-{
-	unsigned long phys;
-	pgd_t *pgd;
-	pmd_t *pmd;
-	pte_t *pte;
-	pte_t entry;
-
-	pgd =3D pgd_offset(mm, eaddr);
-	pmd =3D pmd_offset(pgd, eaddr);
-
-	if (pmd_none(*pmd) || pmd_bad(*pmd))
-		return;
-
-	pte =3D pte_offset_kernel(pmd, eaddr);
-	entry =3D *pte;
-
-	if (pte_none(entry) || !pte_present(entry))
-		return;
-
-	phys =3D pte_val(entry) & PAGE_MASK;
-
-	sh64_dcache_purge_phy_page(phys);
-}
-
 static void sh64_dcache_purge_user_page(struct mm_struct *mm, unsigned lon=
g eaddr)
 {
 	pgd_t *pgd;
@@ -915,7 +890,7 @@
=20
 /*************************************************************************=
***/
=20
-void flush_cache_page(struct vm_area_struct *vma, unsigned long eaddr)
+void flush_cache_page(struct vm_area_struct *vma, unsigned long eaddr, uns=
igned long pfn)
 {
 	/* Invalidate any entries in either cache for the vma within the user
 	   address space vma->vm_mm for the page starting at virtual address
@@ -926,7 +901,7 @@
 	   Note(1), this is called with mm->page_table_lock held.
 	   */
=20
-	sh64_dcache_purge_virt_page(vma->vm_mm, eaddr);
+	sh64_dcache_purge_phy_page(pfn << PAGE_SHIFT);
=20
 	if (vma->vm_flags & VM_EXEC) {
 		sh64_icache_inv_user_page(vma, eaddr);

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCIhep1K+teJFxZ9wRAu+5AJ9Md/98owCqmMcIr8Kt3rJxRIUbTwCfa2QO
+0YDbRO6LZvA84Tjiga7oU0=
=2KxG
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
