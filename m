From: Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 09/25] ia64: Preemptible mmu_gather
Date: Tue, 25 Jan 2011 12:12:56 -0800
Message-ID: <AANLkTikgpX16=ouGCpKqDtr7w-AUWLQNU7cFi4vKWbt+@mail.gmail.com>
References: <20110125173111.720927511@chello.nl>
	<20110125174907.664402563@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58880 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab1AYUM5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jan 2011 15:12:57 -0500
In-Reply-To: <20110125174907.664402563@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>

On Tue, Jan 25, 2011 at 9:31 AM, Peter Zijlstra <a.p.zijlstra@chello.nl=
> wrote:
> =A0struct mmu_gather {
> =A0 =A0 =A0 =A0struct mm_struct =A0 =A0 =A0 =A0*mm;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0nr; =A0 =A0 =A0 =A0=
 =A0 =A0 /* =3D=3D ~0U =3D> fast mode */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0max;
> =A0 =A0 =A0 =A0unsigned char =A0 =A0 =A0 =A0 =A0 fullmm; =A0 =A0 =A0 =
=A0 /* non-zero means full mm flush */
> =A0 =A0 =A0 =A0unsigned char =A0 =A0 =A0 =A0 =A0 need_flush; =A0 =A0 =
/* really unmapped some PTEs? */
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 start_addr;
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 end_addr;
> - =A0 =A0 =A0 struct page =A0 =A0 =A0 =A0 =A0 =A0 *pages[FREE_PTE_NR]=
;
> + =A0 =A0 =A0 struct page =A0 =A0 =A0 =A0 =A0 =A0 **pages;
> + =A0 =A0 =A0 struct page =A0 =A0 =A0 =A0 =A0 =A0 *local[8];
> =A0};

Overall it looks OK - builds, boots & runs too. One question about
the above bit ... why "8" elements in the local[] array?  This ought to=
 be
a #define, maybe with a comment explaining the significance. It doesn't
seem to fill out struct mmu_gather to some "nice" size.  I can't think
of why batching 8 at a time (in the fallback cannot allocate **pages ca=
se)
is a good number. So is there some science to the choice, or did you
pluck 8 out of the air?

Thanks

-Tony
