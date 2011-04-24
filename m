From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 6/6] m68knommu: fix build error due to the lack of find_next_bit_le()
Date: Sun, 24 Apr 2011 18:51:17 +0900
Message-ID: <1303638677-11211-7-git-send-email-akinobu.mita@gmail.com>
References: <1303638677-11211-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56254 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756583Ab1DXJve (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 24 Apr 2011 05:51:34 -0400
In-Reply-To: <1303638677-11211-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Greg Ungerer <gerg@uclinux.org>

m68knommu can't build ext4 and udf due to the lack of find_next_bit_le().
By the previous style change, m68knommu got generic find_next_bit_le().
The extern declaration is only needed to fix the build error.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/asm/bitops_no.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/m68k/include/asm/bitops_no.h b/arch/m68k/include/asm/bitops_no.h
index e98d42c..247854e 100644
--- a/arch/m68k/include/asm/bitops_no.h
+++ b/arch/m68k/include/asm/bitops_no.h
@@ -326,6 +326,9 @@ found_middle:
 }
 #define find_next_zero_bit_le find_next_zero_bit_le
 
+extern unsigned long find_next_bit_le(const void *addr,
+		unsigned long size, unsigned long offset);
+
 #endif /* __KERNEL__ */
 
 #include <asm-generic/bitops/fls.h>
-- 
1.7.4.4
