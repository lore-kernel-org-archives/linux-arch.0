Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e17.ny.us.ibm.com ([129.33.205.207]:54260 "EHLO
	e17.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbbHISzB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 9 Aug 2015 14:55:01 -0400
Received: from /spool/local
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Sun, 9 Aug 2015 14:54:59 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] kexec: override GFP flag for the control page allocation
Date: Tue, 21 Apr 2015 14:06:31 +0200
Message-ID: <1429617992-31686-1-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <20150421120631.PUN_hOBBhLnOOCxq3Jo9Hg9AnH1Hd8cMB8DSP_P7-O4@z>

Greetings,

I got a bug report that kexec does not work on s390 if the system has
lots of memory. It is the kexec load step that dies with out-of-memory. 

The reason why this happens is the value of KEXEC_CONTROL_MEMORY_LIMIT
for s390. To start the new kernel the code in the kexec control page
needs to switch to the ESA mode (31-bit), therefore the memory limit
is 2GB for s390. The allocation of the control page is done with
GFP_KERNEL in kimage_alloc_normal_control_pages. If the allocated page
is a target page in the kexec destination range or if its address is
larger than the memory limit, it is put on the list of extra pages
and another page is allocated until one is found that fits the
requirements.

With a large memory size not only does this loop take a long time to
complete (think 10 terabyte of memory), but eventually the OOM killer
steps in and terminates the program that called kexec load.

The fix for s390 is to use a different GFP flag, GFP_DMA instead of
GFP_KERNEL. To do this a new #define for kexec is introduced that
can be overruled by the architecture.

Martin Schwidefsky (1):
  kexec: allocate the kexec control page with KEXEC_CONTROL_MEMORY_GFP

 arch/s390/include/asm/kexec.h | 3 +++
 include/linux/kexec.h         | 4 ++++
 kernel/kexec.c                | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
1.9.1

