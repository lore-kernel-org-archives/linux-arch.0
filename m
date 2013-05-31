Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hermes.synopsys.com ([198.182.44.81]:48320 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab3EaKzV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2013 06:55:21 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 0/2] mm: fixlets
Date: Fri, 31 May 2013 16:23:48 +0530
Message-ID: <1369997630-6522-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <20130531105348.Ww3mZQ7f_X8ew-eelpat0VPG0lI46k1n-JRM_bO-o7o@z>

Hi Andrew,

Max Filippov reported a generic MM issue with PTE/TLB coherency
@ http://www.spinics.net/lists/linux-arch/msg21736.html

While the fix for issue is still being discussed, sending over a bunch
mm fixlets which we found in due course.

Infact, 1/2 looks like stable material as orig code was flushing wrong range
from TLB - wherever used.

Please consider applying.

Thx,
-Vineet


Vineet Gupta (2):
  mm: Fix the TLB range flushed when __tlb_remove_page() runs out of
    slots
  mm: tlb_fast_mode check missing in tlb_finish_mmu()

 mm/memory.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
1.7.10.4

