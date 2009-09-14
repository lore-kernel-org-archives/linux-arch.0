Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9424 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757311AbZINV4E (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2009 17:56:04 -0400
From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 08/11] alpha: Convert BUG() to use unreachable()
Date: Mon, 14 Sep 2009 14:55:37 -0700
Message-ID: <1252965340-31735-8-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <4AAEBAC2.1050905@caviumnetworks.com>
References: <4AAEBAC2.1050905@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org
Message-ID: <20090914215537.VKVi2bFmzr30GnRFY2BH2f11XHksoxTi_fLEz_mHumE@z>

Use the new unreachable() macro instead of for(;;);

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: linux-alpha@vger.kernel.org
---
 arch/alpha/include/asm/bug.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/alpha/include/asm/bug.h b/arch/alpha/include/asm/bug.h
index 1720c8a..f091682 100644
--- a/arch/alpha/include/asm/bug.h
+++ b/arch/alpha/include/asm/bug.h
@@ -13,7 +13,8 @@
 		"call_pal %0  # bugchk\n\t"				\
 		".long %1\n\t.8byte %2"					\
 		: : "i"(PAL_bugchk), "i"(__LINE__), "i"(__FILE__));	\
-	for ( ; ; ); } while (0)
+	unreachable();							\
+  } while (0)
 
 #define HAVE_ARCH_BUG
 #endif
-- 
1.6.2.5

