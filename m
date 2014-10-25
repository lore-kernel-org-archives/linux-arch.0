Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:41114 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbaJYVAt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 25 Oct 2014 17:00:49 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
	Sat, 25 Oct 2014 20:30:22 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 1/2] mm: Update generic gup implementation to handle hugepage directory
In-Reply-To: <20141023.184035.388557314666522484.davem@davemloft.net>
References: <1413520687-31729-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com> <20141022160224.9c2268795e55d5a2eff5b94d@linux-foundation.org> <20141023.184035.388557314666522484.davem@davemloft.net>
Date: Sat, 25 Oct 2014 16:00:05 +0530
Message-ID: <87ppdg30ia.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>, akpm@linux-foundation.org
Cc: steve.capper@linaro.org, aarcange@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, hannes@cmpxchg.org
Message-ID: <20141025103005.4eoiVfVjLJX4kULkSu0mOvSjkE1GxBtPwnywyW6n3kk@z>

David Miller <davem@davemloft.net> writes:

> Hey guys, was looking over the generic GUP while working on a sparc64
> issue and I noticed that you guys do speculative page gets, and after
> talking with Johannes Weiner (CC:'d) about this we don't see how it
> could be necessary.
>
> If interrupts are disabled during the page table scan (which they
> are), no IPI tlb flushes can arrive.  Therefore any removal from the
> page tables is guarded by interrupts being re-enabled.  And as a
> result, page counts of pages we see in the page tables must always
> have a count > 0.
>
> x86 does direct atomic_add() on &page->_count because of this
> invariant and I would rather see the generic version do this too.


But that won't work with RCU GUP. For example on powerpc the tlb flush
doesn't involve an IPI and we can essentially find page count 0.

-aneesh

