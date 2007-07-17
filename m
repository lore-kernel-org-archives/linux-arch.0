Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33455 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754884AbXGQVzK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jul 2007 17:55:10 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: + sparc64-rename-tlb_flush_mmu.patch added to -mm tree
Date: Tue, 17 Jul 2007 14:55:05 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A01F28290@scsmsx411.amr.corp.intel.com>
In-Reply-To: <1184680583.21357.67.camel@localhost>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: schwidefsky@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org
Cc: davem@davemloft.net, hugh@veritas.com
List-ID: <linux-arch.vger.kernel.org>

-			tlb_finish_mmu(*tlbp, tlb_start, start);
-
 			if (need_resched() ||
 				(i_mmap_lock && need_lockbreak(i_mmap_lock))) {
-				if (i_mmap_lock) {
-					*tlbp = NULL;
+				if (i_mmap_lock)
 					goto out;

If we take this "goto out" path, then we'll miss out on calling
the tlb_finish_mmu() which you deleted just above.  At the very
least this will leave preemption disabled (since we'll miss calling
the put_cpu_var(mmu_gathers)).

I think I'm also missing the big picture view of what you are
doing here.

-Tony
