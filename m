Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:35722 "EHLO
	e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933332AbcAZJSH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jan 2016 04:18:07 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Tue, 26 Jan 2016 09:18:05 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 0/3] Optimize CONFIG_DEBUG_PAGEALLOC
Date: Tue, 26 Jan 2016 10:18:22 +0100
Message-ID: <1453799905-10941-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20160126091822.yUasQS2IFwm55Z8gpPYx1AXY6Xoj-YWfk30Od2CXcbM@z>

As CONFIG_DEBUG_PAGEALLOC can be enabled/disabled via kernel
parameters we can optimize some cases by checking the enablement
state.

I have done s390 and x86 as examples. Other architecture can
provide followup patches later on.

Christian Borntraeger (3):
  mm: provide debug_pagealloc_enabled() without CONFIG_DEBUG_PAGEALLOC
  x86: query dynamic DEBUG_PAGEALLOC setting
  s390: query dynamic DEBUG_PAGEALLOC setting

 arch/s390/kernel/dumpstack.c |  4 +++-
 arch/s390/mm/vmem.c          | 10 ++++------
 arch/x86/kernel/dumpstack.c  |  4 +++-
 arch/x86/mm/init.c           |  7 ++++---
 arch/x86/mm/pageattr.c       | 14 ++++----------
 include/linux/mm.h           |  4 ++++
 6 files changed, 22 insertions(+), 21 deletions(-)

-- 
2.3.0

