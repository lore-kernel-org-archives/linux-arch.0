Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:46411 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757873AbbE3PlB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 30 May 2015 11:41:01 -0400
From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH 35/98] include/uapi/asm-generic/msgbuf.h: include asm/ipcbuf.h
Date: Sat, 30 May 2015 17:38:27 +0200
Message-ID: <1433000370-19509-36-git-send-email-mikko.rapeli@iki.fi>
In-Reply-To: <1433000370-19509-1-git-send-email-mikko.rapeli@iki.fi>
References: <1433000370-19509-1-git-send-email-mikko.rapeli@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150530153827.R43zWWHWVrhE6meaMQvf9YRzDsPwQlFFFHMsZTP49b0@z>

Fixes userspace compilation errors like:

error: field ‘msg_perm’ has incomplete type
struct ipc64_perm msg_perm

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 include/uapi/asm-generic/msgbuf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/asm-generic/msgbuf.h b/include/uapi/asm-generic/msgbuf.h
index f55ecc4..f5fbd8e 100644
--- a/include/uapi/asm-generic/msgbuf.h
+++ b/include/uapi/asm-generic/msgbuf.h
@@ -2,6 +2,8 @@
 #define __ASM_GENERIC_MSGBUF_H
 
 #include <asm/bitsperlong.h>
+#include <asm/ipcbuf.h>
+
 /*
  * generic msqid64_ds structure.
  *
-- 
2.1.4

