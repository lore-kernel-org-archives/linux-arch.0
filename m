From: Vladimir Murzin <murzin.v@gmail.com>
Subject: [PATCH 0/6] get rid of extra check for TASK_SIZE in get_unmapped_area
Date: Tue,  8 May 2012 18:40:16 +0400
Message-ID: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49672 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077Ab2EHOmv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2012 10:42:51 -0400
Received: by lbbgm6 with SMTP id gm6so4261600lbb.19
        for <linux-arch@vger.kernel.org>; Tue, 08 May 2012 07:42:50 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: tglx@linutronix.de, davem@davemloft.net, lethal@linux-sh.org, linux@arm.linux.org.uk

From: Vladimir Murzin <murzin.v@gmail>

The current get_unmapped_area code calls the f_ops->get_unmapped_area or
the arch's one (via the mm) only when check for TASK_SIZE is passed. However,
generic code and some arches do the same check in their a_g_u_a implementation.

This series of patches fix the check order for TASK_SIZE in archs'
get_unmapped_area() implementations, and then removes extra check in
high-level get_unmapped_area().

Vladimir Murzin (6):
  get_unmapped_area checks for TASK_SIZE before MAP_FIXED on arm
  get_unmapped_area checks for TASK_SIZE before MAP_FIXED on sh
  get_unmapped_area checks for TASK_SIZE before MAP_FIXED on sparc32
  get_unmapped_area checks for TASK_SIZE before MAP_FIXED on sparc64
  get_unmapped_area checks for TASK_SIZE before MAP_FIXED on x86_64
  get_unmapped_area remove extra check for TASK_SIZE

 arch/arm/mm/mmap.c               |    6 +++---
 arch/sh/mm/mmap.c                |   12 ++++++------
 arch/sparc/kernel/sys_sparc_32.c |    9 +++++----
 arch/sparc/kernel/sys_sparc_64.c |   16 ++++++++--------
 arch/x86/kernel/sys_x86_64.c     |    6 +++---
 mm/mmap.c                        |    4 ----
 6 files changed, 25 insertions(+), 28 deletions(-)

-- 
1.7.2.5
