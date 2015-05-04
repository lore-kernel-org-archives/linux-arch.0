Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:56206 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbbEDKmo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2015 06:42:44 -0400
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v10 05/19] Add common asm-offsets.h
Date: Mon,  4 May 2015 19:41:48 +0900
Message-ID: <1430736122-20929-7-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1430736122-20929-2-git-send-email-ysato@users.sourceforge.jp>
References: <1430736122-20929-2-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150504104148.w6dZIjquQ6WGNyO8QrMSTD2p3IKHHgQ082vPCbb_t-4@z>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/asm-generic/asm-offsets.h | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 include/asm-generic/asm-offsets.h

diff --git a/include/asm-generic/asm-offsets.h b/include/asm-generic/asm-offsets.h
new file mode 100644
index 0000000..d370ee3
--- /dev/null
+++ b/include/asm-generic/asm-offsets.h
@@ -0,0 +1 @@
+#include <generated/asm-offsets.h>
-- 
2.1.4

