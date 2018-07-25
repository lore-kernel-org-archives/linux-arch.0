Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f173.google.com ([209.85.215.173]:35369 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbeGYRFL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jul 2018 13:05:11 -0400
Received: by mail-pg1-f173.google.com with SMTP id e6-v6so5600679pgv.2
        for <linux-arch@vger.kernel.org>; Wed, 25 Jul 2018 08:52:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 0/4] possibilities for improving invalidations
Date: Thu, 26 Jul 2018 01:52:42 +1000
Message-Id: <20180725155246.1085-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org

I wonder if we could make some improvements to zapping pages to
reduce TLB flushes under PTL, and to single threaded pte updates
to reduce atomic operations.

This might require some changes to arch code, particularly the
last patch. I'd just like to see if I've missed something
fundamental with the mm or with pte/tlb behaviour.

Thanks,
Nick

Nicholas Piggin (4):
  mm: munmap optimise single threaded page freeing
  mm: zap_pte_range only flush under ptl if a dirty shared page was
    unmapped
  mm: zap_pte_range optimise fullmm handling for dirty shared pages
  mm: optimise flushing and pte manipulation for single threaded access

 include/asm-generic/tlb.h |  3 +++
 mm/huge_memory.c          |  4 ++--
 mm/madvise.c              |  4 ++--
 mm/memory.c               | 40 ++++++++++++++++++++++++++++++++-------
 4 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.17.0
