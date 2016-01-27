Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:50407 "EHLO
	e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbcA0IuB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2016 03:50:01 -0500
Received: from localhost
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Wed, 27 Jan 2016 08:49:59 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 0/3] Optimize CONFIG_DEBUG_PAGEALLOC
Date: Wed, 27 Jan 2016 09:50:15 +0100
Message-ID: <1453884618-33852-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, Joonsoo Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20160127085015.S3pPIRTs8MtizMb580VpZBN5CYL45lidon9EBCTyi0M@z>

As CONFIG_DEBUG_PAGEALLOC can be enabled/disabled via kernel
parameters we can optimize some cases by checking the enablement
state.

I have done s390 and x86 as examples.
s390 should be ok, I tested several combinations, x86 seems to
work as well, but I have some concerns about the 1GB pages.
The previous code did not bother at all with CONFIG_DEBUG_PAGEALLOC
and I do not fully understand why.

Power can probably do the same, Michael/Ben?
I am not sure about sparc. Sparc seems to allocate the TSB buffer
really early. David?


V1->V2:
- replace DEBUG_PAGEALLOC(disabled/enabled) with DEBUG_PAGEALLOC
  dump_stack for s390/x86
- add /* CONFIG_DEBUG_PAGEALLOC */ to else and endif


Christian Borntraeger (3):
  mm: provide debug_pagealloc_enabled() without CONFIG_DEBUG_PAGEALLOC
  x86: query dynamic DEBUG_PAGEALLOC setting
  s390: query dynamic DEBUG_PAGEALLOC setting

 arch/s390/kernel/dumpstack.c |  8 ++++----
 arch/s390/mm/vmem.c          | 10 ++++------
 arch/x86/kernel/dumpstack.c  |  5 ++---
 arch/x86/mm/init.c           |  7 ++++---
 arch/x86/mm/pageattr.c       | 14 ++++----------
 include/linux/mm.h           |  9 +++++++--
 6 files changed, 25 insertions(+), 28 deletions(-)

-- 
2.3.0

