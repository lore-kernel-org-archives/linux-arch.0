From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page
 table helpers
Date: Wed, 26 Feb 2020 20:03:53 -0800
Message-ID: <20200226200353.ea5c8ec2efacfb1192f3f3f4@linux-foundation.org>
References: <1581909460-19148-1-git-send-email-anshuman.khandual@arm.com>
        <1582726182.7365.123.camel@lca.pw>
        <1582726340.7365.124.camel@lca.pw>
        <eb154054-68ab-a659-065b-f4f7dcbb8671@c-s.fr>
        <52db1e9b-83b3-c41f-ef03-0f43e2159a83@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52db1e9b-83b3-c41f-ef03-0f43e2159a83@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Qian Cai <cai@lca.pw>, linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, linux-snps-arc
List-Id: linux-arch.vger.kernel.org

On Thu, 27 Feb 2020 08:04:05 +0530 Anshuman Khandual <anshuman.khandual@arm=
.com> wrote:

> > Must be something wrong with the following in debug_vm_pgtable()
> >=20
> > =A0=A0=A0=A0paddr =3D __pa(&start_kernel);
> >=20
> > Is there any explaination why start_kernel() is not in linear memory on=
 ARM64 ?
>=20
>=20
> Cc: + James Morse <james.morse@arm.com>
>=20
> This warning gets exposed with DEBUG_VIRTUAL due to __pa() on a kernel sy=
mbol
> i.e 'start_kernel' which might be outside the linear map. This happens du=
e to
> kernel mapping position randomization with KASLR. Adding James here in ca=
se he
> might like to add more.
>=20
> __pa_symbol() should have been used instead, for accessing the physical a=
ddress
> here. On arm64 __pa() does check for linear address with __is_lm_address(=
) and
> switch accordingly if it is a kernel text symbol. Nevertheless, its much =
better
> to use __pa_symbol() here rather than __pa().
>=20
> Rather than respining the patch once more, will just send a fix replacing=
 this
> helper __pa() with __pa_symbol() for Andrew to pick up as this patch is a=
lready
> part of linux-next (next-20200226). But can definitely respin if that wil=
l be
> preferred.

I didn't see this fix?  I assume it's this?  If so, are we sure it's OK to =
be
added to -next without testing??



From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-debug-add-tests-validating-architecture-page-table-helpers-fix

A warning gets exposed with DEBUG_VIRTUAL due to __pa() on a kernel symbol
i.e 'start_kernel' which might be outside the linear map.  This happens
due to kernel mapping position randomization with KASLR.

__pa_symbol() should have been used instead, for accessing the physical
address here.  On arm64 __pa() does check for linear address with
__is_lm_address() and switch accordingly if it is a kernel text symbol.=20
Nevertheless, its much better to use __pa_symbol() here rather than
__pa().

Reported-by: Qian Cai <cai@lca.pw>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/debug_vm_pgtable.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/debug_vm_pgtable.c~mm-debug-add-tests-validating-architecture-page=
-table-helpers-fix
+++ a/mm/debug_vm_pgtable.c
@@ -331,7 +331,7 @@ void __init debug_vm_pgtable(void)
 	 * helps avoid large memory block allocations to be used for mapping
 	 * at higher page table levels.
 	 */
-	paddr =3D __pa(&start_kernel);
+	paddr =3D __pa_symbol(&start_kernel);
=20
 	pte_aligned =3D (paddr & PAGE_MASK) >> PAGE_SHIFT;
 	pmd_aligned =3D (paddr & PMD_MASK) >> PAGE_SHIFT;
_
