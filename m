Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:37555 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757885AbbE3PlD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 30 May 2015 11:41:03 -0400
From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH 38/98] include/uapi/asm-generic/signal.h: use __kernel_size_t instead of size_t
Date: Sat, 30 May 2015 17:38:30 +0200
Message-ID: <1433000370-19509-39-git-send-email-mikko.rapeli@iki.fi>
In-Reply-To: <1433000370-19509-1-git-send-email-mikko.rapeli@iki.fi>
References: <1433000370-19509-1-git-send-email-mikko.rapeli@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150530153830.UFLouGiwWo4KvfsaF7EGN3SOPRNfJyHsbblFDO4VoVM@z>

Fixes userspace compiler error:

error: unknown type name ‘size_t’

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 include/uapi/asm-generic/signal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
index 9df61f1..0a7c415 100644
--- a/include/uapi/asm-generic/signal.h
+++ b/include/uapi/asm-generic/signal.h
@@ -111,7 +111,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 #endif /* __ASSEMBLY__ */
-- 
2.1.4

