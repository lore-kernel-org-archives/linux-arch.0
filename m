Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:47679 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756559Ab1BQRLd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2011 12:11:33 -0500
Message-ID: <20110217170520.229881980@chello.nl>
Date: Thu, 17 Feb 2011 18:05:20 +0100
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 0/8] mm: Preemptibility -v8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>
Message-ID: <20110217170520.27d4usXRdAlbkNRCWkITqzjxOfu9oz95vQ9NBPxPaT0@z>

This series depends on the previous two series:
  - mm: Simplify anon_vma lifetime rules
  - mm: mmu_gather rework

These patches make part of the mm a lot more preemptible. It converts
i_mmap_lock and anon_vma->lock to mutexes which together with the mmu_gather
rework makes mmu_gather preemptible as well.

Making i_mmap_lock a mutex also enables a clean-up of the truncate code.

This also allows for preemptible mmu_notifiers, something that XPMEM I think
wants.



