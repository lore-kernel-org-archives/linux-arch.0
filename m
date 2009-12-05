From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 5/5] avr32: Convert BUG() to use unreachable()
Date: Fri,  4 Dec 2009 17:44:54 -0800
Message-ID: <1259977494-24636-5-git-send-email-ddaney@caviumnetworks.com>
References: <4B19BAD3.1000808@caviumnetworks.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755068AbZLECHW@vger.kernel.org>
In-Reply-To: <4B19BAD3.1000808@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
List-Id: linux-arch.vger.kernel.org

Use the new unreachable() macro instead of for(;;);

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Acked-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
CC: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
---
 arch/avr32/include/asm/bug.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/avr32/include/asm/bug.h b/arch/avr32/include/asm/bug.h
index 331d45b..2aa373c 100644
--- a/arch/avr32/include/asm/bug.h
+++ b/arch/avr32/include/asm/bug.h
@@ -52,7 +52,7 @@
 #define BUG()								\
 	do {								\
 		_BUG_OR_WARN(0);					\
-		for (;;);						\
+		unreachable();						\
 	} while (0)
 
 #define WARN_ON(condition)							\
-- 
1.6.2.5
