Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727846AbeIRSYn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Sep 2018 14:24:43 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8ICnZ8m043426
        for <linux-arch@vger.kernel.org>; Tue, 18 Sep 2018 08:52:15 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mk14uhqbr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 18 Sep 2018 08:52:14 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Tue, 18 Sep 2018 13:52:13 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [RFC][PATCH 0/2] convert s390 to generic mmu_gather
Date: Tue, 18 Sep 2018 14:51:49 +0200
Message-ID: <20180918125151.31744-1-schwidefsky@de.ibm.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <20180918125149.sn3G1tU0wC1K3M42_wNklmq9GQvApTHUPEGB5ANEf_A@z>

Hi Peter,

as an add-on for the TLB flushing changes two patches to make
s390 use the generic mmu_gather code as well. I let it run for
a few hours with several TLB stress tests, no fallout so far.
It certainly can use more testing but it looks ok to me.

Martin Schwidefsky (2):
  asm-generic/tlb: introduce HAVE_MMU_GATHER_NO_GATHER
  s390/tlb: convert to generic mmu_gather

 arch/Kconfig                |   3 +
 arch/s390/Kconfig           |   3 +
 arch/s390/include/asm/tlb.h | 130 ++++++++++++++------------------------------
 arch/s390/mm/pgalloc.c      |  63 +--------------------
 include/asm-generic/tlb.h   |   9 ++-
 mm/mmu_gather.c             | 114 ++++++++++++++++++++++----------------
 6 files changed, 121 insertions(+), 201 deletions(-)

-- 
2.16.4
