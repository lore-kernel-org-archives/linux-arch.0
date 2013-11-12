From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 07/17] ia64: Remove duplicate declarations of __per_cpu_start[] and __per_cpu_end[]
Date: Tue, 12 Nov 2013 20:42:17 +0100
Message-ID: <1384285347-13506-8-git-send-email-geert@linux-m68k.org>
References: <1384285347-13506-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from jacques.telenet-ops.be ([195.130.132.50]:60509 "EHLO
	jacques.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755455Ab3KLTmk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Nov 2013 14:42:40 -0500
In-Reply-To: <1384285347-13506-1-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org

They're already provided by <asm/sections.h>.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/include/asm/sections.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/include/asm/sections.h b/arch/ia64/include/asm/sections.h
index 1a873b36a4a1..2ab2003698ef 100644
--- a/arch/ia64/include/asm/sections.h
+++ b/arch/ia64/include/asm/sections.h
@@ -10,7 +10,7 @@
 #include <linux/uaccess.h>
 #include <asm-generic/sections.h>
 
-extern char __per_cpu_start[], __per_cpu_end[], __phys_per_cpu_start[];
+extern char __phys_per_cpu_start[];
 #ifdef	CONFIG_SMP
 extern char __cpu0_per_cpu[];
 #endif
-- 
1.7.9.5
