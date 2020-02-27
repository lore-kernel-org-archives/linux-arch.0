Return-Path: <linux-riscv-bounces+rppt=linux.ibm.com@lists.infradead.org>
Date: Wed, 26 Feb 2020 20:03:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page
 table helpers
Message-ID: <20200226200353.ea5c8ec2efacfb1192f3f3f4@linux-foundation.org>
In-Reply-To: <52db1e9b-83b3-c41f-ef03-0f43e2159a83@arm.com>
References: <1581909460-19148-1-git-send-email-anshuman.khandual@arm.com>
 <1582726182.7365.123.camel@lca.pw>
 <1582726340.7365.124.camel@lca.pw>
 <eb154054-68ab-a659-065b-f4f7dcbb8671@c-s.fr>
 <52db1e9b-83b3-c41f-ef03-0f43e2159a83@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+rppt=linux.ibm.com@lists.infradead.org
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>, linux-snps-arc@lists.infradead.org, Vasily Gorbik <gor@linux.ibm.com>, Qian Cai <cai@lca.pw>, Paul Walmsley <paul.walmsley@sifive.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Vineet Gupta <vgupta@synopsys.com>, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, Borislav Petkov <bp@alien8.de>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200227040353.miIfxRVotAxdH67xVVqTzl39wzhNfTOP2YJUiPirR84@z>

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
