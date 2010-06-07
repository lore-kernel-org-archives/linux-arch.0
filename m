Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:58608 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab0FGQjk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2010 12:39:40 -0400
Received: from f199130.upc-f.chello.nl ([80.56.199.130] helo=dyad.programming.kicks-ass.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
	id 1OLfMS-0001P2-2c
	for linux-arch@vger.kernel.org; Mon, 07 Jun 2010 16:39:40 +0000
Subject: Re: [PATCH 00/28] mm: preemptibility -v3
From: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <87hble6brb.fsf@basil.nowhere.org>
References: <20100607110654.606530953@chello.nl>
	 <87hble6brb.fsf@basil.nowhere.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Jun 2010 18:39:31 +0200
Message-ID: <1275928771.1645.572.camel@laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@firstfloor.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20100607163931.oQclzeYm3l3nyH6JEHLBBQ9fT3KmlOq7iFRA0ZtAbFI@z>

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

