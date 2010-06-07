From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/28] mm: preemptibility -v3
Date: Mon, 07 Jun 2010 18:39:31 +0200
Message-ID: <1275928771.1645.572.camel@laptop>
References: <20100607110654.606530953@chello.nl>
	 <87hble6brb.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87hble6brb.fsf@basil.nowhere.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@firstfloor.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Mon, 2010-06-07 at 18:36 +0200, Andi Kleen wrote:
> Peter Zijlstra <a.p.zijlstra@chello.nl> writes:
> 
> > This patch-set makes part of the mm a lot more preemptible. It converts
> > i_mmap_lock and anon_vma->lock to mutexes and makes mmu_gather fully
> > preemptible.
> 
> How about performance measurements?   mutexes still behave quite
> differently from spinlocks, especially under contention.

What's your favourite benchmark to stress i_mmap_mutex/anon_vma->lock?

a cache-hot kernel build didn't really show a difference..
