Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42055 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755652Ab1DZNYG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2011 09:24:06 -0400
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v2 6/6] m68knommu: fix build error due to the lack of find_next_bit_le()
Date: Tue, 26 Apr 2011 22:23:43 +0900
Message-ID: <1303824223-3566-7-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1303824223-3566-1-git-send-email-akinobu.mita@gmail.com>
References: <1303824223-3566-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Greg Ungerer <gerg@uclinux.org>
Message-ID: <20110426132343.l1GV0kYNYidYVEjJa1rILJI_SRKOx4QQuVxL_qf_r4U@z>

m68knommu can't build ext4 and udf due to the lack of find_next_bit_le().
By the previous style change, m68knommu got generic find_next_bit_le().
The extern declaration is only needed to fix the build error.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Greg Ungerer <gerg@uclinux.org>
---

No change from previous submission

 arch/m68k/include/asm/bitops_no.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/m68k/include/asm/bitops_no.h b/arch/m68k/include/asm/bitops_no.h
index 614c613..c4250ae 100644
--- a/arch/m68k/include/asm/bitops_no.h
+++ b/arch/m68k/include/asm/bitops_no.h
@@ -337,6 +337,9 @@ found_middle:
 }
 #define find_next_zero_bit_le find_next_zero_bit_le
 
+extern unsigned long find_next_bit_le(const void *addr,
+		unsigned long size, unsigned long offset);
+
 #endif /* __KERNEL__ */
 
 #include <asm-generic/bitops/fls.h>
-- 
1.7.4.4

