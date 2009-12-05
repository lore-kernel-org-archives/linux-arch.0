Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:1363 "EHLO
	smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbZLECHS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Dec 2009 21:07:18 -0500
From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 4/5] s390: Convert BUG() to use unreachable()
Date: Fri,  4 Dec 2009 17:44:53 -0800
Message-ID: <1259977494-24636-4-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <4B19BAD3.1000808@caviumnetworks.com>
References: <4B19BAD3.1000808@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
Message-ID: <20091205014453.jJ6o9AhNXb6zankeZq2jf8EBW77Vqx0AGLKysDct7zI@z>

Use the new unreachable() macro instead of for(;;);

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>
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

