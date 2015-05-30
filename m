Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:45505 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757868AbbE3PlA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 30 May 2015 11:41:00 -0400
From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH 34/98] include/uapi/asm-generic/ipcbuf.h: include linux/posix_types.h
Date: Sat, 30 May 2015 17:38:26 +0200
Message-ID: <1433000370-19509-35-git-send-email-mikko.rapeli@iki.fi>
In-Reply-To: <1433000370-19509-1-git-send-email-mikko.rapeli@iki.fi>
References: <1433000370-19509-1-git-send-email-mikko.rapeli@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150530153826.Ac-1MOFvpIAVhG1y8fv4DL6jW4WctsjIUIiCs8_WQDU@z>

Fixes userspace compilation error:

error: unknown type name ‘__kernel_key_t’

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 include/uapi/asm-generic/ipcbuf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/asm-generic/ipcbuf.h b/include/uapi/asm-generic/ipcbuf.h
index 3dbcc1e..909f825 100644
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
2.1.4

