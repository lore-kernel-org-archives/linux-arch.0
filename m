Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:53495 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934026AbaLKOFc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2014 09:05:32 -0500
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Thu, 11 Dec 2014 14:05:31 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCHv5 0/8]  ACCESS_ONCE and non-scalar accesses
Date: Thu, 11 Dec 2014 15:05:03 +0100
Message-ID: <1418306712-17245-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, George Spelvin <linux@horizon.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-mm@kvack.org
Message-ID: <20141211140503.AhJSOCbrq7tabeRJii2-IaIcEdLhIdX1Frp8pHtdd8Q@z>

As discussed on LKML http://marc.info/?i=54611D86.4040306%40de.ibm.com
ACCESS_ONCE might fail with specific compilers for non-scalar accesses.

Here is a set of patches to tackle that problem.

The first patch introduce READ_ONCE and ASSIGN_ONCE. If the data structure
is larger than the machine word size memcpy is used and a warning is emitted.
The next patches fix up all in-tree users of ACCESS_ONCE on non-scalar types.

Due to all the trouble when dealing with linux-next, I will defer the patch
that forces ACCESS_ONCE to work only on scalar types after rc1 to give it
a full spin in linux-next.

If nobody complains I will ask Linus to pull this for 3.19 next week.
The tree can be found at 

git://git.kernel.org/pub/scm/linux/kernel/git/borntraeger/linux.git linux-next

Changelog:
v4->v5:
1. READ_ONCE/ASSIGN_ONCE use x instead of p
2. linux/types.h --> uapi/linux/types.h u??-->__u?? to avoid header
   inclusion fun and compile errors
3. Actually provide data_access_exceeds_word_size.
4. also move handle_pte_fault to a barrier as there is ppc44x which has
   64bit ptes and 32bit word size. Some sanity check from a VM person
   would be good.

Cc: linux-mm@kvack.org

Christian Borntraeger (8):
  kernel: Provide READ_ONCE and ASSIGN_ONCE
  mm: replace ACCESS_ONCE with READ_ONCE or barriers
  x86/spinlock: Replace ACCESS_ONCE with READ_ONCE
  x86/gup: Replace ACCESS_ONCE with READ_ONCE
  mips/gup: Replace ACCESS_ONCE with READ_ONCE
  arm64/spinlock: Replace ACCESS_ONCE READ_ONCE
  arm/spinlock: Replace ACCESS_ONCE with READ_ONCE
  s390/kvm: REPLACE barrier fixup with READ_ONCE

 arch/arm/include/asm/spinlock.h   |  4 +--
 arch/arm64/include/asm/spinlock.h |  4 +--
 arch/mips/mm/gup.c                |  2 +-
 arch/s390/kvm/gaccess.c           | 18 ++++------
 arch/x86/include/asm/spinlock.h   |  8 ++---
 arch/x86/mm/gup.c                 |  2 +-
 include/linux/compiler.h          | 70 +++++++++++++++++++++++++++++++++++++++
 lib/Makefile                      |  2 +-
 lib/access.c                      |  8 +++++
 mm/gup.c                          |  2 +-
 mm/memory.c                       | 11 +++++-
 mm/rmap.c                         |  3 +-
 12 files changed, 108 insertions(+), 26 deletions(-)
 create mode 100644 lib/access.c

-- 
1.9.3

