From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/2] xtensa: add highmem support
Date: Wed,  2 Apr 2014 03:15:44 +0400
Message-ID: <1396394146-7594-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:37180 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbaDAXQR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Apr 2014 19:16:17 -0400
Received: by mail-lb0-f170.google.com with SMTP id s7so7525080lbd.15
        for <linux-arch@vger.kernel.org>; Tue, 01 Apr 2014 16:16:15 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-xtensa@linux-xtensa.org
Cc: Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Hi Chris and everybody,

this series adds highmem support for xtensa (currently only for cores with
non-aliased caches).

Please review.

Max Filippov (2):
  xtensa: optimize local_flush_tlb_kernel_range
  xtensa: add HIGHMEM support

 arch/xtensa/Kconfig                | 18 ++++++++++
 arch/xtensa/include/asm/fixmap.h   | 58 ++++++++++++++++++++++++++++++
 arch/xtensa/include/asm/highmem.h  | 45 +++++++++++++++++++++++-
 arch/xtensa/include/asm/pgtable.h  |  4 +++
 arch/xtensa/include/asm/tlbflush.h | 11 +++---
 arch/xtensa/kernel/smp.c           | 15 ++++++++
 arch/xtensa/mm/Makefile            |  1 +
 arch/xtensa/mm/cache.c             |  7 +++-
 arch/xtensa/mm/highmem.c           | 72 ++++++++++++++++++++++++++++++++++++++
 arch/xtensa/mm/init.c              | 45 ++++++++++++++++--------
 arch/xtensa/mm/mmu.c               | 36 +++++++++++++++++++
 arch/xtensa/mm/tlb.c               | 15 ++++++++
 12 files changed, 304 insertions(+), 23 deletions(-)
 create mode 100644 arch/xtensa/include/asm/fixmap.h
 create mode 100644 arch/xtensa/mm/highmem.c

-- 
1.8.1.4
