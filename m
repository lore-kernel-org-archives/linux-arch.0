Return-Path: <SRS0=t4Rs=5I=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [PATCH] mm/debug: Add tests validating arch page table helpers
 for core features
References: <1582799637-11786-1-git-send-email-anshuman.khandual@arm.com>
 <2be41c29-500c-50af-f915-1493846ae9e5@c-s.fr>
 <4343eda9-7df2-a13c-0125-cf784c81ce14@arm.com>
 <20200302222443.Horde.3Vn7_PzcWbAADKFWloR-kw8@messagerie.si.c-s.fr>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <cd80e950-1185-bc12-f844-295b854d429a@arm.com>
Date: Mon, 23 Mar 2020 18:56:47 +0530
MIME-Version: 1.0
In-Reply-To: <20200302222443.Horde.3Vn7_PzcWbAADKFWloR-kw8@messagerie.si.c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, "Kirill A . Shutemov" <kirill@shutemov.name>, Paul Walmsley <paul.walmsley@sifive.com>, Borislav Petkov <bp@alien8.de>, Vasily Gorbik <gor@linux.ibm.com>, linux-snps-arc@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Mike Rapoport <rppt@linux.ibm.com>, x86@kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200323132647.MT0VPWsaakZG4t4AbQjqo3_V2uKIDAwqSelfx2g8TWk@z>



On 03/03/2020 02:54 AM, Christophe Leroy wrote:
> Anshuman Khandual <anshuman.khandual@arm.com> a =C3=A9crit=C2=A0:
>=20
>> On 02/27/2020 04:59 PM, Christophe Leroy wrote:
>>>
>>>
>>> Le 27/02/2020 =C3=A0 11:33, Anshuman Khandual a =C3=A9crit=C2=A0:
>>>> This adds new tests validating arch page table helpers for these fol=
lowing
>>>> core memory features. These tests create and test specific mapping t=
ypes at
>>>> various page table levels.
>>>>
>>>> * SPECIAL mapping
>>>> * PROTNONE mapping
>>>> * DEVMAP mapping
>>>> * SOFTDIRTY mapping
>>>> * SWAP mapping
>>>> * MIGRATION mapping
>>>> * HUGETLB mapping
>>>> * THP mapping
>>>>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>>>> Cc: Vineet Gupta <vgupta@synopsys.com>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>> Cc: Paul Mackerras <paulus@samba.org>
>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>>>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>>>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>> Cc: Borislav Petkov <bp@alien8.de>
>>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>>>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>>>> Cc: linux-snps-arc@lists.infradead.org
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linuxppc-dev@lists.ozlabs.org
>>>> Cc: linux-s390@vger.kernel.org
>>>> Cc: linux-riscv@lists.infradead.org
>>>> Cc: x86@kernel.org
>>>> Cc: linux-arch@vger.kernel.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>> Tested on arm64 and x86 platforms without any test failures. But thi=
s has
>>>> only been built tested on several other platforms. Individual tests =
need
>>>> to be verified on all current enabling platforms for the test i.e s3=
90,
>>>> ppc32, arc etc.
>>>>
>>>> This patch must be applied on v5.6-rc3 after these patches
>>>>
>>>> 1. https://patchwork.kernel.org/patch/11385057/
>>>> 2. https://patchwork.kernel.org/patch/11407715/
>>>>
>>>> OR
>>>>
>>>> This patch must be applied on linux-next (next-20200227) after this =
patch
>>>>
>>>> 2. https://patchwork.kernel.org/patch/11407715/
>>>>
>>>> =C2=A0 mm/debug_vm_pgtable.c | 310 +++++++++++++++++++++++++++++++++=
++++++++-
>>>> =C2=A0 1 file changed, 309 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>>> index 96dd7d574cef..3fb90d5b604e 100644
>>>> --- a/mm/debug_vm_pgtable.c
>>>> +++ b/mm/debug_vm_pgtable.c
>>>> @@ -41,6 +41,44 @@
>>>> =C2=A0=C2=A0 * wrprotect(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D A write protected and not a write entry
>>>> =C2=A0=C2=A0 * pxx_bad(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D A mapped and non-table entry
>>>> =C2=A0=C2=A0 * pxx_same(entry1, entry2)=C2=A0=C2=A0=C2=A0 =3D Both e=
ntries hold the exact same value
>>>> + *
>>>> + * Specific feature operations
>>>> + *
>>>> + * pte_mkspecial(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 Creates a special entry at PTE level
>>>> + * pte_special(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 Tests a special entry at PTE level
>>>> + *
>>>> + * pte_protnone(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 Tests a no access entry at PTE level
>>>> + * pmd_protnone(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 Tests a no access entry at PMD level
>>>> + *
>>>> + * pte_mkdevmap(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 Creates a device entry at PTE level
>>>> + * pmd_mkdevmap(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 Creates a device entry at PMD level
>>>> + * pud_mkdevmap(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 Creates a device entry at PUD level
>>>> + * pte_devmap(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
Tests a device entry at PTE level
>>>> + * pmd_devmap(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
Tests a device entry at PMD level
>>>> + * pud_devmap(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
Tests a device entry at PUD level
>>>> + *
>>>> + * pte_mksoft_dirty(entry)=C2=A0=C2=A0=C2=A0 =3D Creates a soft dir=
ty entry at PTE level
>>>> + * pmd_mksoft_dirty(entry)=C2=A0=C2=A0=C2=A0 =3D Creates a soft dir=
ty entry at PMD level
>>>> + * pte_swp_mksoft_dirty(entry)=C2=A0=C2=A0=C2=A0 =3D Creates a soft=
 dirty swap entry at PTE level
>>>> + * pmd_swp_mksoft_dirty(entry)=C2=A0=C2=A0=C2=A0 =3D Creates a soft=
 dirty swap entry at PMD level
>>>> + * pte_soft_dirty(entry)=C2=A0=C2=A0=C2=A0 =3D Tests a soft dirty e=
ntry at PTE level
>>>> + * pmd_soft_dirty(entry)=C2=A0=C2=A0=C2=A0 =3D Tests a soft dirty e=
ntry at PMD level
>>>> + * pte_swp_soft_dirty(entry)=C2=A0=C2=A0=C2=A0 =3D Tests a soft dir=
ty swap entry at PTE level
>>>> + * pmd_swp_soft_dirty(entry)=C2=A0=C2=A0=C2=A0 =3D Tests a soft dir=
ty swap entry at PMD level
>>>> + * pte_clear_soft_dirty(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D Clears a soft dirty entry at PTE level
>>>> + * pmd_clear_soft_dirty(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D Clears a soft dirty entry at PMD level
>>>> + * pte_swp_clear_soft_dirty(entry) =3D Clears a soft dirty swap ent=
ry at PTE level
>>>> + * pmd_swp_clear_soft_dirty(entry) =3D Clears a soft dirty swap ent=
ry at PMD level
>>>> + *
>>>> + * pte_mkhuge(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
Creates a HugeTLB entry at given level
>>>> + * pte_huge(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D Te=
sts a HugeTLB entry at given level
>>>> + *
>>>> + * pmd_trans_huge(entry)=C2=A0=C2=A0=C2=A0 =3D Tests a trans huge p=
age at PMD level
>>>> + * pud_trans_huge(entry)=C2=A0=C2=A0=C2=A0 =3D Tests a trans huge p=
age at PUD level
>>>> + * pmd_present(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 Tests an entry points to memory at PMD level
>>>> + * pud_present(entry)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 Tests an entry points to memory at PUD level
>>>> + * pmd_mknotpresent(entry)=C2=A0=C2=A0=C2=A0 =3D Invalidates an PMD=
 entry for MMU
>>>> + * pud_mknotpresent(entry)=C2=A0=C2=A0=C2=A0 =3D Invalidates an PUD=
 entry for MMU
>>>> =C2=A0=C2=A0 */
>>>> =C2=A0 #define VMFLAGS=C2=A0=C2=A0=C2=A0 (VM_READ|VM_WRITE|VM_EXEC)
>>>> =C2=A0 @@ -287,6 +325,233 @@ static void __init pmd_populate_tests(s=
truct mm_struct *mm, pmd_t *pmdp,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(pmd_bad(pmd));
>>>> =C2=A0 }
>>>> =C2=A0 +#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>>>
>>> Can we avoid ifdefs unless necessary ?
>>>
>>> In mm/memory.c I see things like the following, it means pte_special(=
) always exist and a #ifdef is not necessary.
>>
>> True, #ifdef here can be dropped here, done.
>>
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) =
{
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (likely(!pte_special(pt=
e)))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to check_pfn;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vma->vm_ops && vma->vm=
_ops->find_special_page)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn vma->vm_ops->find_special_page(vma, addr);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vma->vm_flags & (VM_PF=
NMAP | VM_MIXEDMAP))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (is_zero_pfn(pfn))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pte_devmap(pte))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn NULL;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_bad_pte(vma, addr, p=
te, NULL);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0}
>>>
>>>> +static void __init pte_special_tests(unsigned long pfn, pgprot_t pr=
ot)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 pte_t pte =3D pfn_pte(pfn, prot);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 WARN_ON(!pte_special(pte_mkspecial(pte)));
>>>> +}
>>>> +#else
>>>> +static void __init pte_special_tests(unsigned long pfn, pgprot_t pr=
ot) { }
>>>> +#endif
>>>> +
>>>> +#ifdef CONFIG_NUMA_BALANCING
>>>
>>> Same here, this ifdef shouldn't be necessary because in /include/asm-=
generic/pgtable.h we have the following, so a if (IS_ENABLED()) should be=
 enough.
>>>
>>> #ifndef CONFIG_NUMA_BALANCING
>>> /*
>>> =C2=A0* Technically a PTE can be PROTNONE even when not doing NUMA ba=
lancing but
>>> =C2=A0* the only case the kernel cares is for NUMA balancing and is o=
nly ever set
>>> =C2=A0* when the VMA is accessible. For PROT_NONE VMAs, the PTEs are =
not marked
>>> =C2=A0* _PAGE_PROTNONE so by by default, implement the helper as "alw=
ays no". It
>>> =C2=A0* is the responsibility of the caller to distinguish between PR=
OT_NONE
>>> =C2=A0* protections and NUMA hinting fault protections.
>>> =C2=A0*/
>>> static inline int pte_protnone(pte_t pte)
>>> {
>>> =C2=A0=C2=A0=C2=A0=C2=A0return 0;
>>> }
>>>
>>> static inline int pmd_protnone(pmd_t pmd)
>>> {
>>> =C2=A0=C2=A0=C2=A0=C2=A0return 0;
>>> }
>>> #endif /* CONFIG_NUMA_BALANCING */
>>
>> True,=C2=A0 #ifdef here can be dropped, done. There is something I had=
 missed
>> before, pfn_pmd() requires #ifdef CONFIG_TRANSPARENT_HUGEPAGE instead.=
 We
>> need a pmd_t here with given prot. We cannot go via pfn_pte() followed=
 by
>> pte_pmd(), as the later is platform specific and not available in gene=
ral.
>=20
> As many things require CONFIG_TRANSPARENT_HUGEPAGE,=C2=A0 maybe it woul=
d be worth creating an additional C file with the related functions and b=
uild it conditionnaly to CONFIG_TRANSPARENT_HUGEPAGE
>=20

Apologies for the delayed response here. Any split in the test will break=
 it's
monolithic structure which is not desirable. Also lack of an explicit dep=
endency
between HAVE_ARCH_TRANSPARENT_HUGEPAGE and HAVE_ARCH_TRANSPARENT_HUGEPAGE=
_PUD
makes it difficult to group together fallback dummy stubs from various TH=
P
related test functions here. I am planning to re-spin this patch sooner w=
ith
some more tests while also accommodating other previous comments. Hence, =
will
probably note down this aspect which can then be discussed further if req=
uired.

> Christophe
