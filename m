From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Subject: Re: [PATCH 06/17] arm: mmu_gather rework
Date: Fri, 25 Feb 2011 11:59:23 -0800
Message-ID: <AANLkTinLv=oy5_nPdziV6gpG-BLedsrNF0ew4Wz3x690@mail.gmail.com>
References: <20110217162327.434629380@chello.nl>
	<20110217163235.106239192@chello.nl>
	<1298565253.2428.288.camel@twins>
	<1298657083.2428.2483.camel@twins>
	<1298663105.2428.2693.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:55818 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756368Ab1BYT73 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Feb 2011 14:59:29 -0500
Received: from kpbe17.cbf.corp.google.com (kpbe17.cbf.corp.google.com [172.25.105.81])
	by smtp-out.google.com with ESMTP id p1PJxRct029999
	for <linux-arch@vger.kernel.org>; Fri, 25 Feb 2011 11:59:27 -0800
Received: from vws12 (vws12.prod.google.com [10.241.21.140])
	by kpbe17.cbf.corp.google.com with ESMTP id p1PJv21V014274
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Fri, 25 Feb 2011 11:59:26 -0800
Received: by vws12 with SMTP id 12so1671642vws.19
        for <linux-arch@vger.kernel.org>; Fri, 25 Feb 2011 11:59:26 -0800 (PST)
In-Reply-To: <1298663105.2428.2693.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Russell King <rmk@arm.linux.org.uk>, "Luck,Tony" <tony.luck@intel.com>, PaulMundt <lethal@linux-sh.org>

On Fri, Feb 25, 2011 at 11:45 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> Grmbl.. so doing that would require flush_tlb_range() to take an mm, not
> a vma, but tile and arm both use the vma->flags & VM_EXEC test to avoid
> flushing their i-tlbs.
>
> I'm tempted to make them flush i-tlbs unconditionally as its still
> better than hitting an mm wide tlb flush due to the page table free.
>
> Ideas?

What's wrong with using vma->vm_mm?

Hugh
