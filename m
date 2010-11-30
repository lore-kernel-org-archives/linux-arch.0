From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 09/21] powerpc: Preemptible mmu_gather
Date: Tue, 30 Nov 2010 14:35:48 +1100
Message-ID: <1291088148.32570.342.camel@pasglop>
References: <20101126143843.801484792@chello.nl>
	 <20101126145410.771278578@chello.nl>  <1291086726.32570.341.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1291086726.32570.341.camel@pasglop>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org


> This breaks embedded 64-bit build. Replace CONFIG_PPC64 with
> CONFIG_PPC_BOOK3S_64 to only hit server when you access the
> ppc64_tlb_batch in process.c since it doesn't exist for BOOK3E.
> 
> This patch to fold into yours fixes it for me:

With this fix and the other Kconfig fix, it seems to boot fine and no
obvious breakage doing simple things on G5 and a power6 machine.

Cheers,
Ben.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom policy in Canada: sign http://dissolvethecrtc.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
