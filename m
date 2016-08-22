From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH v05 17/72] asm-generic/sembuf.h: include asm/posix_types.h and asm/ipcbuf.h
Date: Mon, 22 Aug 2016 20:32:34 +0200
Message-ID: <1471890809-4383-18-git-send-email-mikko.rapeli@iki.fi>
References: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:46455 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756079AbcHVShW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Aug 2016 14:37:22 -0400
In-Reply-To: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

Fixes userspace compilation errors like:

error: field ‘msg_perm’ has incomplete type
struct ipc64_perm msg_perm;
error: unknown type name ‘__kernel_ulong_t’

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 include/uapi/asm-generic/sembuf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-generic/sembuf.h
index 4cb2c13..17d523f 100644
--- a/include/uapi/asm-generic/sembuf.h
+++ b/include/uapi/asm-generic/sembuf.h
@@ -2,6 +2,8 @@
 #define __ASM_GENERIC_SEMBUF_H
 
 #include <asm/bitsperlong.h>
+#include <asm/posix_types.h>
+#include <asm/ipcbuf.h>
 
 /*
  * The semid64_ds structure for x86 architecture.
-- 
2.8.1
