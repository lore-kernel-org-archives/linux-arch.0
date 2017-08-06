Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([91.232.154.25]:36233 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751336AbdHFRUy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Aug 2017 13:20:54 -0400
From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH v06 06/36] uapi asm-generic/ipcbuf.h: include linux/posix_types.h
Date: Sun,  6 Aug 2017 18:43:57 +0200
Message-ID: <20170806164428.2273-7-mikko.rapeli@iki.fi>
In-Reply-To: <20170806164428.2273-1-mikko.rapeli@iki.fi>
References: <20170806164428.2273-1-mikko.rapeli@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, "H. Peter Anvin" <hpa@zytor.com>, "H . J . Lu" <hjl.tools@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Message-ID: <20170806164357.kXxchQ-XqOby7KFf-JYT2TsOZx7LwWmrjQIHGgHux-E@z>

Fixes userspace compilation error:

error: unknown type name ‘__kernel_key_t’

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: H.J. Lu <hjl.tools@gmail.com>
---
 include/uapi/asm-generic/ipcbuf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/asm-generic/ipcbuf.h b/include/uapi/asm-generic/ipcbuf.h
index 3dbcc1e771c0..909f825096f4 100644
--- a/include/uapi/asm-generic/ipcbuf.h
+++ b/include/uapi/asm-generic/ipcbuf.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_GENERIC_IPCBUF_H
 #define __ASM_GENERIC_IPCBUF_H
 
+#include <linux/posix_types.h>
+
 /*
  * The generic ipc64_perm structure:
  * Note extra padding because this structure is passed back and forth
-- 
2.13.3
