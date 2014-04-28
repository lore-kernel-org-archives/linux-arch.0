Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:57774 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482AbaD1JNN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Apr 2014 05:13:13 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <maddy@linux.vnet.ibm.com>;
	Mon, 28 Apr 2014 19:01:52 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH V3 0/2] mm: FAULT_AROUND_ORDER patchset performance data for powerpc
Date: Mon, 28 Apr 2014 14:31:28 +0530
Message-ID: <1398675690-16186-1-git-send-email-maddy@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, kirill.shutemov@linux.intel.com, rusty@rustcorp.com.au, akpm@linux-foundation.org, riel@redhat.com, mgorman@suse.de, ak@linux.intel.com, peterz@infradead.org, mingo@kernel.org, dave.hansen@intel.com, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Message-ID: <20140428090128.9q5eYvNgnoF4j_p-Fge62GY0fDckqH8vPGcaFZWbHAY@z>

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

 arch/powerpc/platforms/pseries/setup.c |    5 +++++
 mm/Kconfig                             |    8 ++++++++
 mm/memory.c                            |   11 ++++-------
 3 files changed, 17 insertions(+), 7 deletions(-)

-- 
1.7.10.4

