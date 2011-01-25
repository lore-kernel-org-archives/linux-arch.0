From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 00/25] mm: Preemptibility -v7
Date: Tue, 25 Jan 2011 20:28:53 +0100
Message-ID: <1295983733.28776.1072.camel@laptop>
References: <20110125173111.720927511@chello.nl>
	 <20110125183240.GA31346@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20110125183240.GA31346@merkur.ravnborg.org>
Sender: owner-linux-mm@kvack.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Tue, 2011-01-25 at 19:32 +0100, Sam Ravnborg wrote:

> Foregive me my ignorance..
> Why is this relevant for sparc64 but not for sparc32?
>=20
> A quick grep showed up only this in sparc32 specific files:
>=20
> mm/init_32.c:DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
>=20
> Maybe this is just something sparc32 does not support?

sparc32 uses include/asm-generic/tlb.h, whereas sparc64 implements its
own variant.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom policy in Canada: sign http://dissolvethecrtc.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
