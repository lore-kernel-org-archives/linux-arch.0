From: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 09/28] mm: Move anon_vma ref out from under CONFIG_KSM
Date: Wed, 9 Jun 2010 12:05:01 +0100
Message-ID: <20100609110501.GE5650@csn.ul.ie>
References: <20100607110654.606530953@chello.nl> <20100607111407.216849162@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100607111407.216849162@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Nick Piggin <npiggin@suse.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Jun 07, 2010 at 01:07:03PM +0200, Peter Zijlstra wrote:
> We need an anon_vma refcount for preemptible anon_vma->lock.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Can't see any problems

Acked-by: Mel Gorman <mel@csn.ul.ie>

> <SNIP>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
