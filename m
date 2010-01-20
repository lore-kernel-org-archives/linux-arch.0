From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [CFT] MM: Pass a PTE pointer to update_mmu_cache() rather than
	the PTE itself
Date: Wed, 20 Jan 2010 17:45:34 +0100
Message-ID: <10f740e81001200845o7a31bcb6yea475f3aabcb5476@mail.gmail.com>
References: <20100120135202.GA20937@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752710Ab0ATQpj@vger.kernel.org>
In-Reply-To: <20100120135202.GA20937@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 20, 2010 at 14:52, Russell King <rmk+lkml@arm.linux.org.uk>=
 wrote:
> On VIVT ARM, when we have multiple shared mappings of the same file
> in the same MM, we need to ensure that we have coherency across all
> copies. =C2=A0We do this via make_coherent() by making the pages
> uncacheable.
>
> This used to work fine, until we allowed highmem with highpte - we
> now have a page table which is mapped as required, and is not availab=
le
> for modification via update_mmu_cache().
>
> Ralf Beache suggested getting rid of the PTE value passed to
> update_mmu_cache():
>
> =C2=A0On MIPS update_mmu_cache() calls __update_tlb() which walks pag=
etables
> =C2=A0to construct a pointer to the pte again. =C2=A0Passing a pte_t =
* is much
> =C2=A0more elegant. =C2=A0Maybe we might even replace the pte argumen=
t with the
> =C2=A0pte_t?
>
> Ben Herrenschmidt would also like the pte pointer for PowerPC:
>
> =C2=A0Passing the ptep in there is exactly what I want. =C2=A0I want =
that
> =C2=A0-instead- of the PTE value, because I have issue on some ppc ca=
ses,
> =C2=A0for I$/D$ coherency, where set_pte_at() may decide to mask out =
the
> =C2=A0_PAGE_EXEC.
>
> So, pass in the mapped page table pointer into update_mmu_cache(), an=
d
> remove the PTE value, updating all implementations and call sites to
> suit.

> diff --git a/Documentation/cachetlb.txt b/Documentation/cachetlb.txt
> index da42ab4..74a8b6f 100644
> --- a/Documentation/cachetlb.txt
> +++ b/Documentation/cachetlb.txt
> @@ -88,12 +88,12 @@ changes occur:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0This is used primarily during fault proces=
sing.
>
> =C2=A05) void update_mmu_cache(struct vm_area_struct *vma,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0unsigned long address, pte_t pte)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0unsigned long address, pte_t *ptep)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0At the end of every page fault, this routi=
ne is invoked to
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tell the architecture specific code that a=
 translation
> - =C2=A0 =C2=A0 =C2=A0 described by "pte" now exists at virtual addre=
ss "address"
> - =C2=A0 =C2=A0 =C2=A0 for address space "vma->vm_mm", in the softwar=
e page tables.
> + =C2=A0 =C2=A0 =C2=A0 now exists at virtual address "address" for ad=
dress space
> + =C2=A0 =C2=A0 =C2=A0 "vma->vm_mm", in the software page tables.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A port may use this information in any way=
 it so chooses.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0For example, it could use this event to pr=
e-load TLB

Now the documentation no longer mentions what the 3rd parameter is used=
 for?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
