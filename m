From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [RFC][PATCH 0/2] fun with tlb flushing on s390
Date: Thu, 26 Jul 2012 17:47:12 +0200
Message-ID: <1343317634-13197-1-git-send-email-schwidefsky@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:57869 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab2GZPsC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jul 2012 11:48:02 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Thu, 26 Jul 2012 16:48:00 +0100
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q6QFlof52617462
	for <linux-arch@vger.kernel.org>; Thu, 26 Jul 2012 16:47:50 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q6QFlk64025581
	for <linux-arch@vger.kernel.org>; Thu, 26 Jul 2012 09:47:49 -0600
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-mm@kvack.org, Zachary Amsden <zach@vmware.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>

A code review revealed another potential race in regard to TLB flushing
on s390. See patch #2 for the ugly details. To fix this I would like
to use the arch_enter_lazy_mmu_mode/arch_leave_lazy_mmu_mode but to do
that the pointer to the mm in question needs to be added to the functions.
To keep things symmetrical arch_flush_lazy_mmu_mode should grow an mm
argument as well.

powerpc and x86 have a non-empty implementation for the lazy mmu flush
primitives and tile calls the generic definition in the architecture
files (which is a bit strange because the generic definition is empty).
Comments?

Martin Schwidefsky (2):
  add mm argument to lazy mmu mode hooks
  s390/tlb: race of lazy TLB flush vs. recreation of TLB entries

 arch/powerpc/include/asm/tlbflush.h |    6 ++---
 arch/powerpc/mm/subpage-prot.c      |    4 ++--
 arch/powerpc/mm/tlb_hash64.c        |    4 ++--
 arch/s390/include/asm/hugetlb.h     |   24 ++++++++-----------
 arch/s390/include/asm/mmu_context.h |   13 ++++++++---
 arch/s390/include/asm/pgtable.h     |   43 ++++++++++++++++++++++-------------
 arch/s390/include/asm/tlb.h         |    3 ++-
 arch/s390/include/asm/tlbflush.h    |    8 +++----
 arch/s390/mm/pgtable.c              |    6 ++---
 arch/tile/mm/fault.c                |    2 +-
 arch/tile/mm/highmem.c              |    4 ++--
 arch/x86/include/asm/paravirt.h     |    6 ++---
 arch/x86/kernel/paravirt.c          |   10 ++++----
 arch/x86/mm/highmem_32.c            |    4 ++--
 arch/x86/mm/iomap_32.c              |    2 +-
 include/asm-generic/pgtable.h       |    6 ++---
 mm/memory.c                         |   16 ++++++-------
 mm/mprotect.c                       |    4 ++--
 mm/mremap.c                         |    4 ++--
 19 files changed, 91 insertions(+), 78 deletions(-)

-- 
1.7.10.4
