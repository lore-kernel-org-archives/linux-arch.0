Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35086 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360Ab1CBSFu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 Mar 2011 13:05:50 -0500
Message-ID: <20110302175928.022902359@chello.nl>
Date: Wed, 02 Mar 2011 18:59:28 +0100
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [RFC][PATCH 0/6] mm: Unify TLB gather implementations
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Arcangeli <aarcange@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Russell King <rmk@arm.linux.org.uk>, Chris Metcalf <cmetcalf@tilera.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <20110302175928.OQ5uvraKnGQhVi73hsf1ugrw2EjcrVZ0Kx2huyygrA8@z>

This is a series that attempts to unify and fix the current tlb gather
implementations, theres numerous more tlb range architectures that I need
to visit, but please do comment on the direction taken.

Compile tested, but note I don't have anything to actually test this one
(aside from an omap board without network access).

