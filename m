From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 01/13] powerpc: Add rcu_read_lock() to gup_fast() implementation
Date: Thu, 08 Apr 2010 16:31:43 -0400
Message-ID: <4BBE3D2F.6030609@redhat.com>
References: <20100408191737.296180458@chello.nl> <20100408192722.643778654@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23179 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933486Ab0DHUdB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 8 Apr 2010 16:33:01 -0400
In-Reply-To: <20100408192722.643778654@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>

On 04/08/2010 03:17 PM, Peter Zijlstra wrote:
> The powerpc page table freeing relies on the fact that IRQs hold off
> an RCU grace period, this is currently true for all existing RCU
> implementations but is not an assumption Paul wants to support.
>
> Therefore, also take the RCU read lock along with disabling IRQs to
> ensure the RCU grace period does at least cover these lookups.
>
> Requested-by: Paul E. McKenney<paulmck@linux.vnet.ibm.com>
> Signed-off-by: Peter Zijlstra<a.p.zijlstra@chello.nl>
> Cc: Nick Piggin<npiggin@suse.de>
> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>

Reviewed-by: Rik van Riel <riel@redhat.com>
