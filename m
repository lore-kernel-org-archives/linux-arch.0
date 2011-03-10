From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] arch/tile: optimize icache flush
Date: Thu, 10 Mar 2011 18:19:54 -0500
Message-ID: <4D795C9A.1040509@redhat.com>
References: <201103102125.p2ALPupL017020@farm-0012.internal.tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <201103102125.p2ALPupL017020@farm-0012.internal.tilera.com>
Sender: owner-linux-mm@kvack.org
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, torvalds@linux-foundation.org, aarcange@redhat.com, tglx@linutronix.de, mingo@elte.hu, akpm@linux-foundation.org, "David Miller <davem@davemloft.net>" <linux-arch@vger.kernel.org>, linux-mm@kvack.org, benh@kernel.crashing.org, hugh.dickins@tiscali.co.uk, mel@csn.ul.ie, npiggin@kernel.dk, rmk@arm.linux.org.uk, schwidefsky@de.ibm.com
List-Id: linux-arch.vger.kernel.org

On 03/10/2011 01:05 PM, Chris Metcalf wrote:
> Tile has incoherent icaches, so they must be explicitly invalidated
> when necessary.  Until now we have done so at tlb flush and context
> switch time, which means more invalidation than strictly necessary.
> The new model for icache flush is:
>
> - When we fault in a page as executable, we set an "Exec" bit in the
>    "struct page" information; the bit stays set until page free time.
>    (We use the arch_1 page bit for our "Exec" bit.)
>
> - At page free time, if the Exec bit is set, we do an icache flush.
>    This should happen relatively rarely: e.g., deleting a binary from disk,
>    or evicting a binary's pages from the page cache due to memory pressure.
>
> Signed-off-by: Chris Metcalf<cmetcalf@tilera.com>

Nice trick.

Acked-by: Rik van Riel <riel@redhat.com>

-- 
All rights reversed

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
