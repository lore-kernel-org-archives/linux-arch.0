Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:43298 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbaEHJ2b (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 May 2014 05:28:31 -0400
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <maddy@linux.vnet.ibm.com>;
	Thu, 8 May 2014 14:58:27 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH V4 0/2] mm: FAULT_AROUND_ORDER patchset performance data for powerpc
Date: Thu,  8 May 2014 14:58:14 +0530
Message-ID: <1399541296-18810-1-git-send-email-maddy@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, kirill.shutemov@linux.intel.com, rusty@rustcorp.com.au, akpm@linux-foundation.org, riel@redhat.com, mgorman@suse.de, ak@linux.intel.com, peterz@infradead.org, mingo@kernel.org, dave.hansen@intel.com, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Message-ID: <20140508092814.EXMv7dz3KcoD_cHOERjTT3R6Mx4DHLpLeC7CJb6MV6A@z>

Kirill A. Shutemov with 8c6e50b029 commit introduced
vm_ops->map_pages() for mapping easy accessible pages around
fault address in hope to reduce number of minor page faults.

This patch creates infrastructure to modify the FAULT_AROUND_ORDER
value using mm/Kconfig. This will enable architecture maintainers
to decide on suitable FAULT_AROUND_ORDER value based on
performance data for that architecture. First patch also defaults
FAULT_AROUND_ORDER Kconfig element to 4. Second patch list
out the performance numbers for powerpc (platform pseries) and
initialize the fault around order variable for pseries platform of
powerpc.

V4 Changes:
  Replaced the BUILD_BUG_ON with VM_BUG_ON.
  Moved fault_around_pages() and fault_around_mask() functions outside of
   #ifdef CONFIG_DEBUG_FS.

V3 Changes:
  Replaced FAULT_AROUND_ORDER macro to a variable to support arch's that
   supports sub platforms.
  Made changes in commit messages.

V2 Changes:
  Created Kconfig parameter for FAULT_AROUND_ORDER
  Added check in do_read_fault to handle FAULT_AROUND_ORDER value of 0
  Made changes in commit messages.

Madhavan Srinivasan (2):
  mm: move FAULT_AROUND_ORDER to arch/
  powerpc/pseries: init fault_around_order for pseries

 arch/powerpc/platforms/pseries/pseries.h |    2 ++
 arch/powerpc/platforms/pseries/setup.c   |    5 +++++
 mm/Kconfig                               |    8 ++++++++
 mm/memory.c                              |   25 ++++++-------------------
 4 files changed, 21 insertions(+), 19 deletions(-)

-- 
1.7.10.4

