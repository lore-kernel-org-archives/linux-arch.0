From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 00/28] mm: preemptibility -v3
Date: Mon, 07 Jun 2010 18:36:08 +0200
Message-ID: <87hble6brb.fsf@basil.nowhere.org>
References: <20100607110654.606530953@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:35636 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab0FGQgM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2010 12:36:12 -0400
In-Reply-To: <20100607110654.606530953@chello.nl> (Peter Zijlstra's message of "Mon\, 07 Jun 2010 13\:06\:54 +0200")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@firstfloor.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Peter Zijlstra <a.p.zijlstra@chello.nl> writes:

> This patch-set makes part of the mm a lot more preemptible. It converts
> i_mmap_lock and anon_vma->lock to mutexes and makes mmu_gather fully
> preemptible.

How about performance measurements?   mutexes still behave quite
differently from spinlocks, especially under contention.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
