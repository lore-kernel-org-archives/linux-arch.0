From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [RFC][PATCH 4/6] arm, mm: Convert arm to generic tlb
Date: Wed, 09 Mar 2011 16:19:24 +0100
Message-ID: <1299683964.2308.3075.camel@twins>
References: <20110302175928.022902359@chello.nl>
	 <20110302180259.109909335@chello.nl>
	 <AANLkTimbRS++SCcKGrUcL5xKsCO+1ygkg+83x7F+2S4i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <AANLkTimbRS++SCcKGrUcL5xKsCO+1ygkg+83x7F+2S4i@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Russell King <rmk@arm.linux.org.uk>, Chris Metcalf <cmetcalf@tilera.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Wed, 2011-03-09 at 15:16 +0000, Catalin Marinas wrote:
> Hi Peter,
>=20
> On 2 March 2011 17:59, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> > --- linux-2.6.orig/arch/arm/include/asm/tlb.h
> > +++ linux-2.6/arch/arm/include/asm/tlb.h
> [...]
> > +__pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long ad=
dr)
> >  {
> >        pgtable_page_dtor(pte);
> > -       tlb_add_flush(tlb, addr);
> >        tlb_remove_page(tlb, pte);
> >  }
>=20
> I think we still need a tlb_track_range() call here. On the path to
> pte_free_tlb() (for example shift_arg_pages ... free_pte_range) there
> doesn't seem to be any code setting the tlb->start/end range. Did I
> miss anything?

Patch 3 included:

-#define pte_free_tlb(tlb, ptep, address)                       \
-       do {                                                    \
-               tlb->need_flush =3D 1;                            \
-               __pte_free_tlb(tlb, ptep, address);             \
+#define pte_free_tlb(tlb, ptep, address)                                  =
     \
+       do {                                                               =
     \
+               tlb->need_flush =3D 1;                                     =
       \
+               tlb_track_range(tlb, address, pmd_addr_end(address, TASK_SI=
ZE));\
+               __pte_free_tlb(tlb, ptep, address);                        =
     \
        } while (0)

Also, I posted a new version of this series here:

  https://lkml.org/lkml/2011/3/7/308

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
