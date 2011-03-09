From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC][PATCH 4/6] arm, mm: Convert arm to generic tlb
Date: Wed, 9 Mar 2011 15:16:07 +0000
Message-ID: <AANLkTimbRS++SCcKGrUcL5xKsCO+1ygkg+83x7F+2S4i@mail.gmail.com>
References: <20110302175928.022902359@chello.nl>
	<20110302180259.109909335@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52239 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757097Ab1CIPQI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Mar 2011 10:16:08 -0500
In-Reply-To: <20110302180259.109909335@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Russell King <rmk@arm.linux.org.uk>, Chris Metcalf <cmetcalf@tilera.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

Hi Peter,

On 2 March 2011 17:59, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> --- linux-2.6.orig/arch/arm/include/asm/tlb.h
> +++ linux-2.6/arch/arm/include/asm/tlb.h
[...]
> +__pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long =
addr)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pgtable_page_dtor(pte);
> - =C2=A0 =C2=A0 =C2=A0 tlb_add_flush(tlb, addr);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tlb_remove_page(tlb, pte);
> =C2=A0}

I think we still need a tlb_track_range() call here. On the path to
pte_free_tlb() (for example shift_arg_pages ... free_pte_range) there
doesn't seem to be any code setting the tlb->start/end range. Did I
miss anything?

Thanks.

--=20
Catalin
