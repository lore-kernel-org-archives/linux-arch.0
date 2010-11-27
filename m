Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:15903 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752320Ab0K0Ki2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 27 Nov 2010 05:38:28 -0500
Date: Sat, 27 Nov 2010 21:33:19 +1100
From: Nick Piggin <npiggin@kernel.dk>
Subject: Re: [PATCH 02/21] powerpc: Use call_rcu_sched() for pagetables
Message-ID: <20101127103319.GA6830@amd>
References: <20101126143843.801484792@chello.nl>
 <20101126145410.373743450@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101126145410.373743450@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Nick Piggin <npiggin@suse.de>
Message-ID: <20101127103319.3tkUOgqlOFsnkNcEHlUPoAy0uLvb4AD0aNY6HsvhHsg@z>

Can this go through powerpc tree as a bugfix?

On Fri, Nov 26, 2010 at 03:38:45PM +0100, Peter Zijlstra wrote:
> PowerPC relies on IRQ-disable to guard against RCU quiecent states,
> use the appropriate RCU call version.
> 
