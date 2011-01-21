From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 00/21] mm: Preemptibility -v6
Date: Fri, 21 Jan 2011 18:36:32 +1100
Message-ID: <1295595392.2148.285.camel@pasglop>
References: <20101126143843.801484792@chello.nl>
	 <alpine.LSU.2.00.1101172301340.2899@sister.anvils>
	 <1295457039.28776.137.camel@laptop>
	 <alpine.LSU.2.00.1101201052060.1603@sister.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <alpine.LSU.2.00.1101201052060.1603@sister.anvils>
Sender: owner-linux-mm@kvack.org
To: Hugh Dickins <hughd@google.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Nick Piggin <npiggin@kernel.dk>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 2011-01-20 at 11:57 -0800, Hugh Dickins wrote:
> 
> But that doesn't preclude lumping them all together for the final
> commit,
> for ease of bisection.  I think Andrew and Ben are the ones to decide
> on that: Ben's bisectability got burnt by THP just now, so he'll have
> strong feelings and good reasons.

I do hate bisectability breakage indeed ... :-)

Cheers,
Ben.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom policy in Canada: sign http://dissolvethecrtc.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
