Return-Path: <SRS0=KGKx=AK=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [PATCH V3 2/4] mm/debug_vm_pgtable: Add tests validating advanced
 arch page table helpers
References: <1592192277-8421-1-git-send-email-anshuman.khandual@arm.com>
 <1592192277-8421-3-git-send-email-anshuman.khandual@arm.com>
 <6da177e6-9219-9ccf-a402-f4293c7564f7@csgroup.eu>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <bdea0704-11a5-aab3-c9ce-a9e388394836@arm.com>
Date: Mon, 29 Jun 2020 13:39:28 +0530
MIME-Version: 1.0
In-Reply-To: <6da177e6-9219-9ccf-a402-f4293c7564f7@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org
Cc: christophe.leroy@c-s.fr, ziy@nvidia.com, gerald.schaefer@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200629080928.IKSJn0oHd2-B1Tp7CnNQbVrVnW1h1KdhMmaMM3ys1N4@z>


On 06/27/2020 12:48 PM, Christophe Leroy wrote:
> Le 15/06/2020 =C3=A0 05:37, Anshuman Khandual a =C3=A9crit=C2=A0:
>> This adds new tests validating for these following arch advanced page =
table
>> helpers. These tests create and test specific mapping types at various=
 page
>> table levels.
>>
>> 1. pxxp_set_wrprotect()
>> 2. pxxp_get_and_clear()
>> 3. pxxp_set_access_flags()
>> 4. pxxp_get_and_clear_full()
>> 5. pxxp_test_and_clear_young()
>> 6. pxx_leaf()
>> 7. pxx_set_huge()
>> 8. pxx_(clear|mk)_savedwrite()
>> 9. huge_pxxp_xxx()
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>> Cc: Vineet Gupta <vgupta@synopsys.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: linux-snps-arc@lists.infradead.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-s390@vger.kernel.org
>> Cc: linux-riscv@lists.infradead.org
>> Cc: x86@kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-arch@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> =C2=A0 mm/debug_vm_pgtable.c | 306 +++++++++++++++++++++++++++++++++++=
+++++++
>> =C2=A0 1 file changed, 306 insertions(+)
>>
>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>> index ffa163d4c63c..e3f9f8317a98 100644
>> --- a/mm/debug_vm_pgtable.c
>> +++ b/mm/debug_vm_pgtable.c
>> @@ -21,6 +21,7 @@
>> =C2=A0 #include <linux/module.h>
>> =C2=A0 #include <linux/pfn_t.h>
>> =C2=A0 #include <linux/printk.h>
>> +#include <linux/pgtable.h>
>> =C2=A0 #include <linux/random.h>
>> =C2=A0 #include <linux/spinlock.h>
>> =C2=A0 #include <linux/swap.h>
>> @@ -28,6 +29,7 @@
>> =C2=A0 #include <linux/start_kernel.h>
>> =C2=A0 #include <linux/sched/mm.h>
>> =C2=A0 #include <asm/pgalloc.h>
>> +#include <asm/tlbflush.h>
>> =C2=A0 =C2=A0 #define VMFLAGS=C2=A0=C2=A0=C2=A0 (VM_READ|VM_WRITE|VM_E=
XEC)
>> =C2=A0 @@ -55,6 +57,54 @@ static void __init pte_basic_tests(unsigned =
long pfn, pgprot_t prot)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(pte_write(pte_wrprotect(pte_mkw=
rite(pte))));
>> =C2=A0 }
>> =C2=A0 +static void __init pte_advanced_tests(struct mm_struct *mm,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct vm_area_struct *vma, pte_t *ptep,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 un=
signed long pfn, unsigned long vaddr, pgprot_t prot)
>> +{
>> +=C2=A0=C2=A0=C2=A0 pte_t pte =3D pfn_pte(pfn, prot);
>> +
>> +=C2=A0=C2=A0=C2=A0 pte =3D pfn_pte(pfn, prot);
>> +=C2=A0=C2=A0=C2=A0 set_pte_at(mm, vaddr, ptep, pte);
>> +=C2=A0=C2=A0=C2=A0 ptep_set_wrprotect(mm, vaddr, ptep);
>> +=C2=A0=C2=A0=C2=A0 pte =3D READ_ONCE(*ptep);
>=20
> same
>=20
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(pte_write(pte));
>> +
>> +=C2=A0=C2=A0=C2=A0 pte =3D pfn_pte(pfn, prot);
>> +=C2=A0=C2=A0=C2=A0 set_pte_at(mm, vaddr, ptep, pte);
>> +=C2=A0=C2=A0=C2=A0 ptep_get_and_clear(mm, vaddr, ptep);
>> +=C2=A0=C2=A0=C2=A0 pte =3D READ_ONCE(*ptep);
>=20
> same
>=20
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!pte_none(pte));
>> +
>> +=C2=A0=C2=A0=C2=A0 pte =3D pfn_pte(pfn, prot);
>> +=C2=A0=C2=A0=C2=A0 pte =3D pte_wrprotect(pte);
>> +=C2=A0=C2=A0=C2=A0 pte =3D pte_mkclean(pte);
>> +=C2=A0=C2=A0=C2=A0 set_pte_at(mm, vaddr, ptep, pte);
>> +=C2=A0=C2=A0=C2=A0 pte =3D pte_mkwrite(pte);
>> +=C2=A0=C2=A0=C2=A0 pte =3D pte_mkdirty(pte);
>> +=C2=A0=C2=A0=C2=A0 ptep_set_access_flags(vma, vaddr, ptep, pte, 1);
>> +=C2=A0=C2=A0=C2=A0 pte =3D READ_ONCE(*ptep);
>=20
> same
>=20
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!(pte_write(pte) && pte_dirty(pte)));
>> +
>> +=C2=A0=C2=A0=C2=A0 pte =3D pfn_pte(pfn, prot);
>> +=C2=A0=C2=A0=C2=A0 set_pte_at(mm, vaddr, ptep, pte);
>> +=C2=A0=C2=A0=C2=A0 ptep_get_and_clear_full(mm, vaddr, ptep, 1);
>> +=C2=A0=C2=A0=C2=A0 pte =3D READ_ONCE(*ptep);
>=20
> same
>=20
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!pte_none(pte));
>> +
>> +=C2=A0=C2=A0=C2=A0 pte =3D pte_mkyoung(pte);
>> +=C2=A0=C2=A0=C2=A0 set_pte_at(mm, vaddr, ptep, pte);
>> +=C2=A0=C2=A0=C2=A0 ptep_test_and_clear_young(vma, vaddr, ptep);
>> +=C2=A0=C2=A0=C2=A0 pte =3D READ_ONCE(*ptep);
>=20
> same
>=20
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(pte_young(pte));
>> +}
>> +
>> +static void __init pte_savedwrite_tests(unsigned long pfn, pgprot_t p=
rot)
>> +{
>> +=C2=A0=C2=A0=C2=A0 pte_t pte =3D pfn_pte(pfn, prot);
>> +
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!pte_savedwrite(pte_mk_savedwrite(pte_clea=
r_savedwrite(pte))));
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(pte_savedwrite(pte_clear_savedwrite(pte_mk=
_savedwrite(pte))));
>> +}
>> =C2=A0 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> =C2=A0 static void __init pmd_basic_tests(unsigned long pfn, pgprot_t =
prot)
>> =C2=A0 {
>> @@ -77,6 +127,89 @@ static void __init pmd_basic_tests(unsigned long p=
fn, pgprot_t prot)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(!pmd_bad(pmd_mkhuge(pmd)));
>> =C2=A0 }
>> =C2=A0 +static void __init pmd_advanced_tests(struct mm_struct *mm,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vm_area_struct *vma=
, pmd_t *pmdp,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long pfn, unsigne=
d long vaddr, pgprot_t prot)
>> +{
>> +=C2=A0=C2=A0=C2=A0 pmd_t pmd =3D pfn_pmd(pfn, prot);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!has_transparent_hugepage())
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Align the address wrt HPAGE_PMD_SIZE */
>> +=C2=A0=C2=A0=C2=A0 vaddr =3D (vaddr & HPAGE_PMD_MASK) + HPAGE_PMD_SIZ=
E;
>> +
>> +=C2=A0=C2=A0=C2=A0 pmd =3D pfn_pmd(pfn, prot);
>> +=C2=A0=C2=A0=C2=A0 set_pmd_at(mm, vaddr, pmdp, pmd);
>> +=C2=A0=C2=A0=C2=A0 pmdp_set_wrprotect(mm, vaddr, pmdp);
>> +=C2=A0=C2=A0=C2=A0 pmd =3D READ_ONCE(*pmdp);
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(pmd_write(pmd));
>> +
>> +=C2=A0=C2=A0=C2=A0 pmd =3D pfn_pmd(pfn, prot);
>> +=C2=A0=C2=A0=C2=A0 set_pmd_at(mm, vaddr, pmdp, pmd);
>> +=C2=A0=C2=A0=C2=A0 pmdp_huge_get_and_clear(mm, vaddr, pmdp);
>> +=C2=A0=C2=A0=C2=A0 pmd =3D READ_ONCE(*pmdp);
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!pmd_none(pmd));
>> +
>> +=C2=A0=C2=A0=C2=A0 pmd =3D pfn_pmd(pfn, prot);
>> +=C2=A0=C2=A0=C2=A0 pmd =3D pmd_wrprotect(pmd);
>> +=C2=A0=C2=A0=C2=A0 pmd =3D pmd_mkclean(pmd);
>> +=C2=A0=C2=A0=C2=A0 set_pmd_at(mm, vaddr, pmdp, pmd);
>> +=C2=A0=C2=A0=C2=A0 pmd =3D pmd_mkwrite(pmd);
>> +=C2=A0=C2=A0=C2=A0 pmd =3D pmd_mkdirty(pmd);
>> +=C2=A0=C2=A0=C2=A0 pmdp_set_access_flags(vma, vaddr, pmdp, pmd, 1);
>> +=C2=A0=C2=A0=C2=A0 pmd =3D READ_ONCE(*pmdp);
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!(pmd_write(pmd) && pmd_dirty(pmd)));
>> +
>> +=C2=A0=C2=A0=C2=A0 pmd =3D pmd_mkhuge(pfn_pmd(pfn, prot));
>> +=C2=A0=C2=A0=C2=A0 set_pmd_at(mm, vaddr, pmdp, pmd);
>> +=C2=A0=C2=A0=C2=A0 pmdp_huge_get_and_clear_full(vma, vaddr, pmdp, 1);
>> +=C2=A0=C2=A0=C2=A0 pmd =3D READ_ONCE(*pmdp);
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!pmd_none(pmd));
>> +
>> +=C2=A0=C2=A0=C2=A0 pmd =3D pmd_mkyoung(pmd);
>> +=C2=A0=C2=A0=C2=A0 set_pmd_at(mm, vaddr, pmdp, pmd);
>> +=C2=A0=C2=A0=C2=A0 pmdp_test_and_clear_young(vma, vaddr, pmdp);
>> +=C2=A0=C2=A0=C2=A0 pmd =3D READ_ONCE(*pmdp);
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(pmd_young(pmd));
>> +}
>> +
>> +static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
>> +{
>> +=C2=A0=C2=A0=C2=A0 pmd_t pmd =3D pfn_pmd(pfn, prot);
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * PMD based THP is a leaf entry.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 pmd =3D pmd_mkhuge(pmd);
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!pmd_leaf(pmd));
>> +}
>> +
>> +static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgp=
rot_t prot)
>> +{
>> +=C2=A0=C2=A0=C2=A0 pmd_t pmd;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * X86 defined pmd_set_huge() verifies that t=
he given
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * PMD is not a populated non-leaf entry.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 WRITE_ONCE(*pmdp, __pmd(0));
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!pmd_set_huge(pmdp, __pfn_to_phys(pfn), pr=
ot));
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!pmd_clear_huge(pmdp));
>> +=C2=A0=C2=A0=C2=A0 pmd =3D READ_ONCE(*pmdp);
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!pmd_none(pmd));
>> +}
>> +
>> +static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t p=
rot)
>> +{
>> +=C2=A0=C2=A0=C2=A0 pmd_t pmd =3D pfn_pmd(pfn, prot);
>> +
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!pmd_savedwrite(pmd_mk_savedwrite(pmd_clea=
r_savedwrite(pmd))));
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(pmd_savedwrite(pmd_clear_savedwrite(pmd_mk=
_savedwrite(pmd))));
>> +}
>> +
>> =C2=A0 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>> =C2=A0 static void __init pud_basic_tests(unsigned long pfn, pgprot_t =
prot)
>> =C2=A0 {
>> @@ -100,12 +233,115 @@ static void __init pud_basic_tests(unsigned lon=
g pfn, pgprot_t prot)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(!pud_bad(pud_mkhuge(pud)));
>> =C2=A0 }
>> +
>> +static void pud_advanced_tests(struct mm_struct *mm,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vm_area_struct *vma=
, pud_t *pudp,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long pfn, unsigne=
d long vaddr, pgprot_t prot)
>> +{
>> +=C2=A0=C2=A0=C2=A0 pud_t pud =3D pfn_pud(pfn, prot);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!has_transparent_hugepage())
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Align the address wrt HPAGE_PUD_SIZE */
>> +=C2=A0=C2=A0=C2=A0 vaddr =3D (vaddr & HPAGE_PUD_MASK) + HPAGE_PUD_SIZ=
E;
>> +
>> +=C2=A0=C2=A0=C2=A0 set_pud_at(mm, vaddr, pudp, pud);
>> +=C2=A0=C2=A0=C2=A0 pudp_set_wrprotect(mm, vaddr, pudp);
>> +=C2=A0=C2=A0=C2=A0 pud =3D READ_ONCE(*pudp);
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(pud_write(pud));
>> +
>> +#ifndef __PAGETABLE_PMD_FOLDED
>> +=C2=A0=C2=A0=C2=A0 pud =3D pfn_pud(pfn, prot);
>> +=C2=A0=C2=A0=C2=A0 set_pud_at(mm, vaddr, pudp, pud);
>> +=C2=A0=C2=A0=C2=A0 pudp_huge_get_and_clear(mm, vaddr, pudp);
>> +=C2=A0=C2=A0=C2=A0 pud =3D READ_ONCE(*pudp);
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!pud_none(pud));
>> +
>> +=C2=A0=C2=A0=C2=A0 pud =3D pfn_pud(pfn, prot);
>> +=C2=A0=C2=A0=C2=A0 set_pud_at(mm, vaddr, pudp, pud);
>> +=C2=A0=C2=A0=C2=A0 pudp_huge_get_and_clear_full(mm, vaddr, pudp, 1);
>> +=C2=A0=C2=A0=C2=A0 pud =3D READ_ONCE(*pudp);
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!pud_none(pud));
>> +#endif /* __PAGETABLE_PMD_FOLDED */
>> +=C2=A0=C2=A0=C2=A0 pud =3D pfn_pud(pfn, prot);
>> +=C2=A0=C2=A0=C2=A0 pud =3D pud_wrprotect(pud);
>> +=C2=A0=C2=A0=C2=A0 pud =3D pud_mkclean(pud);
>> +=C2=A0=C2=A0=C2=A0 set_pud_at(mm, vaddr, pudp, pud);
>> +=C2=A0=C2=A0=C2=A0 pud =3D pud_mkwrite(pud);
>> +=C2=A0=C2=A0=C2=A0 pud =3D pud_mkdirty(pud);
>> +=C2=A0=C2=A0=C2=A0 pudp_set_access_flags(vma, vaddr, pudp, pud, 1);
>> +=C2=A0=C2=A0=C2=A0 pud =3D READ_ONCE(*pudp);
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!(pud_write(pud) && pud_dirty(pud)));
>> +
>> +=C2=A0=C2=A0=C2=A0 pud =3D pud_mkyoung(pud);
>> +=C2=A0=C2=A0=C2=A0 set_pud_at(mm, vaddr, pudp, pud);
>> +=C2=A0=C2=A0=C2=A0 pudp_test_and_clear_young(vma, vaddr, pudp);
>> +=C2=A0=C2=A0=C2=A0 pud =3D READ_ONCE(*pudp);
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(pud_young(pud));
>> +}
>> +
>> +static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
>> +{
>> +=C2=A0=C2=A0=C2=A0 pud_t pud =3D pfn_pud(pfn, prot);
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * PUD based THP is a leaf entry.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 pud =3D pud_mkhuge(pud);
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!pud_leaf(pud));
>> +}
>> +
>> +static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgp=
rot_t prot)
>> +{
>> +=C2=A0=C2=A0=C2=A0 pud_t pud;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * X86 defined pud_set_huge() verifies that t=
he given
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * PUD is not a populated non-leaf entry.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 WRITE_ONCE(*pudp, __pud(0));
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!pud_set_huge(pudp, __pfn_to_phys(pfn), pr=
ot));
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!pud_clear_huge(pudp));
>> +=C2=A0=C2=A0=C2=A0 pud =3D READ_ONCE(*pudp);
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!pud_none(pud));
>> +}
>> =C2=A0 #else=C2=A0 /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>> =C2=A0 static void __init pud_basic_tests(unsigned long pfn, pgprot_t =
prot) { }
>> +static void pud_advanced_tests(struct mm_struct *mm,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vm_area_struct *vma=
, pud_t *pudp,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long pfn, unsigne=
d long vaddr, pgprot_t prot)
>> +{
>> +}
>> +static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) {=
 }
>> +static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgp=
rot_t prot)
>> +{
>> +}
>> =C2=A0 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>> =C2=A0 #else=C2=A0 /* !CONFIG_TRANSPARENT_HUGEPAGE */
>> =C2=A0 static void __init pmd_basic_tests(unsigned long pfn, pgprot_t =
prot) { }
>> =C2=A0 static void __init pud_basic_tests(unsigned long pfn, pgprot_t =
prot) { }
>> +static void __init pmd_advanced_tests(struct mm_struct *mm,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vm_area_struct *vma=
, pmd_t *pmdp,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long pfn, unsigne=
d long vaddr, pgprot_t prot)
>> +{
>> +}
>> +static void __init pud_advanced_tests(struct mm_struct *mm,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vm_area_struct *vma=
, pud_t *pudp,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long pfn, unsigne=
d long vaddr, pgprot_t prot)
>> +{
>> +}
>> +static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot) {=
 }
>> +static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) {=
 }
>> +static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgp=
rot_t prot)
>> +{
>> +}
>> +static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgp=
rot_t prot)
>> +{
>> +}
>> +static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t p=
rot) { }
>> =C2=A0 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>> =C2=A0 =C2=A0 static void __init p4d_basic_tests(unsigned long pfn, pg=
prot_t prot)
>> @@ -495,8 +731,56 @@ static void __init hugetlb_basic_tests(unsigned l=
ong pfn, pgprot_t prot)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(!pte_huge(pte_mkhuge(pte)));
>> =C2=A0 #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
>> =C2=A0 }
>> +
>> +static void __init hugetlb_advanced_tests(struct mm_struct *mm,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vm_area_=
struct *vma,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pte_t *ptep, un=
signed long pfn,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long v=
addr, pgprot_t prot)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct page *page =3D pfn_to_page(pfn);
>> +=C2=A0=C2=A0=C2=A0 pte_t pte =3D READ_ONCE(*ptep);
>=20
> Remplace with ptep_get() to avoid build failure on powerpc 8xx.

Sure, will replace all open PTE pointer accesses with ptep_get().
