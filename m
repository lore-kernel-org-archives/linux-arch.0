Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp09.uk.ibm.com ([195.75.94.105]:36657 "EHLO
	e06smtp09.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbbIUPWY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Sep 2015 11:22:24 -0400
Received: from /spool/local
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Mon, 21 Sep 2015 16:22:22 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id B71AE17D805D
	for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2015 16:24:12 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com [9.149.37.251])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t8LFMLFt32833640
	for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2015 15:22:21 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t8LEMLQG009157
	for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2015 08:22:21 -0600
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 0/2] mm: soft-dirty bits for s390
Date: Mon, 21 Sep 2015 17:22:18 +0200
Message-ID: <1442848940-22108-1-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Cyrill Gorcunov <gorcunov@gmail.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <20150921152218.QEGQuGCXTab1UyH_CrDTTfF4P3okPN7dwbCMKrrbe6o@z>

Greetings,

this patch set of two adds memory change tracking alias soft-dirty
feature to the s390 architecture.

The first patch is a cleanup of the existing x86 support, it adds two
arch specific functions pte_clear_soft_dirty and pmd_clear_soft_dirty
to complement the other xxx_soft_dirty functions. This removes the
use of a x86 specific function in fs/proc/tasm_mmu.c.

The second patch is the s390 arch support.

Tested on x86 and s390, seems to work as intended for both platforms.
If the first patch is acceptable I can queue the set on the linux-s390
tree for the 4.4 merge window in a couple of weeks.

Martin Schwidefsky (2):
  mm: add architecture primitives for software dirty bit clearing
  s390/mm: implement soft-dirty bits for user memory change tracking

 arch/s390/Kconfig               |  1 +
 arch/s390/include/asm/pgtable.h | 59 ++++++++++++++++++++++++++++++++++++++---
 arch/s390/mm/hugetlbpage.c      |  2 ++
 arch/x86/include/asm/pgtable.h  | 10 +++++++
 fs/proc/task_mmu.c              |  4 +--
 include/asm-generic/pgtable.h   | 10 +++++++
 6 files changed, 80 insertions(+), 6 deletions(-)

-- 
1.9.1

