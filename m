Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:42933 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559AbbBPXHt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Feb 2015 18:07:49 -0500
From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH 33/45] include/uapi/asm-generic/signal.h: include stdlib.h in userspace
Date: Tue, 17 Feb 2015 00:05:36 +0100
Message-ID: <1424127948-22484-34-git-send-email-mikko.rapeli@iki.fi>
In-Reply-To: <1424127948-22484-1-git-send-email-mikko.rapeli@iki.fi>
References: <1424127948-22484-1-git-send-email-mikko.rapeli@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150216230536.5y3PUKLBX0Bj30Khxgrwtk72EbyqET4NTbhTnt1hbgU@z>

Fixes compiler warning:
error: unknown type name ‘size_t’

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 include/uapi/asm-generic/signal.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
index 9df61f1..8a341a2 100644
--- a/include/uapi/asm-generic/signal.h
+++ b/include/uapi/asm-generic/signal.h
@@ -3,6 +3,10 @@
 
 #include <linux/types.h>
 
+#ifndef __KERNEL__
+#include <stdlib.h>
+#endif
+
 #define _NSIG		64
 #define _NSIG_BPW	__BITS_PER_LONG
 #define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
-- 
2.1.4

