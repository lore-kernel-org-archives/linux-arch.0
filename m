Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 28 Feb 2005 11:18:43 +0200
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: Changing  update_mmu_cache()
Message-ID: <20050228091843.GA5709@linux-sh.org>
References: <1109047997.5327.70.camel@gaston> <20050222090741.B16786@flint.arm.linux.org.uk> <20050222100858.27d05a86.davem@davemloft.net> <20050225201538.B27842@flint.arm.linux.org.uk> <20050225170905.4d98d934.davem@davemloft.net> <20050227185537.GB32383@linux-sh.org> <20050227201208.7e0a5217.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20050227201208.7e0a5217.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: rmk@arm.linux.org.uk, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 27, 2005 at 08:12:08PM -0800, David S. Miller wrote:
> What are you patching against?  In the patch I sent, which are you
> replying to, I made flush_icache_user_range() in this file be:
>=20
> void flush_icache_user_range(struct vm_area_struct *vma,
>                              struct page *page, unsigned long addr, int l=
en)
> {
>         __flush_cache_page(vma, addr,
>                            PHYSADDR(page_address(page)) >> PAGE_SHIFT);
> }
>=20
Yes, you're right, wrong tree, sorry for the confusion. Here are the
fixes against your patch:

=3D=3D=3D=3D=3D arch/sh/mm/cache-sh4.c 1.10 vs edited =3D=3D=3D=3D=3D
--- 1.10/arch/sh/mm/cache-sh4.c	2005-02-28 11:14:14 +02:00
+++ edited/arch/sh/mm/cache-sh4.c	2005-02-28 11:15:27 +02:00
@@ -357,7 +357,6 @@
 void flush_icache_user_range(struct vm_area_struct *vma,
 			     struct page *page, unsigned long addr, int len)
 {
-	__flush_cache_page(vma, addr,
-			   PHYSADDR(page_address(page)) >> PAGE_SHIFT);
+	flush_cache_page(vma, addr, page_to_pfn(page));
 }
=20
=3D=3D=3D=3D=3D arch/sh64/mm/cache.c 1.2 vs edited =3D=3D=3D=3D=3D
--- 1.2/arch/sh64/mm/cache.c	2005-02-28 11:14:14 +02:00
+++ edited/arch/sh64/mm/cache.c	2005-02-28 11:15:01 +02:00
@@ -573,11 +573,6 @@
 	}
 }
=20
-static inline void sh64_dcache_purge_virt_page(struct mm_struct *mm, unsig=
ned long eaddr, unsigned long pfn)
-{
-	sh64_dcache_purge_phy_page(pfn << PAGE_SHIFT);
-}
-
 static void sh64_dcache_purge_user_page(struct mm_struct *mm, unsigned lon=
g eaddr)
 {
 	pgd_t *pgd;
@@ -895,7 +890,7 @@
 	   Note(1), this is called with mm->page_table_lock held.
 	   */
=20
-	sh64_dcache_purge_virt_page(vma->vm_mm, eaddr, pfn);
+	sh64_dcache_purge_phy_page(pfn << PAGE_SHIFT);
=20
 	if (vma->vm_flags & VM_EXEC) {
 		sh64_icache_inv_user_page(vma, eaddr);

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCIuHz1K+teJFxZ9wRAuTsAJ9Kz2YrgcZmGr0Ot6z1bGvxH/SAhACfTaID
cWV6oll8gJRpXmjoi5AAsgk=
=L3S3
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
