Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52644 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab1B1Mwo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2011 07:52:44 -0500
Date: Mon, 28 Feb 2011 12:50:58 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 06/17] arm: mmu_gather rework
Message-ID: <20110228125058.GD492@flint.arm.linux.org.uk>
References: <20110217162327.434629380@chello.nl> <20110217163235.106239192@chello.nl> <1298565253.2428.288.camel@twins> <1298657083.2428.2483.camel@twins> <20110225215123.GA10026@flint.arm.linux.org.uk> <1298893487.2428.10537.camel@twins> <20110228115907.GB492@flint.arm.linux.org.uk> <1298895612.2428.10621.camel@twins> <20110228122803.GC492@flint.arm.linux.org.uk> <1298897342.2428.10687.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1298897342.2428.10687.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, "Luck,Tony" <tony.luck@intel.com>, PaulMundt <lethal@linux-sh.org>, Chris Metcalf <cmetcalf@tilera.com>
Message-ID: <20110228125058.zskgfWTDKiczPK_as3JFFeskk4ddiIMG_dkCBwWhbgA@z>

On Mon, Feb 28, 2011 at 01:49:02PM +0100, Peter Zijlstra wrote:
> On Mon, 2011-02-28 at 12:28 +0000, Russell King wrote:
> > Can you point out where pte_free_tlb() is used with unmap_region()?
> 
> unmap_region()
>   free_pgtables()
>     free_pgd_range()
>       free_pud_range()
>         free_pmd_range()
>           free_pte_range()
>             pte_free_tlb()

Damn it.  Okay, I give up with this.  The TLB shootdown interface is
total crap.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
