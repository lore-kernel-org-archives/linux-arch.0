From: liqin.chen@sunplusct.com
Subject: [PATCH 12/27] score: create head files linkage.h local.h
Date: Tue, 9 Jun 2009 14:29:47 +0800
Message-ID: <OF4F913F1C.49F95FA2-ON482575D0.0023A280-482575D0.00241426@sunplusct.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 219-87-157-179.static.tfn.net.tw ([219.87.157.179]:35512 "EHLO
	mswedge1.sunplus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbZFIGw7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2009 02:52:59 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

From 9a73d300e241dca5f461b0ce533294d667a1aa61 Mon Sep 17 00:00:00 2001
From: Chen Liqin <liqin.chen@sunplusct.com>
Date: Tue, 9 Jun 2009 13:43:10 +0800



Signed-off-by: Chen Liqin <liqin.chen@sunplusct.com>
---
 arch/score/include/asm/linkage.h |    4 ++++
 arch/score/include/asm/local.h   |    6 ++++++
 2 files changed, 10 insertions(+), 0 deletions(-)
 create mode 100644 arch/score/include/asm/linkage.h
 create mode 100644 arch/score/include/asm/local.h

diff --git a/arch/score/include/asm/linkage.h 
b/arch/score/include/asm/linkage.h
new file mode 100644
index 0000000..2580fbb
--- /dev/null
+++ b/arch/score/include/asm/linkage.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_SCORE_LINKAGE_H
+#define _ASM_SCORE_LINKAGE_H
+
+#endif /* _ASM_SCORE_LINKAGE_H */
diff --git a/arch/score/include/asm/local.h 
b/arch/score/include/asm/local.h
new file mode 100644
index 0000000..7e02f13
--- /dev/null
+++ b/arch/score/include/asm/local.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_SCORE_LOCAL_H
+#define _ASM_SCORE_LOCAL_H
+
+#include <asm-generic/local.h>
+
+#endif /* _ASM_SCORE_LOCAL_H */
-- 
1.6.2
