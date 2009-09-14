Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9398 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbZINVz7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2009 17:55:59 -0400
From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 04/11] s390: Convert BUG() to use unreachable()
Date: Mon, 14 Sep 2009 14:55:33 -0700
Message-ID: <1252965340-31735-4-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <4AAEBAC2.1050905@caviumnetworks.com>
References: <4AAEBAC2.1050905@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
Message-ID: <20090914215533.xCpUFT-0CfhumbXfNvAXEwDNoHpPPOmAAYsRQnLNRWE@z>

Use the new unreachable() macro instead of for(;;);

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: linux390@de.ibm.com
CC: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/bug.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index 7efd0ab..efb74fd 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -49,7 +49,7 @@
 
 #define BUG() do {					\
 	__EMIT_BUG(0);					\
-	for (;;);					\
+	unreachable();					\
 } while (0)
 
 #define WARN_ON(x) ({					\
-- 
1.6.2.5

