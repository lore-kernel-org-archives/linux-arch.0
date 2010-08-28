From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/20] mm: Preemptibility -v4
Date: Sat, 28 Aug 2010 17:27:02 +0200
Message-ID: <1283009222.1975.3622.camel@laptop>
References: <20100828141637.421594670@chello.nl>
	 <AANLkTikhV6PLb_pRmBmjynft4pe4paKogFP-JR7aXXyv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikhV6PLb_pRmBmjynft4pe4paKogFP-JR7aXXyv@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Sat, 2010-08-28 at 18:19 +0300, Pekka Enberg wrote:
> Hi Peter,
> 
> On Sat, Aug 28, 2010 at 5:16 PM, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> > Yanmin ran the last posting through the comprehensive Intel test farm
> > and didn't find any regressions.
> 
> Is there data somewhere that shows where this helps and how much?

Yanmin didn't publish any data, but the main point of the series is to
not take hundreds of nested spinlocks. Not regressing is a fine state.

In theory the preemptible mmu could end up doing less TLB invalidates
for large unmaps and thus gain some performance there.
