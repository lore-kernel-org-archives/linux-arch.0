From: Johannes Weiner <hannes@cmpxchg.org>
Subject: [patch 0/5] sparse-vmemmap: hotplug fixes & cleanups
Date: Wed, 20 Mar 2013 14:03:27 -0400
Message-ID: <1363802612-32127-1-git-send-email-hannes@cmpxchg.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zene.cmpxchg.org ([85.214.230.12]:41644 "EHLO zene.cmpxchg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051Ab3CTSDq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Mar 2013 14:03:46 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Hotplug can happen at times when the memory situation is less than
perfect to allocate huge pages for the vmemmap.  This series makes the
allocation try harder in patch #1.  The remaining patches allow x86-64
to fall back to regular pages as a last resort before the hotplug
event fails completely.  As a prerequisite to this, the arch interface
to sparse is cleaned up a little, which should also enable other
architectures to easily mix huge and regular pages in the vmemmap.

 arch/arm64/mm/mmu.c       | 13 +++++--------
 arch/ia64/mm/discontig.c  |  7 +++----
 arch/powerpc/mm/init_64.c | 11 +++--------
 arch/s390/mm/vmem.c       | 13 +++++--------
 arch/sparc/mm/init_64.c   |  7 +++----
 arch/x86/mm/init_64.c     | 68 ++++++++++++++++++++++++++++++++------------------------------------
 include/linux/mm.h        |  8 ++++----
 mm/sparse-vmemmap.c       | 27 +++++++++++++++++----------
 mm/sparse.c               | 10 ++++++++--
 9 files changed, 80 insertions(+), 84 deletions(-)
