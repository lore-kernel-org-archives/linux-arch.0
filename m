From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 02/21] powerpc: Use call_rcu_sched() for pagetables
Date: Sun, 28 Nov 2010 08:55:00 +1100
Message-ID: <1290894900.32570.160.camel@pasglop>
References: <20101126143843.801484792@chello.nl>
	 <20101126145410.373743450@chello.nl>  <20101127103319.GA6830@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20101127103319.GA6830@amd>
Sender: owner-linux-mm@kvack.org
To: Nick Piggin <npiggin@kernel.dk>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Nick Piggin <npiggin@suse.de>
List-Id: linux-arch.vger.kernel.org

On Sat, 2010-11-27 at 21:33 +1100, Nick Piggin wrote:
> Can this go through powerpc tree as a bugfix?
> 
> On Fri, Nov 26, 2010 at 03:38:45PM +0100, Peter Zijlstra wrote:
> > PowerPC relies on IRQ-disable to guard against RCU quiecent states,
> > use the appropriate RCU call version.
> > 

I'm happy to pick that up tomorrow.

Cheers,
Ben.


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom policy in Canada: sign http://dissolvethecrtc.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
